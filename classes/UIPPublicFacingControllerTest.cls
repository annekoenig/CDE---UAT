@isTest
private class UIPPublicFacingControllerTest 
{
    static testMethod void myUnitTest() 
    {
        String rType = [Select Id From RecordType  Where SobjectType = 'ZPIF_UIP__c' and DeveloperName = 'AEC_UIP'].Id;
        String rType2 = [Select Id From RecordType  Where SobjectType = 'ZPF_Performance_Indicator_Targets__c' and DeveloperName = 'This_Year_s_Target'].Id;
        
        String rtChallengeId = Schema.SObjectType.ZPF_UIP_Element__c.getRecordTypeInfosByName().get('Challenge').getRecordTypeId();
        String rtMISId = Schema.SObjectType.ZPF_UIP_Element__c.getRecordTypeInfosByName().get('Major Improvement Strategy').getRecordTypeId();
        String rtRCId = Schema.SObjectType.ZPF_UIP_Element__c.getRecordTypeInfosByName().get('Root Cause').getRecordTypeId();
                
        Account a = new Account();
        a.Name = 'Test Acc';
        insert a;
        
        UIP_Annual_CDE_Plan__c uac = new UIP_Annual_CDE_Plan__c();
        insert uac;
        
        ZPIF_UIP__c u = new ZPIF_UIP__c();
        u.DISTRICT_NAME__c = a.Id;
        u.UIP_Annual_CDE_Plan__c = uac.Id;
        u.TextAreaRich_Test__c = 'text';
        u.Root_Cause_Narrative__c = 'text';
        u.Target_Reflection__c = 'text';
        u.Performance_Challenge_Narrative__c = 'text';
        u.RecordTypeId = rtype;
        u.Public_Facing__c = true;
        u.SCHOOL_NUMBER__c='123';
        u.DIST_NUMBER__c='123';
        u.ZPIF_UIP_Identidier__c='13';
        insert u;
        
        ZPF_UIP_Element__c uipEl3 = new ZPF_UIP_Element__c();
        uipEl3.UIP__c = u.Id;
        uipEl3.RecordTypeId = rtMISId;
        uipEl3.Public_Facing__c=TRUE;
        insert uipEl3;
        
        ZPF_UIP_Element__c uipEl2 = new ZPF_UIP_Element__c();
        uipEl2.UIP__c = u.Id;
        uipEl2.Major_Improvement_Strategy_1__c = uipEl3.Id;
        uipEl2.RecordTypeId = rtChallengeId;
        uipEl2.Public_Facing__c=TRUE;
        insert uipEl2;
        
        ZPF_UIP_Element__c uipEl = new ZPF_UIP_Element__c();
        uipEl.UIP__c = u.Id;
        uipEl.Root_Cause_1__c = uipEl2.Id;
        uipEl.Name = 'Test El';
        uipEl.Major_Improvement_Strategy_1__c = uipEl3.Id;
        uipEl.RecordTypeId = rtMISId;
        uipEl.Public_Facing__c=TRUE;
        insert uipEl;
        
        ZPF_Performance_Indicator_Targets__c pit = new ZPF_Performance_Indicator_Targets__c();
        pit.UIP__c = u.Id;
        pit.Performance_Indicator__c = 'Academic Growth';
        pit.Subject_1__c = 'R';
        pit.Last_Year_Target_1__c = '12';
        pit.Performance_against_Target_1__c = 'asd';
        pit.RecordTypeId = rtype2;
        pit.Public_Facing__c=TRUE;
        insert pit;
        
        String eseaAdd = Schema.SObjectType.ZPF_Addendum__c.getRecordTypeInfosByName().get('DIST ESEA Supporting Addendum').getRecordTypeId();
        ZPF_Addendum__c add = new ZPF_Addendum__c();
        add.RecordTypeId = eseaAdd;
        add.UIP__c = u.Id;
        add.Public_Facing__c=TRUE;
        insert add;
        
        ZPF_Performance_Indicator_Notable_Trends__c pint = new ZPF_Performance_Indicator_Notable_Trends__c();
        pint.Notable_Trends_1__c = '11';
        pint.Performance_Indicator__c = 'Academic Growth';
        pint.UIP__c = u.Id;
        pint.Public_Facing__c=TRUE;
        insert pint;
        
        ZPF_Improvement_Action_Step__c i = new ZPF_Improvement_Action_Step__c();
        i.UIP__c = u.Id;
        i.Major_Improvement_Strategy__c = uipEl.Id;
        i.Public_Facing__c=TRUE;
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
        ApexPages.CurrentPage().getParameters().put('target', 'Academic Growth');
        ApexPages.CurrentPage().getParameters().put('pitId', pit.Id);
        ApexPages.CurrentPage().getParameters().put('pintId', pint.Id);
        ApexPages.CurrentPage().getParameters().put('ElemId', uipEl.Id);
        ApexPages.CurrentPage().getParameters().put('st', 'Academic Growth');
        ApexPages.CurrentPage().getParameters().put('thisYearId', pit.Id);
        ApexPages.CurrentPage().getParameters().put('challengeId', uipEl3.Id);
        //ApexPages.CurrentPage().getParameters().put('uip', u.Id);
        ApexPages.currentPage().getParameters().put('dcode','123');
        ApexPages.currentPage().getParameters().put('scode','123');
        
        //ApexPages.Standardcontroller stdCtrl = new ApexPages.Standardcontroller(u);
        //UIPPublicFacingController ctrl = new UIPPublicFacingController();
        ApexPages.Standardcontroller stdCtrl = new ApexPages.Standardcontroller(u);
        UIPPublicFacingController ctrl = new UIPPublicFacingController(stdCtrl);
        ctrl.uip = u;
        ctrl.populateUIPElem();
        ApexPages.currentPage().getParameters().put('challengeId',uipEl2.Id);
        ctrl.getRcForChallengeList();
        ctrl.getChallengeForSchoolTargetList();
        ctrl.associateElem();
        
        ctrl.ppcElem = new UIPPublicFacingController.ElemWrapper(uipEl.Id, 'Name', 'Desc');
        ctrl.selectedMisOption = uipEl.Id;
        ctrl.selectedMisOption2 = uipEl.Id;
        ctrl.getSupporting_Addenda_Forms();
        ctrl.Save();
        ctrl.updateMISElem();
        ctrl.SaveMisElem();
        ctrl.populateNotableTrends();
        ctrl.getPIOptions();
        ctrl.getSection1Map();
        ctrl.currentId=u.Id;
        ctrl.rerenderForRTF();
        ctrl.rerenderAllRTF();
        ctrl.getAddendumRTMap();
        ctrl.populateESEA();
        ctrl.selectUIP();
        ctrl.getElemRTIds();
        ctrl.populateTargets();
        ctrl.AddNewSchoolTarget();
        ctrl.SaveNewSchoolTarget();
        ctrl.AddNewIasRow();
        ctrl.SaveNewIas();
        ctrl.SaveNewIb();
        //ctrl.cancelIasRow();
        //ctrl.updateUIP();
        //ctrl.SaveReflexion();
        /* ctrl.rerenderForRTF();
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
ctrl.DeletePit();*/
    }
    
    static testMethod void myUnitTest2() 
    {
        String rType = [Select Id From RecordType  Where SobjectType = 'ZPIF_UIP__c' and DeveloperName = 'AEC_UIP'].Id;
        String rType2 = [Select Id From RecordType  Where SobjectType = 'ZPF_Performance_Indicator_Targets__c' and DeveloperName = 'This_Year_s_Target'].Id;
        
        String rtChallengeId = Schema.SObjectType.ZPF_UIP_Element__c.getRecordTypeInfosByName().get('Challenge').getRecordTypeId();
        String rtMISId = Schema.SObjectType.ZPF_UIP_Element__c.getRecordTypeInfosByName().get('Major Improvement Strategy').getRecordTypeId();
        String rtRCId = Schema.SObjectType.ZPF_UIP_Element__c.getRecordTypeInfosByName().get('Root Cause').getRecordTypeId();
                
        Account a = new Account();
        a.Name = 'Test Acc';
        insert a;
        
        UIP_Annual_CDE_Plan__c uac = new UIP_Annual_CDE_Plan__c();
        insert uac;
        
        ZPIF_UIP__c u = new ZPIF_UIP__c();
        u.DISTRICT_NAME__c = a.Id;
        u.UIP_Annual_CDE_Plan__c = uac.Id;
        u.TextAreaRich_Test__c = 'text';
        u.Root_Cause_Narrative__c = 'text';
        u.Target_Reflection__c = 'text';
        u.Performance_Challenge_Narrative__c = 'text';
        u.RecordTypeId = rtype;
        insert u;
        
        ZPF_UIP_Element__c uipEl3 = new ZPF_UIP_Element__c();
        uipEl3.UIP__c = u.Id;
        uipEl3.RecordTypeId = rtMISId;
        insert uipEl3;
        
        ZPF_UIP_Element__c uipEl2 = new ZPF_UIP_Element__c();
        uipEl2.UIP__c = u.Id;
        uipEl2.Major_Improvement_Strategy_1__c = uipEl3.Id;
        uipEl2.RecordTypeId = rtChallengeId;
        insert uipEl2;
        
        ZPF_UIP_Element__c uipEl = new ZPF_UIP_Element__c();
        uipEl.UIP__c = u.Id;
        uipEl.Root_Cause_1__c = uipEl2.Id;
        uipEl.Name = 'Test El';
        uipEl.Major_Improvement_Strategy_1__c = uipEl3.Id;
        uipEl.RecordTypeId = rtMISId;
        insert uipEl;
        
        ZPF_Performance_Indicator_Targets__c pit = new ZPF_Performance_Indicator_Targets__c();
        pit.UIP__c = u.Id;
        pit.Performance_Indicator__c = 'Academic Growth';
        pit.Subject_1__c = 'R';
        pit.Last_Year_Target_1__c = '12';
        pit.Performance_against_Target_1__c = 'asd';
        pit.RecordTypeId = rtype2;
        insert pit;
        
        String eseaAdd = Schema.SObjectType.ZPF_Addendum__c.getRecordTypeInfosByName().get('DIST ESEA Supporting Addendum').getRecordTypeId();
        ZPF_Addendum__c add = new ZPF_Addendum__c();
        add.RecordTypeId = eseaAdd;
        add.UIP__c = u.Id;
        insert add;
        
        ZPF_Performance_Indicator_Notable_Trends__c pint = new ZPF_Performance_Indicator_Notable_Trends__c();
        pint.Notable_Trends_1__c = '11';
        pint.Performance_Indicator__c = 'Academic Growth';
        pint.UIP__c = u.Id;
        insert pint;
        
        ZPF_Improvement_Action_Step__c i = new ZPF_Improvement_Action_Step__c();
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
        ApexPages.CurrentPage().getParameters().put('target', 'Academic Growth');
        ApexPages.CurrentPage().getParameters().put('pitId', pit.Id);
        ApexPages.CurrentPage().getParameters().put('pintId', pint.Id);
        ApexPages.CurrentPage().getParameters().put('ElemId', uipEl.Id);
        ApexPages.CurrentPage().getParameters().put('st', 'Academic Growth');
        ApexPages.CurrentPage().getParameters().put('thisYearId', pit.Id);
        ApexPages.CurrentPage().getParameters().put('challengeId', uipEl3.Id);
        
        //ApexPages.Standardcontroller stdCtrl = new ApexPages.Standardcontroller(u);
        //UIPPublicFacingController ctrl = new UIPPublicFacingController();
        ApexPages.Standardcontroller stdCtrl = new ApexPages.Standardcontroller(u);
        UIPPublicFacingController ctrl = new UIPPublicFacingController();
        ctrl.uip = u;
        ctrl.populateUIPElem();
        ctrl.populateNotableTrends();
        ApexPages.currentPage().getParameters().put('challengeId',uipEl2.Id);
        ctrl.getRcForChallengeList();
        ctrl.getChallengeForSchoolTargetList();
        
        ctrl.getYesNoList();
        ctrl.addPint();
        ctrl.CancelNewPint();
        ctrl.SaveNewPint();
        ctrl.EditPint();
        ctrl.CancelEditPint();
        //ctrl.SaveEditPint();
        ctrl.DeletePint();
        ctrl.addElem();
        ctrl.CancelNewElem();
        ctrl.SaveNewElem();
        //ctrl.SaveEditRCElem();
        ctrl.EditElem();
        ctrl.EditElemx();
        ctrl.CancelEditElem();
        ctrl.CancelEditElemx();
        //ctrl.SaveEditElem();
        //ctrl.DeleteElem();
        ctrl.isExistingRC = true;
        ctrl.choosedRC.put(uipEl2.Id, uipEl2.Id);
        ctrl.SaveNewRC();
        ctrl.isExistingRC = true;
        ctrl.SaveRcForMis();
        ctrl.DeleteRC();
        ctrl.DeleteRcForMis();
        ctrl.SaveEditMisElem();
        ctrl.toggleIas();
        /* ctrl.AddNewIasRow();
ctrl.SaveNewIas();
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
System.assertEquals(1, noUIP);*/
        
    }
    
    static testMethod void myUnitTest3() 
    {
        String rType = [Select Id From RecordType  Where SobjectType = 'ZPIF_UIP__c' and DeveloperName = 'AEC_UIP'].Id;
        String rType2 = [Select Id From RecordType  Where SobjectType = 'ZPF_Performance_Indicator_Targets__c' and DeveloperName = 'This_Year_s_Target'].Id;
        
        String rtChallengeId = Schema.SObjectType.ZPF_UIP_Element__c.getRecordTypeInfosByName().get('Challenge').getRecordTypeId();
        String rtMISId = Schema.SObjectType.ZPF_UIP_Element__c.getRecordTypeInfosByName().get('Major Improvement Strategy').getRecordTypeId();
        String rtRCId = Schema.SObjectType.ZPF_UIP_Element__c.getRecordTypeInfosByName().get('Root Cause').getRecordTypeId();
        
        
        Account a = new Account();
        a.Name = 'Test Acc';
        insert a;
        
        UIP_Annual_CDE_Plan__c uac = new UIP_Annual_CDE_Plan__c();
        insert uac;
        
        ZPIF_UIP__c u = new ZPIF_UIP__c();
        u.DISTRICT_NAME__c = a.Id;
        u.UIP_Annual_CDE_Plan__c = uac.Id;
        u.TextAreaRich_Test__c = 'text';
        u.Root_Cause_Narrative__c = 'text';
        u.Target_Reflection__c = 'text';
        u.Performance_Challenge_Narrative__c = 'text';
        u.RecordTypeId = rtype;
        insert u;
        
        ZPF_UIP_Element__c uipEl3 = new ZPF_UIP_Element__c();
        uipEl3.UIP__c = u.Id;
        uipEl3.RecordTypeId = rtMISId;
        insert uipEl3;
        
        ZPF_UIP_Element__c uipEl2 = new ZPF_UIP_Element__c();
        uipEl2.UIP__c = u.Id;
        uipEl2.Major_Improvement_Strategy_1__c = uipEl3.Id;
        uipEl2.RecordTypeId = rtChallengeId;
        insert uipEl2;
        
        ZPF_UIP_Element__c uipEl = new ZPF_UIP_Element__c();
        uipEl.UIP__c = u.Id;
        uipEl.Root_Cause_1__c = uipEl2.Id;
        uipEl.Name = 'Test El';
        uipEl.Major_Improvement_Strategy_1__c = uipEl3.Id;
        uipEl.RecordTypeId = rtMISId;
        insert uipEl;
        
        ZPF_Performance_Indicator_Targets__c pit = new ZPF_Performance_Indicator_Targets__c();
        pit.UIP__c = u.Id;
        pit.Performance_Indicator__c = 'Academic Growth';
        pit.Subject_1__c = 'R';
        pit.Last_Year_Target_1__c = '12';
        pit.Performance_against_Target_1__c = 'asd';
        pit.RecordTypeId = rtype2;
        insert pit;
        
        String eseaAdd = Schema.SObjectType.ZPF_Addendum__c.getRecordTypeInfosByName().get('DIST ESEA Supporting Addendum').getRecordTypeId();
        ZPF_Addendum__c add = new ZPF_Addendum__c();
        add.RecordTypeId = eseaAdd;
        add.UIP__c = u.Id;
        insert add;
        
        ZPF_Performance_Indicator_Notable_Trends__c pint = new ZPF_Performance_Indicator_Notable_Trends__c();
        pint.Notable_Trends_1__c = '11';
        pint.Performance_Indicator__c = 'Academic Growth';
        pint.UIP__c = u.Id;
        insert pint;
        
        ZPF_Improvement_Action_Step__c i = new ZPF_Improvement_Action_Step__c();
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
        ApexPages.CurrentPage().getParameters().put('target', 'Academic Growth');
        ApexPages.CurrentPage().getParameters().put('pitId', pit.Id);
        ApexPages.CurrentPage().getParameters().put('pintId', pint.Id);
        ApexPages.CurrentPage().getParameters().put('ElemId', uipEl.Id);
        ApexPages.CurrentPage().getParameters().put('st', 'Academic Growth');
        ApexPages.CurrentPage().getParameters().put('thisYearId', pit.Id);
        ApexPages.CurrentPage().getParameters().put('challengeId', uipEl3.Id);
        
        //ApexPages.Standardcontroller stdCtrl = new ApexPages.Standardcontroller(u);
        //UIPPublicFacingController ctrl = new UIPPublicFacingController();
        ApexPages.Standardcontroller stdCtrl = new ApexPages.Standardcontroller(u);
        UIPPublicFacingController ctrl = new UIPPublicFacingController(stdCtrl);
        ctrl.uip = u;
        ctrl.populateUIPElem();
        ctrl.populateNotableTrends();
        ApexPages.currentPage().getParameters().put('challengeId',uipEl2.Id);
        ctrl.getRcForChallengeList();
        ctrl.getChallengeForSchoolTargetList();
        
        ctrl.getYesNoList();
        ctrl.addPint();
        ctrl.CancelNewPint();
        ctrl.SaveNewPint();
        ctrl.EditPint();
        ctrl.CancelEditPint();
        //ctrl.SaveEditPint();
        ctrl.DeletePint();
        ctrl.addElem();
        ctrl.CancelNewElem();
        ctrl.SaveNewElem();
        //ctrl.SaveEditRCElem();
        ctrl.EditElem();
        ctrl.EditElemx();
        ctrl.CancelEditElem();
        ctrl.CancelEditElemx();
        //ctrl.SaveEditElem();
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
        /*  ctrl.AddNewIasRow();
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
ctrl.changeData();
ctrl.deleteRow();
ctrl.addRow();
ctrl.DeleteIasRow();*/
    }
    static testMethod void myUnitTest4() 
    {
        String rType = [Select Id From RecordType  Where SobjectType = 'ZPIF_UIP__c' and DeveloperName = 'AEC_UIP'].Id;
        String rType2 = [Select Id From RecordType  Where SobjectType = 'ZPF_Performance_Indicator_Targets__c' and DeveloperName = 'This_Year_s_Target'].Id;
        
        String rtChallengeId = Schema.SObjectType.ZPF_UIP_Element__c.getRecordTypeInfosByName().get('Challenge').getRecordTypeId();
        String rtMISId = Schema.SObjectType.ZPF_UIP_Element__c.getRecordTypeInfosByName().get('Major Improvement Strategy').getRecordTypeId();
        String rtRCId = Schema.SObjectType.ZPF_UIP_Element__c.getRecordTypeInfosByName().get('Root Cause').getRecordTypeId();
        
        
        Account a = new Account();
        a.Name = 'Test Acc';
        insert a;
        
        UIP_Annual_CDE_Plan__c uac = new UIP_Annual_CDE_Plan__c();
        insert uac;
        
        ZPIF_UIP__c u = new ZPIF_UIP__c();
        u.DISTRICT_NAME__c = a.Id;
        u.UIP_Annual_CDE_Plan__c = uac.Id;
        u.TextAreaRich_Test__c = 'text';
        u.Root_Cause_Narrative__c = 'text';
        u.Target_Reflection__c = 'text';
        u.Performance_Challenge_Narrative__c = 'text';
        u.RecordTypeId = rtype;
        u.Public_Facing__c=TRUE;
        insert u;
        
        ZPF_UIP_Element__c uipEl3 = new ZPF_UIP_Element__c();
        uipEl3.UIP__c = u.Id;
        uipEl3.RecordTypeId = rtMISId;
        uipEl3.Public_Facing__c=TRUE;
        insert uipEl3;
        
        ZPF_UIP_Element__c uipEl2 = new ZPF_UIP_Element__c();
        uipEl2.UIP__c = u.Id;
        uipEl2.Major_Improvement_Strategy_1__c = uipEl3.Id;
        uipEl2.RecordTypeId = rtChallengeId;
        uipEl2.Public_Facing__c=TRUE;
        insert uipEl2;
        
        ZPF_UIP_Element__c uipEl = new ZPF_UIP_Element__c();
        uipEl.UIP__c = u.Id;
        uipEl.Root_Cause_1__c = uipEl2.Id;
        uipEl.Name = 'Test El';
        uipEl.Major_Improvement_Strategy_1__c = uipEl3.Id;
        uipEl.RecordTypeId = rtMISId;
        uipEl.Public_Facing__c=TRUE;
        insert uipEl;
        
        ZPF_Performance_Indicator_Targets__c pit = new ZPF_Performance_Indicator_Targets__c();
        pit.UIP__c = u.Id;
        pit.Performance_Indicator__c = 'Academic Growth';
        pit.Subject_1__c = 'R';
        pit.Last_Year_Target_1__c = '12';
        pit.Performance_against_Target_1__c = 'asd';
        pit.RecordTypeId = rtype2;
        pit.Public_Facing__c=TRUE;
        insert pit;
        
        String eseaAdd = Schema.SObjectType.ZPF_Addendum__c.getRecordTypeInfosByName().get('DIST ESEA Supporting Addendum').getRecordTypeId();
        ZPF_Addendum__c add = new ZPF_Addendum__c();
        add.RecordTypeId = eseaAdd;
        add.UIP__c = u.Id;
        add.Public_Facing__c=TRUE;
        insert add;
        
        ZPF_Performance_Indicator_Notable_Trends__c pint = new ZPF_Performance_Indicator_Notable_Trends__c();
        pint.Notable_Trends_1__c = '11';
        pint.Performance_Indicator__c = 'Academic Growth';
        pint.UIP__c = u.Id;
        pint.Public_Facing__c=TRUE;
        insert pint;
        
        ZPF_Improvement_Action_Step__c i = new ZPF_Improvement_Action_Step__c();
        i.UIP__c = u.Id;
        i.name='test';
        i.Major_Improvement_Strategy__c = uipEl.Id;
        i.Public_Facing__c=TRUE;
        insert i;
        
        ZPF_Implementation_Benchmark__c b=new ZPF_Implementation_Benchmark__c();
        b.UIP__c = u.Id;
        b.name='test';
        b.Major_Improvement_Strategy__c = uipEl.Id;
        b.Public_Facing__c=TRUE;
        insert b;
        
        ZPF_BenchMar_AtciontStep__c ba=new ZPF_BenchMar_AtciontStep__c();
        ba.ZPF_Implementation_Benchmark__c=b.id;
        ba.ZPF_Improvement_Action_Step__c=i.id;
        ba.Public_Facing__c=TRUE;
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
        
        //ApexPages.Standardcontroller stdCtrl = new ApexPages.Standardcontroller(u);
        //UIPPublicFacingController ctrl = new UIPPublicFacingController();
        ApexPages.Standardcontroller stdCtrl = new ApexPages.Standardcontroller(u);
        UIPPublicFacingController ctrl = new UIPPublicFacingController(stdCtrl);
        ctrl.uip = u;
        ctrl.populateUIPElem();
        ctrl.populateNotableTrends();
        ApexPages.currentPage().getParameters().put('challengeId',uipEl2.Id);
        ctrl.getRcForChallengeList();
        ctrl.getChallengeForSchoolTargetList();
        
        ZPF_Improvement_Action_Step__c i1 = new ZPF_Improvement_Action_Step__c();
        i1.UIP__c = u.Id;
        i1.name='test';
        i1.Major_Improvement_Strategy__c = uipEl.Id;
        i1.Public_Facing__c=TRUE;
        insert i1;
        
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
        
        Date d=Date.today();
        String s=d.format();
        ctrl.selectedYear='thisSchoolYear';
        ctrl.selectedYearIbWrapper();
        ctrl.selectedYearIasWrapper();
        ctrl.selectedYear='nextSchoolYear';
        ctrl.selectedYearIbWrapper();
        ctrl.selectedYearIasWrapper();
        ctrl.fillBenchMarkMap();
        //ctrl.saveNewIb();
        ctrl.updateActionStepNameRecords('test','test1');
        //ctrl.SaveNewIas();
        ctrl.editRow();
        //ctrl.editIasRow();
        //ctrl.cancelRow();
        //ctrl.cancelIasRow();
        //ctrl.UpdateIasRecord();
        ctrl.currentId=u.id;
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
        ctrl.NextMajorImpStrategyForm();
        ctrl.NextFullPlanForm();
        ctrl.BackSchoolTargetSetting();
        ctrl.NextRootCauses();
        b.Start_Date__c=Date.newInstance(Date.Today().year(), 08, 02);
        b.End_Date__c=Date.newInstance(Date.Today().year(), 10, 02);
        update b;
        i.Start_Date__c=Date.newInstance(Date.Today().year(), 08, 02);
        i.Target_Date__c=Date.newInstance(Date.Today().year(), 10, 02);
        update i;
        List<UIPPublicFacingController.IbWrapper> bList=new List<UIPPublicFacingController.IbWrapper>();
        UIPPublicFacingController.IbWrapper bw=new UIPPublicFacingController.IbWrapper();
        bw.ib=b;
        bList.add(bw);
        List<UIPPublicFacingController.IasWrapper> aList=new List<UIPPublicFacingController.IasWrapper>();
        UIPPublicFacingController.IasWrapper aw=new UIPPublicFacingController.IasWrapper(i,NULL,NULL);
        aw.ias=i;
        aList.add(aw);
        //ctrl.genericList[0].iasList=aList;
        //ctrl.genericList[0].ibList=bList;
        ctrl.selectedYear='thisSchoolYear';
        ctrl.selectedYearIbWrapper();
        ctrl.selectedYearIasWrapper();
        i.Start_Date__c=Date.newInstance(Date.Today().year()+1, 08, 02);
        i.Target_Date__c=Date.newInstance(Date.Today().year()+1, 10, 02);
        update i;
        b.Start_Date__c=Date.newInstance(Date.Today().year()+1, 08, 02);
        b.End_Date__c=Date.newInstance(Date.Today().year()+1, 10, 02);
        update b;
        ctrl.selectedYear='nextSchoolYear';
        ctrl.selectedYearIbWrapper();
        ctrl.selectedYearIasWrapper();
        ctrl.show();
        
        UIPPublicFacingController.IbWrapper ib=new UIPPublicFacingController.IbWrapper();
        ib.ib=b;
        ib.Start_Date=Date.today().format();
        String s1=ib.Start_Date;
        ib.End_Date=Date.today().format();
        String s2=ib.End_Date;
        
        UIPPublicFacingController.IasWrapper ias=new UIPPublicFacingController.IasWrapper();
        ias.ias=i;
        ias.Start_Date=Date.today().format();
        String s3=ias.Start_Date;
        ias.Target_Date=Date.today().format();
        String s4=ias.Target_Date;
        
        Date present=Date.today();
        Date lastDate=Date.newInstance(Date.Today().year()-1, 1, 1);
        ctrl.IasGanttChart(present,lastDate,null,null);
        ctrl.IbGanttChart(present,lastDate,null,null);
        
        ctrl.selectedRecNameId=String.valueOf(b.id);
        ZPF_Improvement_Action_Step__c di = new ZPF_Improvement_Action_Step__c();
        di.UIP__c = u.Id;
        di.name='test';
        di.Major_Improvement_Strategy__c = uipEl.Id;
        ctrl.saveRecords(di, String.valueOf(b.id));
        ctrl.updateRecords(String.valueOf(i.id), String.valueOf(b.id));
        ctrl.deleteAssociatedBenchMark(String.valueOf(i1.id));
        ctrl.DeleteIasRow();
        ctrl.deleteRow();
        
    }
    static testMethod void myUnitTest5() 
    {
        String rType = [Select Id From RecordType  Where SobjectType = 'ZPIF_UIP__c' and DeveloperName = 'AEC_UIP'].Id;
        String rType2 = [Select Id From RecordType  Where SobjectType = 'ZPF_Performance_Indicator_Targets__c' and DeveloperName = 'This_Year_s_Target'].Id;
        
        String rtChallengeId = Schema.SObjectType.ZPF_UIP_Element__c.getRecordTypeInfosByName().get('Challenge').getRecordTypeId();
        String rtMISId = Schema.SObjectType.ZPF_UIP_Element__c.getRecordTypeInfosByName().get('Major Improvement Strategy').getRecordTypeId();
        String rtRCId = Schema.SObjectType.ZPF_UIP_Element__c.getRecordTypeInfosByName().get('Root Cause').getRecordTypeId();
        
        
        Account a = new Account();
        a.Name = 'Test Acc';
        insert a;
        
        UIP_Annual_CDE_Plan__c uac = new UIP_Annual_CDE_Plan__c();
        insert uac;
        
        ZPIF_UIP__c u = new ZPIF_UIP__c();
        u.DISTRICT_NAME__c = a.Id;
        u.UIP_Annual_CDE_Plan__c = uac.Id;
        u.TextAreaRich_Test__c = 'text';
        u.Root_Cause_Narrative__c = 'text';
        u.Target_Reflection__c = 'text';
        u.Performance_Challenge_Narrative__c = 'text';
        u.RecordTypeId = rtype;
        u.Public_Facing__c=TRUE;
        insert u;
        
        ZPF_UIP_Element__c uipEl3 = new ZPF_UIP_Element__c();
        uipEl3.UIP__c = u.Id;
        uipEl3.RecordTypeId = rtMISId;
        uipEl3.Public_Facing__c=TRUE;
        insert uipEl3;
        
        ZPF_UIP_Element__c uipEl2 = new ZPF_UIP_Element__c();
        uipEl2.UIP__c = u.Id;
        uipEl2.Major_Improvement_Strategy_1__c = uipEl3.Id;
        uipEl2.RecordTypeId = rtChallengeId;
        uipEl2.Public_Facing__c=TRUE;
        insert uipEl2;
        
        ZPF_UIP_Element__c uipEl = new ZPF_UIP_Element__c();
        uipEl.UIP__c = u.Id;
        uipEl.Root_Cause_1__c = uipEl2.Id;
        uipEl.Name = 'Test El';
        uipEl.Major_Improvement_Strategy_1__c = uipEl3.Id;
        uipEl.RecordTypeId = rtMISId;
        uipEl.Public_Facing__c=TRUE;
        insert uipEl;
        
        ZPF_Performance_Indicator_Targets__c pit = new ZPF_Performance_Indicator_Targets__c();
        pit.UIP__c = u.Id;
        pit.Performance_Indicator__c = 'Academic Growth';
        pit.Subject_1__c = 'R';
        pit.Last_Year_Target_1__c = '12';
        pit.Performance_against_Target_1__c = 'asd';
        pit.RecordTypeId = rtype2;
        pit.Public_Facing__c=TRUE;
        insert pit;
        
        String eseaAdd = Schema.SObjectType.ZPF_Addendum__c.getRecordTypeInfosByName().get('DIST ESEA Supporting Addendum').getRecordTypeId();
        ZPF_Addendum__c add = new ZPF_Addendum__c();
        add.RecordTypeId = eseaAdd;
        add.UIP__c = u.Id;
        add.Public_Facing__c=TRUE;
        insert add;
        
        ZPF_Performance_Indicator_Notable_Trends__c pint = new ZPF_Performance_Indicator_Notable_Trends__c();
        pint.Notable_Trends_1__c = '11';
        pint.Performance_Indicator__c = 'Academic Growth';
        pint.UIP__c = u.Id;
        pint.Public_Facing__c=TRUE;
        insert pint;
        
        ZPF_Improvement_Action_Step__c i = new ZPF_Improvement_Action_Step__c();
        i.UIP__c = u.Id;
        i.name='test';
        i.Major_Improvement_Strategy__c = uipEl.Id;
        i.Public_Facing__c=TRUE;
        i.Start_Date__c=Date.Today()+1;
        i.Target_Date__c=Date.today()+20;
        insert i;
        
        ZPF_Implementation_Benchmark__c b=new ZPF_Implementation_Benchmark__c();
        b.UIP__c = u.Id;
        b.name='test';
        b.Major_Improvement_Strategy__c = uipEl.Id;
        b.Public_Facing__c=TRUE;
        b.Start_Date__c=Date.today()+1;
        b.End_Date__c=Date.today()+20;
        insert b;
        
        ZPF_BenchMar_AtciontStep__c ba=new ZPF_BenchMar_AtciontStep__c();
        ba.ZPF_Implementation_Benchmark__c=b.id;
        ba.ZPF_Improvement_Action_Step__c=i.id;
        ba.Public_Facing__c=TRUE;
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
        
        //ApexPages.Standardcontroller stdCtrl = new ApexPages.Standardcontroller(u);
        //UIPPublicFacingController ctrl = new UIPPublicFacingController();
        ApexPages.Standardcontroller stdCtrl = new ApexPages.Standardcontroller(u);
        UIPPublicFacingController ctrl = new UIPPublicFacingController(stdCtrl);
        ctrl.uip = u;
        ctrl.populateUIPElem();
        ctrl.populateNotableTrends();
        ApexPages.currentPage().getParameters().put('challengeId',uipEl2.Id);
        ctrl.currentId=u.id;
        ctrl.DownloadWord_S3();
        ctrl.DownloadExcel_S4_PlanningForm();
        ctrl.DownloadExcel_S4_FullPlanForm();
        ctrl.DownloadExcel_S4_SchoolTarget();
        ctrl.addPit();
        ctrl.SaveNewPit();
        ctrl.populateTargets();
        ctrl.SaveEditPit();
        ctrl.EditPit();
        ctrl.CancelEditPit();
        ctrl.CancelNewPit();
        
        ctrl.populateNotableTrends();
        ctrl.SaveEditPint();
        ctrl.populateSchoolTargetsMap();
        ctrl.SaveEditSchoolTargetElem();
        ctrl.populateUIPElem();
        //ctrl.SaveEditRCElem();
        ctrl.SaveEditElem();
        //ctrl.editIasRow();
        SaveOrder__c so=new SaveOrder__c();
        so.ActionStepOrder__c=i.id;
        so.BenchMarkOrder__c=b.id;
        so.UserId__c=UserInfo.getUserId()+uipEl.Id;
        insert so;
        List<UIPPublicFacingController.IbWrapper> bList=new List<UIPPublicFacingController.IbWrapper>();
        UIPPublicFacingController.IbWrapper bw=new UIPPublicFacingController.IbWrapper();
        bw.ib=b;
        bList.add(bw);
        List<UIPPublicFacingController.IasWrapper> aList=new List<UIPPublicFacingController.IasWrapper>();
        UIPPublicFacingController.IasWrapper aw=new UIPPublicFacingController.IasWrapper(i,NULL,NULL);
        aw.ias=i;
        aList.add(aw);
        List<UIPPublicFacingController.MisWrapper> gList=new List<UIPPublicFacingController.MisWrapper>();
        UIPPublicFacingController.MisWrapper mw=new UIPPublicFacingController.MisWrapper(); 
        mw.iasList=aList;
        mw.ibList=bList;
        mw.mis=uipEl;
        gList.add(mw);
        ctrl.misWrapperList=gList;
        ctrl.genericList=gList;
        ctrl.addMisWrapperListToPagination();
        Date present=Date.today();
        Date lastDate=Date.Today()+30;
        ctrl.IasGanttChart(present,lastDate,null,null);
        ctrl.IbGanttChart(present,lastDate,null,null);
        ctrl.SaveEditIas();
        ctrl.addRow();
        ctrl.cancelRow();
        ctrl.populateOrderIB();
        ctrl.cancelIasRow();
        ctrl.DeletePit();
        ctrl.DeleteSchoolTargetElem();
        ctrl.EditIasRow();
        ctrl.DeleteIasForMis();
        //ctrl.prevAddenda();
        //ctrl.nextAddenda();
        ctrl.nextPage();
        ctrl.previousPage();
        /*Attachment att=new Attachment();
att.body=Blob.valueOf('Test');
att.ParentId=u.Id;
att.Name='Test.doc';
insert att;
UIPPublicFacingController.AttachmentWrapper aw1=new UIPPublicFacingController.AttachmentWrapper(att);
aw1.attName='Test';*/
    }
}