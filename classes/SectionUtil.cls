public without sharing class SectionUtil {
	public static boolean stopTrigger = false; //modified only by the UIP_All.trigger
	
	public static String setActiveMenu() {
		String currentURL = ApexPages.currentPage().getURL();
		String menuItem = '';
		system.debug('currentURL:::' + currentURL);
		if (currentURL.containsIgnoreCase('UIPHome')) {
			menuItem = 'UIPHome';
		} else if (currentURL.containsIgnoreCase('PublicUIP')) {
			menuItem = 'PublicUIP';				
		} else if (currentURL.containsIgnoreCase('Section1')) {
			menuItem = 'Section1';
		} else if (currentURL.containsIgnoreCase('Section2')) {
			menuItem = 'Section2';
		} else if (currentURL.containsIgnoreCase('Section3')) {
			menuItem = 'Section3';
		} else if (currentURL.containsIgnoreCase('Section4')) {
			menuItem = 'Section4';
		} else if (currentURL.containsIgnoreCase('Addend')) {
			menuItem = 'Addenda';
		} else if (currentURL.containsIgnoreCase('Collaboration')) {
			menuItem = 'Collaboration';
		}
		return menuItem;
	}
	
	public static String setActiveSubMenu() {
		String currentURL = ApexPages.currentPage().getURL();
		String submenuItem = '';
		system.debug('currentURL:::' + currentURL);
		if (currentURL.containsIgnoreCase('UIP_Narrative')) {
			submenuItem = 'UIP_Narrative';
		} else if (currentURL.containsIgnoreCase('Brief_Description')) {
			submenuItem = 'Brief_Description';
		} else if (currentURL.containsIgnoreCase('Prior_Year_Targets')) {
			submenuItem = 'Prior_Year_Targets';
		} else if (currentURL.containsIgnoreCase('Current_Performance')) {
			submenuItem = 'Current_Performance';
		} else if (currentURL.containsIgnoreCase('Trend_Analysis')) {
			submenuItem = 'Trend_Analysis';
		} else if (currentURL.containsIgnoreCase('Priority_Performance_Challenges')) {
			submenuItem = 'Priority_Performance_Challenges';
		} else if (currentURL.containsIgnoreCase('Root_Causes')) {
			submenuItem = 'Root_Causes';
		} else if (currentURL.containsIgnoreCase('Feedback')) {
			submenuItem = 'Feedback';
		} else if (currentURL.containsIgnoreCase('Chatter')) {
			submenuItem = 'Chatter';
		} else if (currentURL.containsIgnoreCase('School_Target')) {
			submenuItem = 'School_Target';
		} else if (currentURL.containsIgnoreCase('Planning_Form')) {
			submenuItem = 'Planning_Form';
		} else if (currentURL.containsIgnoreCase('Major_Imp_Strategies_Form')) {  //modified by preeti, added for new sub menu
			submenuItem = 'Major_Imp_Strategies_Form';
		} else if (currentURL.containsIgnoreCase('Full_Plan_Form')) {
			submenuItem = 'Full_Plan_Form';
		} 
		return submenuItem;
	}
	
	public static Boolean isCommunityUser() {
		boolean isCommunityUser = false;
		User currentUser = [SELECT Id, AccountId, ProfileId FROM User WHERE Id = :UserInfo.getUserId()];
		UserLicense customerCommunity = [SELECT Id, LicenseDefinitionKey FROM UserLicense WHERE LicenseDefinitionKey = 'PID_Customer_Community'];
		List<Profile> customerCommunityProfiles = [SELECT Id, Name FROM Profile WHERE UserLicenseId = :customerCommunity.Id];
		Map<Id, Profile> profilesMap = new Map<Id,Profile>();
		for (Profile p : customerCommunityProfiles) {
			profilesMap.put(p.id, p);
		}
		System.debug('currentUser:::' + currentUser);
		System.debug('profilesMap:::' + profilesMap);
		if (profilesMap.containsKey(currentUser.profileId)) {
			isCommunityUser = true;
		}
		return isCommunityUser;
	}
	
	public static Boolean isAdminUser() {
		boolean isAdminUser = false;
		User currentUser = [SELECT Id, AccountId, ProfileId, Profile.Name FROM User WHERE Id = :UserInfo.getUserId()];
		if (currentUser.Profile.Name == 'District Admin' || currentUser.Profile.Name == 'School Admin') {
			isAdminUser = true;
		}
		return isAdminUser;
	}
	
	public static String getUipId() {
		String currentId;
		Map<String,String> params = ApexPages.currentPage().getParameters();
    	if (params.containsKey('id')) {
        	currentId = params.get('id');
    	} else {
    		if (isCommunityUser()) {
	    		User currentUser = [SELECT Id, AccountId, ProfileId FROM User WHERE Id = :UserInfo.getUserId()];
	    		List<UIP__c> assignedUIP = [SELECT Id, RecordType.Name FROM UIP__c WHERE SCHOOL_NAME__c = :currentUser.AccountId AND Is_Version__c != true order by CreatedDate desc];
				if (assignedUIP.size() > 0) {
					currentId = assignedUIP[0].Id;
				}
				System.debug('assignedUIP:::' + assignedUIP);
    		}
    	}
    	return currentId;
	}
    
    public static String getFieldsQuery(String objName) {
        Map<String, Schema.SObjectField> fldObjMap;
        Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe(); 
        System.debug('gd::' + gd);
        fldObjMap = gd.get(objName).getDescribe().fields.getMap();
        System.debug('fldObjMap::' + fldObjMap);
        List<Schema.SObjectField> fldObjMapValues = new List<Schema.SObjectField>();
        for (Schema.SObjectField fld : fldObjMap.values())
            if (fld.getDescribe().isAccessible())
                fldObjMapValues.add(fld);
        System.debug('fldObjMapValues::' + fldObjMapValues);
        
        String theQuery = 'SELECT ';
        for(Schema.SObjectField s : fldObjMapValues) {
            if (s.getDescribe().isAccessible()) {
                String theName = s.getDescribe().getName();
                theQuery += theName + ',';
            }
        }
        
        // Trim last comma
        theQuery = theQuery.subString(0, theQuery.length() - 1);
        //theQuery += ' FROM ' + objName;
        return theQuery;
    }
    
    /*public static Map<Id, String> getPiRtIdMap(String objName) {
        List<RecordType> rts = [SELECT Id, Name FROM RecordType WHERE SobjectType = :objName];
        Map<Id, String> rtMap = new Map<Id, String>();
        for (RecordType rt : rts) {
            rtMap.put(rt.Id, rt.Name);
        }
        return rtMap;
    }*/
    
    public static Map<String, String> getPiRtValueMap(String objName) {
        List<RecordType> rts = [SELECT Id, Name FROM RecordType WHERE SobjectType = :objName];
        Map<String, String> rtMap = new Map<String, String>();
        for (RecordType rt : rts) {
            rtMap.put(rt.Name, rt.Id);
        }
        return rtMap;
    }
    
    /*public static Map<String, String> getPitRtIdMap(String objName, String uipRtName) {
        Map<String, String> pitRtMap = getPiRtValueMap(objName);
        System.debug('valueMap:::' + pitRtMap);
        List<RecordTypeDependencies__c> rts = [SELECT Id, PIT_RecordType__c, UIP_RT__c FROM RecordTypeDependencies__c WHERE UIP_RT__c = :uipRtName];
        System.debug('rts:::' + rts);
        Map<String, String> rtMap = new Map<String, String>();
        for (RecordTypeDependencies__c rt : rts) {
            rtMap.put(pitRtMap.get(rt.PIT_RecordType__c), rt.PIT_RecordType__c);
        }
        return rtMap;
    }*/
    
    public static Map<String, String> getPiValuesMap(String uipRtName) {
        List<RecordTypeDependencies__c> rts = [SELECT Id, PIT_RecordType__c, UIP_RT__c FROM RecordTypeDependencies__c WHERE UIP_RT__c = :uipRtName];
        System.debug('rts:::' + rts);
        Map<String, String> rtMap = new Map<String, String>();
        for (RecordTypeDependencies__c rt : rts) {
            rtMap.put(rt.PIT_RecordType__c, rt.PIT_RecordType__c);
        }
        return rtMap;
    }
    
    public static List<SelectOption> getPicklistValues(String obj, String fld){
        list<SelectOption> options = new list<SelectOption>();
        options.add(new SelectOption('', '-- None --'));
        // Get the object type of the SObject.
        Schema.sObjectType objType = Schema.getGlobalDescribe().get(obj);
        // Describe the SObject using its object type.
        Schema.DescribeSObjectResult objDescribe = objType.getDescribe();
        // Get a map of fields for the SObject
        map<String, Schema.SObjectField> fieldMap = objDescribe.fields.getMap();
        // Get the list of picklist values for this field.
        list<Schema.PicklistEntry> values = fieldMap.get(fld).getDescribe().getPickListValues();
        // Add these values to the selectoption list.
        for (Schema.PicklistEntry a : values) {
            options.add(new SelectOption(a.getValue(), a.getLabel()));
        }
        return options;
    }
    
    public static Date getDate(String stringDate) {
	    Date newDate;
	    if (stringDate != null && stringDate != '') {
	        Integer firstDelimiterPosition = stringDate.indexOf('/');
	        Integer month = Integer.valueOf(stringDate.substring(0, firstDelimiterPosition));
	        Integer secondDelimiterPosition = stringDate.lastIndexOf('/');
	        Integer day = Integer.valueOf(stringDate.substring(firstDelimiterPosition + 1, secondDelimiterPosition));
	        //Integer year = Integer.valueOf(stringDate.substring(secondDelimiterPosition + 1));
	        String year = stringDate.substring(secondDelimiterPosition + 1);
	        if (year.length() == 2) {
	        	year = String.valueOf(Date.today().year()).substring(0,2) + year;
	        }
	        newDate = Date.newInstance(integer.valueOf(year), month, day);
	    }
	    return newDate;
	}
}