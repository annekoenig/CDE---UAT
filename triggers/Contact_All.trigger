/**********************************************************************
 *         NAME: Contact_All
 *      PURPOSE: During JIT Provisioning dynamically determine the 
 *               account to relate contact to
 *   CREATED BY: Lance (Vertiba, Inc)
 * CREATED DATE: 11/2014
 *        NOTES: Since the SSO JIT does not allow for custom fields 
 *               using the Departmnt field to pass in the information
 *               used to determine the account to relate this to
 **********************************************************************
 * CHANGE LOG
 **********************************************************************
 * DATE:        BY: 				        WHAT:
 * 06/13/2014   Lance Davala                Created         
 **********************************************************************/
trigger Contact_All on Contact (before insert) {
	System.debug('### start Contact_All trigger');

	//Map<String,SSO_Utility.UIP_Role> uipRoleMap = new Map<String,SSO_Utility.UIP_Role>();
	
	if(trigger.isBefore) {
		getAccountRoleAndProfile();
		setAccount();
	}

	private void getAccountRoleAndProfile() {
		for (Contact c : Trigger.new) {
			System.debug('contact:::' + c);
			if(c.Department != null && c.Department.toUpperCase().startsWith('UIP-')) {
				c.CDE_Role_Info__c = SSO_Utility.ParseProvidedSecurityInfo(c.Department);
				if(c.CDE_Role_Info__c == null) {
					c.addError('Too Many Profiles Requested via Single Sign On');
				}
				System.debug('### c.CDE_Role_Info__c = ' + c.CDE_Role_Info__c);
			}
		}
		SSO_Utility.getObjectMaps(false);
	}

	private void setAccount() {
		for (Contact c : Trigger.new) {
			if(c.CDE_Role_Info__c != null) {
				System.debug('### SET ACCOUNT BY = ' +c.CDE_Role_Info__c.substring(0, c.CDE_Role_Info__c.lastIndexOf('~')));
				System.debug('### SSO_Utility.accountMap = ' + SSO_Utility.accountMap.KeySet());
				c.AccountId = SSO_Utility.accountMap.get(c.CDE_Role_Info__c.substring(0, c.CDE_Role_Info__c.lastIndexOf('~'))).Id;
				c.Department = '';
			}
		}
	}
}