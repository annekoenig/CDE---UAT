public class UIPHomeController_New {
    
    public String getForwardTocustomStartPage() {
                return null;
        }

    public static final Integer MAX_UIP_ELEM = 9;
    private Map<Id, UIP_Element__c> allElemsMap;
    public String currentId { get ; set; }
    public UIP__c uip { get; set; }
    public List<Attachment> attachList { get; set; }
    public List<AttachmentWrapper> attachWrapperList { get; set; }
    public TableWrapper tableTimeline { get; set; }
    private String rtChallengeId { get; set; }
    private String rtMISId { get; set; }
    private String rtRCId { get; set; }
    public List<PPCMappingWrapper> ppcmWrapperList { get; set; }
    public boolean isCommunityUser { get; set; }
    public boolean isAdminUser { get; set; }
    public String baseURL { get; set; } 
    public boolean isSchoolUser { get; set; }
    public boolean isDistrictUser { get; set; }
    public boolean isSchoolAdmin { get; set; }
    public boolean isSuccessfullyMsg { get; set; }
    public boolean showProduceUIPmessage { get; set; }
    public String activeMenu { get; set; }
        
    public UIPHomeController_New() {
                showProduceUIPmessage = false;
                activeMenu = SectionUtil.setActiveMenu();
                isSuccessfullyMsg = false;
                isCommunityUser = SectionUtil.isCommunityUser();
                isAdminUser = SectionUtil.isAdminUser();
                currentId = SectionUtil.getUipId();
                System.debug('### uipId =' + currentId);
                uip = [SELECT Id, Name, Turnaround__c, TIG_Turnaround__c, TIG_Transformation__c, Section_1__c, Section_1_Percent_Complete__c, Student_Grad_Com_Plan_Progress_Status__c, RecordType.Name,
                                                Section_2__c, Section_2_Percent_Complete__c, Section_3__c, Section_3_Percent_Complete__c, Section_4__c, Section_4_Percent_Complete__c, Review_Required__c , Re_Review_Required__c,
                                                UIP_Annual_CDE_Plan__r.Optional_Review_Help_Text_TIG__c, UIP_Annual_CDE_Plan__r.AEC_SPF_Help_Text__c, UIP_Annual_CDE_Plan__r.Required_Review_Help_Text__c, UIP_Annual_CDE_Plan__r.Re_Review_Help_Text__c,
                                                UIP_Annual_CDE_Plan__r.AEC_SPF_Date__c, UIP_Annual_CDE_Plan__r.Re_review_Submission__c, UIP_Annual_CDE_Plan__r.Final_Submission_Help_Text__c,
                                                TIG_Restart__c, TIG_Closure__c, TIG_Transformation_Percent_Complete__c, TIG_Closure_Percent_Complete__c, Turnaround_Percent_Complete__c, 
                                                TIG_Restart_Percent_Complete__c, TIG_Turnaround_Percent_Complete__c, Title_1_School_Wide__c, Title_1_Percent_Complete__c,
                                                SCHOOL_NAME__r.Name, City__c, DISTRICT_NAME__r.Name, A_TTL_RATING_OFFICIAL__c, Optional_October_Review__c,
                                                UIP_Annual_CDE_Plan__c, UIP_Annual_CDE_Plan__r.April_Deadline__c, UIP_Annual_CDE_Plan__r.Blank_Template_Released__c, 
                                                UIP_Annual_CDE_Plan__r.January_Deadline__c, UIP_Annual_CDE_Plan__r.October_Deadline__c, UIP_Annual_CDE_Plan__r.UIP_Start_Date__c,
                                                UIP_Annual_CDE_Plan__r.Section_1_Data_Populated__c, UIP_Annual_CDE_Plan__r.Section_1_Update__c,
                                                UIP_Annual_CDE_Plan__r.Blank_Template_Status__c, UIP_Annual_CDE_Plan__r.Section_1_Data_Status__c, UIP_Annual_CDE_Plan__r.Section_1_Update_Status__c,
                                                Section_I_Progress_Status__c,Turnaround_Progress_Status__c, Section_II_Progress_Status__c, Section_III_Progress_Status__c, Section_IV_Progress_Status__c, 
                                                TIG_Transformation_Progress_Status__c, TIG_Turnaround_Progress_Status__c, TIG_Closure_Progress_Status__c, TIG_Restart_Progress_Status__c, Title_I_School_Wide_Progress_Status__c,
                                                TextAreaRich_Test__c, ESEA__c, ESEA_Progress_Status__c, Gifted_Education__c, Gifted_Education_Progress_Status__c, TIG_Closure_Complete__c, TIG_Transformation_Complete__c, Turnaround_Complete__c, ESEA_Complete__c, Gifted_Education_Complete__c, Title_I_School_Wide_Complete__c, Title_III_Complete__c, TIG_Turnaround_Complete__c, Student_Grad_Completion_Plan__c, Student_Grad_Completion_Plan_Complete__c,Title_III__c, Title_III_Progress_Status__c,
                                                PLAN_TIMELINE_OCT__c,PLAN_TIMELINE_JAN__c,April_Timeline__c,December_Timeline__c,DIST_NUMBER__c, SCHOOL_NUMBER__c, Section_IV_Action_Planning_Complete__c, Section_IV_Target_Setting_Complete__c FROM UIP__c WHERE Id = :currentId];
                SelectAttachements();
                populatePPCTable();
                tableTimeline = populateTableWrapper();
                System.debug('tableTimeline:::' + tableTimeline);
                baseURL = String.ValueOf(URL.getSalesforceBaseUrl());
                System.debug('baseURL:::' + baseURL);
                String currentProfileId = UserInfo.getProfileId();
                List<Profile> allProfiles = [SELECT Id, Name FROM Profile];
                for (Profile p : allProfiles) {
                        if (p.Name == 'School User' && p.Id == currentProfileId) {
                                isSchoolUser = true;
                        }
                        if (p.Name == 'District User' && p.Id == currentProfileId) {
                                isDistrictUser = true;
                        }
                        if (p.Name == 'School Admin' && p.Id == currentProfileId) {
                                isSchoolAdmin = true;
                        }                        
                }
        }
        
        public UIPHomeController_New(ApexPages.StandardController stdController) {          
                
                showProduceUIPmessage = false;
                activeMenu = SectionUtil.setActiveMenu();
                isSuccessfullyMsg = false;
                isCommunityUser = SectionUtil.isCommunityUser();
                isAdminUser = SectionUtil.isAdminUser();
                currentId = SectionUtil.getUipId();
                System.debug('### uipId =' + currentId);
                uip = [SELECT Id, Name, Turnaround__c, TIG_Turnaround__c, TIG_Transformation__c, Section_1__c, Section_1_Percent_Complete__c, Student_Grad_Com_Plan_Progress_Status__c, RecordType.Name,
                                                Section_2__c, Section_2_Percent_Complete__c, Section_3__c, Section_3_Percent_Complete__c, Section_4__c, Section_4_Percent_Complete__c, Review_Required__c , Re_Review_Required__c,
                                                UIP_Annual_CDE_Plan__r.Optional_Review_Help_Text_TIG__c, UIP_Annual_CDE_Plan__r.AEC_SPF_Help_Text__c, UIP_Annual_CDE_Plan__r.Required_Review_Help_Text__c, UIP_Annual_CDE_Plan__r.Re_Review_Help_Text__c,
                                                UIP_Annual_CDE_Plan__r.AEC_SPF_Date__c, UIP_Annual_CDE_Plan__r.Re_review_Submission__c, UIP_Annual_CDE_Plan__r.Final_Submission_Help_Text__c,
                                                TIG_Restart__c, TIG_Closure__c, TIG_Transformation_Percent_Complete__c, TIG_Closure_Percent_Complete__c, Turnaround_Percent_Complete__c, 
                                                TIG_Restart_Percent_Complete__c, TIG_Turnaround_Percent_Complete__c, Title_1_School_Wide__c, Title_1_Percent_Complete__c,
                                                SCHOOL_NAME__r.Name, City__c, DISTRICT_NAME__r.Name, A_TTL_RATING_OFFICIAL__c, Optional_October_Review__c,
                                                UIP_Annual_CDE_Plan__c, UIP_Annual_CDE_Plan__r.April_Deadline__c, UIP_Annual_CDE_Plan__r.Blank_Template_Released__c, 
                                                UIP_Annual_CDE_Plan__r.January_Deadline__c, UIP_Annual_CDE_Plan__r.October_Deadline__c, UIP_Annual_CDE_Plan__r.UIP_Start_Date__c,
                                                UIP_Annual_CDE_Plan__r.Section_1_Data_Populated__c, UIP_Annual_CDE_Plan__r.Section_1_Update__c,Public_Facing__c,
                                                UIP_Annual_CDE_Plan__r.Blank_Template_Status__c, UIP_Annual_CDE_Plan__r.Section_1_Data_Status__c, UIP_Annual_CDE_Plan__r.Section_1_Update_Status__c,
                                                Section_I_Progress_Status__c,Turnaround_Progress_Status__c, Section_II_Progress_Status__c, Section_III_Progress_Status__c, Section_IV_Progress_Status__c, 
                                                TIG_Transformation_Progress_Status__c, TIG_Turnaround_Progress_Status__c, TIG_Closure_Progress_Status__c, TIG_Restart_Progress_Status__c, Title_I_School_Wide_Progress_Status__c,
                                                TextAreaRich_Test__c, ESEA__c, ESEA_Progress_Status__c, Gifted_Education__c, Gifted_Education_Progress_Status__c, TIG_Closure_Complete__c, TIG_Transformation_Complete__c, Turnaround_Complete__c, ESEA_Complete__c, Gifted_Education_Complete__c, Title_I_School_Wide_Complete__c, Title_III_Complete__c, TIG_Turnaround_Complete__c, Student_Grad_Completion_Plan__c, Student_Grad_Completion_Plan_Complete__c,Title_III__c, Title_III_Progress_Status__c,
                                                PLAN_TIMELINE_OCT__c,PLAN_TIMELINE_JAN__c,April_Timeline__c,December_Timeline__c, DIST_NUMBER__c,SCHOOL_NUMBER__c, Section_IV_Action_Planning_Complete__c, Section_IV_Target_Setting_Complete__c FROM UIP__c WHERE Id = :currentId];
                SelectAttachements();
                populatePPCTable();
                tableTimeline = populateTableWrapper();
                System.debug('tableTimeline:::' + tableTimeline);
                baseURL = String.ValueOf(URL.getSalesforceBaseUrl());
                System.debug('baseURL:::' + baseURL);
                String currentProfileId = UserInfo.getProfileId();
                List<Profile> allProfiles = [SELECT Id, Name FROM Profile];
                for (Profile p : allProfiles) {
                        if (p.Name == 'School User' && p.Id == currentProfileId) {
                                isSchoolUser = true;
                        }
                        if (p.Name == 'District User' && p.Id == currentProfileId) {
                                isDistrictUser = true;
                        }
                        if (p.Name == 'School Admin' && p.Id == currentProfileId) {
                                isSchoolAdmin = true;
                        } 
                }
        }
        
        public void SelectAttachements() {
                attachList = [SELECT Id, Name, CreatedDate, ContentType, IsPrivate FROM Attachment WHERE ParentId = :uip.Id order by CreatedDate];
                AttachmentWrapper attW;
                attachWrapperList = new List<AttachmentWrapper>();
                for (Attachment a : attachList) {
                        attW = new AttachmentWrapper(a);
                        attachWrapperList.add(attW);
                }
                System.debug('attachList:::' + attachList);
        }
        
        public void getElemRTIds() {
                rtChallengeId = Schema.SObjectType.UIP_Element__c.getRecordTypeInfosByName().get('Challenge').getRecordTypeId();
                rtMISId = Schema.SObjectType.UIP_Element__c.getRecordTypeInfosByName().get('Major Improvement Strategy').getRecordTypeId();
                rtRCId = Schema.SObjectType.UIP_Element__c.getRecordTypeInfosByName().get('Root Cause').getRecordTypeId();
        }
        
        public void populatePPCTable() {
                String soql = SectionUtil.getFieldsQuery('UIP_Element__c');
                soql += ' FROM UIP_Element__c WHERE UIP__c = \'' + currentId + '\'';
                List<UIP_Element__c> elemsList = Database.query(soql);
                getElemRTIds();
              
                //get Priority Performance Challenges
                Map<Id,UIP_Element__c> ppcMap = new Map<Id,UIP_Element__c>();
                Map<Id,List<String>> rcMap = new Map<Id,List<String>>();
                Map<Id,List<String>> misMap = new Map<Id,List<String>>();
                allElemsMap = new Map<Id, UIP_Element__c>();
                for (UIP_Element__c elem : elemsList) {
                        allElemsMap.put(elem.Id, elem);
                        if (elem.RecordTypeId == rtChallengeId) {
                                ppcMap.put(elem.Id, elem);
                                rcMap.put(elem.Id, new List<String>());
                                misMap.put(elem.Id, new List<String>());
                        }
                }
                System.debug('allElemsMap:::' + allElemsMap.keySet());
                
                //get Root Cause & MIS
                Set<Id> rcIds;
                Set<Id> misIds;
                for (Id ppcId : ppcMap.KeySet()) {
                        rcIds = new Set<Id>();
                        misIds = new Set<Id>();
                        for(Integer i = 1; i <= MAX_UIP_ELEM; i++) {
                                if ((Id)ppcMap.get(ppcId).get('Root_Cause_' + i + '__c') != null) {
                                        if (!rcIds.contains((Id)ppcMap.get(ppcId).get('Root_Cause_' + i + '__c'))) {
                                                System.debug('RC-id::' + (Id)ppcMap.get(ppcId).get('Root_Cause_' + i + '__c') +'!= null');
                                                System.debug('RC-id!::' + ((Id)ppcMap.get(ppcId).get('Root_Cause_' + i + '__c') != null));
                                                rcIds.add((Id)ppcMap.get(ppcId).get('Root_Cause_' + i + '__c'));
                                                system.debug('###rcMap###'+rcMap);
                                                system.debug('###rcMap.get(ppcId)###'+rcMap.get(ppcId));
                                                rcMap.get(ppcId).add(allElemsMap.get((Id)ppcMap.get(ppcId).get('Root_Cause_' + i + '__c')).Name);
                                                for(Integer j = 1; j <= MAX_UIP_ELEM; j++) {
                                                        System.debug('i:::' + i + '| j:::' + j);
                                                        System.debug('RCID:::' + (Id)ppcMap.get(ppcId).get('Root_Cause_' + i + '__c'));
                                                        System.debug('RCELEM:::' + allElemsMap.get((Id)ppcMap.get(ppcId).get('Root_Cause_' + i + '__c')));
                                                        System.debug('RC-MIS:::' + allElemsMap.get((Id)ppcMap.get(ppcId).get('Root_Cause_' + i + '__c')).get('Major_Improvement_Strategy_' + j + '__c'));
                                                        if ((Id)allElemsMap.get((Id)ppcMap.get(ppcId).get('Root_Cause_' + i + '__c')).get('Major_Improvement_Strategy_' + j + '__c') != null) {
                                                                if (!misIds.contains((Id)allElemsMap.get((Id)ppcMap.get(ppcId).get('Root_Cause_' + i + '__c')).get('Major_Improvement_Strategy_' + j + '__c'))) {
                                                                        misIds.add((Id)allElemsMap.get((Id)ppcMap.get(ppcId).get('Root_Cause_' + i + '__c')).get('Major_Improvement_Strategy_' + j + '__c'));
                                                                        misMap.get(ppcId).add(allElemsMap.get((Id)allElemsMap.get((Id)ppcMap.get(ppcId).get('Root_Cause_' + i + '__c')).get('Major_Improvement_Strategy_' + j + '__c')).Name);
                                                                }
                                                        }
                                                }
                                        }
                                }
                                if ((Id)ppcMap.get(ppcId).get('Major_Improvement_Strategy_' + i + '__c') != null) {
                                        if (!misIds.contains((Id)ppcMap.get(ppcId).get('Major_Improvement_Strategy_' + i + '__c'))) {
                                                misIds.add((Id)ppcMap.get(ppcId).get('Major_Improvement_Strategy_' + i + '__c'));
                                                misMap.get(ppcId).add(allElemsMap.get((Id)ppcMap.get(ppcId).get('Major_Improvement_Strategy_' + i + '__c')).Name);
                                        }
                                }
                        }
                }
                system.debug('misIds:::1' + misIds);
                system.debug('misMap:::1' + misMap);
                
                //populate Priority Performance Challenge Mapping Wrapper
                ppcmWrapperList = new List<PPCMappingWrapper>();
                PPCMappingWrapper ppcm;
                for (Id key : ppcMap.keySet()) {
                        ppcm = new PPCMappingWrapper();
                        ppcm.ppc = ppcMap.get(Key).Name;
                        ppcm.rcList = rcMap.get(key);
                        ppcm.misList = misMap.get(key);
                        ppcmWrapperList.add(ppcm);
                }
                
                //if there are not 5 PPC the table should show 5 rows even blanks
                System.debug('ppcmWrapperList.size():::' + ppcmWrapperList.size());
                System.debug('ppcmWrapperList:::' + ppcmWrapperList);
                Integer listSize = ppcmWrapperList.size();
                if (ppcmWrapperList.size() < 5) {
                        for (Integer i = 0 ; i < (5 - listSize); i++) {
                                ppcm = new PPCMappingWrapper();
                                ppcm.ppc = '';
                                ppcm.rcList = new List<String>();
                                ppcm.misList = new List<String>();
                                ppcmWrapperList.add(ppcm);
                                system.debug('i:::' + i);
                        }
                }
                System.debug('ppcmWrapperList.size():::' + ppcmWrapperList.size());
                System.debug('ppcmWrapperList:::' + ppcmWrapperList);
        }
        
        @testvisible
        private Integer calculatePrecentCurrentDate(Date d, Date startDate, Date endDate) {
                Integer percent = 0;
                //startDate = date.newinstance(2014, 6, 15);
                //Date endDate = date.newinstance(2015, 4, 15);
                //Date startDate = uip.UIP_Annual_CDE_Plan__r.Blank_Template_Released__c;
                //Date endDate = uip.UIP_Annual_CDE_Plan__r.April_Deadline__c;
                if (startDate != null && endDate != null && d != null) {
                        Double numberDaysDue = startDate.daysBetween(endDate);
                        System.debug('numberDaysDue:::' + numberDaysDue);
                        System.debug('numberDaysDue2:::' + startDate.daysBetween(d));
                        percent =(Integer) ((startDate.daysBetween(d) / numberDaysDue) * 100).round();
                        System.debug('percent:::' + percent);
                }
                return percent;
        }
        
        private TableWrapper populateTableWrapper() {
                TableWrapper tableTimeline = new TableWrapper();
                /*Date d1 = date.newinstance(2014, 9, 1);
                Date d2 = date.newinstance(2014, 12, 15);
                Date d3 = date.newinstance(2015, 1, 15);
                Date d4 = date.newinstance(2015, 2, 15);*/
                Date[] d = new Date[9];
                // d[0] = date.newinstance(2014, 6, 15); //start date
                 d[0] = uip.UIP_Annual_CDE_Plan__r.UIP_Start_Date__c;
                 d[1] = uip.UIP_Annual_CDE_Plan__r.Blank_Template_Released__c;
                 d[2] = uip.UIP_Annual_CDE_Plan__r.Section_1_Data_Populated__c;
                 d[3] = (uip.Optional_October_Review__c ? uip.UIP_Annual_CDE_Plan__r.October_Deadline__c : null);
                 d[4] = (uip.RecordType.Name == 'District UIP' || uip.RecordType.Name == 'School UIP' || uip.RecordType.Name == 'District UIP 2015' || uip.RecordType.Name == 'School UIP 2015' || uip.RecordType.Name == 'District UIP 2016' || uip.RecordType.Name == 'School UIP 2016' || uip.RecordType.Name == 'District UIP 2017' || uip.RecordType.Name == 'School UIP 2017'? uip.UIP_Annual_CDE_Plan__r.Section_1_Update__c : null);
                 d[5] = (uip.RecordType.Name == 'AEC UIP' || uip.RecordType.Name == 'AEC UIP 2015' || uip.RecordType.Name == 'AEC UIP 2016' || uip.RecordType.Name == 'AEC UIP 2017'? uip.UIP_Annual_CDE_Plan__r.AEC_SPF_Date__c : null);
                 d[6] = (uip.Review_Required__c ? uip.UIP_Annual_CDE_Plan__r.January_Deadline__c : null);
                 d[7] = (uip.Re_Review_Required__c ? uip.UIP_Annual_CDE_Plan__r.Re_review_Submission__c : null);
                 d[8] = uip.UIP_Annual_CDE_Plan__r.April_Deadline__c;
                //Date d9 = date.newinstance(2015, 2, 15);
                /*Integer firstPercent = calculatePrecentCurrentDate(d1, d0, d8);
                Integer secondPercent = calculatePrecentCurrentDate(d2, d0, d8);
                Integer thirdPercent = calculatePrecentCurrentDate(d3, d0, d8);
                Integer fourthPercent = calculatePrecentCurrentDate(d4, d0, d8);
                Integer fifthPercent = calculatePrecentCurrentDate(d5, d0, d8);
                Integer sixthPercent = calculatePrecentCurrentDate(d6, d0, d8);
                Integer seventhPercent = calculatePrecentCurrentDate(d7, d0, d8);
                Integer eightPercent = calculatePrecentCurrentDate(d8, d0, d8);*/
                List<Integer> percentList = new List<Integer>();
                for (Integer i = 1; i <= 8; i++) {
                        percentList.add(calculatePrecentCurrentDate(d[i], d[0], d[8]));
                }
                System.debug('percentList:::' + percentList);
                Integer [] size = new Integer[9];
                size[0] = percentList[0];
                Integer nextPos = 1;
                Integer val = percentList[0];
                for (Integer i = 1; i <= 7; i++) {
                        size[i] = 0;
                        if (percentList[i] > 0) {
                                size[nextPos] = percentList[i] - val;
                                nextPos = i+1;
                                val = percentList[i];
                        } 
                }
                size[8] = 0;
                System.debug('size:::' + size);
                /*System.debug('firstPercent:::' + firstPercent);
                System.debug('secondPercent:::' + secondPercent);
                System.debug('thirdPercent:::' + thirdPercent);
                System.debug('fourthPercent:::' + fourthPercent);
                System.debug('fifthPercent:::' + fifthPercent);
                System.debug('sixthPercent:::' + sixthPercent);
                System.debug('seventhPercent:::' + seventhPercent);
                System.debug('eightPercent:::' + eightPercent);*/
                tableTimeline.zeroColWidth = size[0];
                tableTimeline.firstColWidth = size[1];
                tableTimeline.secondColWidth = size[2];
                tableTimeline.thirdColWidth = size[3];
                tableTimeline.fourthColWidth = size[4];
                tableTimeline.fifthColWidth = size[5];
                tableTimeline.sixthColWidth = size[6];
                tableTimeline.seventhColWidth = size[7];
                tableTimeline.eightColWidth = size[8];
                /*System.debug('tableTimeline.firstColWidth:::' + tableTimeline.firstColWidth);
                System.debug('tableTimeline.secondColWidth:::' + tableTimeline.secondColWidth);
                System.debug('tableTimeline.thirdColWidth:::' + tableTimeline.thirdColWidth);
                System.debug('tableTimeline.fourthColWidth:::' + tableTimeline.fourthColWidth);
                System.debug('tableTimeline.fifthColWidth:::' + tableTimeline.fifthColWidth);
                System.debug('tableTimeline.sixthColWidth:::' + tableTimeline.sixthColWidth);
                System.debug('tableTimeline.seventhColWidth:::' + tableTimeline.seventhColWidth);
                System.debug('tableTimeline.eightColWidth:::' + tableTimeline.eightColWidth);*/
                //Integer currentPercent = calculatePrecentCurrentDate(date.today().addDays(155), d1, d8);
                Integer currentPercent = calculatePrecentCurrentDate(date.today(), d[0], d[8]);
                System.debug('currentPercent:::' + currentPercent);
                if (currentPercent < 0) {
                        tableTimeline.currentDatePercent = 0;
                } else {
                        tableTimeline.currentDatePercent = currentPercent;
                }
                return tableTimeline;
        }
        
        public class TableWrapper {
                public Integer zeroColWidth { get; set; }
                public Integer firstColWidth { get; set; }
                public Integer firstColChecked { get; set; }
                public Integer secondColWidth { get; set; }
                public Integer secondColChecked { get; set; }
                public Integer thirdColWidth { get; set; }
                public Integer thirdColChecked { get; set; }
                public Integer fourthColWidth { get; set; }
                public Integer fourthColChecked { get; set; }
                public Integer fifthColWidth { get; set; }
                public Integer fifthColChecked { get; set; }
                public Integer sixthColWidth { get; set; }
                public Integer sixthColChecked { get; set; }
                public Integer seventhColWidth { get; set; }
                public Integer seventhColChecked { get; set; }
                public Integer eightColWidth { get; set; }
                public Integer eightColChecked { get; set; }
                public Integer currentDatePercent { get; set; }
        }
        
        public class PPCMappingWrapper {
                public String ppc { get; set; }
                public List<String> rcList { get; set; }
                public List<String> misList { get; set; }
        }
        
        public void SaveTest() {
                update uip;
        }
        
        /* public void produceUIPDoc() {
                showProduceUIPmessage = true;
                //uip.Conga_School_Template_Flag__c = true;
                if (uip.RecordType.Name == 'School UIP' || uip.RecordType.Name == 'School UIP 2015') {
                        uip.School_UIP__c = true;
                } else if (uip.RecordType.Name == 'District UIP' || uip.RecordType.Name == 'District UIP 2015') {
                        uip.Conga_District_UIP__c = true;
                } else if (uip.RecordType.Name == 'AEC UIP' || uip.RecordType.Name == 'AEC UIP 2015') {
                        uip.Conga_AEC_UIP__c = true;
                }
                system.debug('uip:::' + uip);
                try {
                        update uip;
                        system.debug('uip:::after' + uip);
                } catch (DMLException e) {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
                        return;
                }
        }*/
        
        public PageReference produceUIPDoc() {
                showProduceUIPmessage = true;
                PageReference pr;
                //uip.Conga_School_Template_Flag__c = true;
                if (uip.RecordType.Name == 'School UIP' || uip.RecordType.Name == 'School UIP 2015' || uip.RecordType.Name == 'School UIP 2016' || uip.RecordType.Name == 'School UIP 2017') {
                        uip.School_UIP__c = true;
                } else if (uip.RecordType.Name == 'District UIP' || uip.RecordType.Name == 'District UIP 2015' || uip.RecordType.Name == 'District UIP 2016' || uip.RecordType.Name == 'District UIP 2017') {
                        uip.Conga_District_UIP__c = true;
                } else if (uip.RecordType.Name == 'AEC UIP' || uip.RecordType.Name == 'AEC UIP 2015' || uip.RecordType.Name == 'AEC UIP 2016' || uip.RecordType.Name == 'AEC UIP 2017') {
                        uip.Conga_AEC_UIP__c = true;
                }
                system.debug('uip:::' + uip);
                try {
                        update uip;
                        pr=new PageReference('/apex/PublicUIP?id='+uip.id);
                        system.debug('uip:::after' + uip);
                } catch (DMLException e) {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
                        return null;
                }
                return pr;
        }
        
        public PageReference executiveSummary() {
                PageReference pr;
                try {
                        pr=new PageReference('/apex/ExecutiveSummary?id='+uip.id);                        
                } catch (DMLException e) {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
                        return null;
                }
                return pr;
        }
        
        public Integer getVersion(String name) {
                integer index = name.indexOf(' ~V');
                if (index < 0) {
                        return 0;
                }
                Integer oldVersion = Integer.valueOf(name.substring(index + 3));
                return oldVersion;
        }
        
        public Integer newVersion(String name) {
                String name2 = name + '%';
                String soql = 'SELECT Id, Name FROM UIP__c WHERE Name like :name2';
                //List<UIP__c> uipContactList = [SELECT Id, Name FROM UIP__c WHERE Name like :name];
                List<UIP__c> uipContactList = database.query(soql);
                Integer version = 0;
                Integer maxVersion = 0;
                for (UIP__c c : uipContactList) {
                        version = getVersion(c.Name);
                        if (maxVersion < version) {
                                maxVersion = version;
                        }
                        System.debug('maxVersion::::' + maxVersion);
                }
                maxVersion ++;
                System.debug('maxVersion2::::' + maxVersion);
                /*integer index = name.indexOf(' ~V');
                if (index < 0) {
                        return name + ' ~V1';
                }
                String oldName = name.substring(0, index - 1);
                Integer oldVersion = Integer.valueOf(name.substring(index + 3));
                oldVersion ++;
                String newVersion = oldName + ' ~V' + oldVersion;*/
                return maxVersion;
        }
        
        public String getNameWithoutVersion(String name) {
                integer index = name.indexOf(' ~V');
                if (index < 0) {
                        return name;
                }
                String oldName = name.substring(0, index - 1);
                return oldName;
        }
        
        public void deleteExistingFinalVersion() {
                String soql = 'SELECT Id, Name FROM UIP__c WHERE Name like \'' + uip.Name + ' ~Final ' + '%\'';
                List<UIP__c> uipContactList = database.query(soql);
                if (uipContactList.size() > 0) {
                        try {
                                List<UIP_Contact__c> contList = [SELECT Id FROM UIP_Contact__c WHERE UIP__c IN :uipContactList];
                                delete contList;
                                List<UIP_Element__c> uipElemList = [SELECT Id FROM UIP_Element__c WHERE UIP__c IN :uipContactList];
                                delete uipElemList;
                                List<Performance_Indicator_Notable_Trends__c> pintList = [SELECT Id FROM Performance_Indicator_Notable_Trends__c WHERE UIP__c IN :uipContactList];
                                delete pintList;
                                List<Performance_Indicator_Targets__c> piList = [SELECT Id FROM Performance_Indicator_Targets__c WHERE UIP__c IN :uipContactList];
                                delete piList;
                                List<Improvement_Action_Step__c> iasList = [SELECT Id FROM Improvement_Action_Step__c WHERE UIP__c IN :uipContactList];
                                delete iasList;
                                delete uipContactList;
                        } catch (DMLException e) {
                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
                                return;
                        }
                }
        }
        
        public void submitRecord(String type) {
                System.debug('type '+type);
                Integer newVersion = newVersion(uip.Name);
                System.debug('newVersion '+newVersion);
                System.debug('uip.Name '+uip.Name);
                if (uip.RecordType.Name == 'School UIP' || uip.RecordType.Name == 'School UIP 2015' || uip.RecordType.Name == 'School UIP 2016' || uip.RecordType.Name == 'School UIP 2017') {
                        uip.School_UIP__c = true;
                } else if (uip.RecordType.Name == 'District UIP' || uip.RecordType.Name == 'District UIP 2015' || uip.RecordType.Name == 'District UIP 2016' || uip.RecordType.Name == 'District UIP 2017') {
                        uip.Conga_District_UIP__c = true;
                } else if (uip.RecordType.Name == 'AEC UIP' || uip.RecordType.Name == 'AEC UIP 2015' || uip.RecordType.Name == 'AEC UIP 2016' || uip.RecordType.Name == 'AEC UIP 2017') {
                        uip.Conga_AEC_UIP__c = true;
                } 
                if (type == 'Version') {
                        if (newVersion < 2) {
                                uip.UIP_Status__c = 'Submitted for Review';
                                System.debug('uip.UIP_Status__c '+uip.UIP_Status__c);
                        } else {
                                uip.UIP_Status__c = 'Submitted for Re-Review';
                                System.debug('uip.UIP_Status__c '+uip.UIP_Status__c);
                        }
                        try {
                                update uip;
                                System.debug('uip '+uip);
                        } catch (DMLException e) {
                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
                                return;
                        }
                }
                
                // Create PDF
                System.debug('In downloadUIPPublicFacing_NewPDF ');
                System.debug('uip.Id '+uip.Id);
                UIP__c name = [Select Name from UIP__c where Id = :uip.Id];
                String zpifname = name.Name;
                ZPIF_UIP__c zpifId = [Select Id from ZPIF_UIP__c where Name = :zpifname];
                PageReference pdf = Page.UIPPublicFacing_New;
                System.debug('pdf '+pdf);
                pdf.getParameters().put('id',zpifId.Id);
                pdf.setRedirect(true);
                Blob body;
                try{
                    body = pdf.getContent();
                } catch (VisualforceException e) {
                    body = Blob.valueOf('Some Text');
                }
                System.debug('body '+body);
                Attachment attach = new Attachment();
                attach.Name = 'ZPIF.pdf';
                attach.Body = body;
                attach.IsPrivate = false;
                attach.ParentId = uip.Id;
                attach.ContentType = 'application/pdf';
                System.debug('attach '+attach);
                insert attach;        
                
                /*
                //clone UIP__c
                String soqlUIP = SectionUtil.getFieldsQuery('UIP__c');
                soqlUIP += ' FROM UIP__c WHERE Id = \'' + uip.Id + '\'';
                List<UIP__c> oldUipList = Database.query(soqlUIP);
                UIP__c newUip; // = uip.clone(false, true);
                if (oldUipList.size() == 1) {
                        newUip = oldUipList[0].clone(false, true);
                }
                newUip.Is_Version__c = true;
                if (type == 'Version') {
                        newUIP.Name = uip.Name + ' ~V' + newVersion;
                } else {
                        deleteExistingFinalVersion();
                        newUIP.Name = uip.Name + ' ~Final ' + datetime.now();
                }
                try {
                        insert newUip;
                } catch (DMLException e) {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
                        return;
                }
                                
                //clone Contact
                String soql = SectionUtil.getFieldsQuery('UIP_Contact__c');
                soql += ' FROM UIP_Contact__c WHERE UIP__c = \'' + uip.Id + '\'';
                List<UIP_Contact__c> uipContactList = Database.query(soql);
                
                List<UIP_Contact__c> newUipContactList = new List<UIP_Contact__c>();
                UIP_Contact__c newUipContact;
                for (UIP_Contact__c c : uipContactList) {
                        newUipContact = new UIP_Contact__c();
                        newUipContact = c.clone(false, true);
                        newUipContact.UIP__c = newUip.Id;
                        newUipContactList.add(newUipContact);
                }
                System.debug('newUipContactList:::' + newUipContactList);
                
                try {
                        if (newUipContactList.size() > 0) {
                                insert newUipContactList;
                        }
                } catch (DMLException e) {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
                        return;
                }
                
                //clone UIP_Element__c
                //List<UIP_Element__c> uipElemList = [SELECT Id, Name FROM UIP_Element__c WHERE UIP__c = :uip.Id];
                soql = SectionUtil.getFieldsQuery('UIP_Element__c');
                soql += ' FROM UIP_Element__c WHERE UIP__c = \'' + uip.Id + '\'';
                List<UIP_Element__c> uipElemList = Database.query(soql);
                system.debug('uipElemList:::' + uipElemList.size());
                List<UIP_Element__c> newElemList = new List<UIP_Element__c>();
                Map<Id,UIP_Element__c> newElemMap = new Map<Id,UIP_Element__c>();
                UIP_Element__c newUipElem;
                for (UIP_Element__c e : uipElemList) {
                        newUipElem = new UIP_Element__c();
                        newUipElem = e.clone(false, true);
                        newUipElem.UIP__c = newUip.Id;
                        //if (type == 'Version') {
                        //      newUipElem.Name = e.Name + ' ~V' + newVersion;
                        //} else {
                        //      newUipElem.Name = e.Name + ' Final ' + datetime.now();
                        //}
                        newElemList.add(newUipElem);
                        newElemMap.put(e.Id, newUipElem);
                }
                try {
                        if (newElemList.size() > 0) {
                                insert newElemMap.values();
                        }
                } catch (DMLException e) {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
                        return;
                }
                
                System.debug('newElemMap::::' + newElemMap);
                for (Id key : newElemMap.keySet()) {
                        for (integer i = 1; i <= MAX_UIP_ELEM; i++) {
                                if ((Id)newElemMap.get(key).get('Challenge_' + i + '__c') != null) {
                                        newElemMap.get(key).put('Challenge_' + i + '__c', newElemMap.get((Id)newElemMap.get(key).get('Challenge_' + i + '__c')).Id);
                                }
                                if ((Id)newElemMap.get(key).get('Major_Improvement_Strategy_' + i + '__c') != null) {
                                        newElemMap.get(key).put('Major_Improvement_Strategy_' + i + '__c', newElemMap.get((Id)newElemMap.get(key).get('Major_Improvement_Strategy_' + i + '__c')).Id);
                                }
                                if ((Id)newElemMap.get(key).get('Root_Cause_' + i + '__c') != null) {
                                        newElemMap.get(key).put('Root_Cause_' + i + '__c', newElemMap.get((Id)newElemMap.get(key).get('Root_Cause_' + i + '__c')).Id);
                                }
                                //newElemMap.get(key).Major_Improvement_Strategy_1__c = newElemMap.get(newElemMap.get(key).Major_Improvement_Strategy_1__c).Id;
                                //newElemMap.get(key).Root_Cause_1__c = newElemMap.get(newElemMap.get(key).Root_Cause_1__c).Id;
                        }
                }
                try {
                        update newElemMap.values();
                } catch (DMLException e) {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
                        return;
                }
                                
                //clone Performance_Indicator_Targets__c
                soql = SectionUtil.getFieldsQuery('Performance_Indicator_Targets__c');
                soql += ' FROM Performance_Indicator_Targets__c WHERE UIP__c = \'' + uip.Id + '\'';
                List<Performance_Indicator_Targets__c> piList = Database.query(soql);
                
                List<Performance_Indicator_Targets__c> newPitList = new List<Performance_Indicator_Targets__c>();
                Performance_Indicator_Targets__c newPi;
                for (Performance_Indicator_Targets__c pi : piList) {
                        newPi = new Performance_Indicator_Targets__c();
                        newPi = pi.clone(false, true);
                        newPi.UIP__c = newUip.Id;
                        //newPi.Name = pi.Name + ' ~V' + newVersion;
                        if (pi.Major_Improvement_Strategy_1__c != null) {
                                newPi.Major_Improvement_Strategy_1__c = newElemMap.get(pi.Major_Improvement_Strategy_1__c).Id;
                        }
                        if (pi.Priority_Performance_Challenge_1__c != null) {
                                newPi.Priority_Performance_Challenge_1__c = newElemMap.get(pi.Priority_Performance_Challenge_1__c).Id;
                        }
                        newPitList.add(newPi);
                }
                
                try {
                        if (newPitList.size() > 0) {
                                insert newPitList;
                        }
                } catch (DMLException e) {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
                        return;
                }
                
                //clone Performance_Indicator_Notable_Trends__c
                soql = SectionUtil.getFieldsQuery('Performance_Indicator_Notable_Trends__c');
                soql += ' FROM Performance_Indicator_Notable_Trends__c WHERE UIP__c = \'' + uip.Id + '\'';
                List<Performance_Indicator_Notable_Trends__c> pintList = Database.query(soql);
                
                List<Performance_Indicator_Notable_Trends__c> newPintList = new List<Performance_Indicator_Notable_Trends__c>();
                Performance_Indicator_Notable_Trends__c newPint;
                for (Performance_Indicator_Notable_Trends__c pint : pintList) {
                        newPint = new Performance_Indicator_Notable_Trends__c();
                        newPint = pint.clone(false, true);
                        newPint.UIP__c = newUip.Id;
                        //newPint.Name = pint.Name + ' ~V' + newVersion;
                        if (pint.Root_Cause_1__c != null) {
                                newPint.Root_Cause_1__c = newElemMap.get(pint.Root_Cause_1__c).Id;
                        }
                        if (pint.Priority_Performance_Challenge_1__c != null) {
                                newPint.Priority_Performance_Challenge_1__c = newElemMap.get(pint.Priority_Performance_Challenge_1__c).Id;
                        }
                        newPintList.add(newPint);
                }
                
                try {
                        if (newPintList.size() > 0) {
                                insert newPintList;
                        }
                } catch (DMLException e) {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
                        return;
                }
                
                //clone Improvement_Action_Step__c
                soql = SectionUtil.getFieldsQuery('Improvement_Action_Step__c');
                soql += ' FROM Improvement_Action_Step__c WHERE UIP__c = \'' + uip.Id + '\'';
                List<Improvement_Action_Step__c> iasList = Database.query(soql);
                
                List<Improvement_Action_Step__c> newIasList = new List<Improvement_Action_Step__c>();
                Improvement_Action_Step__c newIas;
                for (Improvement_Action_Step__c ias : iasList) {
                        newIas = new Improvement_Action_Step__c();
                        newIas = ias.clone(false, true);
                        newIas.UIP__c = newUip.Id;
                        //if (type == 'Version') {
                        //      newIas.Name = ias.Name + ' ~V' + newVersion;
                        //} else {
                        //      newIas.Name = ias.Name + ' Final ' + datetime.now();
                        //}
                        for (Integer i=1; i <= 5; i++) {
                                if ((Id)ias.get('Root_Cause_' + i +'__c') != null) {
                                        newIas.put('Root_Cause_' + i + '__c', newElemMap.get((Id)ias.get('Root_Cause_' + i + '__c')).Id);
                                }
                        }
                        if (ias.Major_Improvement_Strategy__c != null) {
                                if(newElemMap.get(ias.Major_Improvement_Strategy__c) != null && newElemMap.get(ias.Major_Improvement_Strategy__c).Id != null)
                                newIas.Major_Improvement_Strategy__c = newElemMap.get(ias.Major_Improvement_Strategy__c).Id;
                        }
                        newIasList.add(newIas);
                }
                
                try {
                        if (newIasList.size() > 0) {
                                insert newIasList;
                        }
                } catch (DMLException e) {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
                        return;
                }
                
                //clone Addendum__c
                //addendum are created by trigger and I have to delete the new ones and to put the existing ones
                soql = SectionUtil.getFieldsQuery('Addendum__c');
                soql += ' FROM Addendum__c WHERE UIP__c = \'' + newUip.Id + '\''; 
                List<Addendum__c> existingAddendumList = Database.query(soql);
                try {
                        if (existingAddendumList.size() > 0) {
                                delete existingAddendumList;
                        }
                } catch (DMLException e) {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
                        return;
                }
                
                soql = SectionUtil.getFieldsQuery('Addendum__c');
                soql += ' FROM Addendum__c WHERE UIP__c = \'' + uip.Id + '\'';
                List<Addendum__c> addendumList = Database.query(soql);
                
                Map<Id,Addendum__c> newAddendumMap = new Map<Id,Addendum__c>();
                Addendum__c newAddendum;
                for (Addendum__c add : addendumList) {
                        newAddendum = new Addendum__c();
                        newAddendum = add.clone(false, true);
                        newAddendum.UIP__c = newUip.Id;
                        newAddendumMap.put(add.Id, newAddendum);
                }
                
                try {
                        if (!newAddendumMap.isEmpty()) {
                                insert newAddendumMap.values();
                        }
                } catch (DMLException e) {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
                        return;
                }
                
                //clone Addendum__c && Supporting Addendum
                List<Supporting_Addenda_Forms__c> supportingAddList = [SELECT Id, Name, Addendum__c, Crosswalk_of_Description_in_Action_Plan__c, Description_of_Proposed_Activity__c,
                                                                                         Title_IA_PPC_Proposed_Amount__c, Title_IIA_Proposed_Amount__c, Title_III_Proposed_Amount__c 
                                                                                         FROM Supporting_Addenda_Forms__c WHERE Addendum__c IN :newAddendumMap.keySet()];
                system.debug('supportingAddList:::' + supportingAddList);
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
                                system.debug('newSupAddendumList::' + newSupAddendumList);
                                insert newSupAddendumList;
                                system.debug('newSupAddendumList::' + newSupAddendumList);
                        }
                } catch (DMLException e) {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
                        return;
                } */
        }
        
        public String ErrorMessage {get;set;}
        
        public PageReference submitForSchoolReview() {
                
                // error messages
                String richtextstr = string.valueof(uip.TextAreaRich_Test__c);
                if(richtextstr != null && richtextstr.length() > 0)
                        richtextstr = richtextstr.replaceall('<[^>]+>','');
                if(string.isblank(richtextstr)){
                        ErrorMessage = 'UIP cannot be accepted becuse required elements are missing:  Narrative field must be filled in.';
                        isSuccessfullyMsg = false;
                        return null;
                }
                if(uip.Section_IV_Action_Planning_Complete__c == false) {
                        ErrorMessage = 'UIP cannot be accepted becuse required elements are missing: Action Plan must be complete and ready to submit.';
                        isSuccessfullyMsg = false;
                        return null;
                }
                if(uip.Section_IV_Target_Setting_Complete__c == false) {
                        ErrorMessage = 'UIP cannot be accepted becuse required elements are missing: Target setting must be complete and ready to submit.';
                        isSuccessfullyMsg = false;
                        return null;
                }
                if((uip.TIG_Closure__c == 'Yes' && uip.TIG_Closure_Complete__c == false) || 
                   (uip.TIG_Restart__c == 'Yes' && uip.TIG_Restart_Complete__c == false) || 
                   (uip.TIG_Transformation__c == 'Yes' && uip.TIG_Transformation_Complete__c == false) || 
                   (uip.TIG_Turnaround__c == 'Yes' && uip.TIG_Turnaround_Complete__c == false) || 
                   (uip.Title_1_School_Wide__c == 'Yes' && uip.Title_I_School_Wide_Complete__c == false) || 
                   (uip.Title_III__c == 'Yes' && uip.Title_III_Complete__c == false) || 
                   (uip.Turnaround__c == 'Yes' && uip.Turnaround_Complete__c == false) || 
                   (uip.ESEA__c == 'Yes' && uip.ESEA_Complete__c == false) || 
                   //(uip.Gifted_Education__c == 'Yes' && uip.Gifted_Education_Complete__c == false) || 
                   (uip.Student_Grad_Completion_Plan__c == 'Yes' && uip.Student_Grad_Completion_Plan_Complete__c == false)){
                        ErrorMessage = 'UIP cannot be accepted because required elements are missing:  All addenda must be complete and ready to submit.';
                        isSuccessfullyMsg = false;
                        return null;
                }
                // submitRecord('Final');
                if (uip.Review_Required__c) {
                        uip.Review_Required__c = false;
                }
                uip.Conga_School_Template_Flag__c = true;
                uip.UIP_Status__c = 'Submitted for Posting';
                uip.Public_Facing__c = true;
                Savepoint sp = Database.setSavepoint();
                try {
                    update uip;
                    // updating the cache object for making the changes available to public View
                    try {
                        System.debug('*********uip.Id*********'+uip.Id);
                         List<Id> upid = new List<Id>();
                        upid.add(uip.Id);
                        UIP_Cache_Upsert.updateZPIFCache(upid);   
                    } catch(Exception e) { 
                        ErrorMessage = 'Operation Failed:' + e.getMessage() + '(' + e.getStackTraceString() + ')';
                        isSuccessfullyMsg = false;
                        Database.rollback(sp);
                        return null;
                    }
                } catch (DMLException e) {
                    ErrorMessage = 'Operation Failed:' + e.getMessage() + '(' + e.getStackTraceString() + ')';
                    isSuccessfullyMsg = false;
                    Database.rollback(sp);
                    return null;
                }
                isSuccessfullyMsg = true;
                return null;
        }
        
        public PageReference submitForReview() {
                
                // error messages
                String richtextstr = string.valueof(uip.TextAreaRich_Test__c);
                if(richtextstr != null && richtextstr.length() > 0)
                        richtextstr = richtextstr.replaceall('<[^>]+>','');
                if(string.isblank(richtextstr)){
                        ErrorMessage = 'UIP cannot be accepted becuse required elements are missing:  Narrative field must be filled in.';
                        isSuccessfullyMsg = false;
                        return null;
                }
                if(uip.Section_IV_Action_Planning_Complete__c == false) {
                        ErrorMessage = 'UIP cannot be accepted becuse required elements are missing: Action Plan must be complete and ready to submit.';
                        isSuccessfullyMsg = false;
                        return null;
                }
                if(uip.Section_IV_Target_Setting_Complete__c == false) {
                        ErrorMessage = 'UIP cannot be accepted becuse required elements are missing: Target setting must be complete and ready to submit.';
                        isSuccessfullyMsg = false;
                        return null;
                }
                if((uip.TIG_Closure__c == 'Yes' && uip.TIG_Closure_Complete__c == false) || 
                   (uip.TIG_Restart__c == 'Yes' && uip.TIG_Restart_Complete__c == false) || 
                   (uip.TIG_Transformation__c == 'Yes' && uip.TIG_Transformation_Complete__c == false) || 
                   (uip.TIG_Turnaround__c == 'Yes' && uip.TIG_Turnaround_Complete__c == false) || 
                   (uip.Title_1_School_Wide__c == 'Yes' && uip.Title_I_School_Wide_Complete__c == false) || 
                   (uip.Title_III__c == 'Yes' && uip.Title_III_Complete__c == false) || 
                   (uip.Turnaround__c == 'Yes' && uip.Turnaround_Complete__c == false) || 
                   (uip.ESEA__c == 'Yes' && uip.ESEA_Complete__c == false) || 
                   //(uip.Gifted_Education__c == 'Yes' && uip.Gifted_Education_Complete__c == false) || 
                   (uip.Student_Grad_Completion_Plan__c == 'Yes' && uip.Student_Grad_Completion_Plan_Complete__c == false)){
                        ErrorMessage = 'UIP cannot be accepted because required elements are missing:  All addenda must be complete and ready to submit.';
                        isSuccessfullyMsg = false;
                        return null;
                }
                submitRecord('Version');
                isSuccessfullyMsg = true;
                return null;
        }
        
        public class AttachmentWrapper {
                public Attachment att { get; set; }
                public String attName { get; set; }
                public AttachmentWrapper(Attachment att) {
                        this.att = att;
                        Integer i = att.Name.lastIndexOf('.');
                        String extension;
                        String nameWithoutExtension = '';
                        if (i != -1) {
                                nameWithoutExtension = att.Name.substring(0, i);
                                extension = att.Name.substring(i + 1);
                        }
                        this.attName = nameWithoutExtension + ' - ' + String.valueOf(att.CreatedDate.date().format()) + ' ' + String.valueOf(myTimeFormat(att.CreatedDate)) + '.' + extension;
                }
                public String myTimeFormat(DateTime dt) {
                        return dt.format().replace(dt.date().format(), '').trim();
                }
        }
        
        public PageReference downloadPDF() {
                PageReference pr=new PageReference('/apex/PublicUIP_Print?id='+uip.id);
                pr.setRedirect(true);
                return pr;
        }
    
        public PageReference downloadViewPDF() {
                PageReference pr=new PageReference('/apex/PublicUIPView_Print?id='+uip.id);
                pr.setRedirect(true);
                return pr;
        }
}