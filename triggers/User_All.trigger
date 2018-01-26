/**********************************************************************
 *         NAME: User_All
 *      PURPOSE: update values
 *   CREATED BY: Lance (Vertiba, Inc)
 * CREATED DATE: 05/2014
 *        NOTES: Since the SSO only allows us to write to a "text"
 *               custom field we have to use the AboutMe field since it 
 *              is a "LongText" to store the incoming roles
 **********************************************************************
 * CHANGE LOG
 **********************************************************************
 * DATE:        BY:                         WHAT:
 * 06/13/2014   Lance Davala                Created         
 **********************************************************************/
trigger User_All on User (before insert, before update) {
    System.debug('### start User_All trigger');
    
    //Map<String, Contact> contactEmailMap = new Map<String, Contact>();

    if(trigger.isBefore) {
        getAccountRoleAndProfile();
        setProfileRoleAndAccount();
    }

    private void getAccountRoleAndProfile() {
        for (User u : Trigger.new) {
            System.debug('user:::' + u);
            if(u.CDE_Role_Info__c != null && u.CDE_Role_Info__c.toUpperCase().startsWith('UIP-')) {
                u.ProfileId = null;
                u.CDE_Role_Info__c = SSO_Utility.ParseProvidedSecurityInfo(u.CDE_Role_Info__c);
                if(u.CDE_Role_Info__c != null) {
                    SSO_Utility.emailSet.add(u.Email);
                } 
            }
        }
        SSO_Utility.getObjectMaps(true);
    }

    private void setProfileRoleAndAccount() {
        for(User u : Trigger.new) {
            //if community user = DistId & SchoolId 
            if(u.CDE_Role_Info__c != null) {
                System.debug('### lookup account by: ' + u.CDE_Role_Info__c.substring(0, u.CDE_Role_Info__c.lastIndexOf('~')));
                Account relateToAccount = SSO_Utility.accountMap.get(u.CDE_Role_Info__c.substring(0, u.CDE_Role_Info__c.lastIndexOf('~')));
                if(relateToAccount != null) {
                    System.debug('### Account Found = ' + relateToAccount.id);
                    //look for contact record
                    System.debug('### contactmap = ' + SSO_Utility.contactMap);
                    Contact linkedContact = SSO_Utility.contactMap.get(u.Email);
                    if(linkedContact != null) {
                        if(trigger.isInsert) {
                            u.ContactID = SSO_Utility.contactMap.get(u.Email).Id;
                            System.debug('### contact found = ' + u.ContactID);
                        }
                    }

                    String schoolId = u.CDE_Role_Info__c.substring(u.CDE_Role_Info__c.indexOf('~')+1,u.CDE_Role_Info__c.lastIndexOf('~'));
                    if(schoolId == '') {
                        System.debug('### roleMap = ' + SSO_Utility.roleMap.KeySet());
                        u.UserRoleId = SSO_Utility.roleMap.get(relateToAccount.Name).Id;
                    }
                } else {
                    u.UserRoleId = SSO_Utility.roleMap.get('CDE Admin').Id;
                }
                u.ProfileId = SSO_Utility.profileMap.get(u.CDE_Role_Info__c.substring(u.CDE_Role_Info__c.lastIndexOf('~')+1).toUpperCase()).Id;
                u.CDE_Role_Info__c = null;
            }
        }
    }
    /*
    private UIP_Role ParseProvidedSecurityInfo(String secInfo) {
        
        UIP_Role uipRoleObject = new UIP_Role();
        List<String> roleProfileCombo = null;   
        
        //split into 2 parts (role & profile)
        roleProfileCombo = secInfo.split('~');

        //pull off the "UIP-" prefix
        roleProfileCombo[0] = roleProfileCombo[0].substring(4);

        //split the role into 2 parts District id & school id
        List<String> roleSplit = roleProfileCombo[0].split('-');
        uipRoleObject.districtId = roleSplit[0]; 
        if(roleSplit.size() > 1) {
            uipRoleObject.schoolId = roleSplit[1]; 
        } else {
            uipRoleObject.schoolId = 'NONE';
        }
        uipRoleObject.profileName = roleProfileCombo[1].replace('_',' ');
        
        return uipRoleObject;
 
    }
    
    private class UIP_Role {
        public string districtId {get; set;}
        public string schoolId {get; set;}
        public string profileName {get; set;}
    }
*/
}

/*
private UIP_Role ParseAboutMe(String aboutMe) {
        
        UIP_Role uipRoleObject = new UIP_Role();
        List<String> roleProfileCombo = null;
        if(aboutMe != null) {
            List<String> allRoles = aboutMe.split(',');
            String uipRole = null;
            for(String role : allRoles) {
                if(role.toUpperCase().startsWith('UIP')) {
                    uipRole = role;
                }
            }
            
            if(uipRole != null) {
                roleProfileCombo = uipRole.split('~');
                roleProfileCombo[0] = roleProfileCombo[0].substring(4);
                List<String> roleSplit = roleProfileCombo[0].split('-');
                uipRoleObject.districtId = roleSplit[0]; 
                if(roleSplit.size() > 1) {
                    uipRoleObject.schoolId = roleSplit[1]; 
                } else {
                    uipRoleObject.schoolId = 'NONE';
                }
                uipRoleObject.profileName = roleProfileCombo[1].replace('_',' ');
                
                return uipRoleObject;
            } 
        }
        return null;
    }
*/


/*      
                System.debug('### AboutMe is not null');
                //String uipRole = ParseCdeRoleInfo(so.CDE_Role_Info__c);

                u.ProfileId = '00eF0000000heUpIAI'; 
            }
            //if(so.AboutMe == 'xxx') {
        //      so.addError('User does not have permission to log into Salesforce.');
        //  }
        Map<String, Id> profileNames = new Map<String,Id>(); 
        List<Profile> profileList = [SELECT id, name from Profile];
        for(Profile p : profileList) {
            profileNames.put(p.Name, p.Id);
        }
            
    }
*/



/*
    private void getRoleAndProfilefromRelatedContact() {
        Set<String> emailSet = new Set<String>();
        for(User u : Trigger.new) {
            System.debug('user:::' + u);
            emailSet.add(u.Email);
        }
        //get contacts with the provided emails
        List<Contact> relatedContactList = [SELECT id, Name, Email, AccountId, Account.Name, CDE_Role_Info__c FROM Contact where Email IN :emailSet];
        for(Contact c : relatedContactList) {
            contactEmailMap.put(c.Email,c);
        }
    }

    private void setProfileRoleAndAccount() {
        for(User u : Trigger.new) {
            if(contactEmailMap.containsKey(u.Email)) {
                Contact relContact = contactEmailMap.get(u.Email);
                u.ContactId = relContact.Id;

                u.ProfileId = SSO_Utility.profileMap.get(relContact.CDE_Role_Info__c.substring(relContact.CDE_Role_Info__c.lastIndexOf('~')+1));

                if(SSO_Utility.accountMap.containsKey(relContact.CDE_Role_Info__c.substring(0,relContact.CDE_Role_Info__c.lastIndexOf('~'))) {
                    u.UserRoleId = SSO_Utility.
                }
                
                //Account a = relContact.CDE_Role_Info__c.substring(0, c.CDE_Role_Info__c.lastIndexOf('~')))
                //if(a != null) {}
                //u.Profile = SSO_Utility.accountMap.get()
                //u.Role =
                //SSO_Utility.accountMap.get(relContact.CDE_Role_Info__c.)
            }
        }
    }
    */