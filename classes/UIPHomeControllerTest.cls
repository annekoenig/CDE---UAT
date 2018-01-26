@isTest
private class UIPHomeControllerTest 
{ 
    static testMethod void myUnitTest() 
    {
        Account a = new Account();
        a.Name = 'Test Acc';
        insert a;
        
        UIP_Annual_CDE_Plan__c uac = new UIP_Annual_CDE_Plan__c();
        insert uac;       
        
        UIP__c u = new UIP__c();
        u.Name = 'Test';
        u.DISTRICT_NAME__c = a.Id;
        u.UIP_Annual_CDE_Plan__c = uac.Id;
        insert u;
        
        UIP__c u2 = new UIP__c();
        u2.Name = 'Test ~Final 1';
        u2.DISTRICT_NAME__c = a.Id;
        u2.UIP_Annual_CDE_Plan__c = uac.Id;
        insert u2;
        
        String rtChallengeId = Schema.SObjectType.UIP_Element__c.getRecordTypeInfosByName().get('Challenge').getRecordTypeId();
        String rtMISId = Schema.SObjectType.UIP_Element__c.getRecordTypeInfosByName().get('Major Improvement Strategy').getRecordTypeId();
        String rtRCId = Schema.SObjectType.UIP_Element__c.getRecordTypeInfosByName().get('Root Cause').getRecordTypeId();
        
        List<UIP_Element__c> ueList = new List<UIP_Element__c>();
        //UIP_Element__c ue;
        UIP_Element__c ue = new UIP_Element__c();
        ue.RecordTypeId = rtChallengeId;
        ue.UIP__c = u.Id;
        ueList.add(ue);
        UIP_Element__c ue2 = new UIP_Element__c();
        ue2.RecordTypeId = rtMISId;
        ue2.UIP__c = u.Id;
        ueList.add(ue2);
        UIP_Element__c ue3 = new UIP_Element__c();
        ue3.RecordTypeId = rtRCId;
        ue3.UIP__c = u.Id;
        ueList.add(ue3);
        ue.Root_Cause_1__c = ue2.Id;
        ue2.Major_Improvement_Strategy_1__c = ue3.Id;
        insert ueList;
        //Priority_Performance_Challenge__c ppc = new Priority_Performance_Challenge__c();
        ///ppc.Name = 'PPC Name';
        //insert ppc;
        
        Performance_Indicator_Targets__c pit = new Performance_Indicator_Targets__c();
        pit.UIP__c = u.Id;
        insert pit;
        
        Performance_Indicator_Notable_Trends__c pint = new Performance_Indicator_Notable_Trends__c();
        pint.UIP__c = u.Id;
        insert pint;
        
        Improvement_Action_Step__c ias = new Improvement_Action_Step__c();
        ias.UIP__c = u.Id;
        insert ias;
        
        Attachment att = new Attachment();
        att.Name = 'Test Att';
        att.ParentId = u.id;
        att.Body = Blob.valueOf('Unit Test Attachment Body');
        insert att;
        
        UIP_Contact__c uc = new UIP_Contact__c();
        uc.UIP__c = u.Id;
        Test.setCurrentPage(Page.UIPHome);
        Apexpages.currentPage().getParameters().put('id', u.Id);
        test.startTest();
        UIPHomeController uipc = new UIPHomeController();
        uipc.getForwardTocustomStartPage();
        uipc.getElemRTIds();
        uipc.getNameWithoutVersion('Test');
        uipc.populatePPCTable();
        uipc.produceUIPDoc();
        test.stopTest();
        /*uipc.uip.TextAreaRich_Test__c = 'gfdgsdg';
uipc.uip.Section_IV_Action_Planning_Complete__c = true;
uipc.uip.Section_IV_Target_Setting_Complete__c = true;
uipc.SaveTest();
uipc.submitForSchoolReview();
uipc.submitRecord('V');
uipc.submitForReview();*/
        
    }
    
    static testMethod void myUnitTest4() 
    {
        Account a = new Account();
        a.Name = 'Test Acc';
        insert a;
        
        UIP_Annual_CDE_Plan__c uac = new UIP_Annual_CDE_Plan__c();
        insert uac;       
        
        UIP__c u = new UIP__c();
        u.Name = 'Test';
        u.DISTRICT_NAME__c = a.Id;
        u.UIP_Annual_CDE_Plan__c = uac.Id;
        insert u;
        
        UIP__c u2 = new UIP__c();
        u2.Name = 'Test ~Final 1';
        u2.DISTRICT_NAME__c = a.Id;
        u2.UIP_Annual_CDE_Plan__c = uac.Id;
        insert u2;
        
        String rtChallengeId = Schema.SObjectType.UIP_Element__c.getRecordTypeInfosByName().get('Challenge').getRecordTypeId();
        String rtMISId = Schema.SObjectType.UIP_Element__c.getRecordTypeInfosByName().get('Major Improvement Strategy').getRecordTypeId();
        String rtRCId = Schema.SObjectType.UIP_Element__c.getRecordTypeInfosByName().get('Root Cause').getRecordTypeId();
        
        List<UIP_Element__c> ueList = new List<UIP_Element__c>();
        UIP_Element__c ue = new UIP_Element__c();
        ue.RecordTypeId = rtChallengeId;
        ue.UIP__c = u.Id;
        ueList.add(ue);
        UIP_Element__c ue2 = new UIP_Element__c();
        ue2.RecordTypeId = rtMISId;
        ue2.UIP__c = u.Id;
        ueList.add(ue2);
        UIP_Element__c ue3 = new UIP_Element__c();
        ue3.RecordTypeId = rtRCId;
        ue3.UIP__c = u.Id;
        ueList.add(ue3);
        ue.Root_Cause_1__c = ue2.Id;
        ue2.Major_Improvement_Strategy_1__c = ue3.Id;
        insert ueList;
        
        Performance_Indicator_Targets__c pit = new Performance_Indicator_Targets__c();
        pit.UIP__c = u.Id;
        insert pit;
        
        Performance_Indicator_Notable_Trends__c pint = new Performance_Indicator_Notable_Trends__c();
        pint.UIP__c = u.Id;
        insert pint;
        
        Improvement_Action_Step__c ias = new Improvement_Action_Step__c();
        ias.UIP__c = u.Id;
        insert ias;
        
        Attachment att = new Attachment();
        att.Name = 'Test Att';
        att.ParentId = u.id;
        att.Body = Blob.valueOf('Unit Test Attachment Body');
        insert att;
        
        UIP_Contact__c uc = new UIP_Contact__c();
        uc.UIP__c = u.Id;
        Test.setCurrentPage(Page.UIPHome);
        Apexpages.currentPage().getParameters().put('id', u.Id);
        
        UIPHomeController uipc = new UIPHomeController();
        uipc.uip.TextAreaRich_Test__c = 'gfdgsdg';
        uipc.uip.Section_IV_Action_Planning_Complete__c = true;
        uipc.uip.Section_IV_Target_Setting_Complete__c = true;
        test.startTest();
        uipc.SaveTest();
        uipc.submitForSchoolReview();
        //uipc.submitRecord('V');
        //uipc.submitForReview();
        test.stopTest();
    }
    
    static testMethod void myUnitTest2() 
    {
        Account a = new Account();
        a.Name = 'Test Acc';
        insert a;
        
        UIP_Annual_CDE_Plan__c uac = new UIP_Annual_CDE_Plan__c();
        insert uac;       
        
        UIP__c u = new UIP__c();
        u.Name = 'Test';
        u.DISTRICT_NAME__c = a.Id;
        u.UIP_Annual_CDE_Plan__c = uac.Id;
        insert u;
        
        UIP__c u2 = new UIP__c();
        u2.Name = 'Test ~Final 1';
        u2.DISTRICT_NAME__c = a.Id;
        u2.UIP_Annual_CDE_Plan__c = uac.Id;
        insert u2;
        
        UIP_Element__c ue = new UIP_Element__c();
        ue.UIP__c = u.Id;
        insert ue;
        
        //Priority_Performance_Challenge__c ppc = new Priority_Performance_Challenge__c();
        ///ppc.Name = 'PPC Name';
        //insert ppc;
        
        Performance_Indicator_Targets__c pit = new Performance_Indicator_Targets__c();
        pit.UIP__c = u.Id;
        insert pit;
        
        Performance_Indicator_Notable_Trends__c pint = new Performance_Indicator_Notable_Trends__c();
        pint.UIP__c = u.Id;
        insert pint;
        
        Improvement_Action_Step__c ias = new Improvement_Action_Step__c();
        ias.UIP__c = u.Id;
        insert ias;
        
        Attachment att = new Attachment();
        att.Name = 'Test Att';
        att.ParentId = u.id;
        att.Body = Blob.valueOf('Unit Test Attachment Body');
        insert att;
        
        UIP_Contact__c uc = new UIP_Contact__c();
        uc.UIP__c = u.Id;
        Test.setCurrentPage(Page.UIPHome);
        Apexpages.currentPage().getParameters().put('id', u.Id);
        UIPHomeController uipc = new UIPHomeController();
        //ppc = [SELECT Id, Name FROM Priority_Performance_Challenge__c WHERE Id= :ppc.Id];
        //uipc.ppcList = new List<Priority_Performance_Challenge__c>();
        //uipc.rcList = new List<Challenge_Root__c>();
        uipc.getForwardTocustomStartPage();
        //uipc.ppcList.add(ppc);
        uipc.getElemRTIds();
        uipc.getVersion('Test this that ~V3');
        //uipc.getPPCOptions();
        //uipc.getRCOptions();
        uipc.populatePPCTable();
        uipc.produceUIPDoc();
        //uipc.Save();
        //uipc.uip.TextAreaRich_Test__c = 'gfdgsdg';
        //uipc.uip.Section_IV_Action_Planning_Complete__c = true;
        //uipc.uip.Section_IV_Target_Setting_Complete__c = true;
        uipc.SaveTest();
        uipc.submitForSchoolReview();
        uipc.submitForReview();
        
        //uipc.submitRecord('V');
        
        
        UIPHomeController uipc1 = new UIPHomeController(NULL);
        UIPHomeController.TableWrapper t=new UIPHomeController.TableWrapper();
        t.firstColChecked=NULL;
        t.secondColChecked=NULL;
        t.thirdColChecked=NULL;
        t.fourthColChecked=NULL;
        t.fifthColChecked=NULL;
        t.sixthColChecked=NULL;
        t.seventhColChecked=NULL;
        t.eightColChecked=NULL;
        Date s=Date.today();
        Date d=Date.today()+2;
        Date e=Date.today()+4;
        uipc.calculatePrecentCurrentDate(d,s,e);
    }
    
    static testMethod void myUnitTest3() 
    {
        Account a = new Account();
        a.Name = 'Test Acc';
        insert a;
        
        UIP_Annual_CDE_Plan__c uac = new UIP_Annual_CDE_Plan__c();
        insert uac;       
        
        UIP__c u = new UIP__c();
        u.Name = 'Test';
        u.DISTRICT_NAME__c = a.Id;
        u.UIP_Annual_CDE_Plan__c = uac.Id;
        u.TextAreaRich_Test__c='test';
        u.Section_IV_Action_Planning_Complete__c=true;
        u.Section_IV_Target_Setting_Complete__c=true;
        insert u;
        
        UIP__c u2 = new UIP__c();
        u2.Name = 'Test ~Final 1';
        u2.DISTRICT_NAME__c = a.Id;
        u2.UIP_Annual_CDE_Plan__c = uac.Id;
        insert u2;
        
        UIP_Element__c ue = new UIP_Element__c();
        ue.UIP__c = u.Id;
        insert ue;
        
        Performance_Indicator_Targets__c pit = new Performance_Indicator_Targets__c();
        pit.UIP__c = u.Id;
        insert pit;
        
        Performance_Indicator_Notable_Trends__c pint = new Performance_Indicator_Notable_Trends__c();
        pint.UIP__c = u.Id;
        insert pint;
        
        Improvement_Action_Step__c ias = new Improvement_Action_Step__c();
        ias.UIP__c = u.Id;
        insert ias;
        
        Attachment att = new Attachment();
        att.Name = 'Test Att';
        att.ParentId = u.id;
        att.Body = Blob.valueOf('Unit Test Attachment Body');
        insert att;
        
        UIP_Contact__c uc = new UIP_Contact__c();
        uc.UIP__c = u.Id;
        Test.setCurrentPage(Page.UIPHome);
        Apexpages.currentPage().getParameters().put('id', u.Id);
        
        UIPHomeController uipc = new UIPHomeController();
        uipc.isSchoolUser=true;
        uipc.isDistrictUser=true;
        uipc.isSchoolAdmin=true;
        test.startTest();
        uipc.submitForSchoolReview();
        
		//uipc.submitForReview();
        test.stoptest();
    }
    static testMethod void myUnitTest5() 
    {
        Account a = new Account();
        a.Name = 'Test Acc';
        insert a;
        
        UIP_Annual_CDE_Plan__c uac = new UIP_Annual_CDE_Plan__c();
        insert uac;       
        
        UIP__c u = new UIP__c();
        u.Name = 'Test';
        u.DISTRICT_NAME__c = a.Id;
        u.UIP_Annual_CDE_Plan__c = uac.Id;
        u.TextAreaRich_Test__c='test';
        u.Section_IV_Action_Planning_Complete__c=false;
        u.Section_IV_Target_Setting_Complete__c=true;
        insert u;
        
        UIP__c u2 = new UIP__c();
        u2.Name = 'Test ~Final 1';
        u2.DISTRICT_NAME__c = a.Id;
        u2.UIP_Annual_CDE_Plan__c = uac.Id;
        insert u2;
        
        UIP_Element__c ue = new UIP_Element__c();
        ue.UIP__c = u.Id;
        insert ue;
        
        Performance_Indicator_Targets__c pit = new Performance_Indicator_Targets__c();
        pit.UIP__c = u.Id;
        insert pit;
        
        Performance_Indicator_Notable_Trends__c pint = new Performance_Indicator_Notable_Trends__c();
        pint.UIP__c = u.Id;
        insert pint;
        
        Improvement_Action_Step__c ias = new Improvement_Action_Step__c();
        ias.UIP__c = u.Id;
        insert ias;
        
        Attachment att = new Attachment();
        att.Name = 'Test Att';
        att.ParentId = u.id;
        att.Body = Blob.valueOf('Unit Test Attachment Body');
        insert att;
        
        UIP_Contact__c uc = new UIP_Contact__c();
        uc.UIP__c = u.Id;
        Test.setCurrentPage(Page.UIPHome);
        Apexpages.currentPage().getParameters().put('id', u.Id);
        
        UIPHomeController uipc = new UIPHomeController();
        uipc.isSchoolUser=true;
        uipc.isDistrictUser=true;
        uipc.isSchoolAdmin=true;
        uipc.submitForSchoolReview();
        uipc.submitForReview();
        uipc.submitRecord('Version');
        uipc.deleteExistingFinalVersion();
        uipc.getNameWithoutVersion('test uschool ~V');
        
        uipc.executiveSummary();
        uipc.downloadPDF();
        uipc.downloadViewPDF();
    }
}