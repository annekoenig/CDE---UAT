public with sharing class SSO_Utility {

	public static Map<String, Account> accountMap {get; private set;}
	public static Map<String, Profile> profileMap {get; private set;}
	public static MAP<String, UserRole> roleMap {get; private set;}
	public static MAP<String, Contact> contactMap {get; private set;}

	public static Set<String> districtNumberSet = new Set<String>();
	public static Set<String> schoolNumberSet = new Set<String>();
	public static Set<String> profileNameSet = new Set<String>();
	public static Set<String> emailSet = new Set<String>();

	//public static UIP_Role ParseProvidedSecurityInfo(String secInfo) {
	public static String ParseProvidedSecurityInfo(String secInfo) {
		
		//split the secInfo on "," to verify that there is not muliple profiles being passed in:
		List<String> profilesRequested = secInfo.split(',');
		if(profilesRequested.size() == 1) {

			UIP_Role uipRoleObject = new UIP_Role();
			List<String> roleProfileCombo = null;	
			
			//split into 2 parts (role & profile)
			roleProfileCombo = profilesRequested[0].split('~');

			//pull off the "UIP-" prefix
			roleProfileCombo[0] = roleProfileCombo[0].substring(4);

			//split the role into 2 parts District id & school id
			List<String> roleSplit = roleProfileCombo[0].split('-');
			uipRoleObject.districtId = roleSplit[0]; 
			if(roleSplit.size() > 1) {
				uipRoleObject.schoolId = roleSplit[1]; 
			} else {
				uipRoleObject.schoolId = '';
			}
			uipRoleObject.profileName = roleProfileCombo[1].replace('_',' ');
			
			districtNumberSet.add(uipRoleObject.districtId);
			schoolNumberSet.add(uipRoleObject.schoolId);
			profileNameSet.add(uipRoleObject.profileName);

			return uipRoleObject.districtId + '~' + uipRoleObject.schoolId + '~' + uipRoleObject.profileName;
			//return uipRoleObject;
		} 
		//error condition - too many profiles requested in incoming request
		return null;
 
	}

	public static void getObjectMaps(Boolean setContacts) {
		setProfileMap();
		setAccountMap();
		setRoleMap();
		if(setContacts) {
			setContactMap();
		}
	}

	//public static void setProfileMap(Set<String> profileNames) {
	private static void setProfileMap() {
		if(profileMap == null) {
			profileMap = new Map<String, Profile>();
			System.debug('### profileNameSet = ' + profileNameSet);
			List<Profile> profileList = [SELECT id, Name FROM Profile WHERE Name IN :profileNameSet];
			System.debug('### profilelist.size = ' + profileList.size());
			for(Profile p : profileList) {
				profileMap.put(p.Name.toUpperCase(), p);
			}
		}
	}
	
	//public static void setAccountMap(Set<String> districtNumbers, Set<String> schoolNumbers) {
	private static void setAccountMap() {
		if(accountMap == null) {
			accountMap = new Map<String, Account>();
			List<Account> accountList = [SELECT id,Name,DIST_NUMBER__c,SCHOOL_NUMBER__c FROM Account 
							     WHERE DIST_NUMBER__c IN :districtNumberSet
						           AND SCHOOL_NUMBER__c IN :schoolNumberSet];
			for(Account a : accountList) {
				String schoolNum = a.SCHOOL_NUMBER__c;
				if(schoolNum == null) {
					schoolNum = '';
				}
				accountMap.put(a.DIST_NUMBER__c + '~' + schoolNum, a);
			}
		}
	}

	private static void setRoleMap() {
		if(roleMap == null) {
			roleMap = new Map<String, UserRole>();
			List<Account> accountList = [SELECT id,Name,DIST_NUMBER__c FROM Account 
							     WHERE DIST_NUMBER__c IN :districtNumberSet
						           AND SCHOOL_NUMBER__c = ''];
			Map<String,String> roleNameMap = new Map<String,String>();
			for(Account a : accountList) {
				roleNameMap.put(a.Name, a.DIST_NUMBER__c);
			}
			//add Admin role for use for Admin Users
			roleNameMap.put('CDE Admin', '0000');
			List<UserRole> roleList = [SELECT id, Name from UserRole WHERE Name IN :roleNameMap.KeySet()];

			for(UserRole ur : roleList) {
				roleMap.put(ur.Name, ur);
			}
		}
	}

	private static void setContactMap() {
		if(contactMap == null) {
			contactMap = new Map<String, Contact>();
			List<Contact> contactList = [SELECT id, Email FROM Contact WHERE Email IN :emailSet];
			
			for(Contact c : contactList) {
				contactMap.put(c.Email, c);
			}
		}
	}

	public class UIP_Role {
		public string districtId {get; set;}
		public string schoolId {get; set;}
		public string profileName {get; set;}
	}
}