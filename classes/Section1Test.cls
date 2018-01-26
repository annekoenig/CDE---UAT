@isTest
private class Section1Test {

    static testMethod void myUnitTest() 
    {
        Account a = new Account();
        a.Name = 'Test Acc';
        insert a;
        
        UIP_Annual_CDE_Plan__c uac = new UIP_Annual_CDE_Plan__c();
        insert uac;  
        
        UIP__c u = new UIP__c();
        u.DISTRICT_NAME__c = a.Id;
        u.UIP_Annual_CDE_Plan__c = uac.Id;
        u.TARG_E_ACH_PA_PCT_MATH__c = 71;
        u.TARG_H_ACH_PA_PCT_READ__c = 17;
        insert u;
        
        UIP_Contact__c c = new UIP_Contact__c();
        c.Last_Name__c = 'Bob';
        c.UIP__c = u.Id;
        insert c;
        
        ApexPages.currentPage().getParameters().put('contactId', c.Id);
        Apexpages.currentPage().getParameters().put('id', u.Id);
        ApexPages.Standardcontroller stdCtrl = new ApexPages.Standardcontroller(u);
        Section1 s = new Section1(stdCtrl);
        s.newContact();
        s.Save();
        s.selectUIP();
//        s.selectUIPContacts();
        s.showSections();
        s.updateUIP();
        s.DownloadWord_S2();
        s.DownloadExcel_S1();
        s.DownloadExcel_S1_District();
        s.DownloadExcel_S1_AEC();
        s.CancelNewContact();
        ApexPages.currentPage().getParameters().put('editContactId', c.Id);
        s.EditContact();
        s.SaveEditContact();
        s.CancelEditContact();
        s.AddContact();
        s.setPageChanged();
        s.DeleteContact();
        
        
        Integer noUIP = [SELECT COUNT() FROM UIP__c WHERE Id= :u.Id];
        System.assertEquals(1, noUIP);
        
        s.uipPlan = NULL;
		s.selectedContact = NULL;
		u.TARG_E_ACH_PA_PCT_READ__c=100;
		u.TARG_M_ACH_PA_PCT_READ__c=100;
		u.TARG_H_ACH_PA_PCT_READ__c=NULL;
		u.Stat_AddMeas_1_subj1_MeetCut_M__c=100;
		u.Stat_AddMeas_1_subj1_MeetCutE__c=100;
		u.Stat_AddMeas_1_subj1_MeetCut_H__c=100;
		u.Stat_AddMeas_2_subj1_MeetCutE__c=100;
		u.Stat_AddMeas_2_subj1_MeetCutH__c=100;
		u.Stat_AddMeas_2_subj1_MeetCutM__c=100;
        update u;
         s.selectUIP();
		s.showSections();
        
     /*   ApexPages.StandardController stdController = new ApexPages.StandardController(u);
        SectionHeader sh = new SectionHeader(stdController);
        sh.getSection1Map();
        sh.selectAllAddendums();
        sh.getAddendumRTMap(); */
    }
}