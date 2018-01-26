public with sharing class UIPTab {
	
	public UIPTab() {}
	
	public PageReference goToList() {
		KeyValueStore__c uipTabLink = KeyValueStore__c.getValues('UIP Tab Link');
		return new PageReference(uipTabLink.TextValue__c);
	}
}