@isTest
public class EscapeCharactersTest {

    public static testMethod void test1() {
        
        UIPfields__c field = new UIPfields__c();
        field.Name = 'Name';
        field.Field_API_Name__c = 'Name';
        insert field;
        
        Account a = new Account();
        a.Name = 'Test Acc';
        insert a;
        
        UIP_Annual_CDE_Plan__c uac = new UIP_Annual_CDE_Plan__c();
        insert uac;       
        
        String rtSchoolId = Schema.SObjectType.UIP__c.getRecordTypeInfosByName().get('School UIP').getRecordTypeId();
    
        UIP__c u = new UIP__c();
        u.DISTRICT_NAME__c = a.Id;
        u.UIP_Annual_CDE_Plan__c = uac.Id;
        u.Is_Version__c = false;
        u.RecordTypeId = rtSchoolId;
        insert u;
        
    }

}