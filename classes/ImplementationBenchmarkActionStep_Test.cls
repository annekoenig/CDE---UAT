@isTest
public class ImplementationBenchmarkActionStep_Test 
{
    static testmethod void method1()
    {
        String rType = [Select Id From RecordType  Where SobjectType = 'UIP__c' and DeveloperName = 'AEC_UIP'].Id;
        String rtMISId = Schema.SObjectType.UIP_Element__c.getRecordTypeInfosByName().get('Major Improvement Strategy').getRecordTypeId();
        
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
        
        UIP_Element__c uipEl = new UIP_Element__c();
        uipEl.UIP__c = u.Id;
        uipEl.Name = 'Test El';
        uipEl.RecordTypeId = rtMISId;
        insert uipEl;
        
        Implementation_Benchmark__c b=new Implementation_Benchmark__c();
        b.UIP__c = u.Id;
        b.name='test';
        b.Major_Improvement_Strategy__c = uipEl.Id;
        b.Public_Facing__c=TRUE;
        insert b;
        b.Public_Facing__c=TRUE;
        b.name='test1';
        update b;
        
                
        Improvement_Action_Step__c i = new Improvement_Action_Step__c();
        i.UIP__c = u.Id;
        i.name='test';
        i.Major_Improvement_Strategy__c = uipEl.Id;
        i.Public_Facing__c=TRUE;
        insert i;
        i.Public_Facing__c=TRUE;
        i.name='test1';
        update i;
        
    }
}