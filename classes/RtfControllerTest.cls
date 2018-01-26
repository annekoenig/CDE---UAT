@isTest
private class RtfControllerTest 
{
    static testMethod void myUnitTest() 
    {
        Account a = new Account();
        a.Name = 'Test Acc';
        insert a;
        
        UIP_Annual_CDE_Plan__c uac = new UIP_Annual_CDE_Plan__c();
        insert uac;       
        
        UIP__c uip = new UIP__c();
        uip.DISTRICT_NAME__c = a.Id;
        uip.UIP_Annual_CDE_Plan__c = uac.Id;
        insert uip;
		
		UIP_Element__c uipEl = new UIP_Element__c();
		uipEl.UIP__c = uip.Id;
		insert uipEl;
        
        Performance_Indicator_Targets__c p = new Performance_Indicator_Targets__c();
        p.UIP__c = uip.Id;
        insert p;
        
        ApexPages.CurrentPage().getParameters().put('elemNumber', '1');
        ApexPages.CurrentPage().getParameters().put('elemId', p.Id);
        ApexPages.CurrentPage().getParameters().put('id', uip.Id);
        ApexPages.currentPage().getParameters().put('target','Academic Achievement (Status)');
        
        RtfPage ctrl = new RtfPage();
        ctrl.Cancel();
        ctrl.CancelNarrative();
        ctrl.selectUIP();
        ctrl.SaveReflexion();
        ctrl.SaveNarrative();
        
        //Integer noUip = [SELECT COUNT() FROM UIP__c WHERE Id= :uip.Id];
        
        //System.assertEquals(1, noUip);
    }
}