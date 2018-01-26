global class UIP_Cache_Upsert_New {
    
   public static void upsertToCache(UIP__c[] trigOld,UIP__c[] trigNew){
        for(UIP__c uip:trigNew){uip.ZPIF_UIP_Identidier__c = NewGuid();}
        InsertToCache(trigNew);
    }
    
   webservice static void updateZPIFCachews(Id[] updUIPs){
        System.debug('updUIPs '+updUIPs);
        updateZPIFCache(updUIPs);
    }
    
    Public static List<Id> updUIPId = new List<Id>();
    
    public static void updateZPIFCache(Id[] updUIPs){
                List<UIP__c> uipid = [Select u.Id, (Select Id From UIP_Elements__r), (Select Id From UIP_Contacts__r), (Select Id From Performance_Indicator_Targets__r), (Select Id From Performance_Indicator_Notable_Trends__r), (Select Id From Improvement_Action_Steps__r), (Select Id From Implementation_Benchmarks__r), (Select Id From Addenda1__r) From UIP__c u where Id IN :updUIPs]; 
                System.debug('UIPID :'+uipid);
                InsertToCache(uipid);
                List<UIP_Contact__c> con = New List<UIP_Contact__c>();
                for(UIP__c uip : uipid){ 
                    updUIPId.add(uip.Id); 
                    System.debug('uip.UIP_Contacts__r '+uip.UIP_Contacts__r);
                    con.add(uip.UIP_Contacts__r);
                }
                insertToCache(con); 
                List<Addendum__c> uipAdden = [Select z.ZPIF_UIP_Identidier__c, z.UIP__c, District_UIP_for_Combined_Plans__c, School_UIP__c From Addendum__c z where UIP__c IN :updUIPs or District_UIP_for_Combined_Plans__c IN :updUIPs or School_UIP__c IN :updUIPs];
                System.debug('UIPADDEN '+uipAdden);
                insertToCache(uipAdden);
                List<UIP_Element__c> uipElem = [Select z.ZPIF_UIP_Identidier__c, z.Root_Cause_1__c, z.Root_Cause_2__c, z.Root_Cause_3__c, z.Root_Cause_4__c, z.Root_Cause_5__c, z.Root_Cause_6__c, z.Root_Cause_7__c, z.Root_Cause_8__c, z.Root_Cause_9__c, UIP__c From UIP_Element__c z where UIP__c IN :updUIPs];
                System.debug('uipElem '+uipElem);
                insertToCache(uipElem);
                List<Improvement_Action_Step__c> actImpr = [Select z.ZPIF_UIP_Identidier__c, UIP__c From Improvement_Action_Step__c z where UIP__c IN :updUIPs];  
                insertToCache(actImpr);
                List<Implementation_Benchmark__c> impBench = [Select z.ZPIF_UIP_Identidier__c, UIP__c From Implementation_Benchmark__c z where UIP__c IN :updUIPs];  
                insertToCache(impBench); 
                List<BenchMar_AtciontStep__c> benMarks = [Select z.Improvement_Action_Step__r.UIP__c, z.Implementation_Benchmark__r.UIP__c From BenchMar_AtciontStep__c z where z.Improvement_Action_Step__r.UIP__c IN :updUIPs or z.Implementation_Benchmark__r.UIP__c IN :updUIPs];
                insertToCache(benMarks);
                for(UIP__c uip : uipid){
                insertToCache(uip.Performance_Indicator_Targets__r); 
                insertToCache(uip.Performance_Indicator_Notable_Trends__r);   
                }
                List<Id> addenIds = new List<Id>();
                for(UIP__c uip : uipid){ for(Addendum__c adden:uip.Addenda1__r) {addenIds.add(adden.Id);}}
                List<Supporting_Addenda_Forms__c> addenForms = [Select s.Id, s.Addendum__c From Supporting_Addenda_Forms__c s where Addendum__c IN: addenIds]; 
                insertToCache(addenForms);                                            
                //--addNotesAttachments(updUIPId);         
    }
    
    public static void addNotesAttachments(Id[] updUIPId){
        LIST<Attachment> attachments = [Select Id, Name, Body,ParentId, ContentType from Attachment where parentId IN :updUIPId];
        Id[] zpfId = updUIPId;
        map<Id,Id> mapUIPZ = getZPIFFUIPForUIP(updUIPId);
        //--Id zpfId = mapUIPZ.get(updUIPId);
        Set<String> origAttachNames = new Set<String>();
        for(Attachment attchmt:attachments) { origAttachNames.add(attchmt.Name + attchmt.ContentType); }
        LIST<Attachment> existingAttachmnts = [Select Id, Name, ContentType from Attachment where parentId IN :zpfId];
        Set<String> extngAttachNames = new Set<String>();
        List<Attachment> deleAttachment = new List<Attachment>();
        for(Attachment attchmt:existingAttachmnts) {
            extngAttachNames.add(attchmt.Name + attchmt.ContentType);       
            if(!origAttachNames.contains(attchmt.Name + attchmt.ContentType))
                deleAttachment.add(attchmt);
        }
        List<Attachment> attachmnts = new List<Attachment>();
        for(Attachment attchmt:attachments){
            if(mapUIPZ.containsKey(attchmt.ParentId) && !extngAttachNames.contains(attchmt.Name + attchmt.ContentType)){
                
                Attachment newAttach = new Attachment();
                newAttach = attchmt.clone();
                newAttach.parentId = mapUIPZ.get(attchmt.ParentId);
                attachmnts.add(newAttach);
            }
        }
        if(deleAttachment.size()>0)
            delete deleAttachment;
        if(attachmnts.size()>0)
            insert attachmnts;        
    }
    
    public static void InsertToCache(List<UIP__c> updUIPs){
            string fieldsAPIname = ObjectFields('UIP__c');   
            String qry = 'Select '+fieldsAPIname+',RecordType.DeveloperName from UIP__c where Id IN :updUIPs';
            LIST<UIP__c> uips = Database.query(qry);
            System.debug('uips '+uips);
            List<String> identifiers = new List<String>();
            List<UIP__c> updIdentUIP = new List<UIP__c>(); 
            for(UIP__c u : uips)  {
                if(u.ZPIF_UIP_Identidier__c == null){
                    u.ZPIF_UIP_Identidier__c = NewGuid();
                    updIdentUIP.add(u);
                }
            identifiers.add(u.ZPIF_UIP_Identidier__c);
            }
            System.debug('identifiers '+identifiers);
            System.debug('updIdentUIP '+updIdentUIP);
            if(updIdentUIP.size()>0) {update updIdentUIP; System.debug('Updating updIdentUIP');}
            List<ZPIF_UIP__c> ExstngZuips = [Select ZPIF_UIP_Identidier__c,Id,UIP_Source__c from ZPIF_UIP__c where ZPIF_UIP_Identidier__c IN :identifiers];
            map<String,Id> mapExistingZUIP = new map<String,Id>();
            for(ZPIF_UIP__c zuip: ExstngZuips) {mapExistingZUIP.put(zuip.ZPIF_UIP_Identidier__c,zuip.Id);}
            System.debug('mapExistingZUIP '+mapExistingZUIP);
            List<ZPIF_UIP__c> zuips = new List<ZPIF_UIP__c>();
            Map<String, SObjectField> fields = Schema.getGlobalDescribe().get('ZPIF_UIP__c').getDescribe().fields.getMap();
            List<RecordType> recs = [SELECT Id,DeveloperName FROM RecordType WHERE sobjecttype = 'ZPIF_UIP__c'];
            System.debug('fields '+fields);
            System.debug('recs '+recs);
            Map<String,Id> mapRecId = new Map<String,Id>();
            for(RecordType rec:recs) { mapRecId.put(rec.DeveloperName, rec.Id); }
            System.debug('mapRecId '+mapRecId);
            System.debug('fields.keySet() '+fields.keySet());
            for(UIP__c var:uips){
                ZPIF_UIP__c inserting = new ZPIF_UIP__c();
                for(String f : fields.keySet()){
                    if(!mapExistingZUIP.containsKey(var.ZPIF_UIP_Identidier__c)){
                        if((f.contains('__c') || f.contains('__C')) && !fields.get(f).getDescribe().isCalculated()){ inserting.put(f , var.get(f)); }
                        else if((f.contains('__c') || f.contains('__C')) && !fields.get(f).getDescribe().isCalculated() && fields.get(f).getDescribe().isUpdateable()){ inserting.put(f , var.get(f)); }
                    }             
                }
                if(mapExistingZUIP.containsKey(var.ZPIF_UIP_Identidier__c)){inserting.Id = mapExistingZUIP.get(var.ZPIF_UIP_Identidier__c);}
                else{inserting.RecordTypeId = mapRecId.get(var.RecordType.DeveloperName);}
                inserting.Name = var.Name;                
                inserting.Public_Facing__c = true; 
                System.debug('inserting '+inserting);
                zuips.add(inserting);
            }
            System.debug('zuips '+zuips);
            if(zuips.size()>0) { try{upsert zuips; }catch(Exception e){System.debug('e '+e);}}
    }
    
    public static void insertToCache(UIP_Contact__c[] trigOld,UIP_Contact__c[] trigNew){
       for(UIP_Contact__c var:trigNew){
          var.ZPIF_UIP_Identidier__c = NewGuid();
     }
     insertToCache(trigNew);
    }    
    
    public static void insertToCache(UIP_Contact__c[] uipCons){
            string fieldsAPIname = ObjectFields('UIP_Contact__c');        
            String qry = 'Select '+fieldsAPIname+' from UIP_Contact__c where Id IN :uipCons';
            List<UIP_Contact__c> uipContacts = Database.query(qry);
            System.debug('uipContacts ' + uipContacts);
            List<String> identifiers = new List<String>();
            List<UIP_Contact__c> upContacts = new List<UIP_Contact__c>(); 
            List<Id> uipIds = updUIPId;
            System.debug('uipIds '+uipIds);
            for(UIP_Contact__c uCon : uipContacts)  {
                if(uCon.ZPIF_UIP_Identidier__c == null){
                    uCon.ZPIF_UIP_Identidier__c = NewGuid();
                    upContacts.add(uCon);
                }
                identifiers.add(uCon.ZPIF_UIP_Identidier__c);
            }
            System.debug('upContacts ' + upContacts);
            System.debug('identifiers ' + identifiers);
            map<Id,Id> mapUIPZ = getZPIFFUIPForUIP(uipIds);
            System.debug('mapUIPZ '+mapUIPZ);
            if(upContacts.size()>0) {try{update upContacts;}catch(Exception e){System.debug('e '+e);}}
            List<ZPF_UIP_Contact__c> ExstngZuips = [Select ZPIF_UIP_Identidier__c,Id from ZPF_UIP_Contact__c where ZPIF_UIP_Identidier__c IN :identifiers];
            System.debug('ExstngZuips '+ExstngZuips);
            map<String,Id> mapExistingZUIP = new map<String,Id>();
            for(ZPF_UIP_Contact__c zuip: ExstngZuips) {mapExistingZUIP.put(zuip.ZPIF_UIP_Identidier__c,zuip.Id);}
            System.debug('mapExistingZUIP '+mapExistingZUIP);
            List<ZPF_UIP_Contact__c> zuips = new LIST<ZPF_UIP_Contact__c>();
            Map<String, SObjectField> fields = Schema.getGlobalDescribe().get('ZPF_UIP_Contact__c').getDescribe().fields.getMap();
            System.debug('fields '+fields);
            for(UIP_Contact__c var:uipContacts){
                ZPF_UIP_Contact__c inserting = new ZPF_UIP_Contact__c();
                for(String f:fields.keySet()){
                    if(mapExistingZUIP.containsKey(var.ZPIF_UIP_Identidier__c)){
                        if((f.contains('__c') || f.contains('__C')) && !fields.get(f).getDescribe().isCalculated()){
                            if(f.equalsIgnoreCase('UIP__c')){inserting.put(f,mapUIPZ.get((ID)var.get(f)));}
                            else{inserting.put(f,var.get(f));}                          
                        }
                        else if((f.contains('__c') || f.contains('__C')) && !fields.get(f).getDescribe().isCalculated() && fields.get(f).getDescribe().isUpdateable()){
                            if(f.equalsIgnoreCase('UIP__c')){inserting.put(f,mapUIPZ.get((ID)var.get(f)));}
                            else{inserting.put(f,var.get(f));}                          
                        }
                    }
                } 
                if(mapExistingZUIP.containsKey(var.ZPIF_UIP_Identidier__c)) {inserting.Id = mapExistingZUIP.get(var.ZPIF_UIP_Identidier__c);}
                inserting.Public_Facing__c = true;
                System.debug('inserting '+inserting);
                zuips.add(inserting);
                System.debug('zuips ' + zuips);
            }
            if(zuips.size()>0){try{upsert zuips;}catch(Exception e){System.debug('e '+e);}}
            deleteContactsFromCache(identifiers);
    }    
    
    public static void deleteContactsFromCache(List<String> identifiers){
        System.debug('updUIPId '+updUIPId);
        List<Id> listIds = updUIPId;
        map<Id,Id> mapUIP = getZPIFFUIPForUIP(listIds);
        System.debug('mapUIP '+mapUIP.keySet());
        List<ZPF_UIP_Contact__c> deletedZPF = [Select ZPIF_UIP_Identidier__c, Id from ZPF_UIP_Contact__c where ZPIF_UIP_Identidier__c NOT IN :identifiers and UIP__c IN :mapUIP.keySet()];
        System.debug('deletedZPF '+deletedZPF);
        if(!deletedZPF.isEmpty() && deletedZPF.size()>0){try{delete deletedZPF;}catch(Exception e){System.debug('e '+e);}}
    }
    
    // Inserting Addendum's from trigger
    public static void insertToCache(Addendum__c[] trigOld,Addendum__c[] trigNew){
        for(Addendum__c var:trigNew){
            var.ZPIF_UIP_Identidier__c = NewGuid();
        }
        insertToCache(trigNew);
    }    
   
    public static void insertToCache(Addendum__c[] addends){
            string fieldsAPIname = ObjectFields('Addendum__c');        
            String qry = 'Select '+fieldsAPIname+',RecordType.DeveloperName from Addendum__c where Id IN :addends';
            LIST<Addendum__c> uipContacts = Database.query(qry);
            System.debug('uipContacts '+uipContacts);
            List<String> identifiers = new List<String>();
            List<Addendum__c> upContacts = new List<Addendum__c>(); 
            List<Id> uipIds = updUIPId;
            for(Addendum__c uCon : uipContacts)  {
                if(uCon.ZPIF_UIP_Identidier__c == null){
                    uCon.ZPIF_UIP_Identidier__c = NewGuid();
                    upContacts.add(uCon);
                }
                System.debug('upContacts ' + upContacts);
                identifiers.add(uCon.ZPIF_UIP_Identidier__c);
            }
            System.debug('identifiers '+identifiers);
            map<Id,Id> mapUIPZ = getZPIFFUIPForUIP(uipIds);
            System.debug('mapUIPZ ' + mapUIPZ);
            if(upContacts.size()>0) { update upContacts; }
            List<ZPF_Addendum__c> ExstngZuips = [Select ZPIF_UIP_Identidier__c,Id from ZPF_Addendum__c where ZPIF_UIP_Identidier__c IN :identifiers];
            System.debug('ExstngZuips '+ExstngZuips);
            map<String,Id> mapExistingZUIP = new map<String,Id>();
            for(ZPF_Addendum__c zuip: ExstngZuips) {mapExistingZUIP.put(zuip.ZPIF_UIP_Identidier__c,zuip.Id);}
            System.debug('mapExistingZUIP '+mapExistingZUIP);
            LIST<ZPF_Addendum__c> zuips = new LIST<ZPF_Addendum__c>();
            Map<String, SObjectField> fields = Schema.getGlobalDescribe().get('ZPF_Addendum__c').getDescribe().fields.getMap();
            System.debug('fields '+ fields);
            List<RecordType> recs = [SELECT Id,DeveloperName,Name FROM RecordType WHERE sobjecttype = 'ZPF_Addendum__c'];
            Map<String,Id> mapRecId = new Map<String,Id>();
            for(RecordType rec : recs) { mapRecId.put(rec.DeveloperName, rec.Id);  }        
            for(Addendum__c var:uipContacts){
                ZPF_Addendum__c inserting = new ZPF_Addendum__c();
                for(String f : fields.keySet()){    
                    System.debug('fields.keySet() '+ fields.keySet());
                     if(mapExistingZUIP.containsKey(var.ZPIF_UIP_Identidier__c)){
                        // action is insert
                        if((f.contains('__c') || f.contains('__C')) && !fields.get(f).getDescribe().isCalculated()){
                            if(f.equalsIgnoreCase('UIP__c') || f.equalsIgnoreCase('School_UIP__c') || f.equalsIgnoreCase('District_UIP_for_Combined_Plans__c') ){ inserting.put(f,mapUIPZ.get((ID)var.get(f))); }
                                else{ if(!f.equalsIgnoreCase('UIP__c')) {inserting.put(f,var.get(f));} }
                        }
                    else{
                        //update
                        if((f.contains('__c') || f.contains('__C')) && !fields.get(f).getDescribe().isCalculated() && fields.get(f).getDescribe().isUpdateable()){
                            if(f.equalsIgnoreCase('UIP__c') || f.equalsIgnoreCase('School_UIP__c') || f.equalsIgnoreCase('District_UIP_for_Combined_Plans__c') ){
                                inserting.put(f,mapUIPZ.get((ID)var.get(f))); }
                                else{ if(!f.equalsIgnoreCase('UIP__c')){inserting.put(f,var.get(f));} }
                        }
                    }             
                } 
                }
                System.debug('inserting '+inserting);
                if(mapExistingZUIP.containsKey(var.ZPIF_UIP_Identidier__c)) {inserting.Id = mapExistingZUIP.get(var.ZPIF_UIP_Identidier__c);}
                else{inserting.RecordTypeId = mapRecId.get(var.RecordType.DeveloperName);}
                inserting.Name = var.Name;
                inserting.Public_Facing__c = true;          
                zuips.add(inserting);
            }
            System.debug('zuips '+zuips);
            if(zuips.size()>0){try{upsert zuips;}catch(Exception e){System.debug('e '+e);}}
            deleteAddendumFromCache(identifiers);           
    }
    
    public static void deleteAddendumFromCache(List<String> identifiers){
        System.debug('updUIPId '+updUIPId);
        List<Id> listIds = updUIPId;
        map<Id,Id> mapUIP = getZPIFFUIPForUIP(listIds);
        System.debug('mapUIP '+mapUIP.keySet());
        List<ZPF_Addendum__c> deletedZPF = [Select ZPIF_UIP_Identidier__c,Id from ZPF_Addendum__c where ZPIF_UIP_Identidier__c NOT IN :identifiers and ( UIP__c IN :mapUIP.keySet() or School_UIP__c  IN :mapUIP.keySet() or District_UIP_for_Combined_Plans__c  IN :mapUIP.keySet())];
        System.debug('deletedZPF '+deletedZPF);
        if(!deletedZPF.isEmpty() && deletedZPF.size()>0){try{delete deletedZPF;}catch(Exception e){System.debug('e '+e);}}
    }    
    
    //upserting ZPF_UIP_Element__c when published
    public static void insertToCache(UIP_Element__c[] trigOld,UIP_Element__c[] trigNew){
        for(UIP_Element__c var:trigNew){
            var.ZPIF_UIP_Identidier__c = NewGuid();
        }
        insertToCache(trigNew);
    }    
    
    public static void insertToCache(UIP_Element__c[] elemnts){
            string fieldsAPIname = ObjectFields('UIP_Element__c');        
            String qry = 'Select '+fieldsAPIname+',RecordType.DeveloperName from UIP_Element__c where Id IN :elemnts';
            LIST<UIP_Element__c> uipContacts = Database.query(qry);
            System.debug('uipContacts '+uipContacts);
            List<String> identifiers = new List<String>();
            List<UIP_Element__c> upContacts = new List<UIP_Element__c>(); 
            List<Id> uipIds = updUIPId;
            List<Id> uipElemIds = new List<Id>();
            for(UIP_Element__c uipCon : uipContacts)  {
                uipElemIds.add(uipCon.Id);
                for (Integer i = 1; i <= 9; i++) { uipElemIds.add((ID)uipCon.get('Challenge_' + i + '__c'));  }
                for (Integer i = 1; i <= 9; i++) { uipElemIds.add((ID)uipCon.get('Major_Improvement_Strategy_' + i + '__c')); }    
                 for (Integer i = 1; i <= 9; i++) { uipElemIds.add((ID)uipCon.get('Root_Cause_' + i + '__c')); }  
                if(uipCon.ZPIF_UIP_Identidier__c == null){
                    uipCon.ZPIF_UIP_Identidier__c = NewGuid();
                    upContacts.add(new UIP_Element__c(Id = uipCon.Id, ZPIF_UIP_Identidier__c = uipCon.ZPIF_UIP_Identidier__c));
                }
                System.debug('upContacts ' + upContacts);
                identifiers.add(uipCon.ZPIF_UIP_Identidier__c);
            }
            System.debug('uipElemIds '+uipElemIds);
            System.debug('identifiers '+identifiers);
            if(upContacts.size()>0) {update upContacts;}
            map<Id,Id> mapUIPZ = getZPIFFUIPForUIP(uipIds);
            List<ZPF_UIP_Element__c> ExstngZuips = [Select ZPIF_UIP_Identidier__c,Id from ZPF_UIP_Element__c where ZPIF_UIP_Identidier__c IN :identifiers];
            map<String,Id> mapExistingZUIP = new map<String,Id>();
            for(ZPF_UIP_Element__c zuip: ExstngZuips) {mapExistingZUIP.put(zuip.ZPIF_UIP_Identidier__c,zuip.Id);}
            List<ZPF_UIP_Element__c> zuips = new List<ZPF_UIP_Element__c>();
            Map<String, SObjectField> fields = Schema.getGlobalDescribe().get('ZPF_UIP_Element__c').getDescribe().fields.getMap();
            List<RecordType> recs = [SELECT Id,DeveloperName,Name FROM RecordType WHERE sobjecttype = 'ZPF_UIP_Element__c'];
            Map<String,Id> mapRecId = new Map<String,Id>();
            for(RecordType rec:recs) { mapRecId.put(rec.DeveloperName, rec.Id);  }
            for(UIP_Element__c var : uipContacts){
                ZPF_UIP_Element__c inserting = new ZPF_UIP_Element__c();
                for(String field : fields.keySet()){                    
                    if(mapExistingZUIP.containsKey(var.ZPIF_UIP_Identidier__c)){
                        if((field.contains('__c') || field.contains('__C')) && !fields.get(field).getDescribe().isCalculated()){
                            if(field.equalsIgnoreCase('UIP__c')){ inserting.put(field,mapUIPZ.get((ID)var.get(field))); }
                            else {inserting.put(field,var.get(field)); }
                        }
                    else{
                        if((field.contains('__c') || field.contains('__C')) && !fields.get(field).getDescribe().isCalculated() && fields.get(field).getDescribe().isUpdateable()){
                            if(field.equalsIgnoreCase('UIP__c')){ inserting.put(field,mapUIPZ.get((ID)var.get(field)));}
                            else{ inserting.put(field,var.get(field));}
                        }                       
                    }             
                }        
                if(mapExistingZUIP.containsKey(var.ZPIF_UIP_Identidier__c)) {inserting.Id = mapExistingZUIP.get(var.ZPIF_UIP_Identidier__c); }
                else{ inserting.RecordTypeId = mapRecId.get(var.RecordType.DeveloperName); }
                }               
                inserting.Name = var.Name;                       
                inserting.Public_Facing__c = true;          
                System.debug('inserting '+inserting);
                zuips.add(inserting);
            }
            System.debug('zuips '+zuips);
            if(zuips.size()>0){try{upsert zuips;}catch(Exception e){System.debug('e '+e);}}
            map<Id,Id> mapElem = getZPFElementForUIP(uipElemIds);
            ExstngZuips = [Select ZPIF_UIP_Identidier__c,Id from ZPF_UIP_Element__c where ZPIF_UIP_Identidier__c IN :identifiers];
            mapExistingZUIP = new map<String,Id>();
            for(ZPF_UIP_Element__c zuip: ExstngZuips) {mapExistingZUIP.put(zuip.ZPIF_UIP_Identidier__c,zuip.Id); }
            List<ZPF_UIP_Element__c> updates = new List<ZPF_UIP_Element__c>();
            for(UIP_Element__c var:uipContacts){
                if(mapExistingZUIP.containsKey(var.ZPIF_UIP_Identidier__c)) {
                    ZPF_UIP_Element__c inserting = new ZPF_UIP_Element__c();
                    inserting.Id = mapExistingZUIP.get(var.ZPIF_UIP_Identidier__c);
                    for(String field:fields.keySet()){
                        if((field.contains('__c') || field.contains('__C')) && !fields.get(field).getDescribe().isCalculated()){
                            if(field.contains('root_cause_') || field.contains('challenge_') || field.contains('major_improvement_strategy_')) {
                                if(mapElem.containsKey((ID)var.get(field))) {inserting.put(field,mapElem.get((ID)var.get(field)));}
                            }
                        }
                    }
                    System.debug('inserting '+inserting);
                    updates.add(inserting);
                }
            }
            System.debug('updates '+updates);
            if(updates.size()>0){try{update updates;}catch(Exception e){System.debug('e '+e);}}
            deleteElementFromCache(identifiers);   
    }         
    
    public static void deleteElementFromCache(List<String> identifiers){
        System.debug('updUIPId '+updUIPId);
        List<Id> listIds = updUIPId;
        map<Id,Id> mapUIP = getZPIFFUIPForUIP(listIds);
        System.debug('mapUIP '+mapUIP.keySet());
        List<ZPF_UIP_Element__c> deletedZPF = [Select ZPIF_UIP_Identidier__c,Id from ZPF_UIP_Element__c where ZPIF_UIP_Identidier__c NOT IN :identifiers and UIP__c IN :mapUIP.keySet()];
        if(!deletedZPF.isEmpty() && deletedZPF.size()>0){try{delete deletedZPF;}catch(Exception e){System.debug('e '+e);}}
    }     
 
    // insering ZPF_Improvement_Action_Step__c from trigger    
    public static void insertToCache(Improvement_Action_Step__c[] trigOld,Improvement_Action_Step__c[] trigNew){
        for(Improvement_Action_Step__c var:trigNew){
            var.ZPIF_UIP_Identidier__c = NewGuid();
        }
        insertToCache(trigNew);
    }    
    
    public static void insertToCache(Improvement_Action_Step__c[] Actnsteps){
            string fieldsAPIname = ObjectFields('Improvement_Action_Step__c');        
            String qry = 'Select '+fieldsAPIname+' from Improvement_Action_Step__c where Id IN :Actnsteps';
            List<Improvement_Action_Step__c> uipContacts = Database.query(qry);
            System.debug('uipContacts '+uipContacts);
            List<String> identifiers = new List<String>();
            List<Improvement_Action_Step__c> upContacts = new List<Improvement_Action_Step__c>(); 
            List<Id> uipIds = updUIPId;
            List<Id> uipElemIds = new List<Id>();
            for(Improvement_Action_Step__c uipCon:uipContacts)  {
                for (Integer i = 1; i <= 5; i++) { uipElemIds.add((ID)uipCon.get('Root_Cause_' + i + '__c')); }                 
                uipElemIds.add((ID)uipCon.get('Major_Improvement_Strategy__c'));                                    
                if(uipCon.ZPIF_UIP_Identidier__c == null){ uipCon.ZPIF_UIP_Identidier__c = NewGuid(); upContacts.add(uipCon); }
                System.debug('upContacts ' + upContacts);
                identifiers.add(uipCon.ZPIF_UIP_Identidier__c);
            }
            System.debug('uipElemIds '+uipElemIds);
            System.debug('identifiers '+identifiers);
            if(upContacts.size()>0) {update upContacts;}
            map<Id,Id> mapUIPZ = getZPIFFUIPForUIP(uipIds); 
            map<Id,Id> mapElem = getZPFElementForUIP(uipElemIds);   
            List<ZPF_Improvement_Action_Step__c> ExstngZuips = [Select ZPIF_UIP_Identidier__c,Id from ZPF_Improvement_Action_Step__c where ZPIF_UIP_Identidier__c IN :identifiers];
            System.debug('ExstngZuips '+ExstngZuips);
            map<String,Id> mapExistingZUIP = new map<String,Id>();
            for(ZPF_Improvement_Action_Step__c zuip: ExstngZuips) {mapExistingZUIP.put(zuip.ZPIF_UIP_Identidier__c,zuip.Id);}
            List<ZPF_Improvement_Action_Step__c> zuips = new List<ZPF_Improvement_Action_Step__c>();
            Map<String, SObjectField> fields = Schema.getGlobalDescribe().get('ZPF_Improvement_Action_Step__c').getDescribe().fields.getMap();          
            for(Improvement_Action_Step__c var:uipContacts){
                ZPF_Improvement_Action_Step__c inserting = new ZPF_Improvement_Action_Step__c();
                for(String field:fields.keySet()){                  
                    if(mapExistingZUIP.containsKey(var.ZPIF_UIP_Identidier__c)){
                        if((field.contains('__c') || field.contains('__C')) && !fields.get(field).getDescribe().isCalculated()){
                            if(field.equalsIgnoreCase('UIP__c')){ inserting.put(field,mapUIPZ.get((ID)var.get(field))); }
                            else if(field.contains('root_cause_')){
                                if(mapElem.containsKey((ID)var.get(field))){inserting.put(field,mapElem.get((ID)var.get(field)));}
                                }
                            else if(field.equalsIgnoreCase('Major_Improvement_Strategy__c')){
                                    if(mapElem.containsKey((ID)var.get(field))){inserting.put(field,mapElem.get((ID)var.get(field)));}
                                }
                            else{inserting.put(field,var.get(field));}
                        }
                    else if((field.contains('__c') || field.contains('__C')) && !fields.get(field).getDescribe().isCalculated() && fields.get(field).getDescribe().isUpdateable()){
                            if(field.equalsIgnoreCase('UIP__c')){inserting.put(field,mapUIPZ.get((ID)var.get(field)));}
                            else if(field.contains('root_cause_')){
                                    if(mapElem.containsKey((ID)var.get(field))){inserting.put(field,mapElem.get((ID)var.get(field)));}
                            }else if(field.equalsIgnoreCase('Major_Improvement_Strategy__c')){
                                    if(mapElem.containsKey((ID)var.get(field))){inserting.put(field,mapElem.get((ID)var.get(field)));}
                            }
                            else{inserting.put(field,var.get(field));}
                        }
                    }             
                }
                if(mapExistingZUIP.containsKey(var.ZPIF_UIP_Identidier__c)){inserting.Id = mapExistingZUIP.get(var.ZPIF_UIP_Identidier__c);}
                inserting.Name = var.Name;                                   
                inserting.Public_Facing__c = true;
                System.debug('inserting '+inserting);
                zuips.add(inserting);
            }
            System.debug('zuips '+zuips);
        if(zuips.size()>0){try{upsert zuips;}catch(Exception e){System.debug('e '+e);}}
        deleteImprActionStpFromCache(identifiers);
    }
    
    public static void deleteImprActionStpFromCache(List<String> identifiers){
        System.debug('updUIPId '+updUIPId);
        List<Id> listIds = updUIPId;
        map<Id,Id> mapUIP = getZPIFFUIPForUIP(listIds);
        System.debug('mapUIP '+mapUIP.keySet());
        List<ZPF_Improvement_Action_Step__c> deletedZPF = [Select ZPIF_UIP_Identidier__c,Id from ZPF_Improvement_Action_Step__c where ZPIF_UIP_Identidier__c NOT IN :identifiers and UIP__C IN :mapUIP.keySet()];
        if(!deletedZPF.isEmpty() && deletedZPF.size()>0){try{delete deletedZPF;}catch(Exception e){System.debug('e '+e);}}      
    }  
    
    // insering ZPF_Implementation_Benchmark__c from trigger    
    public static void insertToCache(Implementation_Benchmark__c[] trigOld,Implementation_Benchmark__c[] trigNew){
        for(Implementation_Benchmark__c var:trigNew){
            var.ZPIF_UIP_Identidier__c = NewGuid();
        }
        insertToCache(trigNew);
    }    
    public static void insertToCache(Implementation_Benchmark__c[] Actnsteps){
            String fieldsAPIname=ObjectFields('Implementation_Benchmark__c');        
            String qry = 'Select '+fieldsAPIname+' from Implementation_Benchmark__c where Id IN :Actnsteps';
            List<Implementation_Benchmark__c> uipContacts = Database.query(qry);
            System.debug('uipContacts '+uipContacts);
            List<String> identifiers = new List<String>();
            List<Implementation_Benchmark__c> upContacts = new List<Implementation_Benchmark__c>(); 
            List<Id> uipIds = updUIPId;
            List<Id> uipElemIds = new List<Id>();
            List<Id> uipImpActStp = new List<Id>();
            for(Implementation_Benchmark__c uipCon:uipContacts)  {
                uipImpActStp.add(uipCon.Action_Step__c);              
                uipElemIds.add(uipCon.Major_Improvement_Strategy__c);                                   
                if(uipCon.ZPIF_UIP_Identidier__c == null){
                    uipCon.ZPIF_UIP_Identidier__c = NewGuid();
                    upContacts.add(uipCon);
                }
                identifiers.add(uipCon.ZPIF_UIP_Identidier__c);
            }
            System.debug('uipImpActStp '+uipImpActStp);
            System.debug('upContacts '+upContacts);
            if(upContacts.size()>0) update upContacts;          
            map<Id,Id> mapUIPZ = getZPIFFUIPForUIP(uipIds); 
            system.debug('uipElemIds:: '+uipElemIds);   
            mapUIPElemCache = null;
            map<Id,Id> mapElem = getZPFElementForUIP(uipElemIds);       
            map<Id,Id> mapImpActStps = getZPFImplActionStepsForUIP(uipImpActStp);
            LIST<ZPF_Implementation_Benchmark__c> ExstngZuips = [Select ZPIF_UIP_Identidier__c,Id from ZPF_Implementation_Benchmark__c where ZPIF_UIP_Identidier__c IN :identifiers];
            map<String,Id> mapExistingZUIP = new map<String,Id>();
            for(ZPF_Implementation_Benchmark__c zuip: ExstngZuips) {mapExistingZUIP.put(zuip.ZPIF_UIP_Identidier__c,zuip.Id);}
            LIST<ZPF_Implementation_Benchmark__c> zuips = new LIST<ZPF_Implementation_Benchmark__c>();
            Map<String, SObjectField> fields = Schema.getGlobalDescribe().get('ZPF_Implementation_Benchmark__c').getDescribe().fields.getMap();         
            for(Implementation_Benchmark__c var:uipContacts){
                ZPF_Implementation_Benchmark__c inserting = new ZPF_Implementation_Benchmark__c();
                for(String field:fields.keySet()){                  
                    if(mapExistingZUIP.containsKey(var.ZPIF_UIP_Identidier__c)){
                        if((field.contains('__c') || field.contains('__C')) && !fields.get(field).getDescribe().isCalculated()){
                            if(field.equalsIgnoreCase('UIP__c')){inserting.put(field,mapUIPZ.get((ID)var.get(field)));}
                            else if(field.equalsIgnoreCase('Action_Step__c')){
                                    if(mapImpActStps.containsKey((ID)var.get(field)))
                                        inserting.put(field,mapImpActStps.get((ID)var.get(field)));}
                            else if(field.equalsIgnoreCase('Major_Improvement_Strategy__c')){
                                    if(mapElem.containsKey((ID)var.get(field))){inserting.put(field,mapElem.get((ID)var.get(field)));}}
                            else{inserting.put(field,var.get(field));}
                        }
                    else if((field.contains('__c') || field.contains('__C')) && !fields.get(field).getDescribe().isCalculated() && fields.get(field).getDescribe().isUpdateable()){
                            if(field.equalsIgnoreCase('UIP__c')){inserting.put(field,mapUIPZ.get((ID)var.get(field)));}
                            else if(field.equalsIgnoreCase('Action_Step__c')){
                                    if(mapImpActStps.containsKey((ID)var.get(field))){inserting.put(field,mapImpActStps.get((ID)var.get(field)));}
                                }
                            else if(field.equalsIgnoreCase('Major_Improvement_Strategy__c')){
                                    if(mapElem.containsKey((ID)var.get(field))){inserting.put(field,mapElem.get((ID)var.get(field)));}
                                }
                            else{inserting.put(field,var.get(field));}
                        }                       
                    }             
                }        
                if(mapExistingZUIP.containsKey(var.ZPIF_UIP_Identidier__c)){inserting.Id = mapExistingZUIP.get(var.ZPIF_UIP_Identidier__c);}
                inserting.Name = var.Name;                       
                inserting.Public_Facing__c = true;          
                zuips.add(inserting);
            }
        if(zuips.size()>0){try{upsert zuips;}catch(Exception e){System.debug('e '+e);}}
        deleteImprBnchMrkFromCache(identifiers);
    }
    
    public static void deleteImprBnchMrkFromCache(List<String> identifiers){
        System.debug('updUIPId '+updUIPId);
        List<Id> listIds = updUIPId;
        map<Id,Id> mapUIP = getZPIFFUIPForUIP(listIds);
        System.debug('mapUIP '+mapUIP.keySet());
        List<ZPF_Implementation_Benchmark__c> deletedZPF = [Select ZPIF_UIP_Identidier__c,Id from ZPF_Implementation_Benchmark__c where ZPIF_UIP_Identidier__c NOT IN :identifiers and UIP__C IN :mapUIP.keySet()];
        if(!deletedZPF.isEmpty() && deletedZPF.size()>0){try{delete deletedZPF;}catch(Exception e){System.debug('e '+e);}}      
    }         
        
    // insering ZPF_BenchMar_AtciontStep__c from trigger    
    public static void insertToCache(BenchMar_AtciontStep__c[] trigOld,BenchMar_AtciontStep__c[] trigNew){
        for(BenchMar_AtciontStep__c var:trigNew){
            var.ZPIF_UIP_Identidier__c = NewGuid();
        }
        insertToCache(trigNew);
    }    
    
    public static void insertToCache(BenchMar_AtciontStep__c[] marksb){
            string fieldsAPIname = ObjectFields('BenchMar_AtciontStep__c');        
            String qry = 'Select '+fieldsAPIname+' from BenchMar_AtciontStep__c where Id IN :marksb';
            List<BenchMar_AtciontStep__c> uipContacts = Database.query(qry);
            System.debug('uipContacts '+uipContacts);
            List<String> identifiers = new List<String>();
            List<BenchMar_AtciontStep__c> upContacts = new List<BenchMar_AtciontStep__c>(); 
            List<Id> actstps = new List<Id>();
            List<Id> bnchMark = new List<Id>();
            List<Id> uipElemIds = new List<Id>();
            for(BenchMar_AtciontStep__c uipCon:uipContacts)  {
                bnchMark.add(uipCon.Implementation_Benchmark__c);
                actstps.add(uipCon.Improvement_Action_Step__c); 
                if(uipCon.ZPIF_UIP_Identidier__c == null){
                    uipCon.ZPIF_UIP_Identidier__c = NewGuid();
                    upContacts.add(uipCon);
                }                           
                identifiers.add(uipCon.ZPIF_UIP_Identidier__c);
            }
            System.debug('identifiers '+identifiers);
            System.debug('bnchMark '+bnchMark);
            System.debug('actstps '+actstps);
            System.debug('upContacts '+upContacts);
            if(upContacts.size()>0) {update upContacts;}
            Map<Id,Id> mapImprActzpf = getImprActStp(actstps);
            Map<Id,Id> mapImpBenchMarkzpf = getImpBenchMarkzpf(bnchMark);
            //map<Id,Id> mapElem = getZPFElementForUIP(uipElemIds);
            List<ZPF_BenchMar_AtciontStep__c> ExstngZuips = [Select ZPIF_UIP_Identidier__c,Id from ZPF_BenchMar_AtciontStep__c where ZPIF_UIP_Identidier__c IN :identifiers and ZPIF_UIP_Identidier__c != null];
            map<String,Id> mapExistingZUIP = new map<String,Id>();
            for(ZPF_BenchMar_AtciontStep__c zuip: ExstngZuips) {mapExistingZUIP.put(zuip.ZPIF_UIP_Identidier__c,zuip.Id);}
            List<ZPF_BenchMar_AtciontStep__c> zuips = new List<ZPF_BenchMar_AtciontStep__c>();
            for(BenchMar_AtciontStep__c var:uipContacts){
                ZPF_BenchMar_AtciontStep__c inserting = new ZPF_BenchMar_AtciontStep__c();              
                if(mapExistingZUIP.containsKey(var.ZPIF_UIP_Identidier__c)){inserting.Id = mapExistingZUIP.get(var.ZPIF_UIP_Identidier__c);}
                if(mapImpBenchMarkzpf.containsKey(var.Implementation_Benchmark__c)){inserting.ZPF_Implementation_Benchmark__c = mapImpBenchMarkzpf.get(var.Implementation_Benchmark__c);}
                if(mapImprActzpf.containsKey(var.Improvement_Action_Step__c)){inserting.ZPF_Improvement_Action_Step__c =  mapImprActzpf.get(var.Improvement_Action_Step__c);}
                inserting.ZPIF_UIP_Identidier__c =  var.ZPIF_UIP_Identidier__c;                          
                inserting.Public_Facing__c = true;  
                System.debug('inserting '+inserting);
                zuips.add(inserting);
            }
            System.debug('zuips '+zuips);
            if(zuips.size()>0){try{upsert zuips;}catch(Exception e){System.debug('e '+e);}}
            deleteBnMarkActStpFromCache(identifiers);
    }
    
    public static void deleteBnMarkActStpFromCache(List<String> identifiers){
        System.debug('updUIPId '+updUIPId);
        List<Id> listIds = updUIPId;
        map<Id,Id> mapUIP = getZPIFFUIPForUIP(listIds);
        System.debug('mapUIP '+mapUIP.keySet());
        List<ZPF_BenchMar_AtciontStep__c> deletedZPF = [Select ZPIF_UIP_Identidier__c,Id from ZPF_BenchMar_AtciontStep__c where ZPIF_UIP_Identidier__c NOT IN :identifiers and (ZPF_Improvement_Action_Step__r.UIP__c IN :mapUIP.keySet() or ZPF_Improvement_Action_Step__r.UIP__c IN :mapUIP.keySet())];
        if(!deletedZPF.isEmpty() && deletedZPF.size()>0){try{delete deletedZPF;}catch(Exception e){System.debug('e '+e);}}
    } 
    
    // insering ZPF_Performance_Indicator_Targets__c from trigger    
    public static void insertToCache(Performance_Indicator_Targets__c[] trigOld,Performance_Indicator_Targets__c[] trigNew){
        for(Performance_Indicator_Targets__c var:trigNew){
            var.ZPIF_UIP_Identidier__c = NewGuid();
        }
        insertToCache(trigNew);
    }    
    
    public static void insertToCache(Performance_Indicator_Targets__c[] perfIndTrgts){
            string fieldsAPIname = ObjectFields('Performance_Indicator_Targets__c');        
            String qry = 'Select '+fieldsAPIname+',RecordType.DeveloperName from Performance_Indicator_Targets__c where Id IN :perfIndTrgts';
            LIST<Performance_Indicator_Targets__c> uipContacts = Database.query(qry);
            List<String> identifiers = new List<String>();
            List<Performance_Indicator_Targets__c> upContacts = new List<Performance_Indicator_Targets__c>(); 
            List<Id> uipIds = updUIPId;
            List<Id> uipElemIds = new List<Id>();
            List<Id> uipImpActStp = new List<Id>();
            for(Performance_Indicator_Targets__c uipCon:uipContacts)  {
                uipImpActStp.add(uipCon.Next_Year_Related_Target__c);              
                uipElemIds.add(uipCon.Major_Improvement_Strategy_1__c);
                uipElemIds.add(uipCon.Priority_Performance_Challenge_1__c);                                 
                if(uipCon.ZPIF_UIP_Identidier__c == null){
                    uipCon.ZPIF_UIP_Identidier__c = NewGuid();
                    upContacts.add(uipCon);
                }
                identifiers.add(uipCon.ZPIF_UIP_Identidier__c);
            }
            System.debug('upContacts ' + upContacts);
            System.debug('identifiers '+identifiers);
            if(upContacts.size()>0) {update upContacts;}
            map<Id,Id> mapUIPZ = getZPIFFUIPForUIP(uipIds); 
            system.debug('uipElemIds '+uipElemIds); 
            mapUIPElemCache = null;
            List<ZPF_Performance_Indicator_Targets__c> ExstngZuips = [Select ZPIF_UIP_Identidier__c,Id from ZPF_Performance_Indicator_Targets__c where ZPIF_UIP_Identidier__c IN :identifiers];
            map<String,Id> mapExistingZUIP = new map<String,Id>();
            for(ZPF_Performance_Indicator_Targets__c zuip: ExstngZuips) {mapExistingZUIP.put(zuip.ZPIF_UIP_Identidier__c,zuip.Id);}
            List<ZPF_Performance_Indicator_Targets__c> zuips = new LIST<ZPF_Performance_Indicator_Targets__c>();
            Map<String, SObjectField> fields = Schema.getGlobalDescribe().get('ZPF_Performance_Indicator_Targets__c').getDescribe().fields.getMap(); 
            List<RecordType> recs = [SELECT Id,DeveloperName,Name FROM RecordType WHERE sobjecttype = 'ZPF_Performance_Indicator_Targets__c'];
            Map<String,Id> mapRecId = new Map<String,Id>();
            for(RecordType rec:recs) {  mapRecId.put(rec.DeveloperName, rec.Id); }
            for(Performance_Indicator_Targets__c var:uipContacts){
                ZPF_Performance_Indicator_Targets__c inserting = new ZPF_Performance_Indicator_Targets__c();
                for(String field:fields.keySet()){
                    if(mapExistingZUIP.containsKey(var.ZPIF_UIP_Identidier__c)){
                        if((field.contains('__c') || field.contains('__C')) && !fields.get(field).getDescribe().isCalculated()){
                            if(field.equalsIgnoreCase('UIP__c')){inserting.put(field,mapUIPZ.get((ID)var.get(field)));}
                            else{inserting.put(field,var.get(field));}
                        }
                        else if((field.contains('__c') || field.contains('__C')) && !fields.get(field).getDescribe().isCalculated() && fields.get(field).getDescribe().isUpdateable()){
                            if(field.equalsIgnoreCase('UIP__c')){inserting.put(field,mapUIPZ.get((ID)var.get(field)));}
                            else{inserting.put(field,var.get(field));}
                        }                       
                    }             
                }
                System.debug('inserting '+inserting);
                if(mapExistingZUIP.containsKey(var.ZPIF_UIP_Identidier__c)){inserting.Id = mapExistingZUIP.get(var.ZPIF_UIP_Identidier__c);}
                else{inserting.RecordTypeId = mapRecId.get(var.RecordType.DeveloperName);}
                inserting.Public_Facing__c = true;          
                zuips.add(inserting);
            }
            System.debug('zuips '+zuips);
            if(zuips.size()>0){try{upsert zuips;}catch(Exception e){System.debug('e '+e);}}
            ExstngZuips = [Select ZPIF_UIP_Identidier__c,Id from ZPF_Performance_Indicator_Targets__c where ZPIF_UIP_Identidier__c IN :identifiers];
            mapExistingZUIP = new map<String,Id>();
            for(ZPF_Performance_Indicator_Targets__c zuip: ExstngZuips) {mapExistingZUIP.put(zuip.ZPIF_UIP_Identidier__c,zuip.Id);}
            map<Id,Id> mapPerfIndTargets = getZPFPerfIndTargetForUIP(uipImpActStp);
            map<Id,Id> mapElem = getZPFElementForUIP(uipElemIds);
            List<ZPF_Performance_Indicator_Targets__c> updates = new List<ZPF_Performance_Indicator_Targets__c>();
            for(Performance_Indicator_Targets__c var:uipContacts){
                if(mapExistingZUIP.containsKey(var.ZPIF_UIP_Identidier__c)){
                    ZPF_Performance_Indicator_Targets__c inserting = new ZPF_Performance_Indicator_Targets__c();
                    inserting.Id = mapExistingZUIP.get(var.ZPIF_UIP_Identidier__c); 
                    for(String field:fields.keySet()){
                        if((field.contains('__c') || field.contains('__C')) && !fields.get(field).getDescribe().isCalculated()){
                            if(field.equalsIgnoreCase('Major_Improvement_Strategy_1__c') || field.equalsIgnoreCase('Priority_Performance_Challenge_1__c')){
                                if(mapElem.containsKey((ID)var.get(field))){inserting.put(field,mapElem.get((ID)var.get(field)));}
                            }
                            else if(field.equalsIgnoreCase('Next_Year_Related_Target__c')){
                                if(mapPerfIndTargets.containsKey((ID)var.get(field))){inserting.put(field,mapPerfIndTargets.get((ID)var.get(field)));}
                            }
                        }
                    }
                    updates.add(inserting);
                }
            }
            System.debug('updates '+updates);
            update updates;
            deleteprfIndTargFromCache(identifiers);
    }
    
    public static void deleteprfIndTargFromCache(List<String> identifiers){
        System.debug('updUIPId '+updUIPId);
        List<Id> listIds = updUIPId;
        map<Id,Id> mapUIP = getZPIFFUIPForUIP(listIds);
        System.debug('mapUIP '+mapUIP.keySet());
        List<ZPF_Performance_Indicator_Targets__c> deletedZPF = [Select ZPIF_UIP_Identidier__c,Id from ZPF_Performance_Indicator_Targets__c where ZPIF_UIP_Identidier__c NOT IN :identifiers and UIP__C IN :mapUIP.keySet()];
        if(!deletedZPF.isEmpty() && deletedZPF.size()>0){try{delete deletedZPF;}catch(Exception e){System.debug('e '+e);}}
    }
 
    // insering ZPF_Performance_Indicator_Notable_Trends__c from trigger    
    public static void insertToCache(Performance_Indicator_Notable_Trends__c[] trigOld,Performance_Indicator_Notable_Trends__c[] trigNew){
        for(Performance_Indicator_Notable_Trends__c var:trigNew){
            var.ZPIF_UIP_Identidier__c = NewGuid();
        }
        insertToCache(trigNew);
    }    
    
    public static void insertToCache(Performance_Indicator_Notable_Trends__c[] perfIndTrnds){
            string fieldsAPIname = ObjectFields('Performance_Indicator_Notable_Trends__c');    
            String qry = 'Select '+fieldsAPIname+',RecordType.DeveloperName from Performance_Indicator_Notable_Trends__c where Id IN :perfIndTrnds';
            List<Performance_Indicator_Notable_Trends__c> uipContacts = Database.query(qry);
            List<String> identifiers = new List<String>();
            List<Performance_Indicator_Notable_Trends__c> upContacts = new List<Performance_Indicator_Notable_Trends__c>(); 
            List<Id> uipIds = updUIPId;
            List<Id> uipElemIds = new List<Id>();
            List<Id> uipImpActStp = new List<Id>();
            for(Performance_Indicator_Notable_Trends__c uipCon:uipContacts)  {
                uipElemIds.add(uipCon.Priority_Performance_Challenge_1__c);
                uipElemIds.add(uipCon.Root_Cause_1__c);                 
                if(uipCon.ZPIF_UIP_Identidier__c == null){
                    uipCon.ZPIF_UIP_Identidier__c = NewGuid();
                    upContacts.add(uipCon);
                }
                identifiers.add(uipCon.ZPIF_UIP_Identidier__c);
            }
            System.debug('identifiers '+identifiers);
            if(upContacts.size()>0) {update upContacts;}
            map<Id,Id> mapUIPZ = getZPIFFUIPForUIP(uipIds); 
            mapUIPElemCache = null; 
            map<Id,Id> mapElem = getZPFElementForUIP(uipElemIds);               
            List<ZPF_Performance_Indicator_Notable_Trends__c> ExstngZuips = [Select ZPIF_UIP_Identidier__c,Id from ZPF_Performance_Indicator_Notable_Trends__c where ZPIF_UIP_Identidier__c IN :identifiers];
            map<String,Id> mapExistingZUIP = new map<String,Id>();
            for(ZPF_Performance_Indicator_Notable_Trends__c zuip: ExstngZuips) {mapExistingZUIP.put(zuip.ZPIF_UIP_Identidier__c,zuip.Id);}
            List<ZPF_Performance_Indicator_Notable_Trends__c> zuips = new LIST<ZPF_Performance_Indicator_Notable_Trends__c>();
            Map<String, SObjectField> fields = Schema.getGlobalDescribe().get('ZPF_Performance_Indicator_Notable_Trends__c').getDescribe().fields.getMap();
            List<RecordType> recs = [SELECT Id,DeveloperName,Name FROM RecordType WHERE sobjecttype = 'ZPF_Performance_Indicator_Notable_Trends__c'];
            Map<String,Id> mapRecId = new Map<String,Id>();
            for(RecordType rec:recs) {mapRecId.put(rec.DeveloperName, rec.Id);}
            for(Performance_Indicator_Notable_Trends__c var:uipContacts){
                ZPF_Performance_Indicator_Notable_Trends__c inserting = new ZPF_Performance_Indicator_Notable_Trends__c();
                for(String field:fields.keySet()){                  
                    if(mapExistingZUIP.containsKey(var.ZPIF_UIP_Identidier__c)){
                        if((field.contains('__c') || field.contains('__C')) && !fields.get(field).getDescribe().isCalculated()){
                            if(field.equalsIgnoreCase('UIP__c')){inserting.put(field,mapUIPZ.get((ID)var.get(field)));}
                            else if(field.equalsIgnoreCase('Priority_Performance_Challenge_1__c') || field.equalsIgnoreCase('Root_Cause_1__c')){
                                    if(mapElem.containsKey((ID)var.get(field))){inserting.put(field,mapElem.get((ID)var.get(field)));}
                                }
                            else{inserting.put(field,var.get(field));}
                        }
                    }
                    else if((field.contains('__c') || field.contains('__C')) && !fields.get(field).getDescribe().isCalculated() && fields.get(field).getDescribe().isUpdateable()){
                            if(field.equalsIgnoreCase('UIP__c')){inserting.put(field,mapUIPZ.get((ID)var.get(field)));}
                            else if(field.equalsIgnoreCase('Priority_Performance_Challenge_1__c') || field.equalsIgnoreCase('Root_Cause_1__c')){
                                    if(mapElem.containsKey((ID)var.get(field))){inserting.put(field,mapElem.get((ID)var.get(field)));}
                                }
                            else{inserting.put(field,var.get(field));}
                        }       
                }           
                System.debug('inserting '+inserting);
                if(mapExistingZUIP.containsKey(var.ZPIF_UIP_Identidier__c)){inserting.Id = mapExistingZUIP.get(var.ZPIF_UIP_Identidier__c);}
                else{inserting.RecordTypeId = mapRecId.get(var.RecordType.DeveloperName);}                                                           
                inserting.Public_Facing__c = true;          
                zuips.add(inserting);
            }
            System.debug('zuips '+zuips);
            if(zuips.size()>0){try{upsert zuips;}catch(Exception e){System.debug('e '+e);}}
            deletePerIndNotRndsFromCache(identifiers);
    }
    
    public static void deletePerIndNotRndsFromCache(List<String> identifiers){
        System.debug('updUIPId '+updUIPId);
        List<Id> listIds = updUIPId;
        map<Id,Id> mapUIP = getZPIFFUIPForUIP(listIds);
        System.debug('mapUIP '+mapUIP.keySet());
        List<ZPF_Performance_Indicator_Notable_Trends__c> deletedZPF = [Select ZPIF_UIP_Identidier__c,Id from ZPF_Performance_Indicator_Notable_Trends__c where ZPIF_UIP_Identidier__c NOT IN :identifiers and UIP__C IN :mapUIP.keySet()];
        if(!deletedZPF.isEmpty() && deletedZPF.size()>0){try{delete deletedZPF;}catch(Exception e){System.debug('e '+e);}}
    }  
    
    //insering ZPF_Supporting_Addenda_Forms__c from trigger    
    public static void insertToCache(Supporting_Addenda_Forms__c[] trigOld,Supporting_Addenda_Forms__c[] trigNew){
        for(Supporting_Addenda_Forms__c var:trigNew){
            var.ZPIF_UIP_Identidier__c = NewGuid();
        }
        insertToCache(trigNew);
    }    
    
    public static void insertToCache(Supporting_Addenda_Forms__c[] supAddends){
            string fieldsAPIname = ObjectFields('Supporting_Addenda_Forms__c');        
            String qry = 'Select '+fieldsAPIname+' from Supporting_Addenda_Forms__c where Id IN :supAddends';
            List<Supporting_Addenda_Forms__c> uipContacts = Database.query(qry);
            System.debug('uipContacts '+uipContacts);
            List<String> identifiers = new List<String>();
            List<Supporting_Addenda_Forms__c> upContacts = new List<Supporting_Addenda_Forms__c>(); 
            List<Id> addenIds = new List<Id>();
            for(Supporting_Addenda_Forms__c uipCon:uipContacts)  {
                addenIds.add(uipCon.Addendum__c);               
                if(uipCon.ZPIF_UIP_Identidier__c == null){
                    uipCon.ZPIF_UIP_Identidier__c = NewGuid();
                    upContacts.add(uipCon);
                }
                identifiers.add(uipCon.ZPIF_UIP_Identidier__c);
            }
            System.debug('identifiers '+identifiers);
            if(upContacts.size()>0) {update upContacts;}
            map<Id,Id> mapAddends = getAddendaIds(addenIds);                
            List<ZPF_Supporting_Addenda_Forms__c> ExstngZuips = [Select ZPIF_UIP_Identidier__c,Id from ZPF_Supporting_Addenda_Forms__c where ZPIF_UIP_Identidier__c IN :identifiers];
            map<String,Id> mapExistingZUIP = new map<String,Id>();
            for(ZPF_Supporting_Addenda_Forms__c zuip: ExstngZuips) {mapExistingZUIP.put(zuip.ZPIF_UIP_Identidier__c,zuip.Id);}
            List<ZPF_Supporting_Addenda_Forms__c> zuips = new List<ZPF_Supporting_Addenda_Forms__c>();
            Map<String, SObjectField> fields = Schema.getGlobalDescribe().get('ZPF_Supporting_Addenda_Forms__c').getDescribe().fields.getMap();         
            for(Supporting_Addenda_Forms__c var:uipContacts){
                ZPF_Supporting_Addenda_Forms__c inserting = new ZPF_Supporting_Addenda_Forms__c();
                for(String field:fields.keySet()){                  
                    if(mapExistingZUIP.containsKey(var.ZPIF_UIP_Identidier__c)){
                        if((field.contains('__c') || field.contains('__C')) && !fields.get(field).getDescribe().isCalculated()){inserting.put(field,var.get(field));}
                    }
                    else if((field.contains('__c') || field.contains('__C')) && !fields.get(field).getDescribe().isCalculated() && fields.get(field).getDescribe().isUpdateable()){
                            if(field.equalsIgnoreCase('Addendum__c')){inserting.put(field,mapAddends.get((ID)var.get(field)));}
                            else{inserting.put(field,var.get(field));}
                        }                       
                }             
                if(mapExistingZUIP.containsKey(var.ZPIF_UIP_Identidier__c)){inserting.Id =  mapExistingZUIP.get(var.ZPIF_UIP_Identidier__c);}
                inserting.Public_Facing__c = true;
                zuips.add(inserting);
            }
            if(zuips.size()>0){try{upsert zuips;}catch(Exception e){System.debug('e '+e);}}
            deleteSuppAddenFrmFromCache(identifiers);
    }
    
    public static void deleteSuppAddenFrmFromCache(List<String> identifiers){
        System.debug('updUIPId '+updUIPId);
        List<Id> listIds = updUIPId;
        map<Id,Id> mapUIP = getZPIFFUIPForUIP(listIds);
        System.debug('mapUIP '+mapUIP.keySet());
        List<ZPF_Supporting_Addenda_Forms__c> deletedZPF = [Select ZPIF_UIP_Identidier__c,Id from ZPF_Supporting_Addenda_Forms__c where ZPIF_UIP_Identidier__c NOT IN :identifiers and Addendum__r.UIP__C IN :mapUIP.keySet()];
        if(!deletedZPF.isEmpty() && deletedZPF.size()>0){try{delete deletedZPF;}catch(Exception e){System.debug('e '+e);}}
    }
    
    
    
    public static map<Id,Id> getZPIFFUIPForUIP(List<Id> UIPs){
        Map<Id,Id> mapUIPCache = new Map<Id,Id>();
        for(Id i : UIPs){System.debug('i '+i); mapUIPCache.put(i, i);}
        System.debug('mapUIPCache '+mapUIPCache);
        return mapUIPCache;
    }
    
    public static Map<Id,Id> mapUIPElemCache;
    
    public static map<Id,Id> getZPFElementForUIP(List<Id> UIPs){
        if(mapUIPElemCache == null){
        Map<String,Id> mapIdentiUIP = new Map<String,Id>();
        mapUIPElemCache = new Map<Id,Id>();
        List<UIP_Element__c> uips1 = [Select Id,ZPIF_UIP_Identidier__c from UIP_Element__c where Id IN :UIPs];  
        for(UIP_Element__c uip:uips1) {mapIdentiUIP.put(uip.ZPIF_UIP_Identidier__c,uip.Id);}
        Set<String> identifiers = mapIdentiUIP.keySet();
        List<ZPF_UIP_Element__c> zuips = [Select Id,ZPIF_UIP_Identidier__c from ZPF_UIP_Element__c where ZPIF_UIP_Identidier__c IN :identifiers]; 
        for(ZPF_UIP_Element__c zuip:zuips){
            if(mapIdentiUIP.containsKey(zuip.ZPIF_UIP_Identidier__c)){mapUIPElemCache.put(mapIdentiUIP.get(zuip.ZPIF_UIP_Identidier__c),zuip.Id);}
            }   
        }
        return mapUIPElemCache;
    }
    
    public static Map<Id,Id> mapImpActStp;
    
    public static map<Id,Id> getZPFImplActionStepsForUIP(List<Id> UIPs){
        if(mapImpActStp == null){
        Map<String,Id> mapIdentiUIP = new Map<String,Id>();
        mapImpActStp = new Map<Id,Id>();
        List<Improvement_Action_Step__c> uips1 = [Select Id,ZPIF_UIP_Identidier__c from Improvement_Action_Step__c where Id IN :UIPs];  
        for(Improvement_Action_Step__c uip:uips1) mapIdentiUIP.put(uip.ZPIF_UIP_Identidier__c,uip.Id);
        Set<String> identifiers = mapIdentiUIP.keySet();
        List<ZPF_Improvement_Action_Step__c> zuips = [Select Id,ZPIF_UIP_Identidier__c from ZPF_Improvement_Action_Step__c where ZPIF_UIP_Identidier__c IN :identifiers];  
        for(ZPF_Improvement_Action_Step__c zuip:zuips){
            if(mapIdentiUIP.containsKey(zuip.ZPIF_UIP_Identidier__c))
                mapImpActStp.put(mapIdentiUIP.get(zuip.ZPIF_UIP_Identidier__c),zuip.Id);
        }   
        }
        return mapImpActStp;
    }                  
    
    public static map<Id,Id> getZPFPerfIndTargetForUIP(List<Id> UIPs){
        Map<String,Id> mapIdentiUIP = new Map<String,Id>();
        Map<Id,Id> mapUIPCache1 = new Map<Id,Id>();
        List<Performance_Indicator_Targets__c> uips1 = [Select Id,ZPIF_UIP_Identidier__c from Performance_Indicator_Targets__c where Id IN :UIPs];  
        for(Performance_Indicator_Targets__c uip:uips1) mapIdentiUIP.put(uip.ZPIF_UIP_Identidier__c,uip.Id);
        Set<String> identifiers = mapIdentiUIP.keySet();
        List<ZPF_Performance_Indicator_Targets__c> zuips = [Select Id,ZPIF_UIP_Identidier__c from ZPF_Performance_Indicator_Targets__c where ZPIF_UIP_Identidier__c IN :identifiers];  
        for(ZPF_Performance_Indicator_Targets__c zuip:zuips){
            if(mapIdentiUIP.containsKey(zuip.ZPIF_UIP_Identidier__c))
                mapUIPCache1.put(mapIdentiUIP.get(zuip.ZPIF_UIP_Identidier__c),zuip.Id);
        }   
        return mapUIPCache1;
    }  
    
    public static map<Id,Id> getAddendaIds(List<Id> UIPs){
        Map<String,Id> mapIdentiUIP = new Map<String,Id>();
        Map<Id,Id> mapUIPCache1 = new Map<Id,Id>();
        List<Supporting_Addenda_Forms__c> uips1 = [Select Id,ZPIF_UIP_Identidier__c from Supporting_Addenda_Forms__c where Id IN :UIPs];    
        for(Supporting_Addenda_Forms__c uip:uips1) mapIdentiUIP.put(uip.ZPIF_UIP_Identidier__c,uip.Id);
        Set<String> identifiers = mapIdentiUIP.keySet();
        List<ZPF_Supporting_Addenda_Forms__c> zuips = [Select Id,ZPIF_UIP_Identidier__c from ZPF_Supporting_Addenda_Forms__c where ZPIF_UIP_Identidier__c IN :identifiers];  
        for(ZPF_Supporting_Addenda_Forms__c zuip:zuips){
            if(mapIdentiUIP.containsKey(zuip.ZPIF_UIP_Identidier__c))
                mapUIPCache1.put(mapIdentiUIP.get(zuip.ZPIF_UIP_Identidier__c),zuip.Id);
        }   
        return mapUIPCache1;
    }   
    
    public static Map<Id,Id> mapImprActzpf;               
    
    public static map<Id,Id> getImprActStp(List<Id> UIPs){
        if(mapImprActzpf == null){
            mapImprActzpf = new Map<Id,Id>();       
            Map<String,Id> mapIdentiUIP = new Map<String,Id>();
            List<Improvement_Action_Step__c> uips1 = [Select Id,ZPIF_UIP_Identidier__c from Improvement_Action_Step__c where Id IN :UIPs];  
            for(Improvement_Action_Step__c uip:uips1) {mapIdentiUIP.put(uip.ZPIF_UIP_Identidier__c,uip.Id);}
            Set<String> identifiers = mapIdentiUIP.keySet();
            List<ZPF_Improvement_Action_Step__c> zuips = [Select Id,ZPIF_UIP_Identidier__c from ZPF_Improvement_Action_Step__c where ZPIF_UIP_Identidier__c IN :identifiers];  
            for(ZPF_Improvement_Action_Step__c zuip:zuips){
                if(mapIdentiUIP.containsKey(zuip.ZPIF_UIP_Identidier__c)){mapImprActzpf.put(mapIdentiUIP.get(zuip.ZPIF_UIP_Identidier__c),zuip.Id);}
            }   
        }
        return mapImprActzpf;
    }         
    
    public static Map<Id,Id> mapImpBenchMarkzpf;               
    
    public static map<Id,Id> getImpBenchMarkzpf(List<Id> UIPs){
        if(mapImpBenchMarkzpf == null){
            mapImpBenchMarkzpf = new Map<Id,Id>();      
            Map<String,Id> mapIdentiUIP = new Map<String,Id>();
            List<Implementation_Benchmark__c> uips1 = [Select Id,ZPIF_UIP_Identidier__c from Implementation_Benchmark__c where Id IN :UIPs];    
            for(Implementation_Benchmark__c uip:uips1) {mapIdentiUIP.put(uip.ZPIF_UIP_Identidier__c,uip.Id);}
            Set<String> identifiers = mapIdentiUIP.keySet();
            List<ZPF_Implementation_Benchmark__c> zuips = [Select Id,ZPIF_UIP_Identidier__c from ZPF_Implementation_Benchmark__c where ZPIF_UIP_Identidier__c IN :identifiers];  
            for(ZPF_Implementation_Benchmark__c zuip:zuips){
                if(mapIdentiUIP.containsKey(zuip.ZPIF_UIP_Identidier__c)){mapImpBenchMarkzpf.put(mapIdentiUIP.get(zuip.ZPIF_UIP_Identidier__c),zuip.Id);}
            }   
        }
        return mapImpBenchMarkzpf;
    }             
    
    public static String ObjectFields(String ObjectNameval){
        SObjectType objToken = Schema.getGlobalDescribe().get(ObjectNameval);
        DescribeSObjectResult objDef = objToken.getDescribe();
        Map<String, SObjectField> fields = objDef.fields.getMap();
        Set<String> fieldSet1 = fields.keySet();
        List<String> fieldSet = new List<String>();
        fieldSet.addAll(fieldSet1);
        String fieldsVal = String.join(fieldSet,',');
        if(fieldsVal.endsWith(',')){fieldsVal= fieldsVal.substring(0,fieldsVal.length()-1);}
        return fieldsVal;
    }   
     
              
        
    private static String kHexChars = '0123456789abcdef';
    
    public static String NewGuid() {
        String returnValue = '';
        Integer nextByte = 0;
        for (Integer i=0; i<16; i++) {
            if (i==4 || i==6 || i==8 || i==10)
                returnValue += '-';
            nextByte = (Math.round(Math.random() * 255)-128) & 255;
            if (i==6) {
                nextByte = nextByte & 15;
                nextByte = nextByte | (4 << 4);
            }
            if (i==8) {
                nextByte = nextByte & 63;
                nextByte = nextByte | 128;
            }
            returnValue += getCharAtIndex(kHexChars, nextByte >> 4);
            returnValue += getCharAtIndex(kHexChars, nextByte & 15);
        }
        return returnValue;
    }

    public static String getCharAtIndex(String str, Integer index) {
        if (str == null) return null;
        if (str.length() <= 0) return str;    
        if (index == str.length()) return null;    
        return str.substring(index, index+1);
    }
}