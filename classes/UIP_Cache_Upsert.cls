global class UIP_Cache_Upsert {
    
    public static void upsertToCache(UIP__c[] trigOld,UIP__c[] trigNew){
        for(UIP__c uip:trigNew){uip.ZPIF_UIP_Identidier__c = NewGuid();}
        InsertToCache(trigNew);
    }
    
    public static map<Id,Id> mapUIPZ = new map<Id,Id>();
    public static map<Id,Id> mapUIP = new map<Id,Id>();
    
    webservice static void updateZPIFCachews(Id[] updUIPs){
        System.debug('updUIPs '+updUIPs);
        updateZPIFCache(updUIPs);       
    }
    
    Public static List<Id> updUIPId = new List<Id>();    
    
    //11
    public static void updateZPIFCache(Id[] updUIPs){
        
        string fieldsAPIname = ObjectFields('UIP__c');   
        String qry = 'Select '+fieldsAPIname+',RecordType.DeveloperName from UIP__c where Id IN :updUIPs';
        LIST<UIP__c> uipid = Database.query(qry);
        System.debug('UIPID :'+uipid);
        for(UIP__c uip : uipid){ 
            updUIPId.add(uip.Id); 
        }
        System.debug('updUIPId '+updUIPId);
        System.debug('Inserting ZPIF record');
        InsertToCache(uipid);               
        mapUIPZ = getZPIFFUIPForUIP(updUIPId);
        System.debug('mapUIPZ '+mapUIPZ);
        mapUIP = getZPIFFUIPForUIP(updUIPId);
        System.debug('mapUIP '+mapUIP);
        
        string fieldsContact = ObjectFields('UIP_Contact__c');        
        String qry1 = 'Select '+fieldsContact+' from UIP_Contact__c where UIP__c IN :updUIPs';
        List<UIP_Contact__c> con = Database.query(qry1);
        System.debug('con '+con);
        System.debug('Inserting ZPF_UIP_Contact record');
        insertToCache(con);
        
        string fieldsAddendum = ObjectFields('Addendum__c');        
        String qry2 = 'Select '+fieldsAddendum+',RecordType.DeveloperName from Addendum__c where UIP__c IN :updUIPs or District_UIP_for_Combined_Plans__c IN :updUIPs or School_UIP__c IN :updUIPs';
        LIST<Addendum__c> uipAdden = Database.query(qry2);
        System.debug('UIPADDEN '+uipAdden);
        System.debug('Inserting ZPF_UIP_Addendum record');
        insertToCache(uipAdden);
        
        string fieldsElement = ObjectFields('UIP_Element__c');        
        String qry3 = 'Select '+fieldsElement+',RecordType.DeveloperName from UIP_Element__c where UIP__c IN :updUIPs';
        LIST<UIP_Element__c> uipElem = Database.query(qry3);
        System.debug('uipElem '+uipElem);
        System.debug('Inserting ZPF_UIP_Element record');
        insertToCache(uipElem);
        
        string fieldsImprovement_Action_Step = ObjectFields('Improvement_Action_Step__c');        
        String qry4 = 'Select '+fieldsImprovement_Action_Step+' from Improvement_Action_Step__c where UIP__c IN :updUIPs';
        List<Improvement_Action_Step__c> actImpr = Database.query(qry4);
        System.debug('actImpr '+actImpr);
        System.debug('Inserting ZPF_UIP_Improvement_Action_Step record');
        insertToCache(actImpr);
        
        String fieldsImplementation_Benchmark=ObjectFields('Implementation_Benchmark__c');        
        String qry5 = 'Select '+fieldsImplementation_Benchmark+' from Implementation_Benchmark__c where UIP__c IN :updUIPs';
        List<Implementation_Benchmark__c> impBench = Database.query(qry5);
        System.debug('impBench '+impBench);
        System.debug('Inserting ZPF_UIP_Implementation_Benchmark record');
        insertToCache(impBench); 
        
        string fieldsBenchMar_AtciontStep = ObjectFields('BenchMar_AtciontStep__c');        
        String qry6 = 'Select '+fieldsBenchMar_AtciontStep+' from BenchMar_AtciontStep__c where Improvement_Action_Step__r.UIP__c IN :updUIPs or Implementation_Benchmark__r.UIP__c IN :updUIPs';
        List<BenchMar_AtciontStep__c> benMarks = Database.query(qry6);
        System.debug('benMarks '+benMarks);
        System.debug('Inserting ZPF_UIP_Benchmark_ActionStep record');
        insertToCache(benMarks);
        
        string fieldsPerformance_Indicator_Targets = ObjectFields('Performance_Indicator_Targets__c');        
        String qry7 = 'Select '+fieldsPerformance_Indicator_Targets+',RecordType.DeveloperName from Performance_Indicator_Targets__c where UIP__c  IN :updUIPs';
        LIST<Performance_Indicator_Targets__c> PIT = Database.query(qry7);
        System.debug('PIT '+PIT);
        System.debug('Inserting ZPF_UIP_Performance_Indicator_Targets record');
        insertToCache(PIT); 
        
        string fieldsPerformance_Indicator_Notable_Trends = ObjectFields('Performance_Indicator_Notable_Trends__c');    
        String qry8 = 'Select '+fieldsPerformance_Indicator_Notable_Trends+',RecordType.DeveloperName from Performance_Indicator_Notable_Trends__c where UIP__c  IN :updUIPs';
        List<Performance_Indicator_Notable_Trends__c> PINT = Database.query(qry8);
        System.debug('PINT '+PINT);
        System.debug('Inserting ZPF_UIP_Performance_Indicator_Notable_Trends record');
        insertToCache(PINT);  
        
        List<Id> addenIds = new List<Id>();
        for(UIP__c uip : uipid){ for(Addendum__c adden:uip.Addenda1__r) {addenIds.add(adden.Id);}}
        List<Supporting_Addenda_Forms__c> addenForms = [Select s.Id, s.Addendum__c From Supporting_Addenda_Forms__c s where Addendum__c IN: addenIds]; 
        string fieldsSupporting_Addenda_Forms = ObjectFields('Supporting_Addenda_Forms__c');        
        String qry9 = 'Select '+fieldsSupporting_Addenda_Forms+' from Supporting_Addenda_Forms__c where Id IN :addenForms';
        List<Supporting_Addenda_Forms__c> uipSupporting_Addenda_Forms = Database.query(qry9);
        insertToCache(uipSupporting_Addenda_Forms);     
        
        addNotesAttachments(updUIPId);
    }
    
    //6    
    public static void addNotesAttachments(Id[] updUIPId){
        LIST<Note> notes = [SELECT Body, Id, ParentId, Title FROM Note where parentId IN :updUIPId];
        LIST<Attachment> attachments = [Select Id, Name, Body, ParentId, ContentType from Attachment where parentId IN :updUIPId];
        System.debug('attachments '+attachments);
        Set<String> origAttachNames = new Set<String>();
        for(Attachment attchmt:attachments) { System.debug('attchmt.Name + attchmt.ContentType + attchmt.Body '+attchmt.Name + attchmt.ContentType + attchmt.Body); origAttachNames.add(attchmt.Name + attchmt.ContentType + attchmt.Body); }
        System.debug('origAttachNames '+origAttachNames);        
        Set<String> origNotesNames = new Set<String>();
        for(Note attchmt:notes) { 
            System.debug('attchmt.Title + attchmt.Body '+attchmt.Title + + attchmt.Body); 
            origNotesNames.add(attchmt.Title + attchmt.Body); }
        System.debug('origNotesNames '+origNotesNames);      
        List<UIP__c> ul = [SELECT ZPIF_UIP_Identidier__c from UIP__c where Id IN :updUIPId];
        System.debug('ul '+ul);
        List<String> uec = new List<String>();
        for(UIP__c uel : ul){ uec.add(uel.ZPIF_UIP_Identidier__c); }
        List<ZPIF_UIP__c> zl = [SELECT Id from ZPIF_UIP__c where ZPIF_UIP_Identidier__c IN :uec];
        System.debug('zl '+zl);
        List<Id> zlId = new List<Id>();
        for(ZPIF_UIP__c uel : zl){ zlId.add(uel.Id); }        
        LIST<Attachment> existingAttachmnts = [Select Id, Name, Body, ContentType from Attachment where parentId IN :zlId];
        System.debug('existingAttachmnts '+existingAttachmnts);
        Set<String> extngAttachNames = new Set<String>();
        List<Attachment> deleAttachment = new List<Attachment>();
        for(Attachment attchmt:existingAttachmnts) {
            extngAttachNames.add(attchmt.Name + attchmt.ContentType + attchmt.Body);       
            if(!origAttachNames.contains(attchmt.Name + attchmt.ContentType + attchmt.Body))
                deleAttachment.add(attchmt);
        }
        System.debug('extngAttachNames '+extngAttachNames);
        System.debug('deleAttachment '+deleAttachment);
        List<Attachment> attachmnts = new List<Attachment>();
        for(Attachment attchmt:attachments){
            if(mapUIPZ.containsKey(attchmt.ParentId) && !extngAttachNames.contains(attchmt.Name + attchmt.ContentType + attchmt.Body)){
                Attachment newAttach = new Attachment();
                newAttach = attchmt.clone();
                System.debug('mapUIPZ.get(attchmt.ParentId) '+mapUIPZ.get(attchmt.ParentId));
                newAttach.parentId = mapUIPZ.get(attchmt.ParentId);
                attachmnts.add(newAttach);
            }
        }
        System.debug('attachmnts '+attachmnts);
        
        LIST<Note> existingNotes = [Select Id, Title, Body from Note where parentId IN :zlId];
        System.debug('existingNotes '+existingNotes);
        Set<String> extngNoteNames = new Set<String>();
        List<Note> deleNote = new List<Note>();
        for(Note attchmt:existingNotes) {
            extngNoteNames.add(attchmt.Title + attchmt.Body);       
            if(!origNotesNames.contains(attchmt.Title + attchmt.Body))
                deleNote.add(attchmt);
        }
        System.debug('extngNoteNames '+extngNoteNames);
        System.debug('deleNote '+deleNote);
        List<Note> newNotes = new List<Note>();
        for(Note attchmt:notes){
            if(mapUIPZ.containsKey(attchmt.ParentId) && !extngNoteNames.contains(attchmt.Title + attchmt.Body)){
                Note newAttach = new Note();
                newAttach = attchmt.clone();
                System.debug('mapUIPZ.get(attchmt.ParentId) '+mapUIPZ.get(attchmt.ParentId));
                newAttach.parentId = mapUIPZ.get(attchmt.ParentId);
                newNotes.add(newAttach);
            }
        }
        System.debug('newNotes '+newNotes);        
        if(deleAttachment.size()>0)
            delete deleAttachment;
        if(attachmnts.size()>0)
            insert attachmnts;
        if(deleNote.size()>0)
            delete deleNote;
        if(newNotes.size()>0)
            insert newNotes;        
    }
    
    /*
    public static void addNotesAttachments(Id[] updUIPId){
        LIST<Attachment> attachments = [Select Id, Name, Body,ParentId, ContentType from Attachment where parentId IN :updUIPId];
        System.debug('attachments '+attachments);
        //LIST<Attachment> existingattachments = [Select Id, Name, Body,ParentId, ContentType from Attachment where parentId IN :updUIPId];
        List<Attachment> attachmnts = new List<Attachment>();
        for(Attachment attchmt:attachments){
            if(mapUIPZ.containsKey(attchmt.ParentId)){
                Attachment newAttach = new Attachment();
                newAttach = attchmt.clone();
                newAttach.parentId = mapUIPZ.get(attchmt.ParentId);
                attachmnts.add(newAttach);
            }
        }
        System.debug('attachmnts '+attachmnts);
        if(attachmnts.size()>0)
            insert attachmnts;        
    }
    */
    
    //works
    //2
    public static void InsertToCache(List<UIP__c> updUIPs){
        String currentProfileId = UserInfo.getProfileId();
        Profile p = [SELECT Id, Name FROM Profile where Id = :UserInfo.getProfileId()];
        System.debug('updUIPs '+updUIPs);
        List<String> identifiers = new List<String>();
        List<UIP__c> updIdentUIP = new List<UIP__c>(); 
        for(UIP__c u : updUIPs)  {
            if(u.ZPIF_UIP_Identidier__c == null){
                u.ZPIF_UIP_Identidier__c = NewGuid();               
            }
            identifiers.add(u.ZPIF_UIP_Identidier__c);
            
            if (p.Name == 'District User' || p.Name == 'District Admin' || p.Name == 'CDE Lead Reviewer' || p.Name == 'CDE Reviewer' 
                                || p.Name == 'CDE Admin' || p.Name == 'System Administrator') {
                            u.UIP_Status__c = 'Submitted to CDE for Posting';
            }
            updIdentUIP.add(u);
        }
        System.debug('identifiers '+identifiers);
        System.debug('updIdentUIP '+updIdentUIP);
        if(updIdentUIP.size()>0) {update updIdentUIP; System.debug('Updating updIdentUIP');}
        List<ZPIF_UIP__c> ExstngZuips = [Select ZPIF_UIP_Identidier__c,Id,UIP_Source__c from ZPIF_UIP__c where ZPIF_UIP_Identidier__c IN :identifiers];
        System.debug('ExstngZuips '+ExstngZuips);
        map<String,Id> mapExistingZUIP = new map<String,Id>();
        for(ZPIF_UIP__c zuip: ExstngZuips) {mapExistingZUIP.put(zuip.ZPIF_UIP_Identidier__c,zuip.Id);}
        System.debug('mapExistingZUIP '+mapExistingZUIP);
        List<ZPIF_UIP__c> zuips = new List<ZPIF_UIP__c>();
        List<UIP__c> uipToUpdate = new List<UIP__c>();
        Map<String, SObjectField> fields = Schema.getGlobalDescribe().get('ZPIF_UIP__c').getDescribe().fields.getMap();
        List<RecordType> recs = [SELECT Id,DeveloperName FROM RecordType WHERE sobjecttype = 'ZPIF_UIP__c'];
        System.debug('fields '+fields);
        System.debug('recs '+recs);
        Map<String,Id> mapRecId = new Map<String,Id>();
        for(RecordType rec:recs) { mapRecId.put(rec.DeveloperName, rec.Id); }
        System.debug('mapRecId '+mapRecId);
        System.debug('fields.keySet() '+fields.keySet());
        for(UIP__c var:updUIPs){
            ZPIF_UIP__c inserting = new ZPIF_UIP__c();
            ZPIF_UIP__c existing = new ZPIF_UIP__c();
            for(String f : fields.keySet()){
                if(!mapExistingZUIP.containsKey(var.ZPIF_UIP_Identidier__c)){
                    if((f.contains('__c') || f.contains('__C')) && !fields.get(f).getDescribe().isCalculated()){ inserting.put(f , var.get(f)); }
                    else if((f.contains('__c') || f.contains('__C')) && !fields.get(f).getDescribe().isCalculated() && fields.get(f).getDescribe().isUpdateable()){ inserting.put(f , var.get(f)); }
                }
                else if(mapExistingZUIP.containsKey(var.ZPIF_UIP_Identidier__c)){                        
                    if((f.contains('__c') || f.contains('__C')) && !fields.get(f).getDescribe().isCalculated()){ inserting.put(f , var.get(f)); }
                    else if((f.contains('__c') || f.contains('__C')) && !fields.get(f).getDescribe().isCalculated() && fields.get(f).getDescribe().isUpdateable()){ inserting.put(f , var.get(f)); }
                }
            }
            if(mapExistingZUIP.containsKey(var.ZPIF_UIP_Identidier__c)){
                var.Public_Facing__c = true;
                inserting.Public_Facing__c = true;
                inserting.RecordTypeId = mapRecId.get(var.RecordType.DeveloperName); 
                inserting.ZPIF_UIP_Identidier__c = var.ZPIF_UIP_Identidier__c;
                inserting.Id = mapExistingZUIP.get(var.ZPIF_UIP_Identidier__c); 
            } 
            else{
                var.Public_Facing__c = true;
                inserting.RecordTypeId = mapRecId.get(var.RecordType.DeveloperName);
                inserting.Name = var.Name;                
                inserting.Public_Facing__c = true; 
            }
            System.debug('inserting '+inserting);
            zuips.add(inserting);
            uipToUpdate.add(var);
        }
        System.debug('zuips '+zuips);
        if(zuips.size()>0) { try{upsert zuips; update uipToUpdate;}catch(Exception e){System.debug('e '+e);}}
    }
    
    public static void insertToCache(UIP_Contact__c[] trigOld,UIP_Contact__c[] trigNew){
        for(UIP_Contact__c var:trigNew){
            var.ZPIF_UIP_Identidier__c = NewGuid();
        }
        insertToCache(trigNew);
    }    
    
    //works
    //4
    public static void insertToCache(UIP_Contact__c[] uipCons){
        if(uipCons.isEmpty())
        {return;}
        System.debug('uipCons ' + uipCons);
        List<String> identifiers = new List<String>();
        List<UIP_Contact__c> upContacts = new List<UIP_Contact__c>(); 
        List<Id> uipIds = updUIPId;
        System.debug('uipIds '+uipIds);
        for(UIP_Contact__c uCon : uipCons)  {
            if(uCon.ZPIF_UIP_Identidier__c == null){
                uCon.ZPIF_UIP_Identidier__c = NewGuid();
                upContacts.add(uCon);
            }
            identifiers.add(uCon.ZPIF_UIP_Identidier__c);
        }
        System.debug('upContacts ' + upContacts);
        System.debug('identifiers ' + identifiers);
        if(upContacts.size()>0) {try{update upContacts;}catch(Exception e){System.debug('e '+e);}}        
        ////////////////////////////////////////////////////////////////////////////////////////
        List<UIP_Contact__c> el = [SELECT UIP__c from UIP_Contact__c where ZPIF_UIP_Identidier__c IN :identifiers];
        System.debug('el '+el);
        List<Id> upc = new List<Id>();
        for(UIP_Contact__c uel : el){ upc.add(uel.UIP__c); }
        List<UIP__c> ul = [SELECT ZPIF_UIP_Identidier__c from UIP__c where Id IN :upc];
        System.debug('ul '+ul);
        List<String> uec = new List<String>();
        for(UIP__c uel : ul){ uec.add(uel.ZPIF_UIP_Identidier__c); }
        List<ZPIF_UIP__c> zl = [SELECT Id from ZPIF_UIP__c where ZPIF_UIP_Identidier__c IN :uec];
        System.debug('zl '+zl);
        List<Id> zlId = new List<Id>();
        for(ZPIF_UIP__c uel : zl){ zlId.add(uel.Id); }
        List<ZPF_UIP_Contact__c> ExstngZuips = [Select ZPIF_UIP_Identidier__c,Id, Name, UIP__c from ZPF_UIP_Contact__c where UIP__c IN :zlId];
        System.debug('ExstngZuips '+ExstngZuips);
        /////////////////////////////////////////////////////////////////////////////////////////////////////////        
        System.debug('mapUIPZ '+mapUIPZ);
        map<String,Id> mapExistingZUIP = new map<String,Id>();
        for(ZPF_UIP_Contact__c zuip: ExstngZuips) {mapExistingZUIP.put(zuip.ZPIF_UIP_Identidier__c,zuip.Id);}
        System.debug('mapExistingZUIP '+mapExistingZUIP);
        List<ZPF_UIP_Contact__c> zuips = new LIST<ZPF_UIP_Contact__c>();
        Map<String, SObjectField> fields = Schema.getGlobalDescribe().get('ZPF_UIP_Contact__c').getDescribe().fields.getMap();          
        System.debug('fields '+fields);
        for(UIP_Contact__c var:uipCons){                 
            ZPF_UIP_Contact__c inserting = new ZPF_UIP_Contact__c();
            for(String f:fields.keySet()){
                if(!mapExistingZUIP.containsKey(var.ZPIF_UIP_Identidier__c)){
                    if((f.contains('__c') || f.contains('__C')) && !fields.get(f).getDescribe().isCalculated()){
                        if(f.equalsIgnoreCase('UIP__c')){ System.debug(f +' '+mapUIPZ.get((ID)var.get(f)));  inserting.put(f,mapUIPZ.get((ID)var.get(f)));}
                        else{inserting.put(f,var.get(f));}                          
                    }
                    else if((f.contains('__c') || f.contains('__C')) && !fields.get(f).getDescribe().isCalculated() && fields.get(f).getDescribe().isUpdateable()){
                        if(f.equalsIgnoreCase('UIP__c')){ System.debug(f +' '+mapUIPZ.get((ID)var.get(f))); inserting.put(f,mapUIPZ.get((ID)var.get(f)));}
                        else{inserting.put(f,var.get(f));}                          
                    }
                }
                if(mapExistingZUIP.containsKey(var.ZPIF_UIP_Identidier__c)){
                    if((f.contains('__c') || f.contains('__C')) && !fields.get(f).getDescribe().isCalculated()){
                        if(f.equalsIgnoreCase('UIP__c')){ System.debug(f +' '+mapUIPZ.get((ID)var.get(f)));  inserting.put(f,mapUIPZ.get((ID)var.get(f)));}
                        else{inserting.put(f,var.get(f));}                          
                    }
                    else if((f.contains('__c') || f.contains('__C')) && !fields.get(f).getDescribe().isCalculated() && fields.get(f).getDescribe().isUpdateable()){
                        if(f.equalsIgnoreCase('UIP__c')){ System.debug(f +' '+mapUIPZ.get((ID)var.get(f))); inserting.put(f,mapUIPZ.get((ID)var.get(f)));}
                        else{inserting.put(f,var.get(f));}                          
                    }
                }
            } 
            if(mapExistingZUIP.containsKey(var.ZPIF_UIP_Identidier__c)) {
                inserting.ZPIF_UIP_Identidier__c = var.ZPIF_UIP_Identidier__c;
                inserting.Id = mapExistingZUIP.get(var.ZPIF_UIP_Identidier__c);
                inserting.Public_Facing__c = true;
            }
            else{
                inserting.Public_Facing__c = true;       
            }                
            System.debug('inserting '+inserting);
            zuips.add(inserting);
            System.debug('zuips ' + zuips);
        }
        if(zuips.size()>0){try{upsert zuips;}catch(Exception e){System.debug('e '+e);}}
        deleteContactsFromCache(identifiers);     
    }
    
    //1
    public static void deleteContactsFromCache(List<String> identifiers){
        System.debug('updUIPId '+updUIPId);
        List<Id> listIds = updUIPId;        
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
    
    //works
    //5
    public static void insertToCache(Addendum__c[] uipContacts){
        if(uipContacts.isEmpty())
        {return;}
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
        if(upContacts.size()>0) { update upContacts; }
        System.debug('mapUIPZ '+mapUIPZ);        
        List<Addendum__c> el = [SELECT UIP__c from Addendum__c where ZPIF_UIP_Identidier__c IN :identifiers];
        System.debug('el '+el);
        List<Id> upc = new List<Id>();
        for(Addendum__c uel : el){ upc.add(uel.UIP__c); }
        List<UIP__c> ul = [SELECT ZPIF_UIP_Identidier__c from UIP__c where Id IN :upc];
        System.debug('ul '+ul);
        List<String> uec = new List<String>();
        for(UIP__c uel : ul){ uec.add(uel.ZPIF_UIP_Identidier__c); }
        List<ZPIF_UIP__c> zl = [SELECT Id from ZPIF_UIP__c where ZPIF_UIP_Identidier__c IN :uec];
        System.debug('zl '+zl);
        List<Id> zlId = new List<Id>();
        for(ZPIF_UIP__c uel : zl){ zlId.add(uel.Id); }
        List<ZPF_Addendum__c> ExstngZuips = [Select ZPIF_UIP_Identidier__c,Id, Name, UIP__c from ZPF_Addendum__c where UIP__c IN :zlId];
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
                if(!mapExistingZUIP.containsKey(var.ZPIF_UIP_Identidier__c)){
                    if((f.contains('__c') || f.contains('__C')) && !fields.get(f).getDescribe().isCalculated()){
                        if(f.equalsIgnoreCase('UIP__c') || f.equalsIgnoreCase('School_UIP__c') || f.equalsIgnoreCase('District_UIP_for_Combined_Plans__c') ){
                            System.debug(f +' '+mapUIPZ.get((ID)var.get(f))); inserting.put(f,mapUIPZ.get((ID)var.get(f))); 
                        }
                        else if(!f.equalsIgnoreCase('UIP__c') || !f.equalsIgnoreCase('School_UIP__c') || !f.equalsIgnoreCase('District_UIP_for_Combined_Plans__c')) {
                            inserting.put(f,var.get(f));
                        } 
                    }
                    else if((f.contains('__c') || f.contains('__C')) && !fields.get(f).getDescribe().isCalculated() && fields.get(f).getDescribe().isUpdateable()){
                        if(f.equalsIgnoreCase('UIP__c') || f.equalsIgnoreCase('School_UIP__c') || f.equalsIgnoreCase('District_UIP_for_Combined_Plans__c') ){
                            System.debug(f +' '+mapUIPZ.get((ID)var.get(f)));  inserting.put(f,mapUIPZ.get((ID)var.get(f))); 
                        }
                        else if(!f.equalsIgnoreCase('UIP__c') || !f.equalsIgnoreCase('School_UIP__c') || !f.equalsIgnoreCase('District_UIP_for_Combined_Plans__c')) {
                            inserting.put(f,var.get(f));
                        } 
                    }
                }
                if(mapExistingZUIP.containsKey(var.ZPIF_UIP_Identidier__c)){
                    if((f.contains('__c') || f.contains('__C')) && !fields.get(f).getDescribe().isCalculated()){
                        if(f.equalsIgnoreCase('UIP__c') || f.equalsIgnoreCase('School_UIP__c') || f.equalsIgnoreCase('District_UIP_for_Combined_Plans__c') ){
                            System.debug(f +' '+mapUIPZ.get((ID)var.get(f))); inserting.put(f,mapUIPZ.get((ID)var.get(f))); 
                        }
                        else if(!f.equalsIgnoreCase('UIP__c') || !f.equalsIgnoreCase('School_UIP__c') || !f.equalsIgnoreCase('District_UIP_for_Combined_Plans__c')) {
                            inserting.put(f,var.get(f));
                        } 
                    }
                    else if((f.contains('__c') || f.contains('__C')) && !fields.get(f).getDescribe().isCalculated() && fields.get(f).getDescribe().isUpdateable()){
                        if(f.equalsIgnoreCase('UIP__c') || f.equalsIgnoreCase('School_UIP__c') || f.equalsIgnoreCase('District_UIP_for_Combined_Plans__c') ){
                            System.debug(f +' '+mapUIPZ.get((ID)var.get(f)));  inserting.put(f,mapUIPZ.get((ID)var.get(f))); 
                        }
                        else if(!f.equalsIgnoreCase('UIP__c') || !f.equalsIgnoreCase('School_UIP__c') || !f.equalsIgnoreCase('District_UIP_for_Combined_Plans__c')) {
                            inserting.put(f,var.get(f));
                        } 
                    }
                }
            }
            if(mapExistingZUIP.containsKey(var.ZPIF_UIP_Identidier__c)){
                inserting.RecordTypeId = mapRecId.get(var.RecordType.DeveloperName); 
                inserting.ZPIF_UIP_Identidier__c = var.ZPIF_UIP_Identidier__c;
                inserting.Id = mapExistingZUIP.get(var.ZPIF_UIP_Identidier__c); 
                inserting.Name = var.Name;                
                inserting.Public_Facing__c = true;
            } 
            else{
                inserting.RecordTypeId = mapRecId.get(var.RecordType.DeveloperName);
                inserting.Name = var.Name;                
                inserting.Public_Facing__c = true; 
            }                
            System.debug('inserting '+inserting);
            zuips.add(inserting);
        }
        System.debug('zuips '+zuips);
        if(zuips.size()>0){try{upsert zuips;}catch(Exception e){System.debug('e '+e);}}
        deleteAddendumFromCache(identifiers);           
    }
    
    //1
    public static void deleteAddendumFromCache(List<String> identifiers){
        System.debug('updUIPId '+updUIPId);
        List<Id> listIds = updUIPId;
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
    
    //works
    //3
    public static void insertToCache(UIP_Element__c[] elemnts){
        if(elemnts.isEmpty())
        {return;}
        System.debug('elemnts '+elemnts);
        List<String> identifiers = new List<String>();
        List<UIP_Element__c> upContacts = new List<UIP_Element__c>(); 
        List<Id> uipIds = updUIPId;          
        List<Id> uipElemIds = new List<Id>();
        for(UIP_Element__c uipCon : elemnts)  {
            for (Integer i = 1; i <= 9; i++) { uipElemIds.add((ID)uipCon.get('Challenge_'+i+'__c')); System.debug('Challenge_'+i+'__c '+'Challenge_'+i+'__c'); System.debug('uipElemIds '+uipElemIds);  }
            for (Integer i = 1; i <= 9; i++) { uipElemIds.add((ID)uipCon.get('Major_Improvement_Strategy_' + i + '__c')); System.debug('Major_Improvement_Strategy_' + i + '__c '+'Major_Improvement_Strategy_' + i + '__c'); System.debug('uipElemIds '+uipElemIds); }    
            for (Integer i = 1; i <= 9; i++) { uipElemIds.add((ID)uipCon.get('Root_Cause_' + i + '__c')); System.debug('Root_Cause_' + i + '__c '+'Root_Cause_' + i + '__c'); System.debug('uipElemIds '+uipElemIds); }  
            if(uipCon.ZPIF_UIP_Identidier__c == null){
                uipCon.ZPIF_UIP_Identidier__c = NewGuid();
                System.debug('uipCon.ZPIF_UIP_Identidier__c '+uipCon.ZPIF_UIP_Identidier__c);
                upContacts.add(new UIP_Element__c(Id = uipCon.Id, Root_Cause_1__c = uipCon.Root_Cause_1__c, Root_Cause_2__c = uipCon.Root_Cause_2__c, Root_Cause_9__c = uipCon.Root_Cause_9__c, Root_Cause_8__c = uipCon.Root_Cause_8__c, Root_Cause_7__c = uipCon.Root_Cause_7__c, Root_Cause_6__c = uipCon.Root_Cause_6__c, Root_Cause_5__c = uipCon.Root_Cause_5__c, Root_Cause_4__c = uipCon.Root_Cause_4__c, Root_Cause_3__c = uipCon.Root_Cause_3__c, Major_Improvement_Strategy_1__c = uipCon.Major_Improvement_Strategy_1__c, Major_Improvement_Strategy_2__c = uipCon.Major_Improvement_Strategy_2__c, Major_Improvement_Strategy_3__c = uipCon.Major_Improvement_Strategy_3__c, Major_Improvement_Strategy_4__c = uipCon.Major_Improvement_Strategy_4__c, Major_Improvement_Strategy_5__c = uipCon.Major_Improvement_Strategy_5__c, Major_Improvement_Strategy_6__c = uipCon.Major_Improvement_Strategy_6__c, Major_Improvement_Strategy_7__c = uipCon.Major_Improvement_Strategy_7__c, Major_Improvement_Strategy_8__c = uipCon.Major_Improvement_Strategy_8__c, Major_Improvement_Strategy_9__c = uipCon.Major_Improvement_Strategy_9__c, Challenge_1__c = uipCon.Challenge_1__c, Challenge_2__c = uipCon.Challenge_2__c, Challenge_3__c = uipCon.Challenge_3__c, Challenge_4__c = uipCon.Challenge_4__c, Challenge_5__c = uipCon.Challenge_5__c, Challenge_6__c = uipCon.Challenge_6__c, Challenge_7__c = uipCon.Challenge_7__c, Challenge_8__c = uipCon.Challenge_8__c, Challenge_9__c = uipCon.Challenge_9__c, ZPIF_UIP_Identidier__c = uipCon.ZPIF_UIP_Identidier__c, RecordTypeId = uipCon.RecordTypeId, Name = uipCon.Name, Academic_Achievement_Status__c = uipCon.Academic_Achievement_Status__c, Academic_Growth__c = uipCon.Academic_Growth__c, Academic_Growth_Gaps__c = uipCon.Academic_Growth_Gaps__c, Colorado_Graduation_Pathways_Program__c = uipCon.Colorado_Graduation_Pathways_Program__c, Description__c=uipCon.Description__c, Diagnostic_Review_Grant__c = uipCon.Diagnostic_Review_Grant__c , Gifted_Program__c = uipCon.Gifted_Program__c, Other_Description__c = uipCon.Other_Description__c, Postsecondary_Workforce_Readiness__c = uipCon.Postsecondary_Workforce_Readiness__c, School_Improvement_Support_Grant__c = uipCon.School_Improvement_Support_Grant__c, Other__c = uipCon.Other__c, UIP__c = uipCon.UIP__c, State_Accreditation__c = uipCon.State_Accreditation__c, Student_Graduation_and_Completion_Plan__c = uipCon.Student_Graduation_and_Completion_Plan__c, Tiered_Intervention_Grant_TIG__c = uipCon.Tiered_Intervention_Grant_TIG__c, Title_I_Focus_School__c = uipCon.Title_I_Focus_School__c, Title_IA__c = uipCon.Title_IA__c, Title_IIA__c = uipCon.Title_IIA__c, Title_III__c = uipCon.Title_III__c));
            }
            System.debug('upContacts ' + upContacts);
            System.debug('uipCon.ZPIF_UIP_Identidier__c '+uipCon.ZPIF_UIP_Identidier__c);
            identifiers.add(uipCon.ZPIF_UIP_Identidier__c);
        }
        System.debug('uipElemIds '+uipElemIds);
        System.debug('identifiers '+identifiers);
        if(upContacts.size()>0) {update upContacts;}
        List<ZPF_UIP_Element__c> ExstngZuips = [Select ZPIF_UIP_Identidier__c,Id, Name, UIP__c from ZPF_UIP_Element__c where ZPIF_UIP_Identidier__c IN :identifiers];
        System.debug('ExstngZuips '+ExstngZuips);
        map<String,Id> mapExistingZUIP = new map<String,Id>();
        for(ZPF_UIP_Element__c zuip: ExstngZuips) {mapExistingZUIP.put(zuip.ZPIF_UIP_Identidier__c,zuip.Id);}
        List<ZPF_UIP_Element__c> zuips = new List<ZPF_UIP_Element__c>();
        Map<String, SObjectField> fields = Schema.getGlobalDescribe().get('ZPF_UIP_Element__c').getDescribe().fields.getMap();
        List<RecordType> recs = [SELECT Id,DeveloperName,Name FROM RecordType WHERE sobjecttype = 'ZPF_UIP_Element__c'];
        Map<String,Id> mapRecId = new Map<String,Id>();
        for(RecordType rec:recs) { mapRecId.put(rec.DeveloperName, rec.Id);  }
        System.debug('mapUIPZ '+mapUIPZ);
        for(UIP_Element__c var : elemnts){
            System.debug('var.Id '+var.Id);
            ZPF_UIP_Element__c inserting = new ZPF_UIP_Element__c();
            for(String field : fields.keySet()){     
                if(!mapExistingZUIP.containsKey(var.ZPIF_UIP_Identidier__c)){
                        if((field.contains('__c') || field.contains('__C')) && !fields.get(field).getDescribe().isCalculated()){
                            if(field.equalsIgnoreCase('UIP__c')){ inserting.put(field,mapUIPZ.get((ID)var.get(field))); }
                            else if(field.contains('root_cause_') || field.contains('challenge_') || field.contains('major_improvement_strategy_')) {
                                continue;
                            }
                            else {inserting.put(field,var.get(field)); }
                        }
                        else if((field.contains('__c') || field.contains('__C')) && !fields.get(field).getDescribe().isCalculated() && fields.get(field).getDescribe().isUpdateable()){
                            if(field.equalsIgnoreCase('UIP__c')){ inserting.put(field,mapUIPZ.get((ID)var.get(field)));}
                            else if(field.contains('root_cause_') || field.contains('challenge_') || field.contains('major_improvement_strategy_')) {
                                continue;
                            }
                            else{ inserting.put(field,var.get(field));}
                        }                                                        
                } 
                if(mapExistingZUIP.containsKey(var.ZPIF_UIP_Identidier__c)){
                        if((field.contains('__c') || field.contains('__C')) && !fields.get(field).getDescribe().isCalculated()){
                            if(field.equalsIgnoreCase('UIP__c')){ inserting.put(field,mapUIPZ.get((ID)var.get(field))); }
                            else if(field.contains('root_cause_') || field.contains('challenge_') || field.contains('major_improvement_strategy_')) {
                                continue;
                            }
                            else {inserting.put(field,var.get(field)); }
                        }
                        else if((field.contains('__c') || field.contains('__C')) && !fields.get(field).getDescribe().isCalculated() && fields.get(field).getDescribe().isUpdateable()){
                            if(field.equalsIgnoreCase('UIP__c')){ inserting.put(field,mapUIPZ.get((ID)var.get(field)));}
                            else if(field.contains('root_cause_') || field.contains('challenge_') || field.contains('major_improvement_strategy_')) {
                                continue;
                            }
                            else{ inserting.put(field,var.get(field));}
                        }                                                        
                }
                if(mapExistingZUIP.containsKey(var.ZPIF_UIP_Identidier__c)){
                inserting.RecordTypeId = mapRecId.get(var.RecordType.DeveloperName); 
                inserting.ZPIF_UIP_Identidier__c = var.ZPIF_UIP_Identidier__c;
                inserting.Id = mapExistingZUIP.get(var.ZPIF_UIP_Identidier__c); 
                inserting.Name = var.Name;                
                inserting.Public_Facing__c = true;                 
                } 
                else{
                inserting.RecordTypeId = mapRecId.get(var.RecordType.DeveloperName);
                inserting.Name = var.Name;                
                inserting.Public_Facing__c = true; 
                }
            }
            System.debug('inserting '+inserting);
            zuips.add(inserting);
        }
        System.debug('zuips '+zuips);
        System.debug('-----------------------------inserting all UIP elements first---------------------------');
        if(zuips.size()>0){try{upsert zuips;}catch(Exception e){System.debug('e '+e);}}
            
        map<Id,Id> mapElem = getZPFElementForUIP(uipElemIds);
        System.debug('mapElem '+mapElem);  
        ExstngZuips = [Select ZPIF_UIP_Identidier__c,Id from ZPF_UIP_Element__c where ZPIF_UIP_Identidier__c IN :identifiers];
        mapExistingZUIP = new map<String,Id>();
        for(ZPF_UIP_Element__c zuip: ExstngZuips) {mapExistingZUIP.put(zuip.ZPIF_UIP_Identidier__c,zuip.Id); }
        List<ZPF_UIP_Element__c> updates = new List<ZPF_UIP_Element__c>();
        for(UIP_Element__c var:elemnts){
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
    
    //1
    public static void deleteElementFromCache(List<String> identifiers){
        System.debug('updUIPId '+updUIPId);
        List<Id> listIds = updUIPId;
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
    
    //works
    //2
    public static void insertToCache(Improvement_Action_Step__c[] Actnsteps){
        if(Actnsteps.isEmpty())
        {return;}
        System.debug('Actnsteps '+Actnsteps);           
        List<String> identifiers = new List<String>();
        List<Improvement_Action_Step__c> upContacts = new List<Improvement_Action_Step__c>(); 
        List<Id> uipIds = updUIPId;
        List<Id> uipimp = new List<Id>();
        List<Id> uipElemIds1 = new List<Id>();
        for(Improvement_Action_Step__c uipCon:Actnsteps)  {
            for (Integer i = 1; i <= 5; i++) { uipElemIds1.add((ID)uipCon.get('Root_Cause_' + i + '__c')); }  
            uipimp.add((ID)uipCon.get('Implementation_Benchmark__c'));
            uipElemIds1.add((ID)uipCon.get('Major_Improvement_Strategy__c'));                                    
            if(uipCon.ZPIF_UIP_Identidier__c == null){ 
                uipCon.ZPIF_UIP_Identidier__c = NewGuid(); 
                upContacts.add(uipCon); 
            }
            System.debug('upContacts ' + upContacts);
            identifiers.add(uipCon.ZPIF_UIP_Identidier__c);
        }
        System.debug('uipElemIds1 '+uipElemIds1);
        System.debug('uipimp '+uipimp);
        System.debug('identifiers '+identifiers);
        if(upContacts.size()>0) {update upContacts;}
        List<ZPF_Improvement_Action_Step__c> ExstngZuips = [Select ZPIF_UIP_Identidier__c,Id, Name, UIP__c from ZPF_Improvement_Action_Step__c where ZPIF_UIP_Identidier__c IN :identifiers];
        System.debug('ExstngZuips '+ExstngZuips);        
        System.debug('mapUIPZ '+mapUIPZ);   
        List<RecordType> recs = [SELECT Id FROM RecordType WHERE sobjecttype = 'ZPF_UIP_Element__c'];
        Map<Id,Id> mapRecId = new Map<Id,Id>();
        System.debug('uipElemIds1 '+uipElemIds1);
        map<Id,Id> mapElem = getZPFElementForUIP(uipElemIds1);
        map<Id,Id> mapImp = getImpBenchMarkzpf(uipimp);
        for(RecordType rec:recs) { mapRecId.put(rec.Id, rec.Id);  }
        System.debug('mapRecId '+mapRecId);
        System.debug('mapElem '+mapElem);
        map<String,Id> mapExistingZUIP = new map<String,Id>();
        for(ZPF_Improvement_Action_Step__c zuip: ExstngZuips) {mapExistingZUIP.put(zuip.ZPIF_UIP_Identidier__c,zuip.Id);}
        List<ZPF_Improvement_Action_Step__c> zuips = new List<ZPF_Improvement_Action_Step__c>();
        Map<String, SObjectField> fields = Schema.getGlobalDescribe().get('ZPF_Improvement_Action_Step__c').getDescribe().fields.getMap();          
        for(Improvement_Action_Step__c var:Actnsteps){               
            ZPF_Improvement_Action_Step__c inserting = new ZPF_Improvement_Action_Step__c();
            for(String field:fields.keySet()){                  
                if(!mapExistingZUIP.containsKey(var.ZPIF_UIP_Identidier__c)){
                    if((field.contains('__c') || field.contains('__C')) && !fields.get(field).getDescribe().isCalculated()){
                        if(field.equalsIgnoreCase('UIP__c')){
                            inserting.put(field,mapUIPZ.get((ID)var.get(field)));                               
                        }
                        else if(field.contains('root_cause_')){
                            System.debug('field '+(ID)var.get(field));
                            if(mapElem.containsKey((ID)var.get(field))){
                                System.debug('mapElem.get((ID)var.get(field)) '+mapElem.get((ID)var.get(field)));
                                inserting.put(field,mapElem.get((ID)var.get(field)));
                            }
                        }
                        else if(field.equalsIgnoreCase('Major_Improvement_Strategy__c')){
                            System.debug('(ID)var.get(field) '+(ID)var.get(field));
                            if(mapElem.containsKey((ID)var.get(field))){
                                System.debug('mapElem.get((ID)var.get(field)) '+mapElem.get((ID)var.get(field)));
                                inserting.put(field,mapElem.get((ID)var.get(field)));
                            }
                        }
                        else if(field.equalsIgnoreCase('Implementation_Benchmark__c')){
                            System.debug('(ID)var.get(field) '+(ID)var.get(field));
                            if(mapImp.containsKey((ID)var.get(field))){
                                System.debug('mapImp.get((ID)var.get(field)) '+mapImp.get((ID)var.get(field)));
                                inserting.put(field,mapImp.get((ID)var.get(field)));
                            }
                        }
                        else{inserting.put(field,var.get(field));}
                    }
                    else if((field.contains('__c') || field.contains('__C')) && !fields.get(field).getDescribe().isCalculated() && fields.get(field).getDescribe().isUpdateable()){
                        if(field.equalsIgnoreCase('UIP__c')){
                            inserting.put(field,mapUIPZ.get((ID)var.get(field))); 
                        }
                        else if(field.contains('root_cause_')){
                            System.debug('(ID)var.get(field) '+(ID)var.get(field));
                            if(mapElem.containsKey((ID)var.get(field))){
                                System.debug('mapElem.get((ID)var.get(field)) '+mapElem.get((ID)var.get(field)));
                                inserting.put(field,mapElem.get((ID)var.get(field)));
                            }
                        }
                        else if(field.equalsIgnoreCase('Major_Improvement_Strategy__c')){
                            System.debug('(ID)var.get(field) '+(ID)var.get(field));
                            if(mapElem.containsKey((ID)var.get(field))){
                                System.debug('mapElem.get((ID)var.get(field)) '+mapElem.get((ID)var.get(field)));
                                inserting.put(field,mapElem.get((ID)var.get(field)));
                            }
                        }
                        else{inserting.put(field,var.get(field));}
                    }
                } 
                if(mapExistingZUIP.containsKey(var.ZPIF_UIP_Identidier__c)){
                    if((field.contains('__c') || field.contains('__C')) && !fields.get(field).getDescribe().isCalculated()){
                        if(field.equalsIgnoreCase('UIP__c')){
                            inserting.put(field,mapUIPZ.get((ID)var.get(field)));                               
                        }
                        else if(field.contains('root_cause_')){
                            System.debug('(ID)var.get(field) '+(ID)var.get(field));
                            if(mapElem.containsKey((ID)var.get(field))){
                                System.debug('mapElem.get((ID)var.get(field)) '+mapElem.get((ID)var.get(field)));
                                inserting.put(field,mapElem.get((ID)var.get(field)));
                            }
                        }
                        else if(field.equalsIgnoreCase('Major_Improvement_Strategy__c')){
                            System.debug('(ID)var.get(field) '+(ID)var.get(field));
                            if(mapElem.containsKey((ID)var.get(field))){
                                System.debug('mapElem.get((ID)var.get(field)) '+mapElem.get((ID)var.get(field)));
                                inserting.put(field,mapElem.get((ID)var.get(field)));
                            }
                        }
                        else if(field.equalsIgnoreCase('Implementation_Benchmark__c')){
                            System.debug('(ID)var.get(field) '+(ID)var.get(field));
                            if(mapImp.containsKey((ID)var.get(field))){
                                System.debug('mapImp.get((ID)var.get(field)) '+mapImp.get((ID)var.get(field)));
                                inserting.put(field,mapImp.get((ID)var.get(field)));
                            }
                        }
                        else{inserting.put(field,var.get(field));}
                    }
                    else if((field.contains('__c') || field.contains('__C')) && !fields.get(field).getDescribe().isCalculated() && fields.get(field).getDescribe().isUpdateable()){
                        if(field.equalsIgnoreCase('UIP__c')){
                            inserting.put(field,mapUIPZ.get((ID)var.get(field))); 
                        }
                        else if(field.contains('root_cause_')){
                            System.debug('(ID)var.get(field) '+(ID)var.get(field));
                            if(mapElem.containsKey((ID)var.get(field))){
                                System.debug('mapElem.get((ID)var.get(field)) '+mapElem.get((ID)var.get(field)));
                                inserting.put(field,mapElem.get((ID)var.get(field)));
                            }
                        }
                        else if(field.equalsIgnoreCase('Major_Improvement_Strategy__c')){
                            System.debug('(ID)var.get(field) '+(ID)var.get(field));
                            if(mapElem.containsKey((ID)var.get(field))){
                                System.debug('mapElem.get((ID)var.get(field)) '+mapElem.get((ID)var.get(field)));
                                inserting.put(field,mapElem.get((ID)var.get(field)));
                            }
                        }
                        else{inserting.put(field,var.get(field));}
                    }
                } 
            }
            if(mapExistingZUIP.containsKey(var.ZPIF_UIP_Identidier__c)){
                inserting.Name = var.Name;        
                inserting.Public_Facing__c = true;
                inserting.ZPIF_UIP_Identidier__c = var.ZPIF_UIP_Identidier__c;
                inserting.Id = mapExistingZUIP.get(var.ZPIF_UIP_Identidier__c); 
            } 
            else{
                inserting.Name = var.Name;                
                inserting.Public_Facing__c = true; 
            }
            System.debug('inserting '+inserting);
            zuips.add(inserting);
        }
        System.debug('zuips '+zuips);
        if(zuips.size()>0){try{upsert zuips;}catch(Exception e){System.debug('e '+e);}}
        deleteImprActionStpFromCache(identifiers);
    }
    
    //1
    public static void deleteImprActionStpFromCache(List<String> identifiers){
        System.debug('updUIPId '+updUIPId);
        List<Id> listIds = updUIPId;
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
    
    //works
    //1
    public static void insertToCache(Implementation_Benchmark__c[] Actnsteps){
        if(Actnsteps.isEmpty())
        {return;}
        System.debug('Actnsteps '+Actnsteps);
        List<String> identifiers = new List<String>();
        List<Id> uipImpActStp = new List<Id>();
        List<Implementation_Benchmark__c> upContacts = new List<Implementation_Benchmark__c>(); 
        List<Id> uipIds = updUIPId;
        List<Id> uipElemIds2 = new List<Id>();
        for(Implementation_Benchmark__c uipCon:Actnsteps)  {
            uipImpActStp.add(uipCon.Action_Step__c);              
            uipElemIds2.add(uipCon.Major_Improvement_Strategy__c);                                   
            if(uipCon.ZPIF_UIP_Identidier__c == null){
                uipCon.ZPIF_UIP_Identidier__c = NewGuid();
                upContacts.add(uipCon);
            }
            identifiers.add(uipCon.ZPIF_UIP_Identidier__c);
        }
        System.debug('uipImpActStp '+uipImpActStp);
        system.debug('uipElemIds2 '+uipElemIds2);
        System.debug('identifiers '+identifiers);
        System.debug('upContacts '+upContacts);
        if(upContacts.size()>0) update upContacts;          
        System.debug('mapUIPZ '+mapUIPZ);
        map<Id,Id> mapElem = getZPFElementForUIP(uipElemIds2);   
        map<Id,Id> mapImpActStps = getZPFImplActionStepsForUIP(uipImpActStp);
        LIST<ZPF_Implementation_Benchmark__c> ExstngZuips = [Select ZPIF_UIP_Identidier__c,Id from ZPF_Implementation_Benchmark__c where ZPIF_UIP_Identidier__c IN :identifiers];
        System.debug('ExstngZuips '+ExstngZuips);
        map<String,Id> mapExistingZUIP = new map<String,Id>();
        for(ZPF_Implementation_Benchmark__c zuip: ExstngZuips) {mapExistingZUIP.put(zuip.ZPIF_UIP_Identidier__c,zuip.Id);}
        LIST<ZPF_Implementation_Benchmark__c> zuips = new LIST<ZPF_Implementation_Benchmark__c>();
        Map<String, SObjectField> fields = Schema.getGlobalDescribe().get('ZPF_Implementation_Benchmark__c').getDescribe().fields.getMap(); 
        System.debug('fields.keySet() '+fields.keySet());
        for(Implementation_Benchmark__c var:Actnsteps){
            ZPF_Implementation_Benchmark__c inserting = new ZPF_Implementation_Benchmark__c();
            for(String field:fields.keySet()){     
                if(!mapExistingZUIP.containsKey(var.ZPIF_UIP_Identidier__c)){
                    if((field.contains('__c') || field.contains('__C')) && !fields.get(field).getDescribe().isCalculated()){
                        if(field.equalsIgnoreCase('UIP__c')){ System.debug('mapUIPZ.get((ID)var.get(f)) '+mapUIPZ.get((ID)var.get(field))); inserting.put(field,mapUIPZ.get((ID)var.get(field))); }
                        else if(field.equalsIgnoreCase('Action_Step__c')){
                            if(mapImpActStps.containsKey((ID)var.get(field))){inserting.put(field,mapImpActStps.get((ID)var.get(field)));}
                        }
                        else if(field.equalsIgnoreCase('Major_Improvement_Strategy__c')){
                            if(mapElem.containsKey((ID)var.get(field))){inserting.put(field,mapElem.get((ID)var.get(field)));}
                        }
                        else{inserting.put(field,var.get(field));}
                    }
                    else if((field.contains('__c') || field.contains('__C')) && !fields.get(field).getDescribe().isCalculated() && fields.get(field).getDescribe().isUpdateable()){
                        if(field.equalsIgnoreCase('UIP__c')){ System.debug('mapUIPZ.get((ID)var.get(f)) '+mapUIPZ.get((ID)var.get(field)));  inserting.put(field,mapUIPZ.get((ID)var.get(field)));    }
                        else if(field.equalsIgnoreCase('Action_Step__c')){
                            if(mapImpActStps.containsKey((ID)var.get(field))){ inserting.put(field,mapImpActStps.get((ID)var.get(field))); }
                        }
                        else if(field.equalsIgnoreCase('Major_Improvement_Strategy__c')){
                            if(mapElem.containsKey((ID)var.get(field))){ inserting.put(field,mapElem.get((ID)var.get(field))); }
                        }
                        else{ inserting.put(field,var.get(field)); }
                    }                       
                }
                if(mapExistingZUIP.containsKey(var.ZPIF_UIP_Identidier__c)){
                    if((field.contains('__c') || field.contains('__C')) && !fields.get(field).getDescribe().isCalculated()){
                        if(field.equalsIgnoreCase('UIP__c')){ System.debug('mapUIPZ.get((ID)var.get(f)) '+mapUIPZ.get((ID)var.get(field))); inserting.put(field,mapUIPZ.get((ID)var.get(field))); }
                        else if(field.equalsIgnoreCase('Action_Step__c')){
                            if(mapImpActStps.containsKey((ID)var.get(field))){inserting.put(field,mapImpActStps.get((ID)var.get(field)));}
                        }
                        else if(field.equalsIgnoreCase('Major_Improvement_Strategy__c')){
                            if(mapElem.containsKey((ID)var.get(field))){inserting.put(field,mapElem.get((ID)var.get(field)));}
                        }
                        else{inserting.put(field,var.get(field));}
                    }
                    else if((field.contains('__c') || field.contains('__C')) && !fields.get(field).getDescribe().isCalculated() && fields.get(field).getDescribe().isUpdateable()){
                        if(field.equalsIgnoreCase('UIP__c')){ System.debug('mapUIPZ.get((ID)var.get(f)) '+mapUIPZ.get((ID)var.get(field)));  inserting.put(field,mapUIPZ.get((ID)var.get(field)));    }
                        else if(field.equalsIgnoreCase('Action_Step__c')){
                            if(mapImpActStps.containsKey((ID)var.get(field))){ inserting.put(field,mapImpActStps.get((ID)var.get(field))); }
                        }
                        else if(field.equalsIgnoreCase('Major_Improvement_Strategy__c')){
                            if(mapElem.containsKey((ID)var.get(field))){ inserting.put(field,mapElem.get((ID)var.get(field))); }
                        }
                        else{ inserting.put(field,var.get(field)); }
                    }                       
                }
            }   
            if(mapExistingZUIP.containsKey(var.ZPIF_UIP_Identidier__c)){
                inserting.ZPIF_UIP_Identidier__c = var.ZPIF_UIP_Identidier__c;
                inserting.Id = mapExistingZUIP.get(var.ZPIF_UIP_Identidier__c); 
            } 
            else{
                inserting.Name = var.Name;                
                inserting.Public_Facing__c = true; 
            }   
            System.debug('inserting '+inserting);
            zuips.add(inserting);
        }
        System.debug('zuips '+zuips);
        if(zuips.size()>0){try{upsert zuips;}catch(Exception e){System.debug('e '+e);}}
        deleteImprBnchMrkFromCache(identifiers);
    }
    
    //1
    public static void deleteImprBnchMrkFromCache(List<String> identifiers){
        System.debug('updUIPId '+updUIPId);
        List<Id> listIds = updUIPId;
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
    
    //works
    //1
    public static void insertToCache(BenchMar_AtciontStep__c[] marksb){
        if(marksb.isEmpty())
        {return;}
        System.debug('marksb '+marksb);
        List<String> identifiers = new List<String>();
        List<BenchMar_AtciontStep__c> upContacts = new List<BenchMar_AtciontStep__c>();  
        List<Id> actstps = new List<Id>();
        List<Id> bnchMark = new List<Id>();
        for(BenchMar_AtciontStep__c uipCon:marksb)  {
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
        List<ZPF_BenchMar_AtciontStep__c> ExstngZuips = [Select ZPIF_UIP_Identidier__c,Id from ZPF_BenchMar_AtciontStep__c where ZPIF_UIP_Identidier__c IN :identifiers and ZPIF_UIP_Identidier__c != null];
        map<String,Id> mapExistingZUIP = new map<String,Id>();
        for(ZPF_BenchMar_AtciontStep__c zuip: ExstngZuips) {mapExistingZUIP.put(zuip.ZPIF_UIP_Identidier__c,zuip.Id);}
        List<ZPF_BenchMar_AtciontStep__c> zuips = new List<ZPF_BenchMar_AtciontStep__c>();
        for(BenchMar_AtciontStep__c var:marksb){
            ZPF_BenchMar_AtciontStep__c inserting = new ZPF_BenchMar_AtciontStep__c();              
            if(!mapExistingZUIP.containsKey(var.ZPIF_UIP_Identidier__c)){
                inserting.ZPIF_UIP_Identidier__c = var.ZPIF_UIP_Identidier__c;
            }
            if(!mapImpBenchMarkzpf.containsKey(var.Implementation_Benchmark__c)){
                inserting.ZPF_Implementation_Benchmark__c = var.Implementation_Benchmark__c;                    
            }
            if(!mapImprActzpf.containsKey(var.Improvement_Action_Step__c)){
                inserting.ZPF_Improvement_Action_Step__c = var.Improvement_Action_Step__c;                    
            }
            if(mapExistingZUIP.containsKey(var.ZPIF_UIP_Identidier__c)){
                inserting.Id = mapExistingZUIP.get(var.ZPIF_UIP_Identidier__c);
            }
            if(mapImpBenchMarkzpf.containsKey(var.Implementation_Benchmark__c)){
                inserting.ZPF_Implementation_Benchmark__c = mapImpBenchMarkzpf.get(var.Implementation_Benchmark__c);
            }
            if(mapImprActzpf.containsKey(var.Improvement_Action_Step__c)){
                inserting.ZPF_Improvement_Action_Step__c =  mapImprActzpf.get(var.Improvement_Action_Step__c);
            }
            inserting.Public_Facing__c = true;  
            System.debug('inserting '+inserting);
            zuips.add(inserting);
        }
        System.debug('zuips '+zuips);
        if(zuips.size()>0){try{upsert zuips;}catch(Exception e){System.debug('e '+e);}}
        deleteBnMarkActStpFromCache(identifiers);
    }
    
    //1
    public static void deleteBnMarkActStpFromCache(List<String> identifiers){
        System.debug('updUIPId '+updUIPId);
        List<Id> listIds = updUIPId;
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
    
    public static List<Id> uipImpActStp1 = new List<Id>();
    
    //works
    //2
    public static void insertToCache(Performance_Indicator_Targets__c[] perfIndTrgts){
        if(perfIndTrgts.isEmpty())
        {return;}
        List<String> identifiers = new List<String>();
        List<Performance_Indicator_Targets__c> upContacts = new List<Performance_Indicator_Targets__c>(); 
        List<Id> uipIds = updUIPId;           
        List<Id> uipElemIds3 = new List<Id>();
        for(Performance_Indicator_Targets__c uipCon:perfIndTrgts)  {
            uipImpActStp1.add(uipCon.Next_Year_Related_Target__c);              
            uipElemIds3.add(uipCon.Major_Improvement_Strategy_1__c);
            uipElemIds3.add(uipCon.Priority_Performance_Challenge_1__c);                                 
            if(uipCon.ZPIF_UIP_Identidier__c == null){
                uipCon.ZPIF_UIP_Identidier__c = NewGuid();
                upContacts.add(new Performance_Indicator_Targets__c(Id = uipCon.Id, Interim_Measures_1__c = uipCon.Interim_Measures_1__c, Last_Year_Target_1__c = uipCon.Last_Year_Target_1__c, Major_Improvement_Strategy_1__c = uipCon.Major_Improvement_Strategy_1__c, Measures_Metrics2__c = uipCon.Measures_Metrics2__c, Measures_Metrics__c = uipCon.Measures_Metrics__c, Next_Year_Related_Target__c = uipCon.Next_Year_Related_Target__c, Next_Year_Target_1__c = uipCon.Next_Year_Target_1__c, Performance_against_Target_1__c = uipCon.Performance_against_Target_1__c, Performance_Indicator__c = uipCon.Performance_Indicator__c, Priority_Performance_Challenge_1__c = uipCon.Priority_Performance_Challenge_1__c, Public_Facing__c = uipCon.Public_Facing__c, Subject_1__c = uipCon.Subject_1__c, Target_Reflection_1__c = uipCon.Target_Reflection_1__c, This_Year_Target_1__c = uipCon.This_Year_Target_1__c, UIP__c = uipCon.UIP__c, ZPIF_UIP_Identidier__c = uipCon.ZPIF_UIP_Identidier__c));
            }
            identifiers.add(uipCon.ZPIF_UIP_Identidier__c);
        }
        System.debug('upContacts ' + upContacts);
        System.debug('identifiers '+identifiers);
        if(upContacts.size()>0) {update upContacts;}        
        List<ZPF_Performance_Indicator_Targets__c> ExstngZuips = [Select ZPIF_UIP_Identidier__c,Id, Name, UIP__c from ZPF_Performance_Indicator_Targets__c where ZPIF_UIP_Identidier__c IN :identifiers];
        System.debug('ExstngZuips '+ExstngZuips);
        System.debug('mapUIPZ '+mapUIPZ);
        map<String,Id> mapExistingZUIP = new map<String,Id>();
        for(ZPF_Performance_Indicator_Targets__c zuip: ExstngZuips) {mapExistingZUIP.put(zuip.ZPIF_UIP_Identidier__c,zuip.Id);}
        List<ZPF_Performance_Indicator_Targets__c> zuips = new LIST<ZPF_Performance_Indicator_Targets__c>();
        Map<String, SObjectField> fields = Schema.getGlobalDescribe().get('ZPF_Performance_Indicator_Targets__c').getDescribe().fields.getMap(); 
        List<RecordType> recs = [SELECT Id,DeveloperName,Name FROM RecordType WHERE sobjecttype = 'ZPF_Performance_Indicator_Targets__c'];
        Map<String,Id> mapRecId = new Map<String,Id>();
        map<Id,Id> mapPerfIndTargets = getZPFPerfIndTargetForUIP(uipImpActStp1);
        map<Id,Id> mapElem = getZPFElementForUIP(uipElemIds3);
        for(RecordType rec:recs) {  mapRecId.put(rec.DeveloperName, rec.Id); }
        for(Performance_Indicator_Targets__c var:perfIndTrgts){
            ZPF_Performance_Indicator_Targets__c inserting = new ZPF_Performance_Indicator_Targets__c();
            for(String field:fields.keySet()){
                if(!mapExistingZUIP.containsKey(var.ZPIF_UIP_Identidier__c)){
                    if((field.contains('__c') || field.contains('__C')) && !fields.get(field).getDescribe().isCalculated()){
                        if(field.equalsIgnoreCase('UIP__c')){ System.debug('mapUIPZ.get((ID)var.get(f)) '+mapUIPZ.get((ID)var.get(field))); inserting.put(field,mapUIPZ.get((ID)var.get(field))); }
                        else if(field.equalsIgnoreCase('Major_Improvement_Strategy_1__c') || field.equalsIgnoreCase('Priority_Performance_Challenge_1__c')){
                            if(mapElem.containsKey((ID)var.get(field))){inserting.put(field,mapElem.get((ID)var.get(field)));}
                        }
                        else if(field.equalsIgnoreCase('Next_Year_Related_Target__c')){
                            if(mapPerfIndTargets.containsKey((ID)var.get(field))){inserting.put(field,mapPerfIndTargets.get((ID)var.get(field)));}
                        }
                        else{inserting.put(field,var.get(field));}
                    }
                    else if((field.contains('__c') || field.contains('__C')) && !fields.get(field).getDescribe().isCalculated() && fields.get(field).getDescribe().isUpdateable()){
                        if(field.equalsIgnoreCase('UIP__c')){ System.debug('mapUIPZ.get((ID)var.get(f)) '+mapUIPZ.get((ID)var.get(field))); inserting.put(field,mapUIPZ.get((ID)var.get(field))); }
                        else{inserting.put(field,var.get(field));}
                    }                       
                } 
                if(mapExistingZUIP.containsKey(var.ZPIF_UIP_Identidier__c)){
                    if((field.contains('__c') || field.contains('__C')) && !fields.get(field).getDescribe().isCalculated()){
                        if(field.equalsIgnoreCase('UIP__c')){ System.debug('mapUIPZ.get((ID)var.get(f)) '+mapUIPZ.get((ID)var.get(field))); inserting.put(field,mapUIPZ.get((ID)var.get(field))); }
                        else if(field.equalsIgnoreCase('Major_Improvement_Strategy_1__c') || field.equalsIgnoreCase('Priority_Performance_Challenge_1__c')){
                            if(mapElem.containsKey((ID)var.get(field))){inserting.put(field,mapElem.get((ID)var.get(field)));}
                        }
                        else if(field.equalsIgnoreCase('Next_Year_Related_Target__c')){
                            if(mapPerfIndTargets.containsKey((ID)var.get(field))){inserting.put(field,mapPerfIndTargets.get((ID)var.get(field)));}
                        }
                        else{inserting.put(field,var.get(field));}
                    }
                    else if((field.contains('__c') || field.contains('__C')) && !fields.get(field).getDescribe().isCalculated() && fields.get(field).getDescribe().isUpdateable()){
                        if(field.equalsIgnoreCase('UIP__c')){ System.debug('mapUIPZ.get((ID)var.get(f)) '+mapUIPZ.get((ID)var.get(field))); inserting.put(field,mapUIPZ.get((ID)var.get(field))); }
                        else{inserting.put(field,var.get(field));}
                    }                       
                }
            }
            if(mapExistingZUIP.containsKey(var.ZPIF_UIP_Identidier__c)){
                inserting.RecordTypeId = mapRecId.get(var.RecordType.DeveloperName); 
                inserting.ZPIF_UIP_Identidier__c = var.ZPIF_UIP_Identidier__c;
                inserting.Id = mapExistingZUIP.get(var.ZPIF_UIP_Identidier__c); 
                inserting.Public_Facing__c = true;
            } 
            else{
                inserting.RecordTypeId = mapRecId.get(var.RecordType.DeveloperName);                                   
                inserting.Public_Facing__c = true; 
            }                 
            System.debug('inserting '+inserting);                         
            zuips.add(inserting);
        }
        System.debug('zuips '+zuips);
        if(zuips.size()>0){try{upsert zuips;System.debug('after upsert');}catch(Exception e){System.debug('e '+e);}}
        deleteprfIndTargFromCache(identifiers);
    }
    
    //1
    public static void deleteprfIndTargFromCache(List<String> identifiers){
        System.debug('updUIPId '+updUIPId);
        List<Id> listIds = updUIPId;
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
    
    //works
    //2
    public static void insertToCache(Performance_Indicator_Notable_Trends__c[] perfIndTrnds){
        if(perfIndTrnds.isEmpty())
        {return;}
        List<String> identifiers = new List<String>();
        List<Performance_Indicator_Notable_Trends__c> upContacts = new List<Performance_Indicator_Notable_Trends__c>(); 
        List<Id> uipIds = updUIPId;
        List<Id> uipElemIds4 = new List<Id>();        
        for(Performance_Indicator_Notable_Trends__c uipCon:perfIndTrnds)  {
            uipElemIds4.add(uipCon.Priority_Performance_Challenge_1__c);
            uipElemIds4.add(uipCon.Root_Cause_1__c);                 
            if(uipCon.ZPIF_UIP_Identidier__c == null){
                uipCon.ZPIF_UIP_Identidier__c = NewGuid();
                upContacts.add(uipCon);
            }
            identifiers.add(uipCon.ZPIF_UIP_Identidier__c);
        }
        System.debug('uipElemIds4 '+uipElemIds4);
        System.debug('identifiers '+identifiers);
        System.debug('upContacts '+upContacts);
        if(upContacts.size()>0) {update upContacts;}
        System.debug('mapUIPZ '+mapUIPZ);
        map<Id,Id> mapElem = getZPFElementForUIP(uipElemIds4);   
        List<ZPF_Performance_Indicator_Notable_Trends__c> ExstngZuips = [Select ZPIF_UIP_Identidier__c,Id from ZPF_Performance_Indicator_Notable_Trends__c where ZPIF_UIP_Identidier__c IN :identifiers];
        System.debug('ExstngZuips '+ExstngZuips);
        map<String,Id> mapExistingZUIP = new map<String,Id>();
        for(ZPF_Performance_Indicator_Notable_Trends__c zuip: ExstngZuips) {mapExistingZUIP.put(zuip.ZPIF_UIP_Identidier__c,zuip.Id);}
        List<ZPF_Performance_Indicator_Notable_Trends__c> zuips = new LIST<ZPF_Performance_Indicator_Notable_Trends__c>();
        Map<String, SObjectField> fields = Schema.getGlobalDescribe().get('ZPF_Performance_Indicator_Notable_Trends__c').getDescribe().fields.getMap();
        List<RecordType> recs = [SELECT Id,DeveloperName,Name FROM RecordType WHERE sobjecttype = 'ZPF_Performance_Indicator_Notable_Trends__c'];
        Map<String,Id> mapRecId = new Map<String,Id>();
        for(RecordType rec:recs) {mapRecId.put(rec.DeveloperName, rec.Id);}
        for(Performance_Indicator_Notable_Trends__c var:perfIndTrnds){
            ZPF_Performance_Indicator_Notable_Trends__c inserting = new ZPF_Performance_Indicator_Notable_Trends__c();
            for(String field:fields.keySet()){                  
                if(!mapExistingZUIP.containsKey(var.ZPIF_UIP_Identidier__c)){
                    if((field.contains('__c') || field.contains('__C')) && !fields.get(field).getDescribe().isCalculated()){
                        if(field.equalsIgnoreCase('UIP__c')){System.debug('mapUIPZ.get((ID)var.get(f)) '+mapUIPZ.get((ID)var.get(field))); inserting.put(field,mapUIPZ.get((ID)var.get(field))); }
                        else if(field.equalsIgnoreCase('Priority_Performance_Challenge_1__c') || field.equalsIgnoreCase('Root_Cause_1__c')){
                            if(mapElem.containsKey((ID)var.get(field))){inserting.put(field,mapElem.get((ID)var.get(field)));}
                        }
                        else{inserting.put(field,var.get(field));}
                    }
                    else if((field.contains('__c') || field.contains('__C')) && !fields.get(field).getDescribe().isCalculated() && fields.get(field).getDescribe().isUpdateable()){
                        if(field.equalsIgnoreCase('UIP__c')){System.debug('mapUIPZ.get((ID)var.get(f)) '+mapUIPZ.get((ID)var.get(field))); inserting.put(field,mapUIPZ.get((ID)var.get(field))); }
                        else if(field.equalsIgnoreCase('Priority_Performance_Challenge_1__c') || field.equalsIgnoreCase('Root_Cause_1__c')){
                            if(mapElem.containsKey((ID)var.get(field))){inserting.put(field,mapElem.get((ID)var.get(field)));}
                        }
                        else{inserting.put(field,var.get(field));}
                    }
                }
                if(mapExistingZUIP.containsKey(var.ZPIF_UIP_Identidier__c)){
                    if((field.contains('__c') || field.contains('__C')) && !fields.get(field).getDescribe().isCalculated()){
                        if(field.equalsIgnoreCase('UIP__c')){System.debug('mapUIPZ.get((ID)var.get(f)) '+mapUIPZ.get((ID)var.get(field))); inserting.put(field,mapUIPZ.get((ID)var.get(field))); }
                        else if(field.equalsIgnoreCase('Priority_Performance_Challenge_1__c') || field.equalsIgnoreCase('Root_Cause_1__c')){
                            if(mapElem.containsKey((ID)var.get(field))){inserting.put(field,mapElem.get((ID)var.get(field)));}
                        }
                        else{inserting.put(field,var.get(field));}
                    }
                    else if((field.contains('__c') || field.contains('__C')) && !fields.get(field).getDescribe().isCalculated() && fields.get(field).getDescribe().isUpdateable()){
                        if(field.equalsIgnoreCase('UIP__c')){System.debug('mapUIPZ.get((ID)var.get(f)) '+mapUIPZ.get((ID)var.get(field))); inserting.put(field,mapUIPZ.get((ID)var.get(field))); }
                        else if(field.equalsIgnoreCase('Priority_Performance_Challenge_1__c') || field.equalsIgnoreCase('Root_Cause_1__c')){
                            if(mapElem.containsKey((ID)var.get(field))){inserting.put(field,mapElem.get((ID)var.get(field)));}
                        }
                        else{inserting.put(field,var.get(field));}
                    }
                }
            }  
            if(mapExistingZUIP.containsKey(var.ZPIF_UIP_Identidier__c)){
                inserting.RecordTypeId = mapRecId.get(var.RecordType.DeveloperName); 
                inserting.ZPIF_UIP_Identidier__c = var.ZPIF_UIP_Identidier__c;
                inserting.Id = mapExistingZUIP.get(var.ZPIF_UIP_Identidier__c); 
                inserting.Public_Facing__c = true;
            } 
            else{
                inserting.RecordTypeId = mapRecId.get(var.RecordType.DeveloperName);                                   
                inserting.Public_Facing__c = true; 
            }         
            zuips.add(inserting);
        }
        System.debug('zuips '+zuips);
        if(zuips.size()>0){try{upsert zuips;}catch(Exception e){System.debug('e '+e);}}
        deletePerIndNotRndsFromCache(identifiers);
    }
    
    //1
    public static void deletePerIndNotRndsFromCache(List<String> identifiers){
        System.debug('updUIPId '+updUIPId);
        List<Id> listIds = updUIPId;
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
    
    public static List<Id> addenIds = new List<Id>();
    
    //1
    public static void insertToCache(Supporting_Addenda_Forms__c[] supAddends){
        if(supAddends.isEmpty())
        {return;}
        System.debug('supAddends '+supAddends);
        List<String> identifiers = new List<String>();
        List<Supporting_Addenda_Forms__c> upContacts = new List<Supporting_Addenda_Forms__c>();             
        for(Supporting_Addenda_Forms__c uipCon:supAddends)  {
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
        for(Supporting_Addenda_Forms__c var:supAddends){
            ZPF_Supporting_Addenda_Forms__c inserting = new ZPF_Supporting_Addenda_Forms__c();
            for(String field:fields.keySet()){                  
                if(!mapExistingZUIP.containsKey(var.ZPIF_UIP_Identidier__c)){
                    if((field.contains('__c') || field.contains('__C')) && !fields.get(field).getDescribe().isCalculated()){inserting.put(field,var.get(field));}
                    else if((field.contains('__c') || field.contains('__C')) && !fields.get(field).getDescribe().isCalculated() && fields.get(field).getDescribe().isUpdateable()){
                        if(field.equalsIgnoreCase('Addendum__c')){inserting.put(field,mapAddends.get((ID)var.get(field)));}
                        else{inserting.put(field,var.get(field));}
                    }
                } 
                if(mapExistingZUIP.containsKey(var.ZPIF_UIP_Identidier__c)){
                    if((field.contains('__c') || field.contains('__C')) && !fields.get(field).getDescribe().isCalculated()){inserting.put(field,var.get(field));}
                    else if((field.contains('__c') || field.contains('__C')) && !fields.get(field).getDescribe().isCalculated() && fields.get(field).getDescribe().isUpdateable()){
                        if(field.equalsIgnoreCase('Addendum__c')){inserting.put(field,mapAddends.get((ID)var.get(field)));}
                        else{inserting.put(field,var.get(field));}
                    }
                }
            }    
            if(mapExistingZUIP.containsKey(var.ZPIF_UIP_Identidier__c)){
                inserting.ZPIF_UIP_Identidier__c = var.ZPIF_UIP_Identidier__c;
                inserting.Id = mapExistingZUIP.get(var.ZPIF_UIP_Identidier__c); 
            } 
            else{                    
                inserting.Public_Facing__c = true; 
            }
            zuips.add(inserting);
        }
        if(zuips.size()>0){try{upsert zuips;}catch(Exception e){System.debug('e '+e);}}
        deleteSuppAddenFrmFromCache(identifiers);
    }
    
    //1
    public static void deleteSuppAddenFrmFromCache(List<String> identifiers){
        System.debug('updUIPId '+updUIPId);
        List<Id> listIds = updUIPId;
        System.debug('mapUIP '+mapUIP.keySet());
        List<ZPF_Supporting_Addenda_Forms__c> deletedZPF = [Select ZPIF_UIP_Identidier__c,Id from ZPF_Supporting_Addenda_Forms__c where ZPIF_UIP_Identidier__c NOT IN :identifiers and Addendum__r.UIP__C IN :mapUIP.keySet()];
        if(!deletedZPF.isEmpty() && deletedZPF.size()>0){try{delete deletedZPF;}catch(Exception e){System.debug('e '+e);}}
    }
    
    //2
    public static map<Id,Id> getZPIFFUIPForUIP(Id[] UIPs){
        Map<Id,Id> mapUIPCache = new Map<Id,Id>();
        System.debug('UIPs '+UIPs);
        List<UIP__c> ul = [Select ZPIF_UIP_Identidier__c,Id from UIP__c where Id IN :UIPs];
        map<String,Id> uz = new map<String,Id>();
        for(UIP__c u : ul){uz.put(u.ZPIF_UIP_Identidier__c,u.Id);}
        List<ZPIF_UIP__c> zl = [Select Id,ZPIF_UIP_Identidier__c from ZPIF_UIP__c where ZPIF_UIP_Identidier__c IN :uz.keySet()];
        System.debug('zl '+zl);
        for(ZPIF_UIP__c u : zl){ mapUIPCache.put(uz.get(u.ZPIF_UIP_Identidier__c),u.Id);}
        System.debug('mapUIPCache '+mapUIPCache);
        return mapUIPCache;
    }   
    
    //2
    public static map<Id,Id> getZPFElementForUIP(Id[] UIPs){
        Map<Id,Id> mapUIPElemCache = new Map<Id,Id>();        
        Map<String,Id> mapIdentiUIP = new Map<String,Id>();
        mapUIPElemCache = new Map<Id,Id>();
        System.debug('UIPs '+UIPs);
        List<UIP_Element__c> uips1 = [Select Id,ZPIF_UIP_Identidier__c from UIP_Element__c where Id IN :UIPs];  
        System.debug('uips1 '+uips1);
        for(UIP_Element__c uip:uips1) { System.debug('uip.ZPIF_UIP_Identidier__c,uip.Id '+ uip.ZPIF_UIP_Identidier__c+ ' , ' +uip.Id); mapIdentiUIP.put(uip.ZPIF_UIP_Identidier__c,uip.Id);}
        System.debug('mapIdentiUIP '+mapIdentiUIP);
        Set<String> identifiers = mapIdentiUIP.keySet();
        System.debug('identifiers '+identifiers);
        List<ZPF_UIP_Element__c> zuips = [Select Id,ZPIF_UIP_Identidier__c from ZPF_UIP_Element__c where ZPIF_UIP_Identidier__c IN :identifiers]; 
        System.debug('zuips '+zuips);
        for(ZPF_UIP_Element__c zuip:zuips){
            if(mapIdentiUIP.containsKey(zuip.ZPIF_UIP_Identidier__c)){mapUIPElemCache.put(mapIdentiUIP.get(zuip.ZPIF_UIP_Identidier__c),zuip.Id);}
        }           
        return mapUIPElemCache;
    }
    
    public static Map<Id,Id> mapImpActStp;
    
    //2
    public static map<Id,Id> getZPFImplActionStepsForUIP(List<Id> UIPs){
        if(mapImpActStp == null){
            Map<String,Id> mapIdentiUIP = new Map<String,Id>();
            mapImpActStp = new Map<Id,Id>();
            List<Improvement_Action_Step__c> uips1 = [Select Id,ZPIF_UIP_Identidier__c from Improvement_Action_Step__c where Id IN :UIPs];  
            System.debug('uips1 '+uips1);
            for(Improvement_Action_Step__c uip:uips1) {mapIdentiUIP.put(uip.ZPIF_UIP_Identidier__c,uip.Id);}
            System.debug('mapIdentiUIP '+mapIdentiUIP);
            Set<String> identifiers = mapIdentiUIP.keySet();
            System.debug('identifiers '+identifiers);
            List<ZPF_Improvement_Action_Step__c> zuips = [Select Id,ZPIF_UIP_Identidier__c from ZPF_Improvement_Action_Step__c where ZPIF_UIP_Identidier__c IN :identifiers];  
            System.debug('zuips '+zuips);
            for(ZPF_Improvement_Action_Step__c zuip:zuips){
                if(mapIdentiUIP.containsKey(zuip.ZPIF_UIP_Identidier__c))
                {
                    System.debug('mapIdentiUIP.get(zuip.ZPIF_UIP_Identidier__c) '+mapIdentiUIP.get(zuip.ZPIF_UIP_Identidier__c));
                    System.debug('zuip.Id '+zuip.Id);
                    mapImpActStp.put(mapIdentiUIP.get(zuip.ZPIF_UIP_Identidier__c),zuip.Id);
                }                
            }
            System.debug('mapImpActStp '+mapImpActStp);
        }
        return mapImpActStp;
    }                  
    
    //2
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
    
    //2
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
    
    //2
    public static map<Id,Id> getImprActStp(List<Id> UIPs){
        Map<Id,Id> mapImprActzpf = new Map<Id,Id>();
        Map<String,Id> mapIdentiUIP = new Map<String,Id>();
        List<Improvement_Action_Step__c> uips1 = [Select Id,ZPIF_UIP_Identidier__c from Improvement_Action_Step__c where Id IN :UIPs];  
        for(Improvement_Action_Step__c uip:uips1) {mapIdentiUIP.put(uip.ZPIF_UIP_Identidier__c,uip.Id);}
        Set<String> identifiers = mapIdentiUIP.keySet();
        List<ZPF_Improvement_Action_Step__c> zuips = [Select Id,ZPIF_UIP_Identidier__c from ZPF_Improvement_Action_Step__c where ZPIF_UIP_Identidier__c IN :identifiers];  
        for(ZPF_Improvement_Action_Step__c zuip:zuips){
            if(mapIdentiUIP.containsKey(zuip.ZPIF_UIP_Identidier__c)){mapImprActzpf.put(mapIdentiUIP.get(zuip.ZPIF_UIP_Identidier__c),zuip.Id);}
        }      
        return mapImprActzpf;
    }         
    
    //2
    public static map<Id,Id> getImpBenchMarkzpf(List<Id> UIPs){
        Map<Id,Id> mapImpBenchMarkzpf = new Map<Id,Id>();
        mapImpBenchMarkzpf = new Map<Id,Id>();      
        Map<String,Id> mapIdentiUIP = new Map<String,Id>();
        List<Implementation_Benchmark__c> uips1 = [Select Id,ZPIF_UIP_Identidier__c from Implementation_Benchmark__c where Id IN :UIPs];    
        for(Implementation_Benchmark__c uip:uips1) {mapIdentiUIP.put(uip.ZPIF_UIP_Identidier__c,uip.Id);}
        Set<String> identifiers = mapIdentiUIP.keySet();
        List<ZPF_Implementation_Benchmark__c> zuips = [Select Id,ZPIF_UIP_Identidier__c from ZPF_Implementation_Benchmark__c where ZPIF_UIP_Identidier__c IN :identifiers];  
        for(ZPF_Implementation_Benchmark__c zuip:zuips){
            if(mapIdentiUIP.containsKey(zuip.ZPIF_UIP_Identidier__c)){mapImpBenchMarkzpf.put(mapIdentiUIP.get(zuip.ZPIF_UIP_Identidier__c),zuip.Id);}
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