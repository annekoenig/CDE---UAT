@isTest
public class UIP_MigrateToZPIF_Test 
{
    static testmethod void method1()
    {
        String rType = [Select Id From RecordType  Where SobjectType = 'ZPIF_UIP__c' and DeveloperName = 'AEC_UIP'].Id;
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
        u.Public_Facing__c = true;
        u.SCHOOL_NUMBER__c='123';
        u.DIST_NUMBER__c='123';
        u.ZPIF_UIP_Identidier__c='13';
        insert u;
        
        UIP_MigrateToZPIF.InsertToCache(new List<UIP__c>{u});
    }
}