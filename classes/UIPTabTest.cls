@isTest
public with sharing class UIPTabTest {
	public static testmethod void test1() {
		KeyValueStore__c kvs = new KeyValueStore__c(Name='UIP Tab Link', TextValue__c='www.google.com');
		insert kvs;
		UIPTab ctrl = new UIPTab();
		ctrl.goToList();
	}
}