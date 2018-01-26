@isTest
public with sharing class DownloadAttachment_Test {
	public static testmethod void test1() {
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
    	
    	Attachment att = new Attachment();
        att.Name = 'Test Att';
        att.ParentId = u.id;
        att.Body = Blob.valueOf('Unit Test Attachment Body');
        insert att;
        
        ApexPages.currentPage().getParameters().put('attId', att.Id);
        DownloadAttachment controller = new DownloadAttachment();
	}
}