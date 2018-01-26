@isTest
public class ChooseUIPTest 
{
    static testMethod void myUnitTest() 
    {
        //Insert Custom Setting for Academic Year        
        Academic_Year__c ay = new Academic_Year__c();
        ay.Name = 'Academic Year';
        ay.currentAcademicYrStartDate__c = date.valueOf('2017-08-01');
        ay.currentAcademicYrEndDate__c = date.valueOf('2018-07-31');
        insert ay;
        
        Account a = new Account();
        a.Name = 'Test Acc';
        insert a;
        
        UIP_Annual_CDE_Plan__c uac = new UIP_Annual_CDE_Plan__c();
        insert uac;       
        
        String rtSchoolId = Schema.SObjectType.UIP__c.getRecordTypeInfosByName().get('School UIP').getRecordTypeId();
		
    	UIP__c u = new UIP__c();
        u.DISTRICT_NAME__c = a.Id;
        u.DIST_NUMBER__c = a.DIST_NUMBER__c;
        u.UIP_Annual_CDE_Plan__c = uac.Id;
        u.Is_Version__c = false;
        u.RecordTypeId = rtSchoolId;
    	insert u;
        
        UIP__c ui = new UIP__c();	// Selected UIP
        ui.DISTRICT_NAME__c = a.Id;
        ui.UIP_Annual_CDE_Plan__c = uac.Id;
        ui.Is_Version__c = false;
    	insert ui;
        
        UIP_Contact__c c = new UIP_Contact__c();
        c.Last_Name__c = 'sd';
        c.UIP__c = ui.Id;
        insert c;

        String challengeRT = Schema.SObjectType.UIP_Element__c.getRecordTypeInfosByName().get('Challenge').getRecordTypeId();        
        UIP_Element__c uc = new UIP_Element__c();
        uc.UIP__c = ui.Id;
		uc.RecordTypeId = challengeRT;
        insert uc;
        
        String MISRT = Schema.SObjectType.UIP_Element__c.getRecordTypeInfosByName().get('Major Improvement Strategy').getRecordTypeId();        
        UIP_Element__c um = new UIP_Element__c();
        um.UIP__c = ui.Id;
		um.RecordTypeId = MISRT;
        insert um;
        
        UIP_Element__c ue = new UIP_Element__c();
        ue.UIP__c = ui.Id;
        ue.Challenge_1__c = uc.id;
        insert ue;
        
        String thisYearRT = Schema.SObjectType.Performance_Indicator_Targets__c.getRecordTypeInfosByName().get('This Year\'s Target').getRecordTypeId();
        String nextYearRT = Schema.SObjectType.Performance_Indicator_Targets__c.getRecordTypeInfosByName().get('Next Year\'s Target').getRecordTypeId();
        List <Performance_Indicator_Targets__c> pitList = new List<Performance_Indicator_Targets__c>();
        Performance_Indicator_Targets__c pit = new Performance_Indicator_Targets__c();
        pit.UIP__c = ui.Id;
        pit.RecordTypeId = thisYearRt;
        pitList.add(pit);
        pit = new Performance_Indicator_Targets__c();
        pit.UIP__c = ui.Id;
        pit.Priority_Performance_Challenge_1__c = uc.id;
        pit.RecordTypeId = nextYearRt;
        pitList.add(pit);
        insert pitList;
        
        Performance_Indicator_Notable_Trends__c pint = new Performance_Indicator_Notable_Trends__c();
        pint.UIP__c = ui.Id;
        pint.Priority_Performance_Challenge_1__c = uc.Id;
        pint.Root_Cause_1__c = ue.id;
        insert pint;
        
        Improvement_Action_Step__c ias = new Improvement_Action_Step__c();
        ias.UIP__c = ui.Id;
        ias.School_Year__c = 'Next School Year';
        ias.Start_Date__c = Date.today().addYears(1);
        ias.Root_Cause_1__c = ue.id;
        ias.Major_Improvement_Strategy__c = um.id;
        
        insert ias;
        
        Performance_Indicator_Notable_Trends__c pintt = new Performance_Indicator_Notable_Trends__c();
        pintt.UIP__c = u.Id;
        insert pintt;
        
        Improvement_Action_Step__c iass = new Improvement_Action_Step__c();
        iass.UIP__c = u.Id;
        insert iass;
        
        Implementation_Benchmark__c ib = new Implementation_Benchmark__c();
        ib.UIP__c = ui.Id;
        ib.School_Year__c = 'Next School Year';
        ib.Start_Date__c = date.today().addYears(1);
        ib.Major_Improvement_Strategy__c = um.id;
        insert ib;
        
        BenchMar_AtciontStep__c bmas = new BenchMar_AtciontStep__c();
        bmas.Implementation_Benchmark__c =  ib.id;
        bmas.Improvement_Action_Step__c = ias.id;
        insert bmas;
        
        Addendum__c ad = new Addendum__c();
		ad.UIP__c = ui.id;
        insert ad;
        
        Supporting_Addenda_Forms__c saf = new Supporting_Addenda_Forms__c();
        saf.Addendum__c = ad.id;
        saf.Title_IA_PPC_Proposed_Amount__c= 10;
        insert saf;
        
        ApexPages.currentPage().getParameters().put('id', u.Id);
        
        ChooseUIP ctrl = new ChooseUIP();
        ctrl.getUIPs();
        ctrl.selectedUIP=ui.Id;
        ctrl.CopyValues();
        ctrl.CopyQuestion();
    }
}