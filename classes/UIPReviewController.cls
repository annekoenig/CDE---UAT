public without sharing class UIPReviewController {
    
    public List<BenchMar_AtciontStep__c>  actionStepBenchMarkList {set;get;}
    public Map<Id,List<String>> actionStepRelatedMap {set;get;}      
    public List<IbWrapper> bmarkList {set;get;}
    public List<IasWrapper> actionStepList {set;get;}
    public List<SelectOption> yearsOption {set;get;}
    public boolean editableIBNameselectList {Set;get;}
    public String selectedRecNameId  {set;get;}
    public String fromMonthVal {set;get;}
    public String toMonthVal {set;get;}
    public List<SElectOption> nameOption {set;get;}    
    public List<SelectOption> fromMonthsOption {set;get;}
    public List<SelectOption> toMonthsOption  {set;get;}      
    public List<IbWrapper> filterIbList  {set;get;}
    public List<IasWrapper> filterIasList  {set;get;}    
    public  Integer i {set;get;}
    public Paginate paginater {get;set;}
    public List<MisWrapper> genericList{get;set;}
    public List<List<MisWrapper>> fullGenericList{get;set;}
    public Integer pagesize {Set;get;}
    public Integer pageDiff {set;get;}
    public String viewpage {set;get;}
    public boolean dispButton{ get; set; }    
    public boolean dispIasButton{ get; set; } 
    public String editRecId  {set;get;}
    public String updateRecId {set;get;}    
    public String deleteRecId {set;get;}
    public String deleteIasRecId {set;get;}
    public Integer recordSize {set;get;}
    public Boolean isupdateRecord {set;get;}
    public Boolean isIasUpdateRecord {set;get;}
    public String editIasRecId {set;get;}
    public String updateIasRecId {set;get;}
    public String saveIasRecId {set;get;}
    public boolean defaultPageMisList {set;get;}
    public List<Implementation_Benchmark__c> ibList { get; set; }
    public Implementation_Benchmark__c dummyIb { get; set; }    
    public String getSupporting_Addenda_Forms() {return null; }
    public List<AddendumWrapper> addWList { get; set; }
    public Map<Integer, AddendumWrapper> addWPositionMap { get; set; }
    public integer addWPositionMapsize {
        get {
            if (addWPositionMap == null) return 0;
            return addWPositionMap.size();
        }
    }
    public Integer addPosition { get; set; }
    public static final Integer MAX_TARGET = 1;
    public static final Integer MAX_NOTABLE_TRENDS = 1;
    public static final Integer MAX_UIP_ELEM = 9;
    public static final String SECTION_II = 'Section II';
    public static final String SECTION_IV = 'Section IV';
    public String currentId { get; set; }
    public UIP__c uip { get; set; }
    public List<Performance_Indicator_Notable_Trends__c> piList { get; set; }
    public List<Performance_Indicator_Targets__c> pitList { get; set; }
    public Performance_Indicator_Notable_Trends__c dummyPint { get; set; }
    public Performance_Indicator_Targets__c dummyPit { get; set; }
    public UIP_Element__c dummyUipe { get; set; }
    private List<UIP_Element__c> uipElementsList { get; set; }
    public Map<Id, UIP_Element__c> uipElementsMap { get; set; }
    public Map<Id, UIP_Element__c> challengeMap { get; set; }
    public integer challengeMapsize {
        get {
            if (challengeMap == null) return 0;
            return challengeMap.size();
        }
    }
    public Map<Id, List<UIP_Element__c>> rcForChallengeMap { get; set; }
    public Map<String,List<Performance_Indicator_Targets__c>> pitTargetsMap { get; set; }
    public integer pitTargetsMapsize {
        get {
            if (pitTargetsMap == null) return 0;
            return pitTargetsMap.size();
        }
    }
    public Map<String,List<Performance_Indicator_Notable_Trends__c>> piNotableTrendsMap { get; set; }
    public Map<Id,List<Performance_Indicator_Targets__c>>  performanceIndicatorMap {Set;get;}
    public Map<Id, List<UipElemWrapper>> rcForMisMap { get; set; }
    public String selectedNameId {Set;get;}
    public List<ElemWrapper> misList { get; set; }
    public List<MisWrapper> misWrapperList { get; set; }
    public List<ElemWrapper> rcList { get; set; }
    public List<ElemWrapper> rcForMisList { get; set; }    
    public Map<String,List<SchoolTargetWrapper>> piSchoolTargetsMap { get; set; }    
    public String targetElemId { get; set; }
    public String targetElemNumber { get; set; }
    public String currentPitRt { get; set; }
    public String piValue { get; set; }
    public String uipElemId { get; set; }
    public String ntElemId { get; set; }
    public String ntElemRT { get; set; }
    public String iasId { get; set; }
    public ElemWrapper ppcElem { get; set; }
    public ElemWrapper rcElem { get; set; }
    public ElemWrapper misElem { get; set; }
    public String newMISName { get; set; }
    public String newMISDesc { get; set; }
    public Map<String,String> choosedRC { get; set; }
    public String rtChallengeId { get; set; }
    public String rtMISId { get; set; }
    public String rtRCId { get; set; }
    public Map<String, String> pitRtValueMap { get; set; }
    public Map<String, String> pintRtValueMap { get; set; }
    public String currentPintRt;
    public Boolean isError { get; set; }
    public Boolean isNewElem { get; set; }
    public String elemType { get; set; }
    public List<SelectOption> subjectOpt { get; set; }
    public List<SelectOption> misOptionsList { get; set; }
    public String selectedMisOption { get; set; }
    public String selectedMisOption2 { get; set; }
    public List<UIP_Element__c> allMisList { get; set; }
    public Map<Id, UIP_Element__c> misMap { get; set; }
    public List<UIP_Contact__c> uipContactsList { get; set; }    
    public List<Improvement_Action_Step__c> iasList { get; set; }
    public Improvement_Action_Step__c dummyIas { get; set; }
    public List<Attachment> attachList { get; set; }
    public Addendum__c addendum { get; set; }
    public List<Supporting_Addenda_Forms__c> supAddList { get; set; }
    public List<AttachmentWrapper> attachWrapperList { get; set; }
    public String pitRT { get; set; }
    public String elementValue { get; set; }
    public Map<id,String> elementNameMap {set;get;}    
    public Map<String,String> addendumMap { get; set; }
    public List<String> addendumList { get; set; }
    public Map<String,Integer> addendumPositionMap { get; set; }
    public Integer countAddendum { get; set; }    
    public String eseaId { get; set; }    
    Map<String,String> section1Map  { get; set; }    
    public boolean isCommunityUser { get; set; }
    public boolean closeWindow { get; set; }
    public boolean isEditRTF { get; set; }
    public String target { get; set; }    
    public String activeMenu { get; set; }
    public String activeSubMenu { get; set; }
    public boolean isSection3 { get; set; }    
    public boolean isEditPit { get; set; }
    public boolean isEditPint { get; set; }
    public boolean isEditElem { get; set; }
    public boolean isEditElemx { get; set; }
    public boolean isExistingRC { get; set; }
    public Map<String,String> pitNarrativeMap { get; set; }
    public Map<String,String> schoolYearMap { get; set; }
    public boolean existTrendAnalysis { get; set; }
    public boolean isTextChanged { get; set; }
    public String selectedYear {Set;get;}
    public String ExportId;
    public List<PPCMappingWrapper> ppcmWrapperList { get; set; }
    private Map<Id, UIP_Element__c> allElemsMap;    
    public List<Performance_Indicator_Targets__c> idsList {set;get;}
    public set<ID> elementsIdset {set;get;}
    public Map<Id,String>  ppcChallengeMap {Set;get;}
    public Map<Id,List<SchoolTargetWrapper>>  piTargetMap {Set;get;}
    public integer piTargetMapsize {
        get {
            if (piTargetMap == null) return 0;
            return piTargetMap.size();
        }
    }
    public List<Performance_Indicator_Targets__c> ppcSchoolTatgetList {set;get;}
    public List<Performance_Indicator_Notable_Trends__c> pintList { get; set; }
    public List<UIP_Element__c> rootCauseList {set;get;}
    
    public UIPReviewController() {
        actionStepBenchMarkList = new List<BenchMar_AtciontStep__c>(); 
        fullGenericList = new List<List<MisWrapper>>();
        genericList = new List<MisWrapper>();
        bmarkList = new List<IbWrapper>();
        actionStepList = new List<IasWrapper>();
        YearsOption = new List<SelectOption>();        
        getYears();        
        filterIbList = new List<IbWrapper>();
        filterIasList = new List<IasWrapper>();
        nameOption = new List<selectOption>();
        toMonthsOption = new List<SelectOption>();
        fromMonthsOption=new List<SelectOption>();
        getFromMonths();
        getToMonths();
        i=0;
        isSection3 = false;
        dispButton = true;
        dispIasButton = true;
        activeMenu = SectionUtil.setActiveMenu();
        if (activeMenu == 'Section3') {
            isSection3 = true;
            pitNarrativeMap = new Map<String,String>();
            pitNarrativeMap.put('Academic Achievement (Status)','Narrative_Academic_Achievement_Targets__c');
            pitNarrativeMap.put('Academic Growth','Narrative_Academic_Growth_Targets__c');
            pitNarrativeMap.put('Academic Growth Gaps','Narrative_Academic_Growth_Gaps_Target__c');
            pitNarrativeMap.put('English Language Development and Attainment','Narrative_English_Lang_Dev_Attain_Target__c');
            pitNarrativeMap.put('Postsecondary & Workforce Readiness','Narrative_Postsecondary_Workforce_Target__c');
            pitNarrativeMap.put('Student Engagement','Narrative_Student_Engagement_Target__c');
            pitNarrativeMap.put('Disaggregated Achievement','Narrative_Disaggregated_Achievement__c');
            pitNarrativeMap.put('Student Behavior','Narrative_Student_Behavior__c');
            pitNarrativeMap.put('Other','Narrative_Other__c');
        }
        activeSubMenu = SectionUtil.setActiveSubMenu();
        target = ApexPages.currentPage().getParameters().get('target');
        isError = false;
        closeWindow = false;
        UIP__c uiprec;
        String uipId;
        String strDistrictNumber;
        String strSchoolNumber;
        try{
            string uID = ApexPages.currentPage().getParameters().get('id');
            System.debug('uID '+uID);
            uiprec = [SELECT id FROM UIP__c WHERE id =:uID LIMIT 1];
            System.debug('uiprec '+uiprec);                    
        }catch(exception e){ 
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Error: '+e);
            ApexPages.addMessage(myMsg);
            system.debug(Logginglevel.Error,' '+e);
        }
        if (uiprec != null){ currentId = uiprec.id; }
        isEditElem = false;
        if(currentId != NULL && currentId != ''){
            pitRT = ApexPages.currentPage().getParameters().get('pitRT');
            subjectOpt = SectionUtil.getPicklistValues('Performance_Indicator_Targets__c', 'Subject_1__c');
            dummyUipe = new UIP_Element__c();
            getElemRTIds();
            pitRtValueMap = SectionUtil.getPiRtValueMap('Performance_Indicator_Targets__c');
            pintRtValueMap = SectionUtil.getPiRtValueMap('Performance_Indicator_Notable_Trends__c');
            selectUIP();
            populatePPCTable();            
            addPosition = 1;
            selectAllAddendums();
            countAddendum = addWList.size();            
            ExportId = ApexPages.currentPage().getParameters().get('expId');
            if(!String.isEmpty(ExportId)) {
                selectedMisOption2 = ExportId;
            }
            section1Map = getSection1Map();
            if (activeMenu == 'Section4') {
                schoolYearMap = new Map<String,String>();
                schoolYearMap.put(null, '');
                schoolYearMap.put('This School Year', uip.UIP_Annual_CDE_Plan__r.This_School_Year__c);
                schoolYearMap.put('Next School Year', uip.UIP_Annual_CDE_Plan__r.Next_School_Year__c);
            } 
            addMisWrapperListToPagination();
            callIbIasRefresh();
            show();
            fillBenchMarkMap1();
            fillMapwithBenchMarkList();
            uipContactsList = [SELECT Id, First_Name__c, Last_Name__c, Title__c, Phone__c, Email__c, Mailing_Street__c, Mailing_City__c, Mailing_State_Province__c, Mailing_Zip_Postal_Code__c, UIP__c FROM UIP_Contact__c WHERE UIP__c = :currentId];
            populateOrder();
            populateOrderIB();
            SelectAttachements();
            populatePPCTableForPublicFacing();
            populateTargetsForChallenge();
            populateNotableTrendsUpdated();
        }
    }
    
    public Map<String,String> getSection1Map() {
        Map<String,String> sect1Map = new Map<String,String>();
        sect1Map.put('AEC UIP','Section1_AEC');
        sect1Map.put('District UIP','Section1_District');
        sect1Map.put('School UIP','Section1');
        sect1Map.put('AEC UIP 2015','Section1_AEC_2015');
        sect1Map.put('District UIP 2015','Section1_District_2015');
        sect1Map.put('School UIP 2015','Section1_2015');
        sect1Map.put('AEC UIP 2016','Section1_AEC_2015');
        sect1Map.put('District UIP 2016','Section1_District_2015');
        sect1Map.put('School UIP 2016','Section1_2015');
        sect1Map.put('Network 2016','Section1_2015');        
        return sect1Map;
    }
    
    public void selectAllAddendums() {
        String soql = SectionUtil.getFieldsQuery('Addendum__c');
        soql += ',RecordType.Name, UIP__r.SCHOOL_NAME__r.Name, School_UIP__r.SCHOOL_NAME__r.Name';
        soql += ' FROM Addendum__c WHERE UIP__c = \'' + currentId + '\'';
        List<Addendum__c> addList = Database.query(soql);
        system.debug('addList ' + addList);
        addWList = new List<AddendumWrapper>();
        addWPositionMap = new Map<Integer, AddendumWrapper>();
        AddendumWrapper addW;
        Integer i = 1;
        Set<Id> addEseaSet = new Set<Id>();
        Map<String,String> params = ApexPages.currentPage().getParameters();
        if (params.containsKey('rt')) {
            String currentRequestURL = params.get('rt');
            String currentRT = '';
            Map<String,String> addRTMap = getAddendumRTMap();
            for (String key : addRTMap.KeySet()) {
                if (currentRequestURL.containsIgnoreCase(key)) {
                    currentRT = addRTMap.get(key);
                    break;
                }
            }
            for (Integer k = 0; k < addList.size(); k++) {
                if (addList.get(k).RecordType.Name == currentRT) {
                    if (currentRT == 'DIST ESEA Supporting Addendum') {
                        addEseaSet.add(addList.get(k).Id);
                    }
                    addW = new AddendumWrapper(addList.remove(k), i);
                    addW.addURL = currentRequestURL;
                    addWList.add(addW);
                    addWPositionMap.put(i, addW);
                    i++;
                    break;
                }
            }
            System.debug('addWPositionMap '+addWPositionMap);
        }
        system.debug('addWList ' + addWList);
        for (Addendum__c add : addList) {
            addW = new AddendumWrapper(add, i);
            if (add.RecordType.Name == 'DIST ESEA Supporting Addendum') {
                addW.addURL = 'Addenda_DIST_ESEA_Supporting';
                addEseaSet.add(add.Id);
            } else if (add.RecordType.Name == 'Dist/Sch Turnaround') {
                addW.addURL = 'Addenda_DistSch_Turnaround';
            } else if (add.RecordType.Name == 'DIST Gifted Program') {
                addW.addURL = 'Addenda_DIST_Gifted_Program';
            } else if (add.RecordType.Name == 'Title I') {
                addW.addURL = 'Addenda_SCHTitle1_SW';
            } else if (add.RecordType.Name == 'DIST SGCP Addendum') {
                addW.addURL = 'Addenda_DIST_SGCP';
            } else if (add.RecordType.Name == 'DIST Title III Improvement Addendum') {
                addW.addURL = 'Addenda_DIST_Title_III_Improvement';
            } else if (add.RecordType.Name == 'TIG Turnaround') {
                addW.addURL = 'Addenda_TIGTurnaround';
            } else if (add.RecordType.Name == 'TIG Closure') {
                addW.addURL = 'Addenda_TIGClosure';
            } else if (add.RecordType.Name == 'TIG Transformation') {
                addW.addURL = 'Addenda_TIGTransformation';
            }
            if (add.UIP__r.SCHOOL_NAME__r.Name != null && add.UIP__r.SCHOOL_NAME__r.Name != '') {
                addW.schoolName = add.UIP__r.SCHOOL_NAME__r.Name;
            } else if (add.School_UIP__r.SCHOOL_NAME__r.Name != null && add.School_UIP__r.SCHOOL_NAME__r.Name != '') {
                addW.schoolName = add.School_UIP__r.SCHOOL_NAME__r.Name;
            }
            addWList.add(addW);
            addWPositionMap.put(i, addW);
            i++;
        }
        system.debug('addWPositionMap ' + addWPositionMap);
        System.debug('addWList '+addWList);        
        if (addWList.size() > 0) {
            addendum = addWList[addPosition - 1].addendum;
            if (addendum.RecordType.Name == 'DIST ESEA Supporting Addendum') {
                selectSupportingAddenda(addendum.Id);
            }
        }
    }
    
    public void selectSupportingAddenda(Id addendumId) {
        supAddList = new List<Supporting_Addenda_Forms__c>();
        String soql = SectionUtil.getFieldsQuery('Supporting_Addenda_Forms__c');
        soql += ' FROM Supporting_Addenda_Forms__c WHERE Addendum__r.UIP__c = \'' + currentId +'\'';
        soql += ' AND Addendum__c = \'' + addendumId + '\'';
        supAddList = Database.query(soql);
    }
    
    public Map<String,String> getAddendumRTMap() {
        Map<String,String> addendumMap = new Map<String,String>();
        addendumMap.put('Addenda_DIST_ESEA_Supporting','DIST ESEA Supporting Addendum');
        addendumMap.put('Addenda_DistSch_Turnaround','Dist/Sch Turnaround');
        addendumMap.put('Addenda_DIST_Gifted_Program','DIST Gifted Program');
        addendumMap.put('Addenda_SCHTitle1_SW','Title I');
        addendumMap.put('Addenda_DIST_SGCP','DIST SGCP Addendum');
        addendumMap.put('Addenda_DIST_Title_III_Improvement','DIST Title III Improvement Addendum');
        addendumMap.put('Addenda_TIGTurnaround','TIG Turnaround');
        addendumMap.put('Addenda_TIGClosure','TIG Closure');
        addendumMap.put('Addenda_TIGTransformation','TIG Transformation');
        return addendumMap;
    }
    
    public void populateESEA() {
        eseaId = ApexPages.currentPage().getParameters().get('eseaId');
    }
    
    public void Save() {
        if (addendum != null) {
            Boolean isEseaAddendum = false;
            if (addendum.RecordType.Name == 'DIST ESEA Supporting Addendum') {
                isEseaAddendum = true;
            }
            try {
                upsert addendum;
            } catch (DMLException e) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
                return;
            }
            selectAllAddendums();
            if (isEseaAddendum) {
                if(addWPositionMap.get(addPosition) != null) { selectSupportingAddenda(addWPositionMap.get(addPosition).addendum.Id); }
            }
            closeWindow = true;
        }
    }
    
    public void selectUIP() {
        uip = [SELECT Id, Name, Turnaround__c, TIG_Turnaround__c, TIG_Transformation__c, Section_1__c, Section_1_Percent_Complete__c, ESEA__c, Gifted_Education__c, Student_Grad_Completion_Plan__c, Title_III__c,
               Section_2__c, Section_2_Percent_Complete__c, Section_3__c, Section_3_Percent_Complete__c, Section_4__c, Section_4_Percent_Complete__c, DIST_NUMBER__c, 
               TIG_Restart__c, TIG_Closure__c, TIG_Transformation_Percent_Complete__c, TIG_Closure_Percent_Complete__c, Turnaround_Percent_Complete__c, 
               TIG_Restart_Percent_Complete__c, TIG_Turnaround_Percent_Complete__c, Title_1_School_Wide__c, Title_1_Percent_Complete__c,
               SCHOOL_NAME__r.Name, City__c, DISTRICT_NAME__r.Name, A_TTL_RATING_OFFICIAL__c,Related_Grant_Awards__c,SST_Expedited_Review__c,
               UIP_Annual_CDE_Plan__c, UIP_Annual_CDE_Plan__r.April_Deadline__c, UIP_Annual_CDE_Plan__r.Blank_Template_Released__c, 
               UIP_Annual_CDE_Plan__r.January_Deadline__c, UIP_Annual_CDE_Plan__r.October_Deadline__c, External_Evaluator__c,
               UIP_Annual_CDE_Plan__r.Next_School_Year__c, UIP_Annual_CDE_Plan__r.This_School_Year__c,
               UIP_Annual_CDE_Plan__r.Section_1_Data_Populated__c, UIP_Annual_CDE_Plan__r.Section_1_Update__c, RecordType.Name,
               Section_II_Complete__c, Section_III_Worksheet_1_Complete__c, Section_III_Worksheet_2_Complete__c, Section_III_Data_Narrative_Complete__c, Section_IV_Action_Planning_Complete__c, Section_IV_Major_Imp_Strategies_Complete__c, Section_IV_Target_Setting_Complete__c,
               TextAreaRich_Test__c, Target_Reflection__c, TIG_Turnaround_Complete__c, Student_Graduation_and_Completion_Plan__c, TIG_Closure_Complete__c, Public_Facing__c,
               Turnaround_Complete__c, TIG_Transformation_Complete__c, Title_I_School_Wide_Complete__c, Title_III_Complete__c, Gifted_Education_Complete__c, SCHOOL_NUMBER__c,
               ESEA_Complete__c, Student_Grad_Completion_Plan_Complete__c, Narrative_Academic_Achievement_Targets__c, Narrative_Additional__c,
               Narrative_Academic_Growth_Targets__c, Narrative_Academic_Growth_Gaps_Target__c, Narrative_Postsecondary_Workforce_Target__c,
               Narrative_English_Lang_Dev_Attain_Target__c, Narrative_Student_Engagement_Target__c, Performance_Challenge_Narrative__c,Section_III_PPCs_Complete__c, Section_III_Root_Cause_Complete__c, Section_III_Trend_Analysis_Complete__c, Narrative_Additional_Trend_Information__c, Section_III_Current_Performance_Complete__c,
               Root_Cause_Narrative__c, State_Accreditation__c,Title_I_Focus_School__c,Tiered_Intervention_Grant_TIG__c,Title_IA__c, Colorado_Graduation_Pathways_Program__c, Title_IIA__c, 
               School_Improvement_Support_Grant__c,Title_III_Checkbox__c, Gifted_Education_Checkbox__c, Other__c, Other_Description__c, Narrative_Disaggregated_Achievement__c, Narrative_Other__c, Narrative_Student_Behavior__c FROM UIP__c WHERE Id = :currentId];        
    }
    
    public void getElemRTIds() {
        rtChallengeId = Schema.SObjectType.UIP_Element__c.getRecordTypeInfosByName().get('Challenge').getRecordTypeId();
        rtMISId = Schema.SObjectType.UIP_Element__c.getRecordTypeInfosByName().get('Major Improvement Strategy').getRecordTypeId();
        rtRCId = Schema.SObjectType.UIP_Element__c.getRecordTypeInfosByName().get('Root Cause').getRecordTypeId();
    }
    
    public void populatePPCTable() {
        populateNotableTrends();
        populateTargets();
        populateUIPElem();
        populateSchoolTargetsMap();
        if (selectedMisOption != null && selectedMisOption != '') {
            updateMISElem();
        }
    }
    
    public void rerenderForRTF() {
        selectUIP();
        populateTargets();
        isEditRTF = false;
    }
    
    public void rerenderAllRTF() {
        selectUIP();
        isEditRTF = false;
    }
    
    public void populateTargets() {
        System.debug('get Performance Indicator');
        String soql = SectionUtil.getFieldsQuery('Performance_Indicator_Targets__c');
        soql += ' FROM Performance_Indicator_Targets__c WHERE UIP__c = \'' + uip.Id + '\'';
        soql += ' AND RecordType.Name = \'Prior Year Target\' order by CreatedDate';
        pitList = Database.query(soql);
        System.debug('pitList '+pitList);
        Map<String, String> rtMap = SectionUtil.getPiValuesMap(uip.RecordType.Name);
        System.debug('rtMapT ' + rtMap);
        pitTargetsMap = new Map<String,List<Performance_Indicator_Targets__c>>();
        System.debug('rtMap.keySet() '+rtMap.keySet());
        for (String key : rtMap.keySet()) {
            System.debug('key '+key);
            pitTargetsMap.put(key, new List<Performance_Indicator_Targets__c>());
        }
        System.debug('pitTargetsMap '+pitTargetsMap);
        for (Performance_Indicator_Targets__c pit : pitList) {
            System.debug('pit.get("Last_Year_Target_1__c") '+pit.get('Last_Year_Target_1__c'));
            System.debug('pit.get("Performance_against_Target_1__c") '+pit.get('Performance_against_Target_1__c'));
            if (pit.get('Last_Year_Target_1__c') != null || pit.get('Performance_against_Target_1__c') != null) {
                if (pitTargetsMap.containsKey(pit.Performance_Indicator__c)) {
                    pitTargetsMap.get(pit.Performance_Indicator__c).add(pit);
                }
            }
        }
    }
    
    public void populateNotableTrends() {
        String soql = SectionUtil.getFieldsQuery('Performance_Indicator_Notable_Trends__c');
        soql += ', Priority_Performance_Challenge_1__r.Description__c, Root_Cause_1__r.Description__c, Priority_Performance_Challenge_1__r.Name, Root_Cause_1__r.Name';
        soql += ' FROM Performance_Indicator_Notable_Trends__c WHERE UIP__c = \'' + uip.Id + '\' order by CreatedDate';
        piList = Database.query(soql);
        existTrendAnalysis = false;
        Map<String, String> rtMap = SectionUtil.getPiValuesMap(uip.RecordType.Name);
        piNotableTrendsMap = new Map<String,List<Performance_Indicator_Notable_Trends__c>>();
        for (String key : rtMap.keySet()) {
            piNotableTrendsMap.put(key, new List<Performance_Indicator_Notable_Trends__c>());
        }
        for (Performance_Indicator_Notable_Trends__c pi : piList) {
            if (pi.get('Notable_Trends_1__c') != null || pi.get('Priority_Performance_Challenge_1__c') != null || pi.get('Root_Cause_1__c') != null) {
                if (piNotableTrendsMap.containsKey(pi.Performance_Indicator__c)) {
                    piNotableTrendsMap.get(pi.Performance_Indicator__c).add(pi);
                }
            }
            if(pi.Notable_Trend__c == 'Yes') {
                existTrendAnalysis = true;
            }
        }
        System.debug('piNotableTrendsMap ' + piNotableTrendsMap);
    }
    
    public void populateSchoolTargetsMap() {
        String soql = SectionUtil.getFieldsQuery('Performance_Indicator_Targets__c');
        soql += ', Priority_Performance_Challenge_1__r.Name, Priority_Performance_Challenge_1__r.Description__c, Major_Improvement_Strategy_1__r.Name, Major_Improvement_Strategy_1__r.Description__c, RecordType.Name ';
        soql += ' FROM Performance_Indicator_Targets__c WHERE UIP__c = \'' + uip.Id + '\' order by CreatedDate';
        pitList = Database.query(soql);
        Map<String, String> rtMap = SectionUtil.getPiValuesMap(uip.RecordType.Name);
        piSchoolTargetsMap = new Map<String,List<SchoolTargetWrapper>>();
        for (String key : rtMap.keySet()) {
            piSchoolTargetsMap.put(key, new List<SchoolTargetWrapper>());
        }
        Map<Id,Performance_Indicator_Targets__c> allPitMap = new Map<Id,Performance_Indicator_Targets__c>();
        for (Performance_Indicator_Targets__c pit : pitList) {
            allPitMap.put(pit.id, pit);
        }
        String nextYearRTId = Schema.SObjectType.Performance_Indicator_Targets__c.getRecordTypeInfosByName().get('Next Year\'s Target').getRecordTypeId();
        for (Performance_Indicator_Targets__c pit : pitList) {
            if (piSchoolTargetsMap.containsKey(pit.Performance_Indicator__c) && pit.RecordType.Name == 'This Year\'s Target') {
                if (pit.Next_Year_Related_Target__c != null) {
                    piSchoolTargetsMap.get(pit.Performance_Indicator__c).add(new SchoolTargetWrapper(pit, allPitMap.get(pit.Next_Year_Related_Target__c)));
                } else {
                    piSchoolTargetsMap.get(pit.Performance_Indicator__c).add(new SchoolTargetWrapper(pit, new Performance_Indicator_Targets__c(UIP__c = uip.Id, RecordTypeId = nextYearRTId)));
                }
            }
        }
        System.debug('piSchoolTargetsMap ' + piSchoolTargetsMap);
    }
    
    public void populateUIPElem() {
        String soql = SectionUtil.getFieldsQuery('UIP_Element__c');
        soql += ', UIP__r.RecordType.Name';
        soql += ' FROM UIP_Element__c WHERE UIP__c = \'' + uip.Id + '\' order by CreatedDate';
        uipElementsList = Database.query(soql);
        uipElementsMap = new Map<Id, UIP_Element__c>();
        challengeMap = new Map<Id, UIP_Element__c>();
        misList = new List<ElemWrapper>();
        rcList = new List<ElemWrapper>();
        allMisList = new List<UIP_Element__c>();
        misMap = new Map<Id, UIP_Element__c>();
        rcForChallengeMap = new Map<Id, List<UIP_Element__c>>();
        rcForMisMap = new Map<Id, List<UipElemWrapper>>();
        choosedRC = new Map<String, String>();
        misOptionsList = new List<SelectOption>();
        misOptionsList.add(new SelectOption('', '-- None --'));
        ElemWrapper elemW;
        for (UIP_Element__c elem : uipElementsList) {
            uipElementsMap.put(elem.Id, elem);
            if (elem.RecordTypeId == rtChallengeId) {
                elemW = new ElemWrapper(elem.Id, elem.Name, elem.Description__c);
                elemW.uipElem = elem;
                challengeMap.put(elem.Id, elem);
                choosedRC.put(elem.Id, '');
                rcForChallengeMap.put(elem.Id, new List<UIP_Element__c>());
            } else if (elem.RecordTypeId == rtMISId) {
                misList.add(new ElemWrapper(elem.Id, elem.Name, elem.Description__c));
                misOptionsList.add(new SelectOption(elem.Id, elem.Name));
                allMisList.add(elem);
                misMap.put(elem.Id, elem);
                choosedRC.put(elem.Id, '');
                rcForMisMap.put(elem.Id, new List<UipElemWrapper>());
            } else if (elem.RecordTypeId == rtRCId) {
                rcList.add(new ElemWrapper(elem.Id, elem.Name, elem.Description__c));
            }
        }
        populateRCForChallengeMap();
        populateMisWrapperList();
    }
    
    public void populateMisWrapperList() {
        populateRCForMisMap();
        Map<Id, List<IasWrapper>> iasMap = getIasMap();
        misWrapperList = new List<MisWrapper>();
        Map<Id, List<IbWrapper>> ibMap = getIbMap();
        MisWrapper misWrapper;
        for (UIP_Element__c mis : allMisList) {
            misWrapper = new MisWrapper(misMap.get(mis.Id), rcForMisMap.get(mis.Id), getRcForMisOptionList(mis.Id), iasMap.get(mis.Id), new IasWrapper(new Improvement_Action_Step__c(), true, 'none'), ibMap.get(mis.Id), new IbWrapper(new Implementation_Benchmark__c(), 'none'));
            misWrapperList.add(misWrapper);
        }
    }
    
    public List<SelectOption> getRcForMisOptionList(String misId) {
        Set<Id> existingRC = new Set<Id>();
        for (UipElemWrapper elemW : rcForMisMap.get(misId)) {
            if(elemW.elem != null){ existingRC.add(elemW.elem.Id); }
        }
        system.debug('rcForMisMap.get(misId) ' + rcForMisMap.get(misId));
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('', '-- None --'));
        for (UIP_Element__c elem : uipElementsList) {
            if (elem.RecordTypeId == rtRCId && !existingRC.contains(elem.Id)) {
                options.add(new SelectOption(elem.Id, elem.Name));
            }
        }
        system.debug('options ' + options);
        return options;
    }
    
    public void populateRCForChallengeMap() {
        UIP_Element__c newRC;
        Set<Id> rcIDs = new Set<Id>();
        for (Id challengeId : challengeMap.keySet()) {
            for (Integer i = 1; i <= MAX_UIP_ELEM; i++) {
                if (uipElementsMap.get((Id)challengeMap.get(challengeId).get('Root_Cause_'+ i + '__c')) != null) {
                    newRC = new UIP_Element__c();
                    newRC = uipElementsMap.get((Id)challengeMap.get(challengeId).get('Root_Cause_'+ i + '__c')).clone(true, true);
                    rcForChallengeMap.get(challengeId).add(newRC);
                    rcIDs.add(newRC.Id);
                }
            }
            
        }
        rootcauseList = [SELECT Id,Name,Description__c FROM UIP_Element__c where Id in:rcIDs];
    }
    
    public void populateRCForMisMap() {
        for (Id misId : misMap.keySet()) {
            for (Integer i = 1; i <= MAX_UIP_ELEM; i++) {
                if (misMap.get(misId).get('Root_Cause_'+ i + '__c') != null) {
                    rcForMisMap.get(misId).add(new UipElemWrapper(uipElementsMap.get((Id)misMap.get(misId).get('Root_Cause_'+ i + '__c'))));
                }
            }
        }
    }
    
    public void updateMISElem() {
        selectedMisOption2 = selectedMisOption;
        System.debug('selectedMisOption2 ' + selectedMisOption2);
        if (selectedMisOption2 != null) {
            String soql = SectionUtil.getFieldsQuery('UIP_Element__c');
            soql += ', Root_Cause_1__r.Name, Root_Cause_1__r.Description__c, Root_Cause_2__r.Name, Root_Cause_2__r.Description__c, Root_Cause_3__r.Name, Root_Cause_3__r.Description__c, Root_Cause_4__r.Name, Root_Cause_4__r.Description__c, Root_Cause_5__r.Name, Root_Cause_5__r.Description__c ';
            soql += ', Root_Cause_6__r.Name, Root_Cause_6__r.Description__c, Root_Cause_7__r.Name, Root_Cause_7__r.Description__c, Root_Cause_8__r.Name, Root_Cause_8__r.Description__c, Root_Cause_9__r.Name, Root_Cause_9__r.Description__c';
            soql += ' FROM UIP_Element__c WHERE Id = \'' + selectedMisOption + '\'';
            List<UIP_Element__c> misElemList = Database.query(soql);
            rcForMisList = new List<ElemWrapper>();
            Set<Id> existingRCIds = new Set<Id>();
            if (misElemList.size() > 0) {
                for (UIP_Element__c mis: misElemList) {
                    for (Integer i=1; i<= MAX_UIP_ELEM; i++) {
                        if (mis.get('Root_Cause_'+ i + '__c') != null) {
                            if (!existingRCIds.contains((Id)mis.get('Root_Cause_'+ i + '__c'))) {
                                rcForMisList.add(new ElemWrapper((String)mis.get('Root_Cause_'+ i + '__c'), uipElementsMap.get((String)mis.get('Root_Cause_'+ i + '__c')).Name, uipElementsMap.get((String)mis.get('Root_Cause_'+ i + '__c')).Description__c));
                                existingRCIds.add((Id)mis.get('Root_Cause_'+ i + '__c'));
                            }
                        }
                    }
                }
            }
            populateIasList(selectedMisOption);
        }
    }
    
    public void populateIasList(String selectedMisOption) {
        String soql = SectionUtil.getFieldsQuery('Improvement_Action_Step__c');
        soql += ' FROM Improvement_Action_Step__c WHERE Major_Improvement_Strategy__c = \'' + selectedMisOption + '\' order by Position__c asc';
        iasList = Database.query(soql);
    }
    
    public Map<Id, List<IasWrapper>> getIasMap() {
        List<Improvement_Action_Step__c> iasList = [SELECT Id, Name, Current_Year_Timeline__c, Description_of_Action_Step__c, Implementation_Benchmarks__c,
                                                    Key_Personnel__c, Major_Improvement_Strategy__c, Next_Year_Timeline__c, Position__c, Resources__c, 
                                                    Root_Cause_1__c, Root_Cause_2__c, Root_Cause_3__c, Root_Cause_4__c, Root_Cause_5__c,
                                                    Start_Date__c, Status_of_Action_Step__c, Target_Date__c, UIP__c, School_Year__c
                                                    FROM Improvement_Action_Step__c WHERE Major_Improvement_Strategy__c IN :misMap.keySet() order by Start_Date__c, CreatedDate];
        Map<Id, List<IasWrapper>> iasMap = new Map<Id, List<IasWrapper>>();
        for (Improvement_Action_Step__c ias : iasList) {
            if (!iasMap.containsKey(ias.Major_Improvement_Strategy__c)) {
                iasMap.put(ias.Major_Improvement_Strategy__c, new List<IasWrapper>());
            }
            iasMap.get(ias.Major_Improvement_Strategy__c).add(new IasWrapper(ias, false, 'none'));
        }
        return iasMap;
    }
    
    public Map<Id, List<IbWrapper>> getIbMap() {
        List<Implementation_Benchmark__c> ibList = [SELECT Id, action_step__r.name, Name__c, Name, Description__c, Frequency__c, Key_Personel__c, School_Year__c, (select Id, name from Improvement_Action_Steps__r), Status__c, Start_Date__c, End_Date__c, Major_Improvement_Strategy__c, UIP__c
                                                    FROM Implementation_Benchmark__c WHERE Major_Improvement_Strategy__c IN :misMap.keySet() order by Start_Date__c, CreatedDate];
        Map<Id, List<IbWrapper>> ibMap = new Map<Id, List<IbWrapper>>();
        for (Implementation_Benchmark__c ib : ibList) {
            if (!ibMap.containsKey(ib.Major_Improvement_Strategy__c)) {
                ibMap.put(ib.Major_Improvement_Strategy__c, new List<IbWrapper>());
            }
            ibMap.get(ib.Major_Improvement_Strategy__c).add(new IbWrapper(ib, 'none'));
        }
        return ibMap;
    }
    
    public void SaveMisElem() {
        try {
            update misMap.values();
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            return;
        }
    }
    
    public List<SelectOption> getPIOptions() {
        List<SelectOption> options = new List<SelectOption>();
        for (Performance_Indicator_Notable_Trends__c pi : piList) {
            options.add(new SelectOption(pi.Id, pi.Performance_Indicator__c));
        }
        return options;
    }
    
    public PageReference BackUIPNarrative() {
        PageReference pageRef = new PageReference('/apex/Section3_UIP_Narrative?id=' + uip.Id);
        pageRef.setRedirect(true);
        return pageRef;
    }
    
    public PageReference NextBriefDescription() {
        PageReference pageRef = new PageReference('/apex/Section3_Brief_Description?id=' + uip.Id);
        pageRef.setRedirect(true);
        return pageRef;
    }
    
    public PageReference BackBriefDescription() {
        PageReference pageRef = new PageReference('/apex/Section3_Brief_Description?id=' + uip.Id);
        pageRef.setRedirect(true);
        return pageRef;
    }
    
    public PageReference NextPriorYearTargets() {
        PageReference pageRef = new PageReference('/apex/Section3_Prior_Year_Targets?id=' + uip.Id);
        pageRef.setRedirect(true);
        return pageRef;
    }
    
    public PageReference BackPriorYearTargets() {
        SaveReflexion();
        PageReference pageRef = new PageReference('/apex/Section3_Prior_Year_Targets?id=' + uip.Id);
        pageRef.setRedirect(true);
        return pageRef;
    }
    
    public PageReference NextCurrentPerformance() {
        PageReference pageRef = new PageReference('/apex/Section3_Current_Performance?id=' + uip.Id);
        pageRef.setRedirect(true);
        return pageRef;
    }
    
    public PageReference BackCurrentPerformance() {
        PageReference pageRef = new PageReference('/apex/Section3_Current_Performance?id=' + uip.Id);
        pageRef.setRedirect(true);
        return pageRef;
    }
    
    public PageReference NextTrendAnalysis() {
        PageReference pageRef = new PageReference('/apex/Section3_Trend_Analysis?id=' + uip.Id);
        pageRef.setRedirect(true);
        return pageRef;
    }
    
    public PageReference BackTrendAnalysis() {
        PageReference pageRef = new PageReference('/apex/Section3_Trend_Analysis?id=' + uip.Id);
        pageRef.setRedirect(true);
        return pageRef;
    }
    
    public PageReference NextPriorityPerformanceChallenges() {
        PageReference pageRef = new PageReference('/apex/Section3_Priority_Performance_Challenges?id=' + uip.Id);
        pageRef.setRedirect(true);
        return pageRef;
    }
    
    public PageReference BackPriorityPerformanceChallenges() {
        PageReference pageRef = new PageReference('/apex/Section3_Priority_Performance_Challenges?id=' + uip.Id);
        pageRef.setRedirect(true);
        return pageRef;
    }
    
    public PageReference NextPlanningForm() {
        PageReference pageRef = new PageReference('/apex/Section4_Planning_Form?id=' + uip.Id);
        pageRef.setRedirect(true);
        return pageRef;
    }
    
    
    public PageReference NextMajorImpStrategyForm() {
        PageReference pageRef = new PageReference('/apex/Section4_Major_Imp_Strategies_Form?id=' + uip.Id);
        pageRef.setRedirect(true);
        return pageRef;
    }
    
    public PageReference NextFullPlanForm() {
        PageReference pageRef = new PageReference('/apex/Section4_Full_Plan_Form?id=' + uip.Id);
        pageRef.setRedirect(true);
        return pageRef;
    }
    
    public PageReference BackSchoolTargetSetting() {
        PageReference pageRef = new PageReference('/apex/Section4_School_Target?id=' + uip.Id);
        pageRef.setRedirect(true);
        return pageRef;
    }
    
    public PageReference NextRootCauses() {
        PageReference pageRef = new PageReference('/apex/Section3_Root_Causes?id=' + uip.Id);
        pageRef.setRedirect(true);
        return pageRef;
    }
    
    public void updateUIP() {
        Save();
        try {
            update uip;
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            return;
        }
        selectUIP();
    }
    
    public void SaveReflexion() {
        try {
            update uip;
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            return;
        }
        selectUIP();
    }
    
    public PageReference DownloadWord_S3() {
        PageReference pageRef = new PageReference('/apex/Section3_UIP_Narrative_ExportWord');
        pageRef.getParameters().put('id', uip.Id);
        return pageRef;
    }
    
    public PageReference DownloadExcel_S4_PlanningForm() {
        PageReference pageRef = new PageReference('/apex/Section4_PlanningForm_ExcelDownload');
        pageRef.getParameters().put('id', uip.Id);
        return pageRef;
    }
    
    public PageReference DownloadExcel_S4_FullPlanForm() {
        PageReference pageRef = new PageReference('/apex/Section4_FullPlanForm_ExcelDownload');
        pageRef.getParameters().put('id', uip.Id);
        return pageRef;
    }
    
    public PageReference DownloadExcel_S4_SchoolTarget() {
        PageReference pageRef = new PageReference('/apex/Section4_SchoolTarget_ExcelDownload');
        pageRef.getParameters().put('id', uip.Id);
        return pageRef;
    }
    
    public void addPit() {
        elementValue = ApexPages.currentPage().getParameters().get('target');
        dummyPit = new Performance_Indicator_Targets__c();
        Id rtId = Schema.SObjectType.Performance_Indicator_Targets__c.getRecordTypeInfosByName().get('Prior Year Target').getRecordTypeId();
        dummyPit.RecordTypeId = rtId;
        dummyPit.UIP__c = currentId;
        dummyPit.Performance_Indicator__c = elementValue;
    }
    
    public void CancelNewPit() {
        elementValue = null;
    }
    
    public void SaveNewPit() {
        try {
            insert dummyPit;
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            return;
        }
        elementValue = null;
        populateTargets();
        selectUIP();
    }
    
    public void EditPit() {
        isEditPit = true;
        closeWindow = false;
    }
    
    public void CancelEditPit() {
        isEditPit = false;
    }
    
    public void SaveEditPit() {
        String pitId = ApexPages.currentPage().getParameters().get('pitId');
        String target = ApexPages.currentPage().getParameters().get('target');
        List<Performance_Indicator_Targets__c> pitListToSave = new List<Performance_Indicator_Targets__c>();
        for (Performance_Indicator_Targets__c pit : pitTargetsMap.get(target)) {
            if (pit.Id == pitId) {
                pitListToSave.add(pit);
                break;
            }
        }
        try {
            if (pitListToSave.size() > 0) {
                update pitListToSave;
            }
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            return;
        }
        isEditPit = false;
        populateTargets();
        selectUIP();
    }
    
    public void DeletePit() {
        String pitId = ApexPages.currentPage().getParameters().get('pitId');
        Performance_Indicator_Targets__c pitForDelete = [SELECT Id FROM Performance_Indicator_Targets__c WHERE Id = :pitId];
        try {
            delete pitForDelete;
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            return;
        }
        populateTargets();
    }
    
    public List<SelectOption> getYesNoList() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Yes', 'Yes'));
        options.add(new SelectOption('No', 'No'));
        return options;
    }
    
    public void addPint() {
        elementValue = ApexPages.currentPage().getParameters().get('target');
        dummyPint = new Performance_Indicator_Notable_Trends__c();
        Id rtId = Schema.SObjectType.Performance_Indicator_Notable_Trends__c.getRecordTypeInfosByName().get('Notable Trends').getRecordTypeId();
        dummyPint.RecordTypeId = rtId;
        dummyPint.UIP__c = currentId;
        dummyPint.Performance_Indicator__c = elementValue;
    }
    
    public void CancelNewPint() {
        elementValue = null;
    }
    
    public void SaveNewPint() {
        try {
            insert dummyPint;
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            return;
        }
        populateNotableTrends();
        elementValue = null;
    }
    
    public void EditPint() {
        isEditPint = true;
    }
    
    public void CancelEditPint() {
        isEditPint = false;
        populateNotableTrends();
    }
    
    public void SaveEditPint() {
        String pintId = ApexPages.currentPage().getParameters().get('pintId');
        String target = ApexPages.currentPage().getParameters().get('target');
        List<Performance_Indicator_Notable_Trends__c> pintListToSave = new List<Performance_Indicator_Notable_Trends__c>();
        for (Performance_Indicator_Notable_Trends__c pint : piNotableTrendsMap.get(target)) {
            if (pint.Id == pintId) {
                pintListToSave.add(pint);
                break;
            }
        }
        try {
            if (pintListToSave.size() > 0) {
                update pintListToSave;
            }
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            return;
        }
        isEditPint = false;
        populateNotableTrends();
    }
    
    public void DeletePint() {
        String pintId = ApexPages.currentPage().getParameters().get('pintId');
        Performance_Indicator_Notable_Trends__c pintForDelete = [SELECT Id FROM Performance_Indicator_Notable_Trends__c WHERE Id = :pintId];
        try {
            delete pintForDelete;
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            return;
        }
        populateNotableTrends();
    }
    
    public void addElem() {
        isExistingRC = false;
        elementValue = ApexPages.currentPage().getParameters().get('elemValue');
        dummyUipe = new UIP_Element__c();
        if (elementValue == 'Challenge') {
            dummyUipe.RecordTypeId = rtChallengeId;
        } else if (elementValue == 'Root Cause') {
            dummyUipe.RecordTypeId = rtRCId;
        } else if (elementValue == 'Mis') {
            dummyUipe.RecordTypeId = rtMISId;
        }
        dummyUipe.UIP__c = currentId;
    }
    
    public void CancelNewElem() {
        elementValue = null;
        populateUIPElem();
    }
    
    public void SaveNewElem() {
        try {
            insert dummyUipe;
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            return;
        }
        populateUIPElem();
        elementValue = null;
    }
    
    public void EditElem() {
        isEditElem = true;
    }
    
    public void EditElemx() {
        isEditElemx = true;
    }
    
    public void CancelEditElem() {
        isEditElem = false;
        populateUIPElem();
    }
    
    public void CancelEditElemx() {
        isEditElemx = false;
        populateUIPElem();
    }
    
    public void SaveEditRCElem() {
        String ElemId = ApexPages.currentPage().getParameters().get('ElemId');
        String challengeId = ApexPages.currentPage().getParameters().get('challengeId');
        List<UIP_Element__c> ElemListToSave = new List<UIP_Element__c>();
        for (UIP_Element__c rc : rcForChallengeMap.get(challengeId)) {
            if (rc.Id == elemId) {
                ElemListToSave.add(rc);
            }
        }
        try {
            if (ElemListToSave.size() > 0) {
                update ElemListToSave;
            }
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            return;
        }
        isEditElem = false;
        populateUIPElem();
    }
    
    public void SaveEditElem() {
        String ElemId = ApexPages.currentPage().getParameters().get('ElemId');
        List<UIP_Element__c> ElemListToSave = new List<UIP_Element__c>();
        ElemListToSave.add(uipElementsMap.get(ElemId));
        try {
            if (ElemListToSave.size() > 0) {
                update ElemListToSave;
            }
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            return;
        }
        isEditElem = false;
    }
    
    public void DeleteElem() {
        String ElemId = ApexPages.currentPage().getParameters().get('ElemId');
        List<UIP_Element__c> ElemForDelete = [SELECT Id FROM UIP_Element__c WHERE Id = :ElemId];
        try {
            if (ElemForDelete.size() > 0) {
                delete ElemForDelete;
            }
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            return;
        }
        populateUIPElem();
    }
    
    public void SaveNewRC() {
        String challengeId = ApexPages.currentPage().getParameters().get('challengeId');
        List<UIP_Element__c> elemList = [SELECT Id, Root_Cause_1__c, Root_Cause_2__c, Root_Cause_3__c, Root_Cause_4__c, Root_Cause_5__c,
                                         Root_Cause_6__c, Root_Cause_7__c, Root_Cause_8__c, Root_Cause_9__c, Challenge_1__c, Challenge_2__c,
                                         Challenge_3__c, Challenge_4__c, Challenge_5__c, Challenge_6__c, Challenge_7__c, Challenge_8__c, Challenge_9__c FROM UIP_Element__c WHERE Id = :challengeId OR Id = :choosedRC.get(challengeId)];
        if (isExistingRC) {
            for (UIP_Element__c elem : elemList) {
                if (elem.Id == challengeId) {
                    for (Integer i = 1; i <= MAX_UIP_ELEM; i++) {
                        if (elem.get('Root_Cause_' + i + '__c') == null) {
                            elem.put('Root_Cause_' + i + '__c', choosedRC.get(challengeId));
                            break;
                        }
                    }
                }
                if (elem.Id == choosedRC.get(challengeId)) {
                    for (Integer i = 1; i <= MAX_UIP_ELEM; i++) {
                        if (elem.get('Challenge_' + i + '__c') == null) {
                            elem.put('Challenge_' + i + '__c', challengeId);
                            break;
                        }
                    }
                }
            }
            try {
                update elemList;
            } catch (DMLException e) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
                return;
            }
        } else {
            dummyUipe.Challenge_1__c = challengeId;
            try {
                insert dummyUipe;
            } catch (DMLException e) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
                return;
            }
            for (UIP_Element__c elem : elemList) {
                if (elem.Id == challengeId) {
                    for (Integer i = 1; i <= MAX_UIP_ELEM; i++) {
                        if (elem.get('Root_Cause_' + i + '__c') == null) {
                            elem.put('Root_Cause_' + i + '__c', dummyUipe.Id);
                            break;
                        }
                    }
                }
            }
            try {
                update elemList;
            } catch (DMLException e) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
                return;
            }
        }
        populateUIPElem();
        elementValue = null;
    }
    
    public void SaveRcForMis() {
        String misId = ApexPages.currentPage().getParameters().get('misId');
        String choosedRcForMisId = '';
        for (MisWrapper mw : MisWrapperList) {
            if (mw.mis.Id == misId) {
                choosedRcForMisId = mw.choosedRC;
            }
        }
        List<UIP_Element__c> elemList = [SELECT Id, Root_Cause_1__c, Root_Cause_2__c, Root_Cause_3__c, Root_Cause_4__c, Root_Cause_5__c,
                                         Root_Cause_6__c, Root_Cause_7__c, Root_Cause_8__c, Root_Cause_9__c, Major_Improvement_Strategy_1__c, Major_Improvement_Strategy_2__c, Major_Improvement_Strategy_3__c,
                                         Major_Improvement_Strategy_4__c, Major_Improvement_Strategy_5__c, Major_Improvement_Strategy_6__c,
                                         Major_Improvement_Strategy_7__c, Major_Improvement_Strategy_8__c, Major_Improvement_Strategy_9__c
                                         FROM UIP_Element__c WHERE Id = :choosedRcForMisId OR Id = :misId];
        if (isExistingRC) {
            for (UIP_Element__c elem : elemList) {
                if (elem.Id == misId) {
                    for (Integer i = 1; i <= MAX_UIP_ELEM; i++) {
                        if (elem.get('Root_Cause_' + i + '__c') == null) {
                            elem.put('Root_Cause_' + i + '__c', choosedRcForMisId);
                            break;
                        }
                    }
                }
                if (elem.Id == choosedRcForMisId) {
                    for (Integer i = 1; i <= MAX_UIP_ELEM; i++) {
                        if (elem.get('Major_Improvement_Strategy_' + i + '__c') == null) {
                            elem.put('Major_Improvement_Strategy_' + i + '__c', misId);
                            break;
                        }
                    }
                }
            }
            try {
                update elemList;
            } catch (DMLException e) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
                return;
            }
        } 
        populateUIPElem();
        elementValue = null;
    }
    
    public void DeleteRC() {
        String elemId = ApexPages.currentPage().getParameters().get('elemId');
        String challengeId = ApexPages.currentPage().getParameters().get('challengeId');
        List<UIP_Element__c> uipElemList = [SELECT Id, Root_Cause_1__c, Root_Cause_2__c, Root_Cause_3__c, Root_Cause_4__c, Root_Cause_5__c, Root_Cause_6__c, Root_Cause_7__c, Root_Cause_8__c, Root_Cause_9__c, Challenge_1__c, Challenge_2__c,
                                            Challenge_3__c, Challenge_4__c, Challenge_5__c, Challenge_6__c, Challenge_7__c, Challenge_8__c, Challenge_9__c FROM UIP_Element__c WHERE Id = :challengeId OR Id = :elemId];
        for(UIP_Element__c elem : uipElemList) {
            if (elem.id == challengeId) {
                for (Integer i = 1; i <= MAX_UIP_ELEM; i++) {
                    if (elem.get('Root_Cause_' + i + '__c') == elemId) {
                        elem.put('Root_Cause_' + i + '__c', null);
                        break;
                    }
                }
            }
            if (elem.id == elemId) {
                for (Integer i = 1; i <= MAX_UIP_ELEM; i++) {
                    if (elem.get('Challenge_' + i + '__c') == challengeId) {
                        elem.put('Challenge_' + i + '__c', null);
                        break;
                    }
                }
            }
        }
        try {
            if (uipElemList.size() > 0) {
                update uipElemList;
            }
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            return;
        }
        
        populateUIPElem();
    }
    
    public void DeleteRcForMis() {
        String elemId = ApexPages.currentPage().getParameters().get('elemId');
        String misId = ApexPages.currentPage().getParameters().get('misId');
        List<UIP_Element__c> uipElemList = [SELECT Id, Root_Cause_1__c, Root_Cause_2__c, Root_Cause_3__c, Root_Cause_4__c, Root_Cause_5__c,
                                            Root_Cause_6__c, Root_Cause_7__c, Root_Cause_8__c, Root_Cause_9__c, Major_Improvement_Strategy_1__c, Major_Improvement_Strategy_2__c, Major_Improvement_Strategy_3__c,
                                            Major_Improvement_Strategy_4__c, Major_Improvement_Strategy_5__c, Major_Improvement_Strategy_6__c,
                                            Major_Improvement_Strategy_7__c, Major_Improvement_Strategy_8__c, Major_Improvement_Strategy_9__c
                                            FROM UIP_Element__c WHERE Id = :misId OR Id = :elemId];
        for(UIP_Element__c elem : uipElemList) {
            if (elem.id == misId) {
                for (Integer i = 1; i <= MAX_UIP_ELEM; i++) {
                    if (elem.get('Root_Cause_' + i + '__c') == elemId) {
                        elem.put('Root_Cause_' + i + '__c', null);
                        break;
                    }
                }
            }
            if (elem.id == elemId) {
                for (Integer i = 1; i <= MAX_UIP_ELEM; i++) {
                    if (elem.get('Major_Improvement_Strategy_' + i + '__c') == misId) {
                        elem.put('Major_Improvement_Strategy_' + i + '__c', null);
                        break;
                    }
                }
            }
        }
        try {
            if (uipElemList.size() > 0) {
                update uipElemList;
            }
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            return;
        }
        
        populateUIPElem();
    }
    
    public List<SelectOption> getRcForChallengeList() {
        String challengeId = ApexPages.currentPage().getParameters().get('challengeId');
        Set<Id> existingRC = new Set<Id>();
        if (rcForChallengeMap.containsKey(challengeId)) {
            for (UIP_Element__c elem : rcForChallengeMap.get(challengeId)) {
                existingRC.add(elem.Id);
            }
        }
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('', '-- None --'));
        for (Id elem : uipElementsMap.keySet()) {
            if (uipElementsMap.get(elem).RecordTypeId == rtRCId && !existingRC.contains(elem)) {
                options.add(new SelectOption(elem, uipElementsMap.get(elem).Name));
            }
        }
        return options;
    }
    
    public List<SelectOption> getChallengeForSchoolTargetList() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('', '-- None --'));
        for (Id elem : challengeMap.keySet()) {
            options.add(new SelectOption(elem, challengeMap.get(elem).Name));
        }
        return options;
    }
    
    public void associateElem() {
        isExistingRC = true;
        elementValue = ApexPages.currentPage().getParameters().get('elemValue');
        populateUIPElem();
    }
    
    public void SaveEditMisElem() {
        String elemId = ApexPages.currentPage().getParameters().get('elemId');
        String misId = ApexPages.currentPage().getParameters().get('misId');
        String rcDesc = ApexPages.currentPage().getParameters().get('rcDesc');
        List<UIP_Element__c> ElemListToSave = new List<UIP_Element__c>();
        for (MisWrapper mw : MisWrapperList) {
            if (mw.mis.Id == misId) {
                for (UipElemWrapper elemW : mw.rcForMisList) {
                    if (elemW.elem.Id == elemId) {
                        elemW.elem.Name = elemW.dummyElem.Name;
                        elemW.elem.Description__c = elemW.dummyElem.Description__c;
                        ElemListToSave.add(elemW.elem);
                        break;
                    }
                }
            }
        }
        try {
            if (ElemListToSave.size() > 0) {
                update ElemListToSave;
            }
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            return;
        }
        isEditElemx = false;
        populateUIPElem();
    }
    
    public void SaveEditSchoolTargetElem() {
        String thisYearId = ApexPages.currentPage().getParameters().get('thisYearId');
        String st = ApexPages.currentPage().getParameters().get('st');
        List<Performance_Indicator_Targets__c> piSchoolTargetToSaveList = new List<Performance_Indicator_Targets__c>();
        List<Performance_Indicator_Targets__c> piSchoolTargetToInsertList = new List<Performance_Indicator_Targets__c>();
        for (SchoolTargetWrapper stw : piSchoolTargetsMap.get(st)) {
            if (stw.thisYearST.Id == thisYearId) {
                piSchoolTargetToSaveList.add(stw.thisYearST);
                stw.nextYearST.Measures_Metrics2__c = stw.thisYearST.Measures_Metrics2__c;
                if (stw.nextYearST.Id != null) {
                    piSchoolTargetToSaveList.add(stw.nextYearST);
                } else {
                    stw.nextYearST.Performance_Indicator__c = st;
                    piSchoolTargetToInsertList.add(stw.nextYearST);
                }
            }
        }
        try {
            if (piSchoolTargetToInsertList.size() > 0) {
                insert piSchoolTargetToInsertList;
                piSchoolTargetToSaveList[0].Next_Year_Related_Target__c = piSchoolTargetToInsertList[0].Id;
            }
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            return;
        }
        try {
            if (piSchoolTargetToSaveList.size() > 0) {
                upsert piSchoolTargetToSaveList;
            }
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            return;
        }
        isEditElem = false;
        populateSchoolTargetsMap();
    }
    
    public void DeleteSchoolTargetElem() {
        String thisYearId = ApexPages.currentPage().getParameters().get('thisYearId');
        String nextYearId = ApexPages.currentPage().getParameters().get('nextYearId');
        List<Performance_Indicator_Targets__c> piSchoolTargetToDeleteList = [SELECT Id FROM Performance_Indicator_Targets__c WHERE Id = :thisYearId OR Id = :nextYearId];
        try {
            if (piSchoolTargetToDeleteList.size() > 0) {
                delete piSchoolTargetToDeleteList;
            }
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            return;
        }
        populateSchoolTargetsMap();
    }
    
    public void AddNewSchoolTarget() {
        elementValue = ApexPages.currentPage().getParameters().get('elementValue');
        dummyPit = new Performance_Indicator_Targets__c();
        Id rtId = Schema.SObjectType.Performance_Indicator_Targets__c.getRecordTypeInfosByName().get('This Year\'s Target').getRecordTypeId();
        dummyPit.RecordTypeId = rtId;
        dummyPit.UIP__c = currentId;
        dummyPit.Performance_Indicator__c = elementValue;
    }
    
    public void SaveNewSchoolTarget() {
        Performance_Indicator_Targets__c nextYearST = new Performance_Indicator_Targets__c();
        Id rtId = Schema.SObjectType.Performance_Indicator_Targets__c.getRecordTypeInfosByName().get('Next Year\'s Target').getRecordTypeId();
        nextYearST.RecordTypeId = rtId;
        nextYearST.UIP__c = dummyPit.UIP__c;
        nextYearST.Performance_Indicator__c = dummyPit.Performance_Indicator__c;
        nextYearST.Measures_Metrics2__c = dummyPit.Measures_Metrics2__c;
        nextYearST.Priority_Performance_Challenge_1__c = dummyPit.Priority_Performance_Challenge_1__c;
        nextYearST.Next_Year_Target_1__c = dummyPit.Next_Year_Target_1__c;
        dummyPit.Next_Year_Target_1__c = null;
        nextYearST.Interim_Measures_1__c = dummyPit.Interim_Measures_1__c;
        dummyPit.Interim_Measures_1__c = null;
        try {
            insert nextYearST;
            dummyPit.Next_Year_Related_Target__c = nextYearST.Id;
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            return;
        }
        try {
            insert dummyPit;
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            return;
        }
        elementValue = null;
        populateSchoolTargetsMap();
    }
    
    public void EditRTF() {
        isEditRTF = true;
        target = ApexPages.currentPage().getParameters().get('target');        
    }
    
    public PageReference nextAddenda() {
        Save();
        PageReference pageRef = new PageReference('/apex/' + addWPositionMap.get(addPosition).addURL + '?id=' + currentId);
        addendum = new Addendum__c();
        addendum = addWPositionMap.get(addPosition).addendum;
        if (addWPositionMap.get(addPosition).addendum.RecordType.Name == 'DIST ESEA Supporting Addendum') {
            selectSupportingAddenda(addWPositionMap.get(addPosition).addendum.Id);
        }
        pageRef.setRedirect(false);
        return pageRef;
    }
    
    public PageReference prevAddenda() {
        PageReference pageRef = new PageReference('/apex/' + addWPositionMap.get(addPosition).addURL + '?id=' + currentId);
        addendum = new Addendum__c();
        addendum = addWPositionMap.get(addPosition).addendum;
        if (addWPositionMap.get(addPosition).addendum.RecordType.Name == 'DIST ESEA Supporting Addendum') {
            selectSupportingAddenda(addWPositionMap.get(addPosition).addendum.Id);
        }
        pageRef.setRedirect(false);
        return pageRef;
    }
    
    public class AddendumWrapper {
        public Addendum__c addendum { get; set; }
        public Integer position { get; set; }
        public String addURL { get; set; }
        public String schoolName { get; set; }
        
        public AddendumWrapper(Addendum__c addendum, Integer position) {
            this.addendum = addendum;
            this.position = position;
        }
    }
    
    public class MisWrapper {
        public UIP_Element__c mis { get; set; }
        public List<UipElemWrapper> rcForMisList { get; set; }
        public List<SelectOption> rcForMisOptionList { get; set; }
        public String choosedRC { get; set; }
        public List<IasWrapper> iasList { get; set; }
        public IasWrapper dummyIasWrapper { get; set; }
        public List<IbWrapper> ibList { get; set; }
        public IbWrapper dummyIbWrapper { get; set; }
        
        public MisWrapper(UIP_Element__c mis, List<UipElemWrapper> rcForMisList, List<SelectOption> rcForMisOptionList, List<IasWrapper> iasList, IasWrapper dummyIasWrapper, List<IbWrapper> ibList, IbWrapper dummyIbWrapper) {
            this.mis = mis;
            this.rcForMisList = rcForMisList;
            this.rcForMisOptionList = rcForMisOptionList;
            this.iasList = iasList;
            this.dummyIasWrapper = dummyIasWrapper;
            this.ibList = ibList;
            this.dummyIbWrapper = dummyIbWrapper;           
        }        
        public MisWrapper() {           
        }
    }
    
    public class IasWrapper {
        public Improvement_Action_Step__c ias { get; set; }
        public boolean isCollapsed { get; set; }
        public String finalDivClass { get; set; }
        
        public String Start_Date {
            get {
                String stringDate = '';
                if (ias.Start_Date__c != null) {
                    stringDate = ias.Start_Date__c.format();
                }
                return stringDate;
            }
            set {
                if (value == '' || value == null) {
                    ias.Start_Date__c = null;
                } else {
                    ias.Start_Date__c = SectionUtil.getDate(value);
                }
            }
        }
        
        public String Target_Date {
            get {
                String stringDate = '';
                if (ias.Target_Date__c != null) {
                    stringDate = ias.Target_Date__c.format();
                }
                return stringDate;
            }
            set {
                if (value == '' || value == null) {
                    ias.Target_Date__c = null;
                } else {
                    ias.Target_Date__c = SectionUtil.getDate(value);
                }
            }
        }
        
        public IasWrapper(Improvement_Action_Step__c ias, boolean isCollapsed, String finalDivClass) {
            this.ias = ias;
            this.isCollapsed = isCollapsed;
            this.finalDivClass = finalDivClass;
        }
        public IasWrapper() {}
    } 
    
    public class SchoolTargetWrapper {
        public Performance_Indicator_Targets__c thisYearST { get; set; }
        public Performance_Indicator_Targets__c nextYearST { get; set; }
        
        public SchoolTargetWrapper(Performance_Indicator_Targets__c thisYearST, Performance_Indicator_Targets__c nextYearST) {
            this.thisYearST = thisYearST;
            this.nextYearST = nextYearST;
        }
    }
    
    public class UipElemWrapper {
        public UIP_Element__c elem { get; set; }
        public UIP_Element__c dummyElem { get; set; }
        public UipElemWrapper(UIP_Element__c elem) {
            this.elem = elem;
            this.dummyElem = new UIP_Element__c();
            if(elem != null){ this.dummyElem = elem.clone(false, true); }
        }
    }
    
    public class ElemWrapper {
        public String elemId { get; set; }
        public String elemName { get; set; }
        public String elemDesc { get; set; }
        public String elemMis { get; set; }
        public UIP_Element__c uipElem { get; set; }
        
        public ElemWrapper(String eid, String eName, String eDesc) {
            this.elemId = eId;
            this.elemName = eName;
            this.elemDesc = eDesc;
        }
    }
    
    public class IbWrapper {
        
        public Implementation_Benchmark__c ib { get; set; }
        public Integer ibRecCount { get; set; }
        public String finalIbDivClass { get; set; }
        
        public String Start_Date {
            get {
                String stringDate = '';
                if (ib.Start_Date__c != null) {
                    stringDate = ib.Start_Date__c.format();
                }
                return stringDate;
            }
            set {
                if (value == '' || value == null) {
                    ib.Start_Date__c = null;
                } else {
                    ib.Start_Date__c = SectionUtil.getDate(value);
                }
            }
        }
        
        public String End_Date {
            get {
                String stringDate = '';
                if (ib.End_Date__c != null) {
                    stringDate = ib.End_Date__c.format();
                }
                return stringDate;
            }
            set {
                if (value == '' || value == null) {
                    ib.End_Date__c = null;
                } else {
                    ib.End_Date__c = SectionUtil.getDate(value);
                }
            }
        }
        
        public IbWrapper (Implementation_Benchmark__c ib, String finalIbDivClass) {
            this.ib = ib;
            this.finalIbDivClass = finalIbDivClass;
        }
        
        public IbWrapper() {}
    }
    
    public void toggleIas() {
        String misId = ApexPages.currentPage().getParameters().get('misId');
        String iasId = ApexPages.currentPage().getParameters().get('iasId');
        for (MisWrapper mw : MisWrapperList) {
            if (mw.mis.Id == misId) {
                for (IasWrapper iasW : mw.iasList) {
                    if (iasW.ias.Id == iasId) {
                        if (iasW.isCollapsed) {
                            iasW.isCollapsed = false;
                        } else {
                            iasW.isCollapsed = true;
                        }
                        break;
                    }
                }
            }
        }
    }
    
    public void AddNewIasRow() {
        if(genericList!=null)
        {
            MisWrapper currentMisWrapper;
            editableIBNameselectList = true;        
            if(genericList!=null && genericList.size() >0 )
                currentMisWrapper = genericList.get(0);
            Improvement_Action_Step__c iasObj = new Improvement_Action_Step__c();
            IasWrapper iasWrap = new IasWrapper(iasObj, false, 'none');
            iasWrap.ias = iasObj;                    
            currentMisWrapper.dummyIasWrapper = iasWrap;
            List<IasWrapper> iasList;
            if(currentMisWrapper!=null && currentMisWrapper.iasList ==null)
            {
                iasList = new List<IasWrapper>();
                iasList.add(iasWrap);
                currentMisWrapper.iasList = iasList;
            }
            else{
                iasList = currentMisWrapper.iasList;
                iasList.add(iasWrap);
                currentMisWrapper.iasList = iasList;
            }
            dispIasButton = false;
            isIasUpdateRecord = false; 
            nameOption =new List<SelectOption>();
            genericList = fullGenericList.get(this.paginater.index);
            if(genericList!=null && genericList.size() >0 ) {
                if(genericList.get(0).ibList != null)
                {                   
                    nameOption.add(new SelectOption('','-- None --'));
                    for(Ibwrapper rec : genericList.get(0).ibList) 
                    {    
                        if(rec!=null && rec.ib!=null && rec.ib.id!=null)               
                            nameOption.add(new SelectOption(rec.ib.id, rec.ib.name));
                    }
                }
            }        
            else
            {
                List<SElectOption> nameOption = new List<SElectOption>();
            }
        }
    }
    
    public void EditIasRow()
    {
        editIasRecId = ApexPages.currentPage().getParameters().get('editIasRecId');
        isIasUpdateRecord = true;
        dispIasButton = false;
        editableIBNameselectList = true;
        nameOption =new List<SelectOption>();        
        if(genericList!=null && genericList.size() >0 ) {
            if(genericList.get(0).ibList != null)
            {   
                nameOption.add(new SelectOption('','-- None --'));
                for(Ibwrapper rec : genericList.get(0).ibList)
                {     
                    if(rec!=null && rec.ib!=null && rec.ib.id!=null)               
                        nameOption.add(new SelectOption(rec.ib.id, rec.ib.name));
                }
            }
        }        
        else
        {
            List<SElectOption> nameOption = new List<SElectOption>();
        }
        UpdateIasRecord();
        populateOrder();
    }
    
    public void UpdateIasRecord()
    {
        updateIasRecId = ApexPages.currentPage().getParameters().get('editIasRecId');
        if(updateIasRecId==null)
        {
            updateIasRecId = ApexPages.currentPage().getParameters().get('updateIasRecId');                
            dispiasbutton=true;
        }
        else
            selectedRecNameId = '';
        List<Improvement_Action_Step__c> targetUpdateList = new List<Improvement_Action_Step__c>();   
        String actionStepOldName = [select Id,name from  Improvement_Action_Step__c where id=:updateIasRecId limit 1 ].name; 
        String actionStepNewName='';
        Boolean flag = false;
        for (MisWrapper misWrap : genericList) 
        {
            if (misWrap.iasList != null) {
                for(IasWrapper iasWrap : misWrap.iasList)
                {
                    if(iasWrap.ias.id == updateIasRecId)
                    {
                        if(iasWrap.ias.name!=actionStepoldName)
                        {
                            actionStepNewName=iasWrap.ias.name;
                            flag=true;
                        }   
                        if(selectedRecNameId!=null)
                        {
                            selectedRecNameId = selectedRecNameId.replace(']','');
                            selectedRecNameId = selectedRecNameId.replace('[','');
                        }
                        if(flag)
                            updateActionStepNameRecords(actionStepOldName,actionStepNewName);   
                        
                        if(selectedRecNameId!=null && selectedRecNameId!='')
                            updateRecords(updateIasRecId,selectedRecNameId);
                        targetUpdateList.add(iasWrap.ias);
                        break;
                    }
                    else if (selectedRecNameId =='')
                        targetUpdateList.add(iasWrap.ias);
                }  
            }
        }
        if(targetUpdateList!=null && targetUpdateList.size() >0) 
        {
            update targetUpdateList;
            populateUIPElem(); 
            addMisWrapperListToPagination();
        }
        fillBenchMarkMap1();
        fillMapwithBenchMarkList();
    }
    
    public void updateRecords(String ationStepRecordId,String benchmarkIds)
    {
        set<Id> benchmMarkIdSet  = new set<Id>();
        List<Implementation_Benchmark__c> targetUpdateList = new List<Implementation_Benchmark__c>();
        String[] values = selectedRecNameId.split(',');
        for(String s:values)
        {
            s=s.trim(); 
            if(s!='')
                benchmMarkIdSet.add(s);
        }        
        List<Implementation_Benchmark__c>  benchMarKList = [select Id, Action_Step__c from Implementation_Benchmark__c where id in :benchmMarkIdSet];
        Improvement_Action_Step__c existingActionStep = [select Id,name from Improvement_Action_Step__c where id=:ationStepRecordId limit 1];
        List<Improvement_Action_Step__c> actionStepRecsInsertList = new List<Improvement_Action_Step__c>();
        List<BenchMar_AtciontStep__c> actionBenchList = new List<BenchMar_AtciontStep__c>();
        for(Integer i=0;i<benchMarKList.size();i++)
        {
            if(existsActionStep(ationStepRecordId,benchMarKList.get(i).id))
            {
                BenchMar_AtciontStep__c istep = new BenchMar_AtciontStep__c();
                istep.Implementation_Benchmark__c = benchmarklist.get(i).id;
                istep.Improvement_Action_Step__c = ationStepRecordId;
                actionBenchList.add(istep);
            } 
        }
        if(actionBenchList!=null && actionBenchList.size()>0)
        {
            database.insert(actionBenchList);
        }
    }
    
    public boolean existsActionStep(String actoinStepRecId,String benchMarkId)
    {
        
        List<BenchMar_AtciontStep__c> actionBenchList = new List<BenchMar_AtciontStep__c>();
        actionBenchList = [select Id from BenchMar_AtciontStep__c where Implementation_Benchmark__c=:benchMarkId and Improvement_Action_Step__c=:actoinStepRecId];
        if(actionBenchList!=null && actionBenchList.size()>0)
            return false;
        else
            return true;
    }
    
    public void updateActionStepNameRecords(String oldname,String newName)
    {
        List<Improvement_Action_Step__c> actionStepBeforeList = [select Id,name,(select Id,name from Implementation_Benchmarks__r) from Improvement_Action_Step__c where name=:oldName];
        List<Improvement_Action_Step__c> actionStepAfterList = new List<Improvement_Action_Step__c>();
        if(actionStepBeforeList!=null && actionStepBeforeList.size()>0)
        {
            for(Improvement_Action_Step__c actionStepRec:actionStepBeforeList)
            {
                actionStepRec.name = newName;
                actionStepAfterList.add(actionStepRec);
            }
        }
        if(actionStepAfterList.size()>0)
        {
            database.update(actionStepAfterList);
        }
    }
    
    public void DeleteIasRow()
    {
        deleteRecId=ApexPages.currentPage().getParameters().get('deleteIasRecId');
        if(deleteIasRecId!=null)
        {
            Improvement_Action_Step__c deleteIas =[select Id from Improvement_Action_Step__c  where id=:deleteIasRecId limit 1];
            delete deleteIas;
            populateUIPElem();
        }
    }
    
    public void SaveNewIas() {
        MisWrapper currentMisWrapper = genericList.get(0);   
        String misId =  currentMisWrapper.mis.id;
        List<Improvement_Action_Step__c> iasForSave = new List<Improvement_Action_Step__c>();
        for (MisWrapper mw : genericList) {
            if (mw.mis.Id == misId) {
                mw.dummyIasWrapper.ias.Major_Improvement_Strategy__c = misId;
                mw.dummyIasWrapper.ias.UIP__c = currentId;
                if(selectedRecNameId!='' && selectedRecNameId!=NULL) 
                {
                    selectedRecNameId = selectedRecNameId.replace(']','');
                    selectedRecNameId = selectedRecNameId.replace('[','');
                }
                if(selectedRecNameId!='') 
                {
                    iasForSave.add(mw.dummyIasWrapper.ias);
                }
                else if (selectedRecNameId =='')
                    iasForSave.add(mw.dummyIasWrapper.ias);
            }
        }
        try {
            if (iasForSave.size() > 0) {
                insert iasForSave;
                if(selectedRecNameId!=''  && selectedRecNameId!=NULL) 
                {
                    saveRecords(iasForSave.get(0), selectedRecNameId);
                }
                else
                {
                    BenchMar_AtciontStep__c istep = new BenchMar_AtciontStep__c();
                    istep.Improvement_Action_Step__c = iasForSave.get(0).Id;
                    database.insert(istep);
                }                 
                editableIBNameselectList =false;
            }
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            return;
        }
        elementValue = null;
        populateUIPElem();
        dispIasButton =true;
        dispButton = true;
        if(iasForSave.get(0).Id!=Null)
            saveorder(iasForSave.get(0).Id);
        fillBenchMarkMap1();
        fillMapwithBenchMarkList();
        addMisWrapperListToPagination();
        populateOrder();
    }
    
    public void saveRecords(Improvement_Action_Step__c iasDummyWrapper, String benchmarkIds)
    {
        set<Id> benchmMarkIdSet  = new set<Id>();
        List<Implementation_Benchmark__c> targetUpdateList = new List<Implementation_Benchmark__c>();
        String[] values;
        if(selectedRecNameId!='' && selectedRecNameId!=NULL)
        {
            values = selectedRecNameId.split(',');
        }
        for(String s:values)
        {
            s=s.trim(); 
            if(s!='')
                benchmMarkIdSet.add(s);
        }
        List<Implementation_Benchmark__c>  benchMarKList = [select Id, Action_Step__c from Implementation_Benchmark__c where id in :benchmMarkIdSet];    
        List<Improvement_Action_Step__c> actionStepRecsInsertList = new List<Improvement_Action_Step__c>();
        List<BenchMar_AtciontStep__c> actionBenchList = new List<BenchMar_AtciontStep__c>();
        for(Integer i=0;i<benchmarklist.size();i++)
        {
            BenchMar_AtciontStep__c istep = new BenchMar_AtciontStep__c();
            istep.Implementation_Benchmark__c = benchmarklist.get(i).id;
            istep.Improvement_Action_Step__c = iasDummyWrapper.Id;
            actionBenchList.add(istep);
        }
        if(actionBenchList!=null && actionBenchList.size()>0)
        {
            database.insert(actionBenchList);
        }   
    }
    
    public void SaveEditIas() {
        String misId = ApexPages.currentPage().getParameters().get('misId');
        String iasId = ApexPages.currentPage().getParameters().get('iasId');
        List<Improvement_Action_Step__c> iasForSave = new List<Improvement_Action_Step__c>();
        for (MisWrapper mw : MisWrapperList) {
            if (mw.mis.Id == misId) {
                for (IasWrapper iasW : mw.iasList) {
                    if (iasW.ias.Id == iasId) {
                        iasForSave.add(iasW.ias);
                    }
                }
            }
        }
        try {
            if (iasForSave.size() > 0) {
                update iasForSave;
            }
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            return;
        }
        isEditElemx = false;
        populateUIPElem();
    }
    
    public void DeleteIasForMis() {
        String misId = ApexPages.currentPage().getParameters().get('misId');
        String deleteIasRecId = ApexPages.currentPage().getParameters().get('deleteIasRecId');
        List<Improvement_Action_Step__c> iasForDelete = new List<Improvement_Action_Step__c>();
        for (MisWrapper mw : genericList) {
            if (mw.mis.Id == misId) {
                for (IasWrapper iasW : mw.iasList) {
                    if (iasW.ias.Id == deleteIasRecId) {
                        iasForDelete.add(iasW.ias);
                    }
                }
            }
        }
        try {
            if (iasForDelete.size() > 0) {  
                deleteAssociatedBenchMark(deleteIasRecId); 
            }
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            return;
        }
        isEditElem = false;
        populateUIPElem();
        fillBenchMarkMap1();
        fillMapwithBenchMarkList();
        addMisWrapperListToPagination(); 
        populateOrder();
    }
    
    public void deleteAssociatedBenchMark(String deleteIasRecId)
    {
        Improvement_Action_Step__c actionStep = [select Id,name from Improvement_Action_Step__c where id=:deleteIasRecId];
        List<Improvement_Action_Step__c> actionStepList = [select Id from Improvement_Action_Step__c where name=:actionStep.name];
        List<Implementation_Benchmark__c> benchmarkList = [select Id,Action_Step__c from Implementation_Benchmark__c where Action_Step__r.name=:actionStep.name];
        List<Implementation_Benchmark__c> updateList = new List<Implementation_Benchmark__c>();
        for(Integer i=0;i<benchmarkList.size();i++)
        {
            benchmarkList.get(i).Action_Step__c=null;
            updateList.add(benchmarkList.get(i));
        }
        if(updateList!=null && updateList.size()>0)
        {
            database.update(updateList);
        }
        if(actionStepList!=null && actionStepList.size()>0)
        {
            database.delete(actionStepList);
        }
    }
    
    public void SaveNewIb() {
        MisWrapper currentMisWrapper = genericList.get(0);        
        String misId =  currentMisWrapper.mis.id;
        List<Implementation_Benchmark__c> ibForSave = new List<Implementation_Benchmark__c>();
        for (MisWrapper mw : genericList) {
            if (mw.mis.Id == misId) {               
                mw.dummyIbWrapper.ib.Major_Improvement_Strategy__c = misId;
                mw.dummyIbWrapper.ib.UIP__c = currentId;
                ibForSave.add(mw.dummyIbWrapper.ib);
            }
            else
            {
                mw.dummyIbWrapper.ib.Major_Improvement_Strategy__c = misId;
                mw.dummyIbWrapper.ib.UIP__c = currentId;
                if(mw.dummyIbWrapper.ib.id == null || mw.dummyIbWrapper.ib.id == '')
                    ibForSave.add(mw.dummyIbWrapper.ib);
            }
        }
        try {
            if (ibForSave.size() > 0) {                
                insert ibForSave;
                BenchMar_AtciontStep__c istep = new BenchMar_AtciontStep__c();
                istep.Implementation_Benchmark__c = ibForSave.get(0).id;
                database.insert(istep);
                fillBenchMarkMap1();
            }
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            return;
        }
        if(ibForSave.get(0).Id!=Null)
            saveorderIB(ibForSave.get(0).Id);
        elementValue = null;
        populateUIPElem();
        addMisWrapperListToPagination();
        fillMapwithBenchMarkList();
        dispButton =true;
        dispIasButton = true;
        populateOrderIB();
    }
    
    public void addRow()
    {
        if(genericList!=null)
        {
            MisWrapper currentMisWrapper = genericList.get(0); 
            Implementation_Benchmark__c obj = new Implementation_Benchmark__c();            
            IbWrapper wrapIb = new IbWrapper();
            wrapIb.ib = obj;
            currentMisWrapper.dummyIbWrapper=wrapIb;
            List<IbWrapper> ibList;
            if(currentMisWrapper!=null && currentMisWrapper.ibList ==null)
            {
                ibList = new List<IbWrapper>();
                ibList.add(wrapIb);
                currentMisWrapper.ibList = ibList;
            }
            else{
                ibList = currentMisWrapper.ibList;
                ibList.add(wrapIb);
                currentMisWrapper.ibList = ibList;
            }
            isupdateRecord = false;
            dispButton = false;                        
        }   
    }
    
    public void editRow()
    {
        editRecId = ApexPages.currentPage().getParameters().get('editRecId');
        dispButton = false;
        isupdateRecord = true;
        updateRecord();
    }
    
    public void updateRecord()
    {
        updateRecId = ApexPages.currentPage().getParameters().get('updateRecId');
        if (updateRecId==null)
        {
            dispButton = false;
        }
        else
        {
            dispButton = true;
        }
        List<Implementation_Benchmark__c> targetUpdateList = new List<Implementation_Benchmark__c>();       
        for (MisWrapper mw : genericList) 
        {
            if (mw.ibList != null) {
                for(IbWrapper wrap:mw.ibList)
                {
                    if(wrap.ib.id==updateRecId)
                    {
                        targetUpdateList.add(wrap.ib);
                        break;
                    }             
                }    
            }
        }
        if(targetUpdateList!=null && targetUpdateList.size() >0) 
        {
            update targetUpdateList;
            populateUIPElem();
            addMisWrapperListToPagination();
            populateOrderIB();
        }
    }   
    
    public void deleteRow()
    {
        deleteRecId=ApexPages.currentPage().getParameters().get('deleteRecId');
        if(deleteRecId!=null)
        {
            Implementation_Benchmark__c deleteMe =[select Id from Implementation_Benchmark__c  where id=:deleteRecId limit 1];
            delete deleteMe;
            populateUIPElem();
            addMisWrapperListToPagination();
            populateOrderIB();
        }
    }
    
    public PageReference previousPage()
    { 
        if(this.paginater.index >0 ){ i--; this.paginater.decrement(); }        
        pageDiff = paginater.totalPage - paginater.pagenum;
        viewpage = paginater.pagenum +' - '+ pageDiff +' of '+paginater.totalPage;
        callIbIasRefresh();
        return changeData();
    }
    
    public PageReference nextPage()
    {
        i++;
        this.paginater.increment();
        pageDiff = paginater.totalPage - paginater.pagenum;
        viewpage = paginater.pagenum +'-'+ pageDiff +'of'+paginater.totalPage;
        callIbIasRefresh();
        return changeData();
    }
    
    public PageReference changeData() { 
        
        if(this.paginater.index >0 ) { Integer x = this.paginater.index; this.genericList = this.fullGenericList.get(--x); }
        else { this.genericList = this.fullGenericList.get(this.paginater.index); }
        System.debug('in changeData');
        System.debug('fullGenericList.get(this.paginater.index) '+this.paginater.index);
        System.debug('fullGenericList '+fullGenericList);        
        populateOrder();
        populateOrderIB();
        return null;
    }
    
    public PageReference updatePage()
    { 
        this.paginater.updateNumbers();
        return changeData();
    }    
    
    public void addMisWrapperListToPagination()
    {
        pageSize = 1;
        if(MisWrapperList.size()>0)
        {
            if(paginater==null)
                paginater = new Paginate(MisWrapperList.size(), pageSize);
            fullGenericList = new List<List<MisWrapper>>();
            genericList = new List<MisWrapper>();
            if(misWrapperList.size() > 0)
            {
                List<MisWrapper> tempCC = new List<MisWrapper>();        
                Integer i = 0;
                for(MisWrapper cc : misWrapperList)
                {
                    tempCC.add(cc);
                    i++;
                    if(i == pageSize){
                        this.fullGenericList.add(tempCC);
                        tempCC = new List<MisWrapper>();
                        i = 0;                        
                    }
                }
                if(!tempCC.isEmpty())
                {
                    fullGenericList.add(tempCC);
                }
                genericList = fullGenericList.get(this.paginater.index);
                pageDiff = paginater.totalPage - paginater.pagenum;
                viewpage = paginater.pagenum +' - '+ pageDiff +' of '+paginater.totalPage;
                callIbIasRefresh();
            } 
        }
    }
    
    public List<SelectOption> getFromMonths() 
    {
        map<String,String> mapMonths=new  map<String,String>();   
        mapMonths.put('8','August');
        mapMonths.put('9','September');
        mapMonths.put('10','October');
        mapMonths.put('11','November');
        mapMonths.put('12','December');
        mapMonths.put('1','January');
        mapMonths.put('2','Febuary');
        mapMonths.put('3','March');
        mapMonths.put('4','April');
        mapMonths.put('5','May');
        mapMonths.put('6','June');
        mapMonths.put('7','July');
        for(String key:mapMonths.keyset())
        {
            fromMonthsOption.add(new SelectOption(key,mapMonths.get(key)));
        } 
        return  fromMonthsOption;
    }
    
    public List<SelectOption> getToMonths() 
    {
        map<String,String> mapMonths=new  map<String,String>();   
        mapMonths.put('7','July');
        mapMonths.put('8','August');
        mapMonths.put('9','September');
        mapMonths.put('10','October');
        mapMonths.put('11','November');
        mapMonths.put('12','December');
        mapMonths.put('1','January');
        mapMonths.put('2','Febuary');
        mapMonths.put('3','March');
        mapMonths.put('4','April');
        mapMonths.put('5','May');
        mapMonths.put('6','June');
        for(String key:mapMonths.keyset())
        {
            toMonthsOption.add(new SelectOption(key,mapMonths.get(key)));
        }
        return  toMonthsOption;
    }
    
    public void cancelRow()
    { 
        editRecId = ApexPages.currentPage().getParameters().get('editRecId');
        editRecId='';
        isupdateRecord = false;
        if(genericList!=null)
        {   
            MisWrapper currentMisWrapper = genericList.get(0); 
            List <IbWrapper> ibList = currentMisWrapper.ibList; 
            for (Integer i = (ibList.size() - 1) ; i>=0; i--) { 
                if (ibList[i].ib.id == null) {
                    ibList[i].ib = null;
                    ibList.remove(i);                               
                }
            }
            populateUIPElem();
            addMisWrapperListToPagination();
            populateOrderIB();
            dispButton = true;
            dispIasButton = true;
        }
    }
    
    public List<SelectOption> getYears() 
    {     
        yearsOption.add(new SelectOption('-- None --','-- None --'));
        yearsOption.add(new SelectOption('thisSchoolYear','This School Year'));
        yearsOption.add(new SelectOption('nextSchoolYear', 'Next School Year'));
        return  yearsOption;
    }
    
    public void show()
    {
        if(genericList!=null  && fullGenericList!=null && paginater!=null) {
            this.genericList = this.fullGenericList.get(this.paginater.index);
            if(genericList!=null && genericList.size()>0)
            {
                System.debug('genericList[0].ibList '+genericList);
                List<IBWrapper> impBenchMarkList = genericList[0].ibList;
                if(impBenchMarkList!=null && impBenchMarkList.size()>0)
                {
                    for(IBWrapper impBmark :impBenchMarkList)
                    {
                        if(impBmark!=null)
                            bmarkList.add(impBmark);
                    }
                }
                List<IasWrapper> iasList = genericList[0].iasList;            
                if(iasList !=null && iasList .size()>0)
                {
                    for(IasWrapper iasr :iasList )
                    {
                        if(iasr !=null)
                            actionStepList.add(iasr);
                    }
                }
            }
        }   
    }     
    
    public Date setStringToDateFormat(String myDate) {
        String[] myDateOnly = myDate.split(' ');
        String[] strDate = myDateOnly[0].split('/');
        Integer myIntDate = integer.valueOf(strDate[1]);
        Integer myIntMonth = integer.valueOf(strDate[0]);
        Integer myIntYear = integer.valueOf(strDate[2]);
        Date d = Date.newInstance(myIntYear, myIntMonth, myIntDate);
        return d;
    }
    
    public void selectedYearIbWrapper() {       
        Date startDate; 
        Date endDate;
        String currentAcademicYearStartDate;
        String currentAcademicYearEndDate;
        if (selectedYear == 'thisSchoolYear') { 
            currentAcademicYearStartDate = '07/31/2015 11:59:00 PM';
            currentAcademicYearEndDate = '08/01/2016 11:59:00 PM';
            startDate = setStringToDateFormat(currentAcademicYearStartDate);
            endDate = setStringToDateFormat(currentAcademicYearEndDate);   
            if (genericList != null && fullGenericList != null && paginater != null) {
                IbGanttChart(startDate, endDate, currentAcademicYearStartDate, currentAcademicYearEndDate);
            }            
        }
        else if (selectedYear == 'nextSchoolYear')
        {
            currentAcademicYearStartDate = '07/31/2016 11:59:00 PM';
            currentAcademicYearEndDate = '08/01/2017 11:59:00 PM';
            startDate = setStringToDateFormat(currentAcademicYearStartDate);
            endDate = setStringToDateFormat(currentAcademicYearEndDate); 
            if (genericList != null && fullGenericList != null && paginater != null) {
                IbGanttChart(startDate, endDate, currentAcademicYearStartDate, currentAcademicYearEndDate);
            }               
        }               
    }   
    
    public void IbGanttChart(Date startDate, Date endDate, String currentAcademicYearStartDate, String currentAcademicYearEndDate) {
        String currentYear;
        String nextYear;
        Integer differenceInMonth;
        Integer differenceInYear;
        Integer ibStartMonth;
        Integer ibEndMonth;
        Integer ibStartYear;
        Integer ibEndYear;
        String dynamicDiv;
        String dynamicOffset;
        String fixedbgColor;
        String finalIbDivClass;
        filterIbList = new List<IbWrapper>();
        if (genericList != null && fullGenericList != null && paginater != null) {
            this.genericList = this.fullGenericList.get(this.paginater.index);
            if (genericList != null && genericList.size() > 0) { 
                List<IbWrapper> ibList = genericList[0].ibList;
                List<IbWrapper> ibListThisYear = new List<IbWrapper> ();
                if(ibList !=null && ibList .size()>0) {
                    for (IbWrapper ibWrapper : ibList) { 
                        if (ibWrapper.ib.Start_Date__c != null && ibWrapper.ib.End_Date__c != null && ibWrapper.ib.Start_Date__c > startDate && ibWrapper.ib.End_Date__c < endDate &&
                            ibWrapper.ib.Start_Date__c <= ibWrapper.ib.End_Date__c)
                        {                                                               
                            ibListThisYear.add(ibWrapper);                                                  
                        }       
                    }
                    for(IbWrapper ibr : ibListThisYear )    {
                        dynamicDiv =  'col-xs-';
                        dynamicOffset = 'col-xs-offset-';
                        fixedbgColor = 'action bg-success';
                        finalIbDivClass = 'none';
                        ibStartMonth = ibr.ib.Start_Date__c.month();
                        ibEndMonth = ibr.ib.End_Date__c.month();
                        ibStartYear = ibr.ib.Start_Date__c.year();
                        ibEndYear = ibr.ib.End_Date__c.year();
                        if (ibStartYear == startDate.year())
                        {
                            differenceInYear = ibEndYear - ibStartYear;
                            differenceInMonth = (differenceInYear * 12) + (ibEndMonth - ibStartMonth) + 1;
                            Integer offset = ibStartMonth - 8;
                            if(ibr.ib.Start_Date__c == ibr.ib.End_Date__c)
                            {
                                dynamicDiv = dynamicDiv + '1';
                            }
                            else if(differenceInMonth == 0)
                            {
                                dynamicDiv = dynamicDiv + '1';
                            }
                            else
                            {
                                dynamicDiv = dynamicDiv + differenceInMonth;
                            }
                            dynamicOffset = dynamicOffset + offset; 
                            finalIbDivClass = dynamicDiv + ' ' + dynamicOffset + ' ' + fixedbgColor; 
                        }                                                       
                        else if ((ibStartYear == endDate.year()) && (ibEndYear <= endDate.year()))                                                  
                        {
                            differenceInYear = ibEndYear - ibStartYear;
                            differenceInMonth = (differenceInYear * 12) + (ibEndMonth - ibStartMonth) +1;
                            Integer startOffset = ibStartMonth + 4;
                            dynamicOffset =  dynamicOffset + startOffset;
                            dynamicDiv = dynamicDiv + differenceInMonth;                            
                            finalIbDivClass = dynamicDiv + ' ' +  dynamicOffset + ' ' + fixedbgColor;               
                        }                                                       
                        else
                        {
                            finalIbDivClass = 'none';  
                        }
                        ibr.finalIbDivClass = finalIbDivClass;
                        filterIbList.add(ibr); 
                    }
                }    
                else
                {
                    filterIbList= ibList;
                }
            }
        }
    }
    
    public void selectedYearIasWrapper() {       
        Date startDate; 
        Date endDate;
        String currentAcademicYearStartDate;
        String currentAcademicYearEndDate;
        if (selectedYear == 'thisSchoolYear') {             
            currentAcademicYearStartDate = '07/31/2015 11:59:00 PM';
            currentAcademicYearEndDate = '08/01/2016 11:59:00 PM';            
            startDate = setStringToDateFormat(currentAcademicYearStartDate);
            endDate = setStringToDateFormat(currentAcademicYearEndDate);   
            if (genericList != null && fullGenericList != null && paginater != null) {
                IasGanttChart(startDate, endDate, currentAcademicYearStartDate, currentAcademicYearEndDate);
            }            
        }
        else if (selectedYear == 'nextSchoolYear')
        {            
            currentAcademicYearStartDate = '07/31/2016 11:59:00 PM';
            currentAcademicYearEndDate = '08/01/2017 11:59:00 PM';            
            startDate = setStringToDateFormat(currentAcademicYearStartDate);
            endDate = setStringToDateFormat(currentAcademicYearEndDate); 
            if (genericList != null && fullGenericList != null && paginater != null) {
                IasGanttChart(startDate, endDate, currentAcademicYearStartDate, currentAcademicYearEndDate);
            }               
        }               
    }  
    
    public void IasGanttChart(Date startDate, Date endDate, String currentAcademicYearStartDate, String currentAcademicYearEndDate) {
        String currentYear;
        String nextYear;
        Integer differenceInMonth;
        Integer differenceInYear;
        Integer iasStartMonth;
        Integer iasEndMonth;
        Integer iasStartYear;
        Integer iasEndYear;
        String dynamicDiv;
        String dynamicOffset;
        String fixedbgColor;
        String finalDivClass;
        filterIasList = new List<IasWrapper>();
        if (genericList != null && fullGenericList != null && paginater != null) {
            this.genericList = this.fullGenericList.get(this.paginater.index);
            if (genericList != null && genericList.size() > 0) { 
                List<IasWrapper> iasList = genericList[0].iasList;
                List<IasWrapper> iasListThisYear = new List<IasWrapper> ();
                if(iasList !=null && iasList .size()>0) {
                    for (IasWrapper iasWrapper : iasList) { 
                        if (IasWrapper.ias.Start_Date__c != null && IasWrapper.ias.Target_Date__c != null && IasWrapper.ias.Start_Date__c > startDate && IasWrapper.ias.Target_Date__c < endDate &&
                            IasWrapper.ias.Start_Date__c <= IasWrapper.ias.Target_Date__c)
                        {                                                               
                            iasListThisYear.add(iasWrapper);                                                  
                        }       
                    }
                    for(IasWrapper iasWrapper : iasListThisYear )    {
                        dynamicDiv =  'col-xs-';
                        dynamicOffset = 'col-xs-offset-';
                        fixedbgColor = 'action bg-success';
                        finalDivClass = 'none';
                        iasStartMonth = iasWrapper.ias.Start_Date__c.month();
                        iasEndMonth = iasWrapper.ias.Target_Date__c.month();
                        iasStartYear = iasWrapper.ias.Start_Date__c.year();
                        iasEndYear = iasWrapper.ias.Target_Date__c.year();
                        if (iasStartYear == startDate.year())
                        {
                            differenceInYear = iasEndYear - iasStartYear;
                            differenceInMonth = (differenceInYear * 12) + (iasEndMonth - iasStartMonth) + 1;
                            Integer offset = iasStartMonth - 8;
                            if(iasWrapper.ias.Start_Date__c == iasWrapper.ias.Target_Date__c)
                            {
                                dynamicDiv = dynamicDiv + '1';
                            }
                            else if(differenceInMonth == 0)
                            {
                                dynamicDiv = dynamicDiv + '1';
                            }
                            else
                            {
                                dynamicDiv = dynamicDiv + differenceInMonth;
                            }
                            dynamicOffset = dynamicOffset + offset; 
                            finalDivClass = dynamicDiv + ' ' + dynamicOffset + ' ' + fixedbgColor; 
                        }                                                       
                        else if ((iasStartYear == endDate.year()) && (iasEndYear <= endDate.year()))                                                  
                        {
                            differenceInYear = iasEndYear - iasStartYear;
                            differenceInMonth = (differenceInYear * 12) + (iasEndMonth - iasStartMonth) +1;
                            Integer startOffset = iasStartMonth + 4;
                            dynamicOffset =  dynamicOffset + startOffset;
                            dynamicDiv = dynamicDiv + differenceInMonth;                            
                            finalDivClass = dynamicDiv + ' ' +  dynamicOffset + ' ' + fixedbgColor;               
                        }                                                       
                        else
                        {
                            finalDivClass = 'none';  
                        }
                        iasWrapper.finalDivClass = finalDivClass;
                        filterIasList.add(iasWrapper); 
                    }
                }    
                else
                {
                    filterIasList= iasList;
                }
            }
        }
    }   
    
    public void callIbIasRefresh()
    {
        selectedYearIbWrapper();
        selectedYearIasWrapper();
    }
    
    public  void cancelIasRow()
    {
        editIasRecId = ApexPages.currentPage().getParameters().get('editIasRecId');
        isIasUpdateRecord = false;
        if(genericList!=null)
        {   
            MisWrapper currentMisWrapper = genericList.get(0); 
            List <IasWrapper> iasList = currentMisWrapper.iasList; 
            if (iasList != null) {
                for (Integer i = (iasList.size() - 1) ; i>=0; i--) { 
                    if (iasList[i].ias.id == null) {
                        iasList[i].ias = null;
                        iasList.remove(i);                              
                    }
                }
            }
            populateUIPElem();
            addMisWrapperListToPagination();
            populateOrder();
            dispIasButton = true;
            dispButton = true;
        }
    }
    
    public void fillBenchMarkMap()
    {
        List<BenchMar_AtciontStep__c> actionBenchJunctionList = [select Id,name,Implementation_Benchmark__c,Implementation_Benchmark__r.id,Improvement_Action_Step__c,
                                                                 Improvement_Action_Step__r.id,Improvement_Action_Step__r.name from BenchMar_AtciontStep__c 
                                                                 WHERE Improvement_Action_Step__r.UIP__c = :currentId];    
        actionStepRelatedMap = new Map<Id,List<String>>();        
        set<Id> benchMarkIdSet = new set<Id>();        
        Map<id,Improvement_Action_Step__c> tempYMap = new MAP<id,Improvement_Action_Step__c>([select Id,name from Improvement_Action_Step__c WHERE UIP__c = :currentId]);        
        List<String> actionStepList = new List<String>();
        for(BenchMar_AtciontStep__c junctionRec : actionBenchJunctionList)
        {
            if(benchMarkIdSet.contains(junctionRec.Implementation_Benchmark__r.id))
            {
                if((tempYMap.get(junctionRec.Improvement_Action_Step__r.id))!=null)
                {
                    actionStepList.add(junctionRec.Improvement_Action_Step__r.name);
                    actionStepRelatedMap.put(junctionRec.Implementation_Benchmark__r.id, actionStepList);
                    
                }
            }
            else
            {
                actionStepList = new List<String>();
                actionStepList.add(junctionRec.Improvement_Action_Step__r.name);
                if(actionStepList.size()!=0){
                    actionStepRelatedMap.put(junctionRec.Implementation_Benchmark__r.id, actionStepList);                    
                    actionStepList= new List<String>();
                }else{
                    actionStepList= new List<String>();                    
                }
            }
        }        
    }    
    
    public void fillBenchMarkMap1()
    {
        List<BenchMar_AtciontStep__c> actionBenchJunctionList = [select Id,name,Implementation_Benchmark__c,Implementation_Benchmark__r.id,Improvement_Action_Step__c,
                                                                 Improvement_Action_Step__r.id,Improvement_Action_Step__r.name from BenchMar_AtciontStep__c 
                                                                 WHERE Improvement_Action_Step__r.UIP__c = :currentId];
        actionStepRelatedMap = new Map<Id,List<String>>();
        Map<ID,String> asMap=new Map<ID,String>();
        for(BenchMar_AtciontStep__c newUser  :actionBenchJunctionList)
        {
            if(actionStepRelatedMap.containsKey(newUser.Implementation_Benchmark__r.id)) {
                List<String> usersId = actionStepRelatedMap.get(newUser.Implementation_Benchmark__r.id);                
                usersId.add(newUser.Improvement_Action_Step__r.name);
            }
            else {
                actionStepRelatedMap.put(newUser.Implementation_Benchmark__r.id, new List<String> { newUser.Improvement_Action_Step__r.name });
            }
        } 
    }
    
    public void fillBenchMarkMap2(List<Implementation_Benchmark__c> benchmarkList)
    {
        Map<ID,ID> asMap=new Map<ID,ID>();        
        List<BenchMar_AtciontStep__c> actionBenchJunctionList = [select Id,name,Implementation_Benchmark__c,Implementation_Benchmark__r.id,Improvement_Action_Step__c,Improvement_Action_Step__r.id,Improvement_Action_Step__r.name 
                                                                 from BenchMar_AtciontStep__c WHERE Improvement_Action_Step__r.UIP__c = :currentId];
        for(BenchMar_AtciontStep__c newUser  :actionBenchJunctionList)
        {
            for(Implementation_Benchmark__c bench:benchmarkList)
            {
                if(bench.Id == newUser.Implementation_Benchmark__r.id)
                {
                    if(actionStepRelatedMap.containsKey(newUser.Implementation_Benchmark__r.id)) 
                    {
                        List<String> usersId = actionStepRelatedMap.get(newUser.Implementation_Benchmark__r.id);
                        if(!asMap.containsKey(newUser.Improvement_Action_Step__r.id))
                        {
                            usersId.add(newUser.Improvement_Action_Step__r.name);
                            asMap.put(newUser.Improvement_Action_Step__r.id,'');
                        }
                    }
                    else
                    {
                        actionStepRelatedMap.put(newUser.Implementation_Benchmark__r.id, new List<String> { newUser.Improvement_Action_Step__r.name });
                        asMap.put(newUser.Improvement_Action_Step__r.id,'');
                    }
                }                
            }
        }
    }  
    
    public void fillMapwithBenchMarkList()
    {
        for(List<MisWrapper> mis:fullGenericList)
        {
            List<IbWrapper>  implBenchList = mis[0].ibList;
            if(implBenchList!=null  && implBenchList.size()>0)
            {
                for(IbWrapper benchRecord:implBenchList)
                {
                    if(benchRecord!=null && !actionStepRelatedMap.containsKey(benchRecord.ib.id))
                        actionStepRelatedMap.put(benchRecord.ib.Id,new List<String>());
                }
            }
        }
    }
    
    public String asIdList{get;set;}
    public String mis{get;set;}
    
    public void SaveOrder()
    {
        if(asIdList!=NULL && mis!=NULL && asIdList!='')
        {
            SaveOrder__c s=new SaveOrder__c();
            s.UserId__c=UserInfo.getUserId()+mis;
            s.ActionStepOrder__c=asIdList;
            upsert s UserId__c;
        }
        populateOrder();
    }
    
    public void SaveOrder(String ID)
    {
        List<SaveOrder__c> saveOrderList=new List<SaveOrder__c>();
        String var=String.valueOf(genericList[0].mis.id);
        String var1=UserInfo.getUserId()+var;
        saveOrderList=[SELECT ActionStepOrder__c,BenchMarkOrder__c FROM SaveOrder__c WHERE UserId__c=:var1];
        if(saveOrderList.size()>0 && saveOrderList[0].ActionStepOrder__c!=NULL)
        {
            String asOrderList=saveOrderList[0].ActionStepOrder__c;
            saveOrderList[0].ActionStepOrder__c=asOrderList+','+ID;
            Update saveOrderList;
        }
    }
    
    public void populateOrder()
    {
        String var;
        List<SaveOrder__c> saveOrderList=new List<SaveOrder__c>();
        if(genericList !=null && genericList.size()> 0)
        {
            var=String.valueOf(genericList[0].mis.id);
        }
        String var1=UserInfo.getUserId()+var;
        saveOrderList=[SELECT ActionStepOrder__c,BenchMarkOrder__c FROM SaveOrder__c WHERE UserId__c=:var1];
        if(saveOrderList.size()>0&&saveOrderList[0].ActionStepOrder__c!=NULL)
        {
            List<String> asOrderList=saveOrderList[0].ActionStepOrder__c.split(',');
            List<IasWrapper> dupIasList=new  List<IasWrapper>();
            if(genericList !=null && genericList.size()> 0 && genericList[0].iasList!=null)
            {
                dupIasList=genericList[0].iasList;
                List<IasWrapper> iasList=new  List<IasWrapper>();
                for(String s:asOrderList)
                {
                    for(IasWrapper a:dupIasList)
                    {
                        if(s==String.valueOf(a.ias.id))
                        {
                            iasList.add(a);
                        }
                    }
                }
                genericList[0].iasList.clear();
                genericList[0].iasList=iasList;
            }
        }
    }
    
    public String ibIdList{get;set;}
    
    public void SaveOrderIB()
    {
        if(ibIdList!=NULL)
        {
            SaveOrder__c s=new SaveOrder__c();
            s.UserId__c=UserInfo.getUserId()+mis;
            s.BenchMarkOrder__c=ibIdList;
            upsert s UserId__c;
        }
        populateOrderIB();
    }
    
    public void SaveOrderIB(String ID)
    {
        List<SaveOrder__c> saveOrderList=new List<SaveOrder__c>();
        String var=String.valueOf(genericList[0].mis.id);
        String var1=UserInfo.getUserId()+var;
        saveOrderList=[SELECT ActionStepOrder__c,BenchMarkOrder__c FROM SaveOrder__c WHERE UserId__c=:var1];
        if(saveOrderList.size()>0 && saveOrderList[0].BenchMarkOrder__c!=NULL)
        {
            String ibOrderList=saveOrderList[0].BenchMarkOrder__c;
            saveOrderList[0].BenchMarkOrder__c=ibOrderList+','+ID;
            Update saveOrderList;
        }
    }
    
    public void populateOrderIB()
    {
        String var;
        if(genericList !=null && genericList.size()> 0)
        {
            var=String.valueOf(genericList[0].mis.id);
        }
        String var1=UserInfo.getUserId()+var;
        List<SaveOrder__c> saveOrderList=new List<SaveOrder__c>();
        saveOrderList=[SELECT ActionStepOrder__c,BenchMarkOrder__c FROM SaveOrder__c WHERE UserId__c=:var1];
        if(saveOrderList.size()>0 && saveOrderList[0].BenchMarkOrder__c!=NULL)
        {
            List<String> asOrderList=saveOrderList[0].BenchMarkOrder__c.split(',');
            List<IbWrapper> dupIbList=new  List<IbWrapper>();
            if(genericList !=null && genericList.size()> 0 && genericList[0].ibList!=null)
            {
                dupIbList=genericList[0].ibList;
                List<IbWrapper> ibList=new  List<IbWrapper>();
                for(String s:asOrderList)
                {               
                    for(IbWrapper a : dupIbList)
                    {
                        if(s==String.valueOf(a.ib.id))
                        {
                            ibList.add(a);
                        }
                    }               
                }
                genericList[0].ibList.clear();
                genericList[0].ibList=ibList;
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
    
    public void populatePPCTableForPublicFacing() {
        String soql = SectionUtil.getFieldsQuery('UIP_Element__c');
        soql += ' FROM UIP_Element__c WHERE UIP__c = \'' + currentId + '\'';
        List<UIP_Element__c> elemsList = Database.query(soql);        
        getElemRTIds();
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
        Set<Id> rcIds;
        Set<Id> misIds;
        for (Id ppcId : ppcMap.KeySet()) {
            rcIds = new Set<Id>();
            misIds = new Set<Id>();
            for(Integer i = 1; i <= MAX_UIP_ELEM; i++) {
                if ((Id)ppcMap.get(ppcId).get('Root_Cause_' + i + '__c') != null) {
                    if (!rcIds.contains((Id)ppcMap.get(ppcId).get('Root_Cause_' + i + '__c'))) {
                        rcIds.add((Id)ppcMap.get(ppcId).get('Root_Cause_' + i + '__c'));
                        if(allElemsMap.containsKey((ID)ppcMap.get(ppcId).get('Root_Cause_' + i + '__c')))
                        {rcMap.get(ppcId).add(allElemsMap.get((Id)ppcMap.get(ppcId).get('Root_Cause_' + i + '__c')).Name);
                         for(Integer j = 1; j <= MAX_UIP_ELEM; j++) {
                             if ((Id)allElemsMap.get((Id)ppcMap.get(ppcId).get('Root_Cause_' + i + '__c')).get('Major_Improvement_Strategy_' + j + '__c') != null) {
                                 if (!misIds.contains((Id)allElemsMap.get((Id)ppcMap.get(ppcId).get('Root_Cause_' + i + '__c')).get('Major_Improvement_Strategy_' + j + '__c'))) {
                                     misIds.add((Id)allElemsMap.get((Id)ppcMap.get(ppcId).get('Root_Cause_' + i + '__c')).get('Major_Improvement_Strategy_' + j + '__c'));
                                     misMap.get(ppcId).add(allElemsMap.get((Id)allElemsMap.get((Id)ppcMap.get(ppcId).get('Root_Cause_' + i + '__c')).get('Major_Improvement_Strategy_' + j + '__c')).Name);
                                 }
                             }
                         }
                        }
                    }
                }
                if ((Id)ppcMap.get(ppcId).get('Major_Improvement_Strategy_' + i + '__c') != null) {
                    if (!misIds.contains((Id)ppcMap.get(ppcId).get('Major_Improvement_Strategy_' + i + '__c'))) {
                        misIds.add((Id)ppcMap.get(ppcId).get('Major_Improvement_Strategy_' + i + '__c'));
                        if(allElemsMap.containsKey((ID)ppcMap.get(ppcId).get('Major_Improvement_Strategy_'+i+'__c')))
                        {misMap.get(ppcId).add(allElemsMap.get((Id)ppcMap.get(ppcId).get('Major_Improvement_Strategy_' + i + '__c')).Name);}
                    }
                }
            }
        }
        ppcmWrapperList = new List<PPCMappingWrapper>();
        PPCMappingWrapper ppcm;
        for (Id key : ppcMap.keySet()) {
            ppcm = new PPCMappingWrapper();
            ppcm.ppc = ppcMap.get(Key).Name;
            ppcm.rcList = rcMap.get(key);
            ppcm.misList = misMap.get(key);
            ppcmWrapperList.add(ppcm);
        }
        Integer listSize = ppcmWrapperList.size();
        if (ppcmWrapperList.size() < 5) {
            for (Integer i = 0 ; i < (5 - listSize); i++) {
                ppcm = new PPCMappingWrapper();
                ppcm.ppc = '';
                ppcm.rcList = new List<String>();
                ppcm.misList = new List<String>();
                ppcmWrapperList.add(ppcm);
            }
        }
    }
    
    public class PPCMappingWrapper {
        public String ppc { get; set; }
        public List<String> rcList { get; set; }
        public List<String> misList { get; set; }
    }
    
    public void populateTargetsForChallenge()
    {      
        System.debug('uip.Id '+uip.Id);
        String elemSoql = SectionUtil.getFieldsQuery('UIP_Element__c');
        elemSoql += ' FROM UIP_Element__c WHERE RecordType.Name like '+'\'Challenge\' and UIP__c='+'\''+uip.Id+'\' order by CreatedDate';
        system.debug('elemSoql '+elemSoql);
        List<UIP_Element__c> uipElementsList = Database.query(elemSoql);
        System.debug('uipElementsList '+uipElementsList);
        ppcChallengeMap = new Map<Id,String>();
        Set<Id> ppcIDs = new Set<Id>();
        piTargetMap = new Map<Id,List<SchoolTargetWrapper>>();
        for(UIP_Element__c uipElem : uipElementsList)
        {
            System.debug('uipElem.id '+uipElem.id);
            System.debug('uipElem.name '+uipElem.name);
            ppcIDs.add(uipElem.id);
            System.debug('ppcIDs '+ppcIDs);
            piTargetMap.put(uipElem.id,new List<SchoolTargetWrapper>());
            System.debug('piTargetMap '+piTargetMap);
            ppcChallengeMap.put(uipElem.id,uipElem.name);
            System.debug('ppcChallengeMap '+ppcChallengeMap);
        }
        ppcSchoolTatgetList = [SELECT Id,Interim_Measures_1__c,IsDeleted,LastModifiedById,LastModifiedDate,Last_Year_Target_1__c,Major_Improvement_Strategy_1__c,Measures_Metrics2__c,Measures_Metrics__c,
                               Name,Next_Year_Related_Target__c,Next_Year_Target_1__c,OwnerId,Performance_against_Target_1__c,Performance_Indicator__c,Priority_Performance_Challenge_1__c,
                               Public_Facing__c,RecordTypeId,Subject_1__c,SystemModstamp,Target_Reflection_1__c,This_Year_Target_1__c,UIP__c,ZPIF_UIP_Identidier__c,
                               Priority_Performance_Challenge_1__r.name, RecordType.Name FROM Performance_Indicator_Targets__c where Priority_Performance_Challenge_1__c in:ppcIDs];
        system.debug('ppcSchoolTatgetList '+ppcSchoolTatgetList); 
        Map<Id,Performance_Indicator_Targets__c> allPitMap = new Map<Id,Performance_Indicator_Targets__c>();
        for (Performance_Indicator_Targets__c pit : ppcSchoolTatgetList) {
            allPitMap.put(pit.id, pit);
        }
        System.debug('allPitMap '+allPitMap);
        String nextYearRTId = Schema.SObjectType.Performance_Indicator_Targets__c.getRecordTypeInfosByName().get('Next Year\'s Target').getRecordTypeId();  
        System.debug('nextYearRTId '+nextYearRTId);
        for(Performance_Indicator_Targets__c pit:ppcSchoolTatgetList)
        {
            System.debug('pit.Priority_Performance_Challenge_1__c '+pit.Priority_Performance_Challenge_1__c);
            System.debug('pit.RecordType.Name '+pit.RecordType.Name);
            System.debug('piTargetMap.containsKey(pit.Priority_Performance_Challenge_1__c '+piTargetMap.containsKey(pit.Priority_Performance_Challenge_1__c));
            if(piTargetMap.containsKey(pit.Priority_Performance_Challenge_1__c) && pit.RecordType.Name == 'This Year\'s Target')
            {               
                System.debug('pit.Next_Year_Related_Target__c '+pit.Next_Year_Related_Target__c);
                if(pit.Next_Year_Related_Target__c != null)
                    piTargetMap.get(pit.Priority_Performance_Challenge_1__c).add(new SchoolTargetWrapper(pit, allPitMap.get(pit.Next_Year_Related_Target__c)));
                else
                    piTargetMap.get(pit.Priority_Performance_Challenge_1__c).add(new SchoolTargetWrapper(pit, new Performance_Indicator_Targets__c(UIP__c = uip.Id, RecordTypeId = nextYearRTId)));
            }
            System.debug('piTargetMap '+piTargetMap);
        }
    }
    
    public void populateNotableTrendsUpdated() {
        String soql = SectionUtil.getFieldsQuery('Performance_Indicator_Notable_Trends__c');
        soql += ', Priority_Performance_Challenge_1__r.Description__c, Root_Cause_1__r.Description__c, Priority_Performance_Challenge_1__r.Name, Root_Cause_1__r.Name';
        soql += ' FROM Performance_Indicator_Notable_Trends__c WHERE UIP__c = \'' + uip.Id + '\' order by CreatedDate';
        pintList = Database.query(soql);
    }
    
    public PageReference downloadPDF() {
        PageReference pr;
        if(uip.SCHOOL_NUMBER__c != null){ pr=new PageReference('/PublicUIPview_Print?dcode='+uip.DIST_NUMBER__c+'&scode='+uip.SCHOOL_NUMBER__c); }
        else if(uip.SCHOOL_NUMBER__c == null){ pr=new PageReference('/PublicUIPview_Print?dcode='+uip.DIST_NUMBER__c); }
        pr.setRedirect(true);
        return pr;
    }
}