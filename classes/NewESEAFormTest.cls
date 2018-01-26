@isTest
public class NewESEAFormTest 
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

        Addendum__c add = new Addendum__c();
        add.UIP__c = u.Id;
        insert add;        
        
        Supporting_Addenda_Forms__c sup = new Supporting_Addenda_Forms__c();
        sup.Addendum__c = add.Id;
        insert sup;
        
        
        ApexPages.currentPage().getParameters().put('id', u.Id);
        ApexPages.currentPage().getParameters().put('addendumId', add.Id);
        ApexPages.currentPage().getParameters().put('eseaId', sup.Id);
        ApexPages.currentPage().getParameters().put('isNewElem', 'true');
        
        NewESEAForm ctrl = new NewESEAForm();
        ctrl.Save();
        ctrl.DeleteQuestion();
        ctrl.DeleteSupAddendum();
    }
}