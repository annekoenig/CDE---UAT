@isTest
public class UIP_AllTest 
{
    static testMethod void myUnitTest() 
    {
        Account a = new Account();
        a.Name = 'Test Acc Name';
        insert a;
        
        UIP_Annual_CDE_Plan__c uac = new UIP_Annual_CDE_Plan__c();
        insert uac;
       
        
        UIP__c u = new UIP__c();
        u.DISTRICT_NAME__c = a.Id;
        u.UIP_Annual_CDE_Plan__c = uac.Id;
        u.ESEA__c = 'Yes';
        u.Gifted_Education__c = 'Yes';
        u.Student_Grad_Completion_Plan__c = 'Yes';
        u.Title_III__c = 'Yes';
        u.Turnaround__c = 'Yes';
        u.TIG_Closure__c = 'Yes';
        u.TIG_Transformation__c = 'Yes';
        u.TIG_Turnaround__c = 'Yes';
        u.Title_1_School_Wide__c = 'Yes';
        insert u;
        
        Addendum__c add = new Addendum__c();
        add.UIP__c = u.Id;
        
        u = [SELECT Id, DISTRICT_NAME__c, UIP_Annual_CDE_Plan__c FROM UIP__c WHERE Id= :u.Id];
        update u;
    }
    static testMethod void myUnitTestExc() 
    {	
    	String schoolUIP = Schema.SObjectType.UIP__c.getRecordTypeInfosByName().get('School UIP').getRecordTypeId();
        String districtUIP = Schema.SObjectType.UIP__c.getRecordTypeInfosByName().get('District UIP').getRecordTypeId();
    	
        Account a = new Account();
        a.Name = 'Test Acc Name';
        insert a;
        
        UIP_Annual_CDE_Plan__c uac = new UIP_Annual_CDE_Plan__c();
        insert uac;
        
        UIP__c uId = new UIP__c();
        uId.DISTRICT_NAME__c = a.Id;
        uId.UIP_Annual_CDE_Plan__c = uac.Id;
        uId.RecordTypeId = districtUIP;
        uId.DIST_NUMBER__c = '010';
        insert uId; 
        
        SectionUtil.stopTrigger = false;
        
        system.debug('insert begin:::');
        
        UIP__c u = new UIP__c();
        u.RecordTypeId = schoolUIP;
        u.DISTRICT_NAME__c = a.Id;
        u.DIST_NUMBER__c = '010';
        u.Combined_Plan__c = true;
        u.UIP_Annual_CDE_Plan__c = uac.Id;
        u.ESEA__c = 'Yes';
        u.Gifted_Education__c = 'Yes';
        u.Student_Grad_Completion_Plan__c = 'Yes';
        u.Title_III__c = 'Yes';
        u.Turnaround__c = 'Yes';
        u.TIG_Closure__c = 'Yes';
        u.TIG_Transformation__c = 'Yes';
        u.TIG_Turnaround__c = 'Yes';
        u.Title_1_School_Wide__c = 'Yes';
        insert u;
        
        SectionUtil.stopTrigger = false;
        
        system.debug('update begin:::');
        u.Combined_Plan__c = false;
        update u;
    }
}