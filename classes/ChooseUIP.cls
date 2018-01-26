public without sharing class ChooseUIP {
/**
* ─────────────────────────────────────────────────────────────────────────────────────────────────┐
* ChooseUIP
*
* Accessed via button code on UIPHome Visualforce page.  Copies UIP data and related records from
* a SELECTED prior year's UIP to the CURRENT year UIP to "prefill" UIP data and related records for updating
* ──────────────────────────────────────────────────────────────────────────────────────────────────
* @author:         Vertiba
* @modifiedBy:     Vertiba
*   10/25/17 Support Request-00008655 - Prior code deleted related records that had been added to UIP and "re-initialized" with selected prior year data
* Changed to no longer delete any data in case school already began working on current year
* Add last year's data as was already implemented
*/    
    public static final Integer MAX_UIP_ELEM = 9;
    
    private List<UIP__c> uipList;
    public String currentId { get; set; }
    public String selectedUIP { get; set; }
    
    private UIP__c currentUIP;
    public boolean isDeleteError { get; set; }
    private Map<Id, UIP__c> uipMap;
    public boolean closeWindow { get; set; }
    public Date startDate {get; set;}
    
    public ChooseUIP() {
        closeWindow = false;
        Map<String,String> params = ApexPages.currentPage().getParameters();
        isDeleteError = false;
        if (params.containsKey('id')) {currentId = params.get('id');}
        selectUIP();
        selectUIPs();
    }
    
    private void selectUIP() {
        if (currentId != null && currentId != '') {
            String soql = SectionUtil.getFieldsQuery('UIP__c');
            soql += ', RecordType.Name ';
            soql += ',(SELECT Id, RecordTypeId FROM Addenda__r)'; 
            soql += ' FROM UIP__c WHERE Id = \'' + currentId + '\' limit 1';
            currentUIP = Database.query(soql);
        }
    }
    
    private void selectUIPs() {
        List<Id>  recType = new List<Id>();
        if(currentUIP.RecordType.Name == 'District UIP 2017') {
            recType.add(Schema.SObjectType.UIP__c.getRecordTypeInfosByName().get('District UIP 2016').getRecordTypeId());
            recType.add(Schema.SObjectType.UIP__c.getRecordTypeInfosByName().get('District UIP 2015').getRecordTypeId());
            recType.add(Schema.SObjectType.UIP__c.getRecordTypeInfosByName().get('District UIP').getRecordTypeId()); 
        }
            
        else if(currentUIP.RecordType.Name == 'AEC UIP 2017') {
            recType.add(Schema.SObjectType.UIP__c.getRecordTypeInfosByName().get('AEC UIP 2016').getRecordTypeId());
            recType.add(Schema.SObjectType.UIP__c.getRecordTypeInfosByName().get('AEC UIP 2015').getRecordTypeId());
            recType.add(Schema.SObjectType.UIP__c.getRecordTypeInfosByName().get('AEC UIP').getRecordTypeId()); 
        }
        else if(currentUIP.RecordType.Name == 'School UIP 2017') {
            recType.add(Schema.SObjectType.UIP__c.getRecordTypeInfosByName().get('School UIP 2016').getRecordTypeId());
            recType.add(Schema.SObjectType.UIP__c.getRecordTypeInfosByName().get('School UIP 2015').getRecordTypeId());
            recType.add(Schema.SObjectType.UIP__c.getRecordTypeInfosByName().get('School UIP').getRecordTypeId()); 
        }
        
        String soql;
        if(recType != null) {
            soql = 'SELECT Id, Name FROM UIP__c WHERE Id != \'' + currentId + '\' AND Is_Version__c != true AND RecordTypeId IN : recType';
            if (currentUIP.SCHOOL_NUMBER__c != null) {  soql += ' AND SCHOOL_NUMBER__c = \'' + currentUIP.SCHOOL_NUMBER__c + '\'';} 
            else if (currentUIP.DIST_NUMBER__c != null) { soql += ' AND DIST_NUMBER__c = \'' + currentUIP.DIST_NUMBER__c + '\'';}
        }
        else
        {
            soql = 'SELECT Id, Name FROM UIP__c WHERE Id != \'' + currentId + '\' AND Is_Version__c != true ';
            if (currentUIP.SCHOOL_NUMBER__c != null) { soql += ' AND SCHOOL_NUMBER__c = \'' + currentUIP.SCHOOL_NUMBER__c + '\''; } 
            else if (currentUIP.DIST_NUMBER__c != null) {soql += ' AND DIST_NUMBER__c = \'' + currentUIP.DIST_NUMBER__c + '\'';}
        }
        uipList = Database.query(soql);
    }
    
    public List<SelectOption> getUIPs() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','-- None --'));
        for (UIP__c elem : uipList) {
            options.add(new SelectOption(elem.Id, elem.Name));
        }
        return options;
    }
    
    public Map<String,UIP_Element__c> currYearPPCNameMap = new Map<String,UIP_Element__c>();
    public UIP_Element__c associationPPC;

    // Method to create a map of Current UIP Element records keyed by Name
    public void updateMapPPC(){
        String soql = SectionUtil.getFieldsQuery('UIP_Element__c');                        
        soql += ' FROM UIP_Element__c where RecordType.name like '+'\'Challenge\' and UIP__c='+'\''+currentUIP.Id+'\' order by name desc';
        List<UIP_Element__c> currYearUipElemList = Database.query(soql); 
        for (UIP_Element__c uipElem : currYearUipElemList) {  
            currYearPPCNameMap.put(uipElem.name, uipElem); 
            system.debug('uipEl.id:'+uipElem.id);
        }
    }
    // No Longer Used 110717 Method to get the name of the PPC for a 'Selected' PI Target, see fi there is a corresponding 'Current' PI Target with a PPC with the same name
    // Return the 'Current' UIP Element record for that Challenge so that the new cloned PI target can look up to the 'Current' existing Challenge record  
/*    public UIP_Element__c CopyTargetForPPC(Performance_Indicator_Targets__c prevYearTarget) {
        if(prevYearTarget.Priority_Performance_Challenge_1__r.name!=null && currYearPPCNameMap.containsKey(prevYearTarget.Priority_Performance_Challenge_1__r.name))
        { associationPPC = currYearPPCNameMap.get(prevYearTarget.Priority_Performance_Challenge_1__r.name); }       
        return associationPPC;
    }
*/    
    public void CopyQuestion() {
        isDeleteError = true;
    }
    
    public void CopyValues() {
        Savepoint sp = database.setSavepoint();
        set<id> inactiveUsers=new Map<Id,User>([select id from user where isactive=false]).keySet();
        system.debug('curUIP:'+currentUIP);
        if(currentUIP.Copy_from_Last_Year_Done__c) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'The Current UIP has already been updated from a Prior UIP - Contact CDE if you need assistance refreshing information.'));
            database.rollback(sp);
            return;
        }
        
        uipMap = new Map<Id, UIP__c>();
        String soql = SectionUtil.getFieldsQuery('UIP__c');
        soql += ' FROM UIP__c WHERE Id = \'' + selectedUIP + '\' limit 1';
        UIP__c selectedUIPrec = Database.query(soql);
        uipMap.put(selectedUIPrec.Id, selectedUIPrec);
        // Update UIP fields - get allowed length of field and append substring of selected UIP field's value to the "unused" length if the current UIP field already has a value
        // currentUIP.Related_Grant_Awards__c!=null ? currentUIP.Related_Grant_Awards__c
        //    + (uipMap.get(selectedUIP).Related_Grant_Awards__c !=null ? (uipMap.get(selectedUIP).Related_Grant_Awards__c).left(UIP__c.Related_Grant_Awards__c.getDescribe().getLength()-currentUIP.Related_Grant_Awards__c.length()) : '')       
        currentUIP.Related_Grant_Awards__c = uipMap.get(selectedUIP).Related_Grant_Awards__c;
        currentUIP.SST_Expedited_Review__c = uipMap.get(selectedUIP).SST_Expedited_Review__c;
        currentUIP.External_Evaluator__c = uipMap.get(selectedUIP).External_Evaluator__c;
        currentUIP.State_Accreditation__c = uipMap.get(selectedUIP).State_Accreditation__c;
        currentUIP.Title_I_Focus_School__c = uipMap.get(selectedUIP).Title_I_Focus_School__c;
        currentUIP.Tiered_Intervention_Grant_TIG__c = uipMap.get(selectedUIP).Tiered_Intervention_Grant_TIG__c;
        currentUIP.Diagnostic_Review_Grant_Checkbox__c = uipMap.get(selectedUIP).Diagnostic_Review_Grant_Checkbox__c;
        currentUIP.School_Improvement_Support_Grant__c = uipMap.get(selectedUIP).School_Improvement_Support_Grant__c;
        currentUIP.Colorado_Graduation_Pathways_Program__c = uipMap.get(selectedUIP).Colorado_Graduation_Pathways_Program__c;
        currentUIP.Other__c = uipMap.get(selectedUIP).Other__c;
        currentUIP.Other_Description__c = uipMap.get(selectedUIP).Other_Description__c;
        currentUIP.TextAreaRich_Test__c = uipMap.get(selectedUIP).TextAreaRich_Test__c;
        currentUIP.Target_Reflection__c = uipMap.get(selectedUIP).Target_Reflection__c;
        currentUIP.Narrative_Academic_Achievement_Targets__c = uipMap.get(selectedUIP).Narrative_Academic_Achievement_Targets__c;
        currentUIP.Narrative_Academic_Growth_Targets__c = uipMap.get(selectedUIP).Narrative_Academic_Growth_Targets__c;
        currentUIP.Narrative_Academic_Growth_Gaps_Target__c = uipMap.get(selectedUIP).Narrative_Academic_Growth_Gaps_Target__c;
        currentUIP.Narrative_Postsecondary_Workforce_Target__c = uipMap.get(selectedUIP).Narrative_Postsecondary_Workforce_Target__c;
        currentUIP.Narrative_English_Lang_Dev_Attain_Target__c = uipMap.get(selectedUIP).Narrative_English_Lang_Dev_Attain_Target__c;
        currentUIP.Narrative_Student_Engagement_Target__c = uipMap.get(selectedUIP).Narrative_Student_Engagement_Target__c;
        currentUIP.Performance_Challenge_Narrative__c = uipMap.get(selectedUIP).Performance_Challenge_Narrative__c;
        currentUIP.Root_Cause_Narrative__c = uipMap.get(selectedUIP).Root_Cause_Narrative__c;
        currentUIP.Narrative_Additional__c = uipMap.get(selectedUIP).Narrative_Additional__c;
        currentUIP.Narrative_Additional_Trend_Information__c = uipMap.get(selectedUIP).Narrative_Additional_Trend_Information__c;
        currentUIP.Last_Year_s_UIP__c = uipMap.get(selectedUIP).Id;
        currentUIP.Copy_from_Last_Year_Done__c = true;
        try {
            update currentUIP;
            updateMapPPC();
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            database.rollback(sp);
            return;
        }
        // Removed per Support Request-00008655
/*        List<UIP_Contact__c> existingUipContactList = [SELECT Id FROM UIP_Contact__c WHERE UIP__c = :currentUIP.Id ];
        try {
            if (existingUipContactList.size() > 0) { delete existingUipContactList; }
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            database.rollback(sp);
            return;
        }
*/
        if (test.isRunningTest()) { soql = 'SELECT Id';  } 
        else { soql = SectionUtil.getFieldsQuery('UIP_Contact__c');  }
        soql += ' FROM UIP_Contact__c WHERE UIP__c = \'' + selectedUIP + '\'';
        List<UIP_Contact__c> uipContactList = Database.query(soql);
        List<UIP_Contact__c> newUipContactList = new List<UIP_Contact__c>();
        system.debug('uipContact:'+uipContactList);
        UIP_Contact__c newUipContact;
        for (UIP_Contact__c c : uipContactList) {
            newUipContact = new UIP_Contact__c();
            newUipContact = c.clone(false, true);
            if(inactiveUsers.contains(newUipContact.ownerId))
                newUipContact.ownerId=Userinfo.getUserId();
            newUipContact.UIP__c = currentUIP.Id;
            newUipContact.ZPIF_UIP_Identidier__c=null;
            newUipContactList.add(newUipContact);
        }
        try {
            if (newUipContactList.size() > 0) {insert newUipContactList;}
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            database.rollback(sp);
            return;
        }
        // Removed per Support Request-00008655
/*        soql = SectionUtil.getFieldsQuery('UIP_Element__c');
        soql += ' FROM UIP_Element__c WHERE UIP__c = \'' + currentUIP.Id + '\'';
        List<UIP_Element__c> existingUipElemList = Database.query(soql);
        system.debug('delElemList:'+existingUipElemList);
        try {
            if (existingUipElemList.size() > 0) { delete existingUipElemList; }
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            database.rollback(sp);
            return;
        }
*/        
        // UIP Element has 30 recursive lookups to UIP Element records, 10 each for Challenge, MIS, and Root Cause
        soql = SectionUtil.getFieldsQuery('UIP_Element__c');
        soql += ' FROM UIP_Element__c WHERE UIP__c = \'' + selectedUIP + '\'';
        List<UIP_Element__c> uipElemList = Database.query(soql);
        List<UIP_Element__c> newElemList = new List<UIP_Element__c>();
        Map<Id,UIP_Element__c> newElemMap = new Map<Id,UIP_Element__c>();
        UIP_Element__c newUipElem;
        for (UIP_Element__c e : uipElemList) {
            newUipElem = new UIP_Element__c();
            newUipElem = e.clone(false, true);  //create a full copy of the record
            if(inactiveUsers.contains(newUipElem.ownerId))
                newUipElem.ownerId=UserInfo.getUserId();
            newUipElem.UIP__c = currentUIP.Id;
            newUipElem.ZPIF_UIP_Identidier__c=null;
            newElemList.add(newUipElem);
            newElemMap.put(e.Id, newUipElem);
            // newElemMap maps the "old" (related to Selected UIP) UIP Element record.id with the newly created cloned UIP Element record that is related to the Current UIP.  
            // This allows updating lookups for Challenge, MIS, and Root Cause records to new record IDS
        }
        system.debug('newElemap:'+newElemMap);
        try {
            if (newElemList.size() > 0) { insert newElemMap.values(); }
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            database.rollback(sp);
            return;
        }
        system.debug('AInewElemap:'+newElemMap); 
        // For each Element record in the Map, If the Element has a Challenge, MIS, or Root Cause lookup, update it from the Selected UIP-related Element id to the newly created Element ID
        for (Id key : newElemMap.keySet()) {
            for (integer i = 1; i <= MAX_UIP_ELEM; i++) {
                if ((Id)newElemMap.get(key).get('Challenge_' + i + '__c') != null && newElemMap.get((Id)newElemMap.get(key).get('Challenge_' + i + '__c')) != null) {    
                    //get the Element record then get that record's field value for the old Challenge lookup id to see if not null, and check that there is a newElemMap record with the id from Challenge_i
                    // get the map record with key=old Challenge_i lookup value, and update the new Element's Challenge_i lookup value to the record ID from the new Element record
                    newElemMap.get(key).put('Challenge_' + i + '__c', newElemMap.get((Id)newElemMap.get(key).get('Challenge_' + i + '__c')).Id);
                }
                if ((Id)newElemMap.get(key).get('Major_Improvement_Strategy_' + i + '__c') !=null && newElemMap.get((Id)newElemMap.get(key).get('Major_Improvement_Strategy_' + i + '__c')) !=null) {
                    newElemMap.get(key).put('Major_Improvement_Strategy_' + i + '__c', newElemMap.get((Id)newElemMap.get(key).get('Major_Improvement_Strategy_' + i + '__c')).Id);
                }
                if ((Id)newElemMap.get(key).get('Root_Cause_' + i + '__c') !=null && newElemMap.get((Id)newElemMap.get(key).get('Root_Cause_' + i + '__c')) != null) {
                    newElemMap.get(key).put('Root_Cause_' + i + '__c', newElemMap.get((Id)newElemMap.get(key).get('Root_Cause_' + i + '__c')).Id);
                }
            }
        }
        try {
            update newElemMap.values();
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            database.rollback(sp);
            return;
        }
        

        // Removed per Support Request-00008655
/*        soql = SectionUtil.getFieldsQuery('Performance_Indicator_Targets__c');
        soql += ' FROM Performance_Indicator_Targets__c WHERE UIP__c = \'' + currentUip.Id + '\'';
        List<Performance_Indicator_Targets__c> existingPiList = Database.query(soql);
        try {
            if (existingPiList.size() > 0) {
                delete existingPiList;
            }
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            database.rollback(sp);
            return;
        }
*/
        //get Performance Indicator Targets for 'Selected' UIP
        soql = SectionUtil.getFieldsQuery('Performance_Indicator_Targets__c');
        soql += ',Priority_Performance_Challenge_1__r.name FROM Performance_Indicator_Targets__c WHERE UIP__c = \'' + selectedUIP + '\'';
        List<Performance_Indicator_Targets__c> piList = Database.query(soql);
        System.debug('piList '+ piList);
        List<Performance_Indicator_Targets__c> newPitList = new List<Performance_Indicator_Targets__c>();
        Performance_Indicator_Targets__c newPi;
        String priorYearRT = Schema.SObjectType.Performance_Indicator_Targets__c.getRecordTypeInfosByName().get('Prior Year Target').getRecordTypeId();
        String thisYearRT = Schema.SObjectType.Performance_Indicator_Targets__c.getRecordTypeInfosByName().get('This Year\'s Target').getRecordTypeId();
        String nextYearRT = Schema.SObjectType.Performance_Indicator_Targets__c.getRecordTypeInfosByName().get('Next Year\'s Target').getRecordTypeId();
        
        // For each Performance Indicator Target for the Selected UIP, change "This Year" targets to "Last Year", and change "Next Year" targets to "This Year"
        // For example if user selected 2016 targets to prefill 2017 UIP, 2016's "this year" is 2017's "prior year"
        // PI Target has 2 UIP Element lookups - MIS and PP Challenge
        // Record type of Prior Year Target are NOT copied to 'Current' UIP

        for (Performance_Indicator_Targets__c pi : piList) {
            // since we made a copy of 'Selected' UIP Elements for 'Current' UIP, keep existing PIT-Element record relationship, user will manually update to lookup to 'Current' Challenge if needed
//            UIP_Element__c newPPC = CopyTargetForPPC(pi);
            if (pi.RecordTypeId == thisYearRT) {
                newPi = new Performance_Indicator_Targets__c();
                newPi.UIP__c = currentUip.Id;
                newPi.RecordTypeId = priorYearRT;
                newPi.Last_Year_Target_1__c = pi.This_Year_Target_1__c;
                newPi.Performance_Indicator__c = pi.Performance_Indicator__c;
//                if(newPPC!=null)
//                    newPi.Priority_Performance_Challenge_1__c = newPPC.Id;
//              // update PPC record lookup to newly created copy of Challenge Element but leave MIS lookup and Next Year Related Target lookup blank
                if(newPi.Priority_Performance_Challenge_1__c != null)
                    newPi.Priority_Performance_Challenge_1__c = newElemMap.get(pi.Priority_Performance_Challenge_1__c).Id;
                newPitList.add(newPi);
            } else if (pi.RecordTypeId == nextYearRT) {
                newPi = new Performance_Indicator_Targets__c();
                newPi = pi.clone(false, true);
                if(inactiveUsers.contains(newPi.ownerId))
                    newPi.ownerId=UserInfo.getUserId();
                newPi.UIP__c = currentUip.Id;
                newPi.RecordTypeId = thisYearRT;
                newPi.Last_Year_Target_1__c = null;
                newPi.This_Year_Target_1__c = pi.Next_Year_Target_1__c;
                newPi.Next_Year_Target_1__c = null;
//                if(newPPC!=null)
//                    newPi.Priority_Performance_Challenge_1__c = newPPC.Id;
                if(newPi.Priority_Performance_Challenge_1__c != null)
                    newPi.Priority_Performance_Challenge_1__c = newElemMap.get(pi.Priority_Performance_Challenge_1__c).Id;
                newPi.Major_Improvement_Strategy_1__c = null;
                newPi.Next_Year_Related_Target__c = null;
                newPi.ZPIF_UIP_Identidier__c=null;
                newPitList.add(newPi);
            }
        }
        try {
            if (newPitList.size() > 0) {
                insert newPitList;
            }
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            database.rollback(sp);
            return;
        }       
        // Removed per Support Request-00008655
/*        soql = SectionUtil.getFieldsQuery('Performance_Indicator_Notable_Trends__c');
        soql += ' FROM Performance_Indicator_Notable_Trends__c WHERE UIP__c = \'' + currentUIP.Id + '\'';
        List<Performance_Indicator_Notable_Trends__c> existingPintList = Database.query(soql);
        try {
            if (existingPintList.size() > 0) {
                delete existingPintList;
            }
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            database.rollback(sp);
            return;
        }
*/
        //clone Performance_Indicator_Notable_Trends__c
        soql = SectionUtil.getFieldsQuery('Performance_Indicator_Notable_Trends__c');
        soql += ' FROM Performance_Indicator_Notable_Trends__c WHERE UIP__c = \'' + selectedUIP + '\'';
        List<Performance_Indicator_Notable_Trends__c> pintList = Database.query(soql);
        System.debug('pintList:::' + pintList);
        List<Performance_Indicator_Notable_Trends__c> newPintList = new List<Performance_Indicator_Notable_Trends__c>();
        Performance_Indicator_Notable_Trends__c newPint;
        for (Performance_Indicator_Notable_Trends__c pint : pintList) {
            newPint = new Performance_Indicator_Notable_Trends__c();
            newPint = pint.clone(false, true);
            newPint.UIP__c = currentUIP.Id;
            //newPint.Trend_Direction__c = null;
            //newPint.Notable_Trend__c = null;
            if (newPint.Root_Cause_1__c != null)
                newPint.Root_Cause_1__c = (Id)newElemMap.get(pint.Root_Cause_1__c).get('Id');
            if (newPint.Priority_Performance_Challenge_1__c != null)
                newPint.Priority_Performance_Challenge_1__c = newElemMap.get(pint.Priority_Performance_Challenge_1__c).Id;
            newPint.Notable_Trend__c = pint.Notable_Trend__c;
             //added by shiva for inactive user error
            if(inactiveUsers.contains(newPint.ownerId))
                newPint.ownerid=UserInfo.getUserId();
            newPint.ZPIF_UIP_Identidier__c=null;
            newPintList.add(newPint);
            System.debug('newPintList:::' + newPintList);
        }
        try {
            if (newPintList.size() > 0) {
                insert newPintList;
            }
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            database.rollback(sp);
            return;
        }

        // Removed per Support Request-00008655
/*        soql = SectionUtil.getFieldsQuery('Improvement_Action_Step__c');
        soql += ' FROM Improvement_Action_Step__c WHERE UIP__c = \'' + currentUIP.Id + '\'';
        system.debug('******clone Improvement_Action_Step__c******'+soql);
        List<Improvement_Action_Step__c> existingIasList = Database.query(soql);
        system.debug('******existingIasList******'+existingIasList.size());
        try {
            if (existingIasList.size() > 0) {
                delete existingIasList;
            }
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            database.rollback(sp);
            return;
        }
*/
        // get current academic year dates start/end dates
        // Only copy to UIP the IAS and IB records with Start or End Date > Current Academic Year start date
        Academic_Year__c academicYear =Academic_Year__c.getInstance('Academic Year');	
        if (academicYear == null) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'The Current Academic Year has not been set in Custom Settings. Contact CDE for assistance.'));
            database.rollback(sp);
            return;
        }
        startDate = academicYear.CurrentAcademicYrStartDate__c;
        
        //clone Improvement_Action_Step__c - as part of Support Request-00008655, copy only if Start_Date or End_Date is within the Current Academic Year fields
        soql = SectionUtil.getFieldsQuery('Improvement_Action_Step__c');
        soql += ' FROM Improvement_Action_Step__c WHERE UIP__c = \'' + selectedUIP + '\' AND (Start_Date__c >= :startDate OR Target_Date__c >= :startDate)';
        system.debug('******soql******'+soql);
        List<Improvement_Action_Step__c> iasList = Database.query(soql);        
        Map<Id,Improvement_Action_Step__c> iasOldIdNewRecMap = new Map<Id,Improvement_Action_Step__c>();    // use this to fill in new lookup ID to the IAS record in Benchmark-Action Step junction obj.
        system.debug('******iasList******'+iasList.size());
        List<Improvement_Action_Step__c> newIasList = new List<Improvement_Action_Step__c>();
        Improvement_Action_Step__c newIas;
        for (Improvement_Action_Step__c ias : iasList) {
            newIas = new Improvement_Action_Step__c();
            newIas = ias.clone(false, true);
            if(inactiveUsers.contains(newIas.ownerId))
                newIas.ownerId=UserInfo.getUserId();
            newIas.UIP__c = currentUIP.Id;
            newIas.Current_Year_Timeline__c = ias.Next_Year_Timeline__c;
            newIas.Next_Year_Timeline__c = null;
            // Improvement Action Step and Implementation Benchmark have lookups to each other - clone for  Implementation Benchmark is later in the code so can't set lookup here
            newIas.Implementation_Benchmark__c = null;   
            if (ias.Major_Improvement_Strategy__c != null) {
                newIas.Major_Improvement_Strategy__c = newElemMap.get(ias.Major_Improvement_Strategy__c).Id;
            }
            if(ias.Root_Cause_1__c != null)
                newIas.Root_Cause_1__c = newElemMap.get(ias.Root_Cause_1__c).Id;
            if(ias.Root_Cause_2__c != null)
                newIas.Root_Cause_2__c = newElemMap.get(ias.Root_Cause_2__c).Id;
            if(ias.Root_Cause_3__c != null)
                newIas.Root_Cause_3__c = newElemMap.get(ias.Root_Cause_3__c).Id;
            if(ias.Root_Cause_4__c != null)
                newIas.Root_Cause_4__c = newElemMap.get(ias.Root_Cause_4__c).Id;
            if(ias.Root_Cause_5__c != null)
                newIas.Root_Cause_5__c = newElemMap.get(ias.Root_Cause_5__c).Id;             
            newIas.ZPIF_UIP_Identidier__c = null;
            newIas.School_Year__c = 'This School Year';
            newIasList.add(newIas);
            iasOldIdNewRecMap.put(ias.Id,newIas);
        }
        system.debug('******newIasList.size()******'+newIasList.size());
        try {
            if (newIasList.size() > 0) {
                insert iasOldIdNewRecMap.values();
            }
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            database.rollback(sp);
            return;
        }
        system.debug('iasMapInserted:'+iasOldIdNewRecMap);
        
        // Removed per Support Request-00008655
/*        soql = SectionUtil.getFieldsQuery('Implementation_Benchmark__c');
        soql += ' FROM Implementation_Benchmark__c WHERE UIP__c = \'' + currentUIP.Id + '\'';
        system.debug('******clone Implementation_Benchmark__c******'+soql);
        List<Implementation_Benchmark__c> existingIbList = Database.query(soql);
        system.debug('******existingIasList******'+existingIbList.size());
        try {
            if (existingIbList.size() > 0) {
                delete existingIbList;
            }
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            database.rollback(sp);
            return;
        }
*/
        //clone Implementation Benchmark - as part of Support Request-00008655, copy only 'Next School Year', not 'This School Year'
        soql = SectionUtil.getFieldsQuery('Implementation_Benchmark__c');
        soql += ',Major_Improvement_Strategy__r.Id, Major_Improvement_Strategy__r.Name';
        soql += ' FROM Implementation_Benchmark__c WHERE UIP__c = \'' + selectedUIP + '\' AND (Start_Date__c >= :startDate OR End_Date__c >= :startDate)';            
        system.debug('******soql******'+soql);
        List<Implementation_Benchmark__c> ibList = Database.query(soql);
        Map<Id,Implementation_Benchmark__c> ibOldIdNewRecMap = new Map<Id,Implementation_Benchmark__c>();   // use this to fill in new lookup ID to the IB record in Benchnmark-Action Step junction obj.
        List<Implementation_Benchmark__c> newIbList = new List<Implementation_Benchmark__c>();
        Implementation_Benchmark__c newIb;
        for (Implementation_Benchmark__c ib : ibList) {
            newIb = new Implementation_Benchmark__c();
            newIb = ib.clone(false, true);
            if(inactiveUsers.contains(newIb.ownerId))
                newIb.ownerId=Userinfo.getUserId();
            newIb.UIP__c = currentUIP.Id;
            if (ib.Major_Improvement_Strategy__c != null) {
                newIb.Major_Improvement_Strategy__c = newElemMap.get(ib.Major_Improvement_Strategy__c).Id;
            }
            newIb.ZPIF_UIP_Identidier__c = null;
            newIb.School_Year__c = 'This School Year';
            newIbList.add(newIb);
            ibOldIdNewRecMap.put(ib.Id,newIb);
//Note code assumes Action_Step__c field lookup to Improvement_Action_Step__c object is/will be replaced by Benchmark-Action Step junction object
        }
        try {
            if (newIbList.size() > 0) {
                insert ibOldIdNewRecMap.values();
            }
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            database.rollback(sp);
            return;
        }

        // For each Implementation Benchmark and Action Step relationship there is a record in a junction object called BenchMar_ActiontStep__c. 
        // Clone BenchMar_ActiontStep for each Implementation benchmark and Action Step that is brought over to the new UIP
        // 
        if (ibOldIdNewRecMap.size() > 0 || iasOldIdNewRecMap.size() > 0) {
        Set<ID> ibKeys = ibOldIdNewRecMap.Keyset();
        Set<ID> iasKeys = iasOldIdNewRecMap.Keyset();
        soql = SectionUtil.getFieldsQuery('BenchMar_AtciontStep__c');
        soql += ' FROM BenchMar_AtciontStep__c WHERE Implementation_Benchmark__c IN :ibKeys OR Improvement_Action_Step__c IN :iasKeys';    
        system.debug('******soql******'+soql);
        List<BenchMar_AtciontStep__c> benchMarList = Database.query(soql);
        List<BenchMar_AtciontStep__c> newBenchMarList = new List<BenchMar_AtciontStep__c>();
        BenchMar_AtciontStep__c newBmas;
        for (BenchMar_AtciontStep__c bmas: benchMarList){
            //Only need to set Improvement Benchmark and Improvement Action Step lookups.  Since junction object may link IAS to IB where one was NOT defined as Next School Year, it won't be in map so can't copy 
            newBmas = new BenchMar_AtciontStep__c();        
            if (bmas.Implementation_Benchmark__c != null && ibOldIdNewRecMap.get(bmas.Implementation_Benchmark__c) != null) {
                newBmas.Implementation_Benchmark__c = ibOldIdNewRecMap.get(bmas.Implementation_Benchmark__c).Id;
            } 
            if (bmas.Improvement_Action_Step__c != null && iasOldIdNewRecMap.get(bmas.Improvement_Action_Step__c) != null) {
                newBmas.Improvement_Action_Step__c = iasOldIdNewRecMap.get(bmas.Improvement_Action_Step__c).Id;         
            }
            if(newBmas != null) {                   // don't create record if both Improvement Benchmark and IAS lookups are blank
                    newBenchMarList.add(newBmas);
                }
        }
        try {
            if (newBenchMarList.size() > 0) {
                insert newBenchMarList;
            }
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            database.rollback(sp);
            return;
        }
        }
        
        //clone Addendum__c
        
        // Removed per Support Request-00008655
/*        Set<Id> existingAddendaRTids = new Set<Id>();
        for (Addendum__c add : currentUIP.Addenda__r) {
            existingAddendaRTids.add(add.RecordTypeId);
        }
       
        //select only addendum from last year that exist this year too
*/        
        soql = SectionUtil.getFieldsQuery('Addendum__c');
        soql += ' FROM Addendum__c WHERE UIP__c = \'' + selectedUIP + '\'';
//        soql += ' AND RecordTypeId IN :existingAddendaRTids';
        List<Addendum__c> addendumList = Database.query(soql);
        Set<Id> existingLastYearAddendaRTids = new Set<Id>();
        Map<Id,Addendum__c> newAddendumMap = new Map<Id,Addendum__c>();
        Addendum__c newAddendum;
        for (Addendum__c add : addendumList) {
            existingLastYearAddendaRTids.add(add.RecordTypeId);
            newAddendum = new Addendum__c();
            newAddendum = add.clone(false, true);
            newAddendum.UIP__c = currentUIP.Id;
            if(inactiveUsers.contains(newAddendum.ownerId))
                newAddendum.ownerId=UserInfo.getUserId();
            newAddendum.District_UIP_for_Combined_Plans__c = null;
            newAddendumMap.put(add.Id, newAddendum);
        }
        
        //delete only addendum that exist last year       
        // Removed per Support Request-00008655
/*        List<Addendum__c> existingAddendumList = new List<Addendum__c>();
        for (Addendum__c add : currentUIP.Addenda__r) {
            if (existingLastYearAddendaRTids.contains(add.RecordTypeId)) {
                existingAddendumList.add(add);
            }
        }
        try {
            if (existingAddendumList.size() > 0) {
                delete existingAddendumList;
            }
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            database.rollback(sp);
            return;
        }
*/        
        //insert new addendum from last year
        
        try {
            if (!newAddendumMap.isEmpty()) {
                insert newAddendumMap.values();
            }
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            database.rollback(sp);
            return;
        }
        
        //clone Supporting Addendum
        
        List<Supporting_Addenda_Forms__c> supportingAddList = [SELECT Id, Name, Addendum__c, Crosswalk_of_Description_in_Action_Plan__c, Description_of_Proposed_Activity__c,
                                                               Title_IA_PPC_Proposed_Amount__c, Title_IIA_Proposed_Amount__c, Title_III_Proposed_Amount__c 
                                                               FROM Supporting_Addenda_Forms__c WHERE Addendum__c IN :newAddendumMap.keySet()];
        List<Supporting_Addenda_Forms__c> newSupAddendumList = new List<Supporting_Addenda_Forms__c>();
        Supporting_Addenda_Forms__c newSupAddendum;
        for (Supporting_Addenda_Forms__c sa : supportingAddList) {
            newSupAddendum = new Supporting_Addenda_Forms__c();
            newSupAddendum = sa.clone(false, true);
            newSupAddendum.Addendum__c = newAddendumMap.get(sa.Addendum__c).Id;
            newSupAddendumList.add(newSupAddendum);
        }
        try {
            if (newSupAddendumList.size() > 0 ) {
                insert newSupAddendumList;
            }
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            database.rollback(sp);
            return;
        }
        closeWindow = true;
    }
}