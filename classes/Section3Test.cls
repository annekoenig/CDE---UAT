@isTest
public class Section3Test 
{
    static testMethod void myUnitTest() 
    {
        String rType = [Select Id From RecordType  Where SobjectType = 'UIP__c' and DeveloperName = 'AEC_UIP'].Id;
        String rType4 = [Select Id From RecordType  Where SobjectType = 'Performance_Indicator_Targets__c' and DeveloperName = 'Prior_Year_Target'].Id;
        
        String rtChallengeId = Schema.SObjectType.UIP_Element__c.getRecordTypeInfosByName().get('Challenge').getRecordTypeId();
        String rtMISId = Schema.SObjectType.UIP_Element__c.getRecordTypeInfosByName().get('Major Improvement Strategy').getRecordTypeId();
        String rtRCId = Schema.SObjectType.UIP_Element__c.getRecordTypeInfosByName().get('Root Cause').getRecordTypeId();        
        
        Account a = new Account();
        a.Name = 'Test Acc';
        insert a;
        
        UIP_Annual_CDE_Plan__c uac = new UIP_Annual_CDE_Plan__c();
        insert uac;
        
        UIP__c u = new UIP__c();
        u.DISTRICT_NAME__c = a.Id;
        u.UIP_Annual_CDE_Plan__c = uac.Id;
        u.TextAreaRich_Test__c = 'text';
        u.Root_Cause_Narrative__c = 'text';
        u.Target_Reflection__c = 'text';
        u.Performance_Challenge_Narrative__c = 'text';
        u.RecordTypeId = rtype;
        insert u;
        
        UIP_Element__c uipEl3 = new UIP_Element__c();
        uipEl3.UIP__c = u.Id;
        uipEl3.RecordTypeId = rtMISId;
        insert uipEl3;
        
        UIP_Element__c uipEl2 = new UIP_Element__c();
        uipEl2.UIP__c = u.Id;
        uipEl2.Major_Improvement_Strategy_1__c = uipEl3.Id;
        uipEl2.RecordTypeId = rtChallengeId;
        insert uipEl2;
        
        UIP_Element__c uipEl = new UIP_Element__c();
        uipEl.UIP__c = u.Id;
        uipEl.Root_Cause_1__c = uipEl2.Id;
        uipEl.Name = 'Test El';
        uipEl.Major_Improvement_Strategy_1__c = uipEl3.Id;
        uipEl.RecordTypeId = rtMISId;
        insert uipEl;
        
        Performance_Indicator_Targets__c pit = new Performance_Indicator_Targets__c();
        pit.UIP__c = u.Id;
        pit.Performance_Indicator__c = 'Academic Growth';
        pit.Subject_1__c = 'R';
        pit.Last_Year_Target_1__c = '12';
        pit.Performance_against_Target_1__c = 'asd';
        pit.RecordTypeId = rType4;
        insert pit;
        
        String eseaAdd = Schema.SObjectType.Addendum__c.getRecordTypeInfosByName().get('DIST ESEA Supporting Addendum').getRecordTypeId();
        Addendum__c add = new Addendum__c();
        add.RecordTypeId = eseaAdd;
        add.UIP__c = u.Id;
        insert add;
        
        Performance_Indicator_Notable_Trends__c pint = new Performance_Indicator_Notable_Trends__c();
        pint.Notable_Trends_1__c = '11';
        pint.Performance_Indicator__c = 'Academic Growth';
        pint.UIP__c = u.Id;
        insert pint;
        
        Improvement_Action_Step__c i = new Improvement_Action_Step__c();
        i.Name = 'ias1';
        i.UIP__c = u.Id;
        i.Major_Improvement_Strategy__c = uipEl.Id;
        insert i;       
        
        Implementation_Benchmark__c ib = new Implementation_Benchmark__c();
        ib.Name = 'ib1';
        ib.UIP__c = u.Id;
        ib.Major_Improvement_Strategy__c = uipEl.Id;
        insert ib;       
        
        RecordTypeDependencies__c rtd = new RecordTypeDependencies__c();
        rtd.PIT_RecordType__c = 'Academic Growth';
        rtd.Name = 'name';
        rtd.UIP_RT__c = 'AEC UIP';
        insert rtd;
        
        PageReference pageRef = Page.Section3_Trend_Analysis;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('id', u.Id);
        ApexPages.CurrentPage().getParameters().put('piValue', 'UTF-8');
        ApexPages.CurrentPage().getParameters().put('target', 'Academic Growth');
        ApexPages.CurrentPage().getParameters().put('pitId', pit.Id);
        ApexPages.CurrentPage().getParameters().put('pintId', pint.Id);
        ApexPages.CurrentPage().getParameters().put('ElemId', uipEl.Id);
        ApexPages.CurrentPage().getParameters().put('st', 'Academic Growth');
        ApexPages.CurrentPage().getParameters().put('thisYearId', pit.Id);
        ApexPages.CurrentPage().getParameters().put('challengeId', uipEl3.Id);
        
        ApexPages.Standardcontroller stdCtrl = new ApexPages.Standardcontroller(u);
        Section3 ctrl = new Section3(stdCtrl);
        ctrl.populateUIPElem();
        ApexPages.currentPage().getParameters().put('challengeId',uipEl2.Id);
        ctrl.getRcForChallengeList();
        ctrl.getChallengeForSchoolTargetList();
        ctrl.associateElem();        
        ctrl.ppcElem = new Section3.ElemWrapper(uipEl.Id, 'Name', 'Desc');
        ctrl.selectedMisOption = uipEl.Id;
        ctrl.selectedMisOption2 = uipEl.Id;
        ctrl.userDataCode();
        ctrl.getperformanceIndicator();
        ctrl.closemodalPopup();
        ctrl.showmodalPopup();
        ctrl.closetarget();        
        ctrl.picklistvalue = 'Student Behavior';
        ctrl.lastyeartarget = 'test';
        ctrl.performanceontarget = 'done';
        ctrl.savetarget();        
        ctrl.getSupporting_Addenda_Forms();
        ctrl.Save();
        ctrl.updateMISElem();
        ctrl.SaveMisElem();
        ctrl.getPIOptions();
        ctrl.updateUIP();
        ctrl.SaveReflexion();
        ctrl.rerenderForRTF();
        ctrl.rerenderAllRTF();
        ctrl.BackUIPNarrative();
        ctrl.NextBriefDescription();
        ctrl.BackBriefDescription();
        ctrl.NextPriorYearTargets();
        ctrl.BackPriorYearTargets();
        ctrl.NextCurrentPerformance();
        ctrl.BackCurrentPerformance();
        ctrl.NextTrendAnalysis();
        ctrl.BackTrendAnalysis();
        ctrl.NextPriorityPerformanceChallenges();
        ctrl.BackPriorityPerformanceChallenges();
        ctrl.NextPlanningForm();
        ctrl.BackSchoolTargetSetting();
        ctrl.NextRootCauses();
        ctrl.DownloadWord_S3();
        ctrl.DownloadExcel_S4_PlanningForm();
        ctrl.DownloadExcel_S4_SchoolTarget();
        ctrl.addPit();
        ctrl.CancelNewPit();
        ctrl.SaveNewPit();
        ctrl.EditPit();
        ctrl.CancelEditPit();
        ctrl.SaveEditPit();
        ctrl.DeletePit();
        ctrl.selectSupportingAddendaForPublicUIP(new Set<Id>());
        ctrl.DownloadExcel_S4_FullPlanForm();
        ctrl.nextPage();
        ctrl.previousPage();
        ctrl.showPopup();
        ctrl.closePopup();
        ctrl.showPopupNew();
        ctrl.closePopupNew();        
        ctrl.getchooseIb();
        ctrl.getchooseIas();
        ctrl.chooseniasValue = 'ias1';
        ctrl.choosenibValue = 'ib1';
        ctrl.benchmark();        
        integer aux = 0;
        aux = ctrl.addWPositionMapsize;
        aux = ctrl.challengeMapsize;
        aux = ctrl.pitTargetsMapsize;
        aux = ctrl.piTargetMapsize;        
    }
    
    static testMethod void myUnitTest2() 
    {
        String rType = [Select Id From RecordType  Where SobjectType = 'UIP__c' and DeveloperName = 'AEC_UIP'].Id;
        String rType2 = [Select Id From RecordType  Where SobjectType = 'Performance_Indicator_Targets__c' and DeveloperName = 'This_Year_s_Target'].Id;
        
        String rtChallengeId = Schema.SObjectType.UIP_Element__c.getRecordTypeInfosByName().get('Challenge').getRecordTypeId();
        String rtMISId = Schema.SObjectType.UIP_Element__c.getRecordTypeInfosByName().get('Major Improvement Strategy').getRecordTypeId();
        String rtRCId = Schema.SObjectType.UIP_Element__c.getRecordTypeInfosByName().get('Root Cause').getRecordTypeId();        
        
        Account a = new Account();
        a.Name = 'Test Acc';
        insert a;
        
        UIP_Annual_CDE_Plan__c uac = new UIP_Annual_CDE_Plan__c();
        insert uac;
        
        UIP__c u = new UIP__c();
        u.DISTRICT_NAME__c = a.Id;
        u.UIP_Annual_CDE_Plan__c = uac.Id;
        u.TextAreaRich_Test__c = 'text';
        u.Root_Cause_Narrative__c = 'text';
        u.Target_Reflection__c = 'text';
        u.Performance_Challenge_Narrative__c = 'text';
        u.RecordTypeId = rtype;
        insert u;
        
        UIP_Element__c uipEl3 = new UIP_Element__c();
        uipEl3.UIP__c = u.Id;
        uipEl3.RecordTypeId = rtMISId;
        insert uipEl3;
        
        UIP_Element__c uipEl2 = new UIP_Element__c();
        uipEl2.UIP__c = u.Id;
        uipEl2.Major_Improvement_Strategy_1__c = uipEl3.Id;
        uipEl2.RecordTypeId = rtChallengeId;
        insert uipEl2;
        
        UIP_Element__c uipEl = new UIP_Element__c();
        uipEl.UIP__c = u.Id;
        uipEl.Root_Cause_1__c = uipEl2.Id;
        uipEl.Name = 'Test El';
        uipEl.Major_Improvement_Strategy_1__c = uipEl3.Id;
        uipEl.RecordTypeId = rtMISId;
        insert uipEl;
        
        Performance_Indicator_Targets__c pit = new Performance_Indicator_Targets__c();
        pit.UIP__c = u.Id;
        pit.Performance_Indicator__c = 'Academic Growth';
        pit.Subject_1__c = 'R';
        pit.Last_Year_Target_1__c = '12';
        pit.Performance_against_Target_1__c = 'asd';
        pit.RecordTypeId = rtype2;
        insert pit;
        
        String eseaAdd = Schema.SObjectType.Addendum__c.getRecordTypeInfosByName().get('DIST ESEA Supporting Addendum').getRecordTypeId();
        Addendum__c add = new Addendum__c();
        add.RecordTypeId = eseaAdd;
        add.UIP__c = u.Id;
        insert add;
        
        Performance_Indicator_Notable_Trends__c pint = new Performance_Indicator_Notable_Trends__c();
        pint.Notable_Trends_1__c = '11';
        pint.Performance_Indicator__c = 'Academic Growth';
        pint.UIP__c = u.Id;
        insert pint;
        
        Improvement_Action_Step__c i = new Improvement_Action_Step__c();
        i.Name = 'ias1';
        i.UIP__c = u.Id;
        i.Major_Improvement_Strategy__c = uipEl.Id;
        insert i;
        
        RecordTypeDependencies__c rtd = new RecordTypeDependencies__c();
        rtd.PIT_RecordType__c = 'Academic Growth';
        rtd.Name = 'name';
        rtd.UIP_RT__c = 'AEC UIP';
        insert rtd;
        
        PageReference pageRef = Page.Section3_Trend_Analysis;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('id', u.Id);
        ApexPages.CurrentPage().getParameters().put('piValue', 'UTF-8');
        ApexPages.CurrentPage().getParameters().put('target', 'Disaggregated Growth');
        ApexPages.CurrentPage().getParameters().put('pitId', pit.Id);
        ApexPages.CurrentPage().getParameters().put('pintId', pint.Id);
        ApexPages.CurrentPage().getParameters().put('ElemId', uipEl.Id);
        ApexPages.CurrentPage().getParameters().put('st', pit.Id);
        ApexPages.CurrentPage().getParameters().put('thisYearId', pit.Id);
        ApexPages.CurrentPage().getParameters().put('challengeId', uipEl3.Id);
        
        ApexPages.Standardcontroller stdCtrl = new ApexPages.Standardcontroller(u);
        Section3 ctrl = new Section3();
        ctrl.populateUIPElem();
        ApexPages.currentPage().getParameters().put('challengeId',uipEl2.Id);
        Test.startTest();
        ctrl.getRcForChallengeList();
        ctrl.getChallengeForSchoolTargetList();        
        ctrl.getYesNoList();
        ctrl.addPint();
        ctrl.CancelNewPint();
        ctrl.SaveNewPint();
        ctrl.EditPint();
        ctrl.CancelEditPint();
        ctrl.SaveEditPint();
        ctrl.DeletePint();
        ctrl.addElem();
        ctrl.CancelNewElem();
        ctrl.SaveNewElem();
        ctrl.SaveEditRCElem();
        ctrl.EditElem();
        ctrl.EditElemx();
        ctrl.CancelEditElem();
        ctrl.CancelEditElemx();
        ctrl.SaveEditElem();
        ctrl.DeleteElem();
        ctrl.isExistingRC = true;
        ctrl.choosedRC.put(uipEl2.Id, uipEl2.Id);
        ctrl.SaveNewRC();
        ctrl.isExistingRC = true;
        ctrl.SaveRcForMis();
        ctrl.DeleteRC();
        ctrl.DeleteRcForMis();
        ctrl.SaveEditMisElem();
        ctrl.toggleIas();
        ctrl.AddNewIasRow();
        //ctrl.SaveNewIas();
        ctrl.SaveEditIas();
        ctrl.populateMisWrapperList();
        ctrl.DeleteIasForMis();
        ctrl.SaveEditSchoolTargetElem();
        ctrl.DeleteSchoolTargetElem();
        ctrl.AddNewSchoolTarget();
        ctrl.SaveNewSchoolTarget();
        ctrl.EditRTF();         
        ctrl.nextAddenda();
        //ctrl.cancelme();        
        Test.stopTest(); 
        
        Integer noUIP = [SELECT COUNT() FROM UIP__c WHERE Id= :u.Id];
        System.assertEquals(1, noUIP);
    }
    
    static testMethod void myUnitTest3() 
    {
        String rType = [Select Id From RecordType  Where SobjectType = 'UIP__c' and DeveloperName = 'AEC_UIP'].Id;
        String rType2 = [Select Id From RecordType  Where SobjectType = 'Performance_Indicator_Targets__c' and DeveloperName = 'This_Year_s_Target'].Id;
        
        String rtChallengeId = Schema.SObjectType.UIP_Element__c.getRecordTypeInfosByName().get('Challenge').getRecordTypeId();
        String rtMISId = Schema.SObjectType.UIP_Element__c.getRecordTypeInfosByName().get('Major Improvement Strategy').getRecordTypeId();
        String rtRCId = Schema.SObjectType.UIP_Element__c.getRecordTypeInfosByName().get('Root Cause').getRecordTypeId();
        
        
        Account a = new Account();
        a.Name = 'Test Acc';
        insert a;
        
        UIP_Annual_CDE_Plan__c uac = new UIP_Annual_CDE_Plan__c();
        insert uac;
        
        UIP__c u = new UIP__c();
        u.DISTRICT_NAME__c = a.Id;
        u.UIP_Annual_CDE_Plan__c = uac.Id;
        u.TextAreaRich_Test__c = 'text';
        u.Root_Cause_Narrative__c = 'text';
        u.Target_Reflection__c = 'text';
        u.Performance_Challenge_Narrative__c = 'text';
        u.RecordTypeId = rtype;
        insert u;
        
        UIP_Element__c uipEl3 = new UIP_Element__c();
        uipEl3.UIP__c = u.Id;
        uipEl3.RecordTypeId = rtMISId;
        insert uipEl3;
        
        UIP_Element__c uipEl2 = new UIP_Element__c();
        uipEl2.UIP__c = u.Id;
        uipEl2.Major_Improvement_Strategy_1__c = uipEl3.Id;
        uipEl2.RecordTypeId = rtChallengeId;
        insert uipEl2;
        
        UIP_Element__c uipEl = new UIP_Element__c();
        uipEl.UIP__c = u.Id;
        uipEl.Root_Cause_1__c = uipEl2.Id;
        uipEl.Name = 'Test El';
        uipEl.Major_Improvement_Strategy_1__c = uipEl3.Id;
        uipEl.RecordTypeId = rtMISId;
        insert uipEl;
        
        Performance_Indicator_Targets__c pit = new Performance_Indicator_Targets__c();
        pit.UIP__c = u.Id;
        pit.Performance_Indicator__c = 'Academic Growth';
        pit.Subject_1__c = 'R';
        pit.Last_Year_Target_1__c = '12';
        pit.Performance_against_Target_1__c = 'asd';
        pit.RecordTypeId = rtype2;
        insert pit;
        
        String eseaAdd = Schema.SObjectType.Addendum__c.getRecordTypeInfosByName().get('DIST ESEA Supporting Addendum').getRecordTypeId();
        Addendum__c add = new Addendum__c();
        add.RecordTypeId = eseaAdd;
        add.UIP__c = u.Id;
        insert add;
        
        Performance_Indicator_Notable_Trends__c pint = new Performance_Indicator_Notable_Trends__c();
        pint.Notable_Trends_1__c = '11';
        pint.Performance_Indicator__c = 'Academic Growth';
        pint.UIP__c = u.Id;
        insert pint;
        
        Improvement_Action_Step__c i = new Improvement_Action_Step__c();
        i.UIP__c = u.Id;
        i.name='test';
        i.Major_Improvement_Strategy__c = uipEl.Id;
        insert i;
        
        Implementation_Benchmark__c b=new Implementation_Benchmark__c();
        b.UIP__c = u.Id;
        b.name='test';
        b.Major_Improvement_Strategy__c = uipEl.Id;
        insert b;
        
        BenchMar_AtciontStep__c ba=new BenchMar_AtciontStep__c();
        ba.Implementation_Benchmark__c=b.id;
        ba.Improvement_Action_Step__c=i.id;
        insert ba;
        
        RecordTypeDependencies__c rtd = new RecordTypeDependencies__c();
        rtd.PIT_RecordType__c = 'Academic Growth';
        rtd.Name = 'name';
        rtd.UIP_RT__c = 'AEC UIP';
        insert rtd;
        
        PageReference pageRef = Page.Section3_Trend_Analysis;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('id', u.Id);
        ApexPages.CurrentPage().getParameters().put('piValue', 'UTF-8');
        ApexPages.CurrentPage().getParameters().put('target', 'Disaggregated Growth');
        ApexPages.CurrentPage().getParameters().put('pitId', pit.Id);
        ApexPages.CurrentPage().getParameters().put('pintId', pint.Id);
        ApexPages.CurrentPage().getParameters().put('ElemId', uipEl.Id);
        ApexPages.CurrentPage().getParameters().put('st', pit.Id);
        ApexPages.CurrentPage().getParameters().put('thisYearId', pit.Id);
        ApexPages.CurrentPage().getParameters().put('challengeId', uipEl3.Id);
        
        ApexPages.CurrentPage().getParameters().put('editIasRecId', i.Id);
        ApexPages.CurrentPage().getParameters().put('updateIasRecId', i.Id);
        ApexPages.CurrentPage().getParameters().put('rt','key');
        ApexPages.CurrentPage().getParameters().put('deleteIasRecId', i.Id);
        ApexPages.CurrentPage().getParameters().put('deleteRecId', b.Id);
        
        ApexPages.Standardcontroller stdCtrl = new ApexPages.Standardcontroller(u);
        Section3 ctrl = new Section3(stdCtrl);
        ctrl.populateUIPElem();
        ApexPages.currentPage().getParameters().put('challengeId',uipEl2.Id);
        
        Test.startTest();
        
        ctrl.getRcForChallengeList();
        ctrl.getChallengeForSchoolTargetList();     
        ctrl.getYesNoList();
        ctrl.addPint();
        ctrl.CancelNewPint();
        ctrl.SaveNewPint();
        ctrl.EditPint();
        ctrl.CancelEditPint();
        ctrl.SaveEditPint();
        ctrl.DeletePint();
        ctrl.addElem();
        ctrl.CancelNewElem();
        ctrl.SaveNewElem();
        ctrl.SaveEditRCElem();
        ctrl.EditElem();
        ctrl.EditElemx();
        ctrl.CancelEditElem();
        ctrl.CancelEditElemx();
        ctrl.SaveEditElem();
        ctrl.DeleteElem();
        ctrl.isExistingRC = true;
        ctrl.choosedRC.put(uipEl2.Id, uipEl2.Id);
        ctrl.SaveNewRC();
        ctrl.isExistingRC = true;
        ctrl.SaveRcForMis();
        ctrl.DeleteRC();
        ctrl.DeleteRcForMis();
        ctrl.SaveEditMisElem();
        ctrl.toggleIas();
        ctrl.AddNewIasRow();        
        //ctrl.SaveNewIas();
        ctrl.SaveEditIas();
        ctrl.populateMisWrapperList();
        ctrl.DeleteIasForMis();
        ctrl.SaveEditSchoolTargetElem();
        ctrl.DeleteSchoolTargetElem();
        ctrl.AddNewSchoolTarget();
        ctrl.SaveNewSchoolTarget();
        ctrl.EditRTF();        
        ctrl.nextAddenda();
        
        Integer noUIP = [SELECT COUNT() FROM UIP__c WHERE Id= :u.Id];
        System.assertEquals(1, noUIP);        
        
        //New
        
        ctrl.getAddendumRTMap();
        
        //ctrl.UpdateIasRecord();
        ctrl.selectedRecNameId='';
        ctrl.fromMonthVal='';
        ctrl.toMonthVal='';
        ctrl.editRecId='';
        ctrl.updateRecId='';
        ctrl.recordSize=0;
        ctrl.editIasRecId='';
        ctrl.updateIasRecId='';
        ctrl.saveIasRecId='';
        ctrl.defaultPageMisList=true;
        ctrl.ibList=NULL;
        ctrl.dummyIb=NULL;
        ctrl.selectedNameId='';
        ctrl.targetElemId='';
        ctrl.targetElemNumber='';
        ctrl.currentPitRt='';
        ctrl.piValue='';
        ctrl.uipElemId='';
        ctrl.ntElemId='';
        ctrl.ntElemRT='';
        ctrl.iasId='';
        ctrl.rcElem=NULL;
        ctrl.misElem=NULL;
        ctrl.newMISName='';
        ctrl.addendumMap=NULL;
        ctrl.addendumList=NULL;
        ctrl.addendumPositionMap=NULL;
        ctrl.dummyIas=NULL;
        ctrl.schoolYearMap=NULL;
        ctrl.isTextChanged=NULL;
        ctrl.isNewElem=NULL;
        ctrl.elemType=NULL;
        ctrl.dummyIas=NULL;
        ctrl.newMISDesc=NULL;
        
        ctrl.existsActionStep(String.valueOf(i.id),String.valueOf(b.id));
        //ctrl.updateActionStepNameRecords('test','test1');
        ctrl.populateESEA();
        ctrl.NextMajorImpStrategyForm();
        ctrl.NextFullPlanForm();
        ctrl.prevAddenda();
        
        
        //ctrl.changeData();
        //ctrl.nextPage();
        //ctrl.previousPage();
        
        ctrl.addRow();
        /* b.Start_Date__c=Date.today()-5;
        b.End_Date__c=Date.today()-3;
        update b;
        i.Start_Date__c=Date.today()-5;
        i.Target_Date__c=Date.today()-3;
        update i;
        List<Section3.IbWrapper> bList=new List<Section3.IbWrapper>();
        Section3.IbWrapper bw=new Section3.IbWrapper();
        bw.ib=b;
        bList.add(bw);
        List<Section3.IasWrapper> aList=new List<Section3.IasWrapper>();
        Section3.IasWrapper aw=new Section3.IasWrapper();
        aw.ias=i;
        aList.add(aw);
        ctrl.genericList[0].iasList=aList;
        ctrl.genericList[0].ibList=bList;*/
        Date present=Date.today();
        Date lastDate=Date.newInstance(Date.Today().year()-1, 1, 1);
        ctrl.IasGanttChart(present,lastDate);
        ctrl.IbGanttChart(present,lastDate);
        Test.stopTest();
        
    }
    static testMethod void myUnitTest4() 
    {
        String rType = [Select Id From RecordType  Where SobjectType = 'UIP__c' and DeveloperName = 'AEC_UIP'].Id;
        String rType2 = [Select Id From RecordType  Where SobjectType = 'Performance_Indicator_Targets__c' and DeveloperName = 'This_Year_s_Target'].Id;
        
        String rtChallengeId = Schema.SObjectType.UIP_Element__c.getRecordTypeInfosByName().get('Challenge').getRecordTypeId();
        String rtMISId = Schema.SObjectType.UIP_Element__c.getRecordTypeInfosByName().get('Major Improvement Strategy').getRecordTypeId();
        String rtRCId = Schema.SObjectType.UIP_Element__c.getRecordTypeInfosByName().get('Root Cause').getRecordTypeId();
        
        Integer MAX_QUERY = Limits.getLimitQueries(); 
        Integer NUM_QUERY = MAX_QUERY - 1;
        
        //Insert custom setting record
        Academic_Year__c ay = new Academic_Year__c();
        ay.Name = 'Academic Year';
        ay.CurrentAcademicYrEndDate__c = Date.Today() + 120;
        ay.CurrentAcademicYrStartDate__c = Date.Today() - 120;
        ay.NextAcademicYrEndDate__c = Date.Today() + 240;
        ay.NextAcademicYrStartDate__c = Date.Today()+121;
        
        insert ay;
        
        
        Account a = new Account();
        a.Name = 'Test Acc';
        insert a;
        
        UIP_Annual_CDE_Plan__c uac = new UIP_Annual_CDE_Plan__c();
        insert uac;
        
        UIP__c u = new UIP__c();
        u.DISTRICT_NAME__c = a.Id;
        u.UIP_Annual_CDE_Plan__c = uac.Id;
        u.TextAreaRich_Test__c = 'text';
        u.Root_Cause_Narrative__c = 'text';
        u.Target_Reflection__c = 'text';
        u.Performance_Challenge_Narrative__c = 'text';
        u.RecordTypeId = rtype;
        insert u;
        
        UIP_Element__c uipEl3 = new UIP_Element__c();
        uipEl3.UIP__c = u.Id;
        uipEl3.RecordTypeId = rtMISId;
        insert uipEl3;
        
        UIP_Element__c uipEl2 = new UIP_Element__c();
        uipEl2.UIP__c = u.Id;
        uipEl2.Major_Improvement_Strategy_1__c = uipEl3.Id;
        uipEl2.RecordTypeId = rtChallengeId;
        insert uipEl2;
        
        UIP_Element__c uipEl = new UIP_Element__c();
        uipEl.UIP__c = u.Id;
        uipEl.Root_Cause_1__c = uipEl2.Id;
        uipEl.Name = 'Test El';
        uipEl.Major_Improvement_Strategy_1__c = uipEl3.Id;
        uipEl.RecordTypeId = rtMISId;
        insert uipEl;
        
        Performance_Indicator_Targets__c pit = new Performance_Indicator_Targets__c();
        pit.UIP__c = u.Id;
        pit.Performance_Indicator__c = 'Academic Growth';
        pit.Subject_1__c = 'R';
        pit.Last_Year_Target_1__c = '12';
        pit.Performance_against_Target_1__c = 'asd';
        pit.RecordTypeId = rtype2;
        insert pit;
        
        String eseaAdd = Schema.SObjectType.Addendum__c.getRecordTypeInfosByName().get('DIST ESEA Supporting Addendum').getRecordTypeId();
        Addendum__c add = new Addendum__c();
        add.RecordTypeId = eseaAdd;
        add.UIP__c = u.Id;
        insert add;
        
        Performance_Indicator_Notable_Trends__c pint = new Performance_Indicator_Notable_Trends__c();
        pint.Notable_Trends_1__c = '11';
        pint.Performance_Indicator__c = 'Academic Growth';
        pint.UIP__c = u.Id;
        insert pint;
        
        Improvement_Action_Step__c i = new Improvement_Action_Step__c();
        i.UIP__c = u.Id;
        i.name='test';
        i.Major_Improvement_Strategy__c = uipEl.Id;
        insert i;
        
        Implementation_Benchmark__c b=new Implementation_Benchmark__c();
        b.UIP__c = u.Id;
        b.name='test';
        b.Major_Improvement_Strategy__c = uipEl.Id;
        insert b;
        
        BenchMar_AtciontStep__c ba=new BenchMar_AtciontStep__c();
        ba.Implementation_Benchmark__c=b.id;
        ba.Improvement_Action_Step__c=i.id;
        insert ba;
        
        RecordTypeDependencies__c rtd = new RecordTypeDependencies__c();
        rtd.PIT_RecordType__c = 'Academic Growth';
        rtd.Name = 'name';
        rtd.UIP_RT__c = 'AEC UIP';
        insert rtd;
        
        PageReference pageRef = Page.Section3_Trend_Analysis;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('id', u.Id);
        ApexPages.CurrentPage().getParameters().put('piValue', 'UTF-8');
        ApexPages.CurrentPage().getParameters().put('target', 'Academic Growth');
        ApexPages.CurrentPage().getParameters().put('pitId', pit.Id);
        ApexPages.CurrentPage().getParameters().put('pintId', pint.Id);
        ApexPages.CurrentPage().getParameters().put('ElemId', uipEl.Id);
        ApexPages.CurrentPage().getParameters().put('st', 'Academic Growth');
        ApexPages.CurrentPage().getParameters().put('thisYearId', pit.Id);
        ApexPages.CurrentPage().getParameters().put('challengeId', uipEl3.Id);
        
        ApexPages.CurrentPage().getParameters().put('editIasRecId', i.Id);
        ApexPages.CurrentPage().getParameters().put('updateIasRecId', i.Id);
        ApexPages.CurrentPage().getParameters().put('editRecId', b.Id);
        ApexPages.CurrentPage().getParameters().put('updateRecId', b.Id);
        ApexPages.CurrentPage().getParameters().put('rt','key');
        ApexPages.CurrentPage().getParameters().put('deleteIasRecId', i.Id);
        ApexPages.CurrentPage().getParameters().put('deleteRecId', b.Id);
        
        ApexPages.Standardcontroller stdCtrl = new ApexPages.Standardcontroller(u);
        Section3 ctrl = new Section3(stdCtrl);
        ctrl.populateUIPElem();
        ApexPages.currentPage().getParameters().put('challengeId',uipEl2.Id);
        ctrl.getRcForChallengeList();
        ctrl.getChallengeForSchoolTargetList();
        
        Improvement_Action_Step__c i1 = new Improvement_Action_Step__c();
        i1.UIP__c = u.Id;
        i1.name='test';
        i1.Major_Improvement_Strategy__c = uipEl.Id;
        insert i1;
        
        Date d=Date.today();
        String s=d.format();
        ctrl.setStringToDateFormat(s);
        ctrl.selectedYear='thisSchoolYear';
        ctrl.selectedYearIbWrapper();
        ctrl.selectedYearIasWrapper();
        ctrl.selectedYear='nextSchoolYear';
        ctrl.selectedYearIbWrapper();
        ctrl.selectedYearIasWrapper();
        ctrl.saveNewIb();
        ctrl.SaveNewIas();
        ctrl.editRow();
        ctrl.editIasRow();
        ctrl.cancelRow();
     //   ctrl.cancelIasRow();
        List<Implementation_Benchmark__c> bList=new List<Implementation_Benchmark__c>();
        bList.add(b);   
        Section3.IbWrapper ib=new Section3.IbWrapper();
        ib.ib=b;
        ib.Start_Date=Date.today().format();
        String s1=ib.Start_Date;
        ib.End_Date=Date.today().format();
        String s2=ib.End_Date;
        
        Section3.IasWrapper ias=new Section3.IasWrapper();
        ias.ias=i;
        ias.Start_Date=Date.today().format();
        String s3=ias.Start_Date;
        ias.Target_Date=Date.today().format();
        String s4=ias.Target_Date;
        
        ctrl.asIdList=String.valueOf(i.id);
        ctrl.mis=String.valueOf(ctrl.genericList[0].mis.id);
        
        Test.startTest();
        
        ctrl.SaveOrder();
        ctrl.SaveOrder(i.id);
        ctrl.ibIdList=String.valueOf(b.id);
        ctrl.SaveOrderIB();        
        ctrl.SaveOrderIB(b.id);
        ctrl.populateBenchmark();
        // System.assertEquals('expected', String.valueOf(ctrl.genericList[0].mis.name));
        ctrl.selectedRecNameId=String.valueOf(b.id);
        Improvement_Action_Step__c di = new Improvement_Action_Step__c();
        Implementation_Benchmark__c ibnew = new Implementation_Benchmark__c();
        di.UIP__c = u.Id;
        di.name='test';
        di.Major_Improvement_Strategy__c = uipEl.Id;
        
        ibnew.UIP__c = u.id;
        ibnew.name='ibtest';
        ibnew.Major_Improvement_Strategy__c = uipEl.Id;
        
        Section3.BenchMarkWrapper bmw = new Section3.BenchMarkWrapper();
        bmw.flag = true;
        bmw.benchRecord = ibnew;
        List<Section3.BenchMarkWrapper> bmwl=new List<Section3.BenchMarkWrapper>();
        bmwl.add(bmw);
        
        ctrl.saveRecords(di, bmwl);
        ctrl.updateRecords(String.valueOf(i.id), String.valueOf(b.id));
        ctrl.deleteAssociatedBenchMark(String.valueOf(i1.id));
        ctrl.DeleteIasRow();
        ctrl.deleteRow();
        ctrl.populateTargetsForPPC();        
        Test.stopTest();
    }
}