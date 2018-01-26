@isTest
public class NewAttachmentTest 
{
    static testMethod void myUnitTest() 
    {
        Account a = new Account();
        a.Name = 'Name';
        insert a;
        
        UIP_Annual_CDE_Plan__c uac = new UIP_Annual_CDE_Plan__c();
        insert uac;
        
        UIP__c u = new UIP__c();
        u.DISTRICT_NAME__c = a.Id;
        u.UIP_Annual_CDE_Plan__c = uac.Id;
        insert u;
        
        ApexPages.currentPage().getParameters().put('id', u.Id);
        
        NewAttachment ctrl = new NewAttachment();
        ctrl.Save();
    }
}