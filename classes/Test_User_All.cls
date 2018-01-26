/**********************************************************************
 *         NAME: Test_User_All
 *      PURPOSE: Test the User_All trigger
 *   CREATED BY: Lance (Vertiba, Inc)
 * CREATED DATE: 06/2014
 *        NOTES: 
 **********************************************************************
 * CHANGE LOG
 **********************************************************************
 * DATE:        BY: 				        WHAT:
 * 06/16/2014   Lance Davala                Created         
 **********************************************************************/

@isTest()
private class Test_User_All {

    static testMethod void createCommunityUser() {
        List<Account> acctList = new List<Account>();
        Account dummyAcct = new Account(Name='dummyAcct',DIST_NUMBER__c='9999',SCHOOL_NUMBER__c='8888', AccountNumber='9999-8888');
        acctList.add(dummyAcct);
        Account targetAcct = new Account(Name='MONTE VISTA C-8',DIST_NUMBER__c='0123',SCHOOL_NUMBER__c='4567', AccountNumber='0123-4567');
        acctList.add(targetAcct);
        insert acctList;

        Contact testContact = new Contact(FirstName='Test', LastName='Tester', AccountId=dummyAcct.id,email='test@tester.com',Department='UIP-0123-4567~School_Admin');
        insert testContact;

        Profile profileToIgnore = [SELECT id, Name FROM Profile WHERE Name = 'School Admin'];
        test.startTest();
            User testUser = new User(FirstName = 'Test1', LastName = 'Tester', Email = 'test@tester.com',
                                   Phone = '303-333-4444', Username = 'test@cdetest.com', Alias = 'test',
                                   CommunityNickname = 'test', TimeZoneSidKey = 'America/Denver', LocaleSidKey = 'en_US',
                                   EmailEncodingKey = 'UTF-8', LanguageLocaleKey = 'en_US', ProfileId = profileToIgnore.Id,
                                   CDE_Role_Info__c = 'UIP-0123-4567~School_Admin'
                    );
            //old value = CDE_Role_Info__c = 'ADULTED-0301-3,PIPELINE-0010-TI1~LEAVIEWER,UIP-0000~CDE_Admin,PIPELINE-0000-ACC~CDEADMIN,steq-0880-1,SSCC-0880-99,PIPELINE-0000-RED~CDEADMIN,rits-0900-2,GPS-1520-5'
            insert testUser; 
            System.debug('### testUser id = ' + testUser.Id);
            testUser = [SELECT id, CDE_Role_Info__c, ContactId, Contact.Name, UserRoleId, ProfileId, Profile.Name FROM User where id = :testUser.Id];
            Profile targetProfile = [Select id FROM Profile WHERE Name = 'School Admin'];
            System.debug('### testUser Contact name = ' + testUser.Contact.Name);
      
          system.assertEquals(testContact.Id, testUser.ContactId);
          system.assertEquals(targetProfile.Id, testUser.ProfileId);
          system.assertEquals(null, testUser.UserRoleId);
        test.stopTest();
    }
    static testMethod void createCommunityUserFailure() {
        //try to pass in too many user role requests 
        List<Account> acctList = new List<Account>();
        Account dummyAcct = new Account(Name='dummyAcct',DIST_NUMBER__c='9999',SCHOOL_NUMBER__c='8888', AccountNumber='9999-8888');
        acctList.add(dummyAcct);
        Account targetAcct = new Account(Name='MONTE VISTA C-8',DIST_NUMBER__c='0123',SCHOOL_NUMBER__c='4567', AccountNumber='0123-4567');
        acctList.add(targetAcct);
        insert acctList;

        Contact testContact = new Contact(FirstName='Test', LastName='Tester', AccountId=dummyAcct.id,email='test@tester.com',Department='UIP-0123-4567~School_Admin,UIP-0123-4567~School_User');
        try {
          insert testContact;
        } catch(exception e) {
          System.debug('### >' + e.getMessage() + '<');
          system.assert(e.getMessage().contains('Too Many Profiles Requested via Single Sign On'));
        }

        Profile profileToIgnore = [SELECT id, Name FROM Profile WHERE Name = 'District User'];
        test.startTest();
            User testUser = new User(FirstName = 'Test1', LastName = 'Tester', Email = 'test@tester.com',
                                   Phone = '303-333-4444', Username = 'test@cdetest.com', Alias = 'test',
                                   CommunityNickname = 'test', TimeZoneSidKey = 'America/Denver', LocaleSidKey = 'en_US',
                                   EmailEncodingKey = 'UTF-8', LanguageLocaleKey = 'en_US', ProfileId = profileToIgnore.Id,
                                   CDE_Role_Info__c = 'UIP-0123-4567~School_Admin,UIP-0123-4567~School_User'
                    );
            try {
              insert testUser; 
              } catch(exception e) {
                  system.assert(e.getMessage().contains('Required fields are missing: [ProfileId]'));
              }
         //   System.debug('### testUser id = ' + testUser.Id);
         //   testUser = [SELECT id, CDE_Role_Info__c, ContactId, Contact.Name, UserRoleId, ProfileId, Profile.Name FROM User where id = :testUser.Id];
         //   Profile targetProfile = [Select id FROM Profile WHERE Name = 'School Admin'];
         //   System.debug('### testUser Contact name = ' + testUser.Contact.Name);
      
         // system.assertEquals(testContact.Id, testUser.ContactId);
         // system.assertEquals(targetProfile.Id, testUser.ProfileId);
         // system.assertEquals(null, testUser.UserRoleId);
        test.stopTest();
    }

    static testMethod void createDistrictUser() {
        List<Account> acctList = new List<Account>();
        Account targetAcct = new Account(Name='MONTE VISTA C-8',DIST_NUMBER__c='0123', AccountNumber='0123');
        acctList.add(targetAcct);
        insert acctList;

        Profile profileToIgnore = [SELECT id, Name FROM Profile WHERE Name = 'School Admin'];
        test.startTest();
            User testUser = new User(FirstName = 'Test1', LastName = 'Tester', Email = 'test@tester.com',
                                   Phone = '303-333-4444', Username = 'test@cdetest.com', Alias = 'test',
                                   CommunityNickname = 'test', TimeZoneSidKey = 'America/Denver', LocaleSidKey = 'en_US',
                                   EmailEncodingKey = 'UTF-8', LanguageLocaleKey = 'en_US', ProfileId = profileToIgnore.Id,
                                   CDE_Role_Info__c = 'UIP-0123~District_Admin'
                    );
            insert testUser; 
            
            testUser = [SELECT id, CDE_Role_Info__c, ContactId, Contact.Name, UserRoleId, ProfileId, Profile.Name FROM User where id = :testUser.Id];
            Profile targetProfile = [Select id FROM Profile WHERE Name = 'District Admin'];
            UserRole targetUserRole = [Select id FROM UserRole WHERE Name = 'MONTE VISTA C-8'];
      
            system.assertEquals(null, testUser.ContactId);
            system.assertEquals(targetProfile.Id, testUser.ProfileId);
            system.assertEquals(targetUserRole.Id, testUser.UserRoleId);
        test.stopTest();
    }

    static testMethod void createAdminUser() {
        Profile profileToIgnore = [SELECT id, Name FROM Profile WHERE Name = 'School Admin'];      
        test.startTest();
            User testUser = new User(FirstName = 'Test1', LastName = 'Tester', Email = 'test@tester.com',
                                   Phone = '303-333-4444', Username = 'test@cdetest.com', Alias = 'test',
                                   CommunityNickname = 'test', TimeZoneSidKey = 'America/Denver', LocaleSidKey = 'en_US',
                                   EmailEncodingKey = 'UTF-8', LanguageLocaleKey = 'en_US', ProfileId = profileToIgnore.Id,
                                   CDE_Role_Info__c = 'UIP-0000~CDE_Admin'
                    );
            insert testUser; 
            System.debug('### testUser id = ' + testUser.Id);
            testUser = [SELECT id, CDE_Role_Info__c, ContactId, Contact.Name, UserRoleId, ProfileId, Profile.Name FROM User where id = :testUser.Id];
            Profile targetProfile = [Select id FROM Profile WHERE Name = 'CDE Admin'];
            UserRole targetUserRole = [Select id FROM UserRole WHERE Name = 'CDE Admin'];

          system.assertEquals(null, testUser.ContactId);
          system.assertEquals(targetProfile.Id, testUser.ProfileId);
          system.assertEquals(targetUserRole.Id, testUser.UserRoleId);
        test.stopTest();
    }

    static testMethod void createUserWithoutSSO() {
        Profile profileToInsert = [SELECT id, Name FROM Profile WHERE Name = 'System Administrator'];
        test.startTest();
            User testUser = new User(FirstName = 'Test1', LastName = 'Tester', Email = 'test@tester.com',
                                   Phone = '303-333-4444', Username = 'test@cdetest.com', Alias = 'test',
                                   CommunityNickname = 'test', TimeZoneSidKey = 'America/Denver', LocaleSidKey = 'en_US',
                                   EmailEncodingKey = 'UTF-8', LanguageLocaleKey = 'en_US', ProfileId = profileToInsert.Id
                    );
            insert testUser; 
            System.debug('### testUser id = ' + testUser.Id);
            testUser = [SELECT id, CDE_Role_Info__c, ContactId, Contact.Name, UserRoleId, ProfileId, Profile.Name FROM User where id = :testUser.Id];
            
          system.assertEquals(null, testUser.ContactId);
          system.assertEquals(profileToInsert.Id, testUser.ProfileId);
          system.assertEquals(null, testUser.UserRoleId);
        test.stopTest();
    }

    static testMethod void createContactWithoutSSO() {

        List<Account> acctList = new List<Account>();
        //insert an account that will be used as a dummy account
        Account dummyAcct = new Account(Name='dummyAcct',DIST_NUMBER__c='9999',SCHOOL_NUMBER__c='8888');
        acctList.add(dummyAcct);

        insert acctList;
        test.startTest();
            //insert contact to Overwrite the provided account with 
            Contact testContact = new Contact(FirstName='Test', LastName='Tester', AccountId=dummyAcct.id,email='test@tester.com',Department='Some Internal Department');

            insert testContact;

            testContact = [select id, AccountId from Contact where id = :testContact.Id];

            system.assertEquals(dummyAcct.id, testContact.AccountId);
        test.stopTest();
    }

    static testMethod void createAndUpdateAccount() {
        List<Account> acctList = new List<Account>();
        //insert an account that will be used as a dummy account
        Account dummyAcct = new Account(Name='dummyAcct',DIST_NUMBER__c='9999',SCHOOL_NUMBER__c='8888', AccountNumber='9999-8888');
        acctList.add(dummyAcct);
        insert acctList;

        dummyAcct.Name = 'Account';
        update dummyAcct;

        dummyAcct = [SELECT id, name, AccountNumber from Account where DIST_NUMBER__c='9999' and SCHOOL_NUMBER__c='8888'];
        System.assertEquals('dummyAcct', dummyAcct.name);
        System.assertEquals('9999-8888', dummyAcct.AccountNumber);
    }

    static testMethod void createAndUpdateSSOUser() {
        List<Account> acctList = new List<Account>();
        Account dummyAcct = new Account(Name='dummyAcct',DIST_NUMBER__c='9999',SCHOOL_NUMBER__c='8888', AccountNumber='9999-8888');
        acctList.add(dummyAcct);
        Account targetAcct = new Account(Name='MONTE VISTA C-8',DIST_NUMBER__c='0123',SCHOOL_NUMBER__c='4567', AccountNumber='0123-4567');
        acctList.add(targetAcct);
        insert acctList;

        Contact testContact = new Contact(FirstName='Test', LastName='Tester', AccountId=dummyAcct.id,email='test@tester.com',Department='UIP-0123-4567~School_Admin');
        insert testContact;

        Profile profileToIgnore = [SELECT id, Name FROM Profile WHERE Name = 'School Admin'];
        User testUser = new User(FirstName = 'Test1', LastName = 'Tester', Email = 'test@tester.com',
                                 Phone = '303-333-4444', Username = 'test@cdetest.com', Alias = 'test',
                                 CommunityNickname = 'test', TimeZoneSidKey = 'America/Denver', LocaleSidKey = 'en_US',
                                 EmailEncodingKey = 'UTF-8', LanguageLocaleKey = 'en_US', ProfileId = profileToIgnore.Id,
                                 CDE_Role_Info__c = 'UIP-0123-4567~School_Admin'
                                );
        insert testUser; 
            
        testUser = [SELECT id, Name, FederationIdentifier, CDE_Role_Info__c FROM User WHERE id = :testUser.Id];

        system.assertEquals(null, testUser.CDE_Role_Info__c);

        test.startTest();
            testUser.FederationIdentifier = 'SOME_NEW_VALUE';
        test.stopTest();
    }
}