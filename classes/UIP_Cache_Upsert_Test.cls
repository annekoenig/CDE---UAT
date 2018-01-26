@isTest
private class UIP_Cache_Upsert_Test {
    
    static testMethod void myUnitTest() 
    {
        Account a = new Account();
        a.Name = 'Test Acc';
        insert a;
        
        UIP_Annual_CDE_Plan__c uac = new UIP_Annual_CDE_Plan__c();
        insert uac;       
        
        UIP__c u = new UIP__c();
        u.Name = 'Test 1';
        u.DISTRICT_NAME__c = a.Id;
        u.UIP_Annual_CDE_Plan__c = uac.Id;
                
        UIP__c u2 = new UIP__c();
        u2.Name = 'Test 2';
        u2.DISTRICT_NAME__c = a.Id;
        u2.UIP_Annual_CDE_Plan__c = uac.Id;
                
        List<UIP__c> uipList = new List<UIP__c>();
        uipList.add(u);
        uipList.add(u2);
        insert uipList;
        
        UIP_Contact__c uc = new UIP_Contact__c();
        uc.UIP__c = u.Id;
        uc.Public_Facing__c = false;
                
        UIP_Contact__c uc2 = new UIP_Contact__c();
        uc2.UIP__c = u2.Id;
        uc2.Public_Facing__c = false;
        
        List<UIP_Contact__c> uipconList = new List<UIP_Contact__c>();
        uipconList.add(uc);
        uipconList.add(uc2);
        insert uipconList;

		Id adRecordType1 = Schema.SObjectType.Addendum__c.getRecordTypeInfosByName().get('TIG Transformation').getRecordTypeId();
        Id adRecordType2 = Schema.SObjectType.Addendum__c.getRecordTypeInfosByName().get('DIST Gifted Program').getRecordTypeId();
                
        Addendum__c ad = new Addendum__c();
        ad.UIP__c = u.Id;
        ad.Name = 'Test 1';
        ad.RecordTypeId = adRecordType1;
                
        Addendum__c ad1 = new Addendum__c();
        ad1.UIP__c = u2.Id;
        ad1.Name = 'Test 2';
        ad1.RecordTypeId = adRecordType2;
        
        List<Addendum__c> addenList = new List<Addendum__c>();
        addenList.add(ad);
        addenList.add(ad1);
        insert addenList;
        
        String elRecordType1 = Schema.SObjectType.UIP_Element__c.getRecordTypeInfosByName().get('Major Improvement Strategy').getRecordTypeId();
        String elRecordType2 = Schema.SObjectType.UIP_Element__c.getRecordTypeInfosByName().get('Root Cause').getRecordTypeId();
        String elRecordType3 = Schema.SObjectType.UIP_Element__c.getRecordTypeInfosByName().get('Challenge').getRecordTypeId();
        
        UIP_Element__c ue = new UIP_Element__c();
        ue.Name = 'MIS1';
        ue.RecordTypeId = elRecordType1;
        ue.UIP__c = u.Id;
        ue.Public_Facing__c = false;
               
        UIP_Element__c ue2 = new UIP_Element__c();
        ue2.Name = 'RC1';
        ue2.RecordTypeId = elRecordType2;
        ue2.UIP__c = u2.Id;
        ue2.Public_Facing__c = false;
        
        UIP_Element__c ue3= new UIP_Element__c();
        ue3.Name = 'C1';
        ue3.RecordTypeId = elRecordType3;
        ue3.UIP__c = u.Id;
        ue3.Public_Facing__c = false;
        
        List<UIP_Element__c> uipelList = new List<UIP_Element__c>();
        uipelList.add(ue);
        uipelList.add(ue2);
        uipelList.add(ue3);
        insert uipelList;
        ue.Major_Improvement_Strategy_1__c = ue.Id;
        ue2.Root_Cause_1__c = ue2.Id;
        ue3.Challenge_1__c = ue3.Id;
               
        Improvement_Action_Step__c ias = new Improvement_Action_Step__c();
        ias.UIP__c = u.Id;
        ias.Name = 'Test 1';
        
        Improvement_Action_Step__c ias2 = new Improvement_Action_Step__c();
        ias2.UIP__c = u2.Id;
        ias2.Name = 'Test 2';
        
        List<Improvement_Action_Step__c> iasList = new List<Improvement_Action_Step__c>();
        iasList.add(ias);
        iasList.add(ias2);
        insert iasList;
        ias.improvement_action_step_source__c = ias.Id;
        ias2.improvement_action_step_source__c = ias2.Id;
        
        Implementation_Benchmark__c ib1 = new Implementation_Benchmark__c();
        ib1.Major_Improvement_Strategy__c = ue.Id;
        ib1.Public_Facing__c = false;
        ib1.Name = 'Test 1';
        ib1.UIP__c = u.Id;
                
        Implementation_Benchmark__c ib2 = new Implementation_Benchmark__c();
        ib2.Major_Improvement_Strategy__c = ue.Id;
        ib2.Public_Facing__c = false;
        ib2.Name = 'Test 2';
        ib2.UIP__c = u2.Id;
                
        List<Implementation_Benchmark__c> ibList = new List<Implementation_Benchmark__c>();
        ibList.add(ib1);
        ibList.add(ib2);
        insert ibList;
        
        BenchMar_AtciontStep__c bas1 = new BenchMar_AtciontStep__c();
        bas1.Implementation_Benchmark__c = ib1.Id;
        bas1.Improvement_Action_Step__c = ias.Id;
        bas1.Public_Facing__c = false;
                
        BenchMar_AtciontStep__c bas2 = new BenchMar_AtciontStep__c();
        bas2.Implementation_Benchmark__c = ib2.Id;
        bas2.Improvement_Action_Step__c = ias2.Id;
        bas2.Public_Facing__c = false;
                
        List<BenchMar_AtciontStep__c> basList = new List<BenchMar_AtciontStep__c>();
        basList.add(bas1);
        basList.add(bas2);
        insert basList;
               
        String pitRecordType1 = Schema.SObjectType.Performance_Indicator_Targets__c.getRecordTypeInfosByName().get('This Year\'s Target').getRecordTypeId();
        String pitRecordType2 = Schema.SObjectType.Performance_Indicator_Targets__c.getRecordTypeInfosByName().get('Prior Year Target').getRecordTypeId();
        
        Performance_Indicator_Targets__c pit = new Performance_Indicator_Targets__c();
        pit.UIP__c = u.Id;
        pit.Public_Facing__c = false;
        pit.Priority_Performance_Challenge_1__c = ue3.Id;
        pit.Major_Improvement_Strategy_1__c = ue.Id;
        pit.RecordTypeId = pitRecordType1;
                
        Performance_Indicator_Targets__c pit2 = new Performance_Indicator_Targets__c();
        pit2.UIP__c = u2.Id;
        pit2.Public_Facing__c = false;
        pit2.Priority_Performance_Challenge_1__c = ue3.Id;
        pit2.Major_Improvement_Strategy_1__c = ue.Id;
        pit2.RecordTypeId = pitRecordType2;
                
        List<Performance_Indicator_Targets__c> pitList = new List<Performance_Indicator_Targets__c>();
        pitList.add(pit);
        pitList.add(pit2);
        insert pitList;
        
        Performance_Indicator_Notable_Trends__c pint = new Performance_Indicator_Notable_Trends__c();
        pint.UIP__c = u.Id;
        pint.Notable_Trends_1__c = 'Test 1';
        pint.Root_Cause_1__c = ue2.Id;
        pint.Public_Facing__c = false;
                
        Performance_Indicator_Notable_Trends__c pint2 = new Performance_Indicator_Notable_Trends__c();
        pint2.UIP__c = u2.Id;
        pint2.Notable_Trends_1__c = 'Test 2';
        pint2.Priority_Performance_Challenge_1__c = ue3.Id;
        pint2.Public_Facing__c = false;
                
        List<Performance_Indicator_Notable_Trends__c> pintList = new List<Performance_Indicator_Notable_Trends__c>();
        pintList.add(pint);
        pintList.add(pint2);
        insert pintList;
        
        Supporting_Addenda_Forms__c saf = new Supporting_Addenda_Forms__c();
        Supporting_Addenda_Forms__c saf2 = new Supporting_Addenda_Forms__c();
        
        List<Supporting_Addenda_Forms__c> safList = new List<Supporting_Addenda_Forms__c>();
        safList.add(saf);
        safList.add(saf2);
                
        Attachment att = new Attachment();
        att.Name = 'Test 1';
        att.ParentId = u.id;
        att.Body = Blob.valueOf('Unit Test 1 Attachment Body');
        att.ContentType = 'application/pdf';
                
        Attachment att2 = new Attachment();
        att2.Name = 'Test 2';
        att2.ParentId = u2.id;
        att2.Body = Blob.valueOf('Unit Test 2 Attachment Body');
        att2.ContentType = 'application/pdf';
                
        List<Attachment> attList = new List<Attachment>();
        attList.add(att);
        attList.add(att2);
        insert attList;
        
        Note n = new Note();
        n.Title = 'Test 1';
        n.ParentId = u.id;
        n.Body = 'Unit Test 1 Attachment Body';
                        
        Note n2 = new Note();
        n2.Title = 'Test 2';
        n2.ParentId = u2.id;
        n2.Body = 'Unit Test 2 Attachment Body';
                        
        List<Note> nList = new List<Note>();
        nList.add(n);
        nList.add(n2);
        insert nList;
        
        List<Id> idList = new List<Id>();
        idList.add(u.Id);
        idList.add(u2.Id);
        
        System.Test.startTest();
        UIP_Cache_Upsert.updateZPIFCachews(idList);
        System.Test.stopTest();
   }
    
    static testMethod void myUnitTest1() 
    {
        Account a = new Account();
        a.Name = 'Test Acc';
        insert a;
        
        UIP_Annual_CDE_Plan__c uac = new UIP_Annual_CDE_Plan__c();
        insert uac;       
        
        UIP__c u = new UIP__c();
        u.Name = 'Test 1';
        u.DISTRICT_NAME__c = a.Id;
        u.UIP_Annual_CDE_Plan__c = uac.Id;
        u.ZPIF_UIP_Identidier__c = 'af121dc0-0463-4912-a5b0-ec26b390b9f3';
        
        ZPIF_UIP__c zu = new ZPIF_UIP__c();
        zu.Name = 'Test 1';
        zu.DISTRICT_NAME__c = a.Id;
        zu.UIP_Annual_CDE_Plan__c = uac.Id;
        zu.ZPIF_UIP_Identidier__c = 'af121dc0-0463-4912-a5b0-ec26b390b9f3';
                
        UIP__c u2 = new UIP__c();
        u2.Name = 'Test 2';
        u2.DISTRICT_NAME__c = a.Id;
        u2.UIP_Annual_CDE_Plan__c = uac.Id;
        u2.ZPIF_UIP_Identidier__c = 'af121dc0-0463-4912-a5b0-ec26b390b9f4';
        
        ZPIF_UIP__c zu2 = new ZPIF_UIP__c();
        zu2.Name = 'Test 2';
        zu2.DISTRICT_NAME__c = a.Id;
        zu2.UIP_Annual_CDE_Plan__c = uac.Id;
        zu2.ZPIF_UIP_Identidier__c = 'af121dc0-0463-4912-a5b0-ec26b390b9f4';
                
        List<UIP__c> uipList = new List<UIP__c>();
        uipList.add(u);
        uipList.add(u2);
        insert uipList;
        
        List<ZPIF_UIP__c> zuipList = new List<ZPIF_UIP__c>();
        zuipList.add(zu);
        zuipList.add(zu2);
        insert zuipList;
        
        UIP_Contact__c uc = new UIP_Contact__c();
        uc.UIP__c = u.Id;
        uc.Public_Facing__c = false;
        uc.ZPIF_UIP_Identidier__c = 'af121dc0-0463-4912-a5b0-ec26b390b9f3';
                
        UIP_Contact__c uc2 = new UIP_Contact__c();
        uc2.UIP__c = u2.Id;
        uc2.Public_Facing__c = false;
        uc2.ZPIF_UIP_Identidier__c = 'af121dc0-0463-4912-a5b0-ec26b390b9f4';
        
        List<UIP_Contact__c> uipconList = new List<UIP_Contact__c>();
        uipconList.add(uc);
        uipconList.add(uc2);
        insert uipconList;
        
        ZPF_UIP_Contact__c zuc = new ZPF_UIP_Contact__c();
        zuc.UIP__c = zu.Id;
        zuc.Public_Facing__c = false;
        zuc.ZPIF_UIP_Identidier__c = 'af121dc0-0463-4912-a5b0-ec26b390b9f3';
                
        ZPF_UIP_Contact__c zuc2 = new ZPF_UIP_Contact__c();
        zuc2.UIP__c = zu2.Id;
        zuc2.Public_Facing__c = false;
        zuc2.ZPIF_UIP_Identidier__c = 'af121dc0-0463-4912-a5b0-ec26b390b9f4';
        
        List<ZPF_UIP_Contact__c> zuipconList = new List<ZPF_UIP_Contact__c>();
        zuipconList.add(zuc);
        zuipconList.add(zuc2);
        insert zuipconList;

		Id adRecordType1 = Schema.SObjectType.Addendum__c.getRecordTypeInfosByName().get('TIG Transformation').getRecordTypeId();
        Id adRecordType2 = Schema.SObjectType.Addendum__c.getRecordTypeInfosByName().get('DIST Gifted Program').getRecordTypeId();
                
        Addendum__c ad = new Addendum__c();
        ad.UIP__c = u.Id;
        ad.Name = 'Test 1';
        ad.RecordTypeId = adRecordType1;
        ad.ZPIF_UIP_Identidier__c = 'af121dc0-0463-4912-a5b0-ec26b390b9f3';
                
        Addendum__c ad1 = new Addendum__c();
        ad1.UIP__c = u2.Id;
        ad1.Name = 'Test 2';
        ad1.RecordTypeId = adRecordType2;
        ad1.ZPIF_UIP_Identidier__c = 'af121dc0-0463-4912-a5b0-ec26b390b9f4';
        
        List<Addendum__c> addenList = new List<Addendum__c>();
        addenList.add(ad);
        addenList.add(ad1);
        insert addenList;
        
        Id zadRecordType1 = Schema.SObjectType.ZPF_Addendum__c.getRecordTypeInfosByName().get('TIG Transformation').getRecordTypeId();
        Id zadRecordType2 = Schema.SObjectType.ZPF_Addendum__c.getRecordTypeInfosByName().get('DIST Gifted Program').getRecordTypeId();
                
        ZPF_Addendum__c zad = new ZPF_Addendum__c();
        zad.UIP__c = zu.Id;
        zad.Name = 'Test 1';
        zad.RecordTypeId = zadRecordType1;
        zad.ZPIF_UIP_Identidier__c = 'af121dc0-0463-4912-a5b0-ec26b390b9f3';
                
        ZPF_Addendum__c zad1 = new ZPF_Addendum__c();
        zad1.UIP__c = zu2.Id;
        zad1.Name = 'Test 2';
        zad1.RecordTypeId = zadRecordType2;
        zad1.ZPIF_UIP_Identidier__c = 'af121dc0-0463-4912-a5b0-ec26b390b9f4';
        
        List<ZPF_Addendum__c> zaddenList = new List<ZPF_Addendum__c>();
        zaddenList.add(zad);
        zaddenList.add(zad1);
        insert zaddenList;
        
        String elRecordType1 = Schema.SObjectType.UIP_Element__c.getRecordTypeInfosByName().get('Major Improvement Strategy').getRecordTypeId();
        String elRecordType2 = Schema.SObjectType.UIP_Element__c.getRecordTypeInfosByName().get('Root Cause').getRecordTypeId();
        String elRecordType3 = Schema.SObjectType.UIP_Element__c.getRecordTypeInfosByName().get('Challenge').getRecordTypeId();
        
        UIP_Element__c ue = new UIP_Element__c();
        ue.Name = 'MIS1';
        ue.RecordTypeId = elRecordType1;
        ue.UIP__c = u.Id;
        ue.Public_Facing__c = false;
        ue.ZPIF_UIP_Identidier__c = 'af121dc0-0463-4912-a5b0-ec26b390b9f3';
               
        UIP_Element__c ue2 = new UIP_Element__c();
        ue2.Name = 'RC1';
        ue2.RecordTypeId = elRecordType2;
        ue2.UIP__c = u2.Id;
        ue2.Public_Facing__c = false;
        ue2.ZPIF_UIP_Identidier__c = 'af121dc0-0463-4912-a5b0-ec26b390b9f4';
        
        UIP_Element__c ue3= new UIP_Element__c();
        ue3.Name = 'C1';
        ue3.RecordTypeId = elRecordType3;
        ue3.UIP__c = u.Id;
        ue3.Public_Facing__c = false;
        ue3.ZPIF_UIP_Identidier__c = 'af121dc0-0463-4912-a5b0-ec26b390b9f5';
        
        List<UIP_Element__c> uipelList = new List<UIP_Element__c>();
        uipelList.add(ue);
        uipelList.add(ue2);
        uipelList.add(ue3);
        insert uipelList;
        ue.Major_Improvement_Strategy_1__c = ue.Id;
        ue2.Root_Cause_1__c = ue2.Id;
        ue3.Challenge_1__c = ue3.Id;
        
        String zelRecordType1 = Schema.SObjectType.ZPF_UIP_Element__c.getRecordTypeInfosByName().get('Major Improvement Strategy').getRecordTypeId();
        String zelRecordType2 = Schema.SObjectType.ZPF_UIP_Element__c.getRecordTypeInfosByName().get('Root Cause').getRecordTypeId();
        String zelRecordType3 = Schema.SObjectType.ZPF_UIP_Element__c.getRecordTypeInfosByName().get('Challenge').getRecordTypeId();
        
        ZPF_UIP_Element__c zue = new ZPF_UIP_Element__c();
        zue.Name = 'MIS1';
        zue.RecordTypeId = zelRecordType1;
        zue.UIP__c = zu.Id;
        zue.Public_Facing__c = false;
        zue.ZPIF_UIP_Identidier__c = 'af121dc0-0463-4912-a5b0-ec26b390b9f3';
               
        ZPF_UIP_Element__c zue2 = new ZPF_UIP_Element__c();
        zue2.Name = 'RC1';
        zue2.RecordTypeId = zelRecordType2;
        zue2.UIP__c = zu.Id;
        zue2.Public_Facing__c = false;
        zue2.ZPIF_UIP_Identidier__c = 'af121dc0-0463-4912-a5b0-ec26b390b9f4';
        
        ZPF_UIP_Element__c zue3= new ZPF_UIP_Element__c();
        zue3.Name = 'C1';
        zue3.RecordTypeId = zelRecordType3;
        zue3.UIP__c = zu.Id;
        zue3.Public_Facing__c = false;
        zue3.ZPIF_UIP_Identidier__c = 'af121dc0-0463-4912-a5b0-ec26b390b9f5';
        
        List<ZPF_UIP_Element__c> zuipelList = new List<ZPF_UIP_Element__c>();
        zuipelList.add(zue);
        zuipelList.add(zue2);
        zuipelList.add(zue3);
        insert zuipelList;
        zue.Major_Improvement_Strategy_1__c = zue.Id;
        zue2.Root_Cause_1__c = zue2.Id;
        zue3.Challenge_1__c = zue3.Id;
               
        Improvement_Action_Step__c ias = new Improvement_Action_Step__c();
        ias.UIP__c = u.Id;
        ias.Name = 'Test 1';
        ias.ZPIF_UIP_Identidier__c = 'af121dc0-0463-4912-a5b0-ec26b390b9f3';
        
        Improvement_Action_Step__c ias2 = new Improvement_Action_Step__c();
        ias2.UIP__c = u2.Id;
        ias2.Name = 'Test 2';
        ias2.ZPIF_UIP_Identidier__c = 'af121dc0-0463-4912-a5b0-ec26b390b9f4';
        
        List<Improvement_Action_Step__c> iasList = new List<Improvement_Action_Step__c>();
        iasList.add(ias);
        iasList.add(ias2);
        insert iasList;
        ias.improvement_action_step_source__c = ias.Id;
        ias2.improvement_action_step_source__c = ias2.Id;
        
        ZPF_Improvement_Action_Step__c zias = new ZPF_Improvement_Action_Step__c();
        zias.UIP__c = zu.Id;
        zias.Name = 'Test 1';
        zias.ZPIF_UIP_Identidier__c = 'af121dc0-0463-4912-a5b0-ec26b390b9f3';
        
        ZPF_Improvement_Action_Step__c zias2 = new ZPF_Improvement_Action_Step__c();
        zias2.UIP__c = zu2.Id;
        zias2.Name = 'Test 2';
        zias2.ZPIF_UIP_Identidier__c = 'af121dc0-0463-4912-a5b0-ec26b390b9f4';
        
        List<ZPF_Improvement_Action_Step__c> ziasList = new List<ZPF_Improvement_Action_Step__c>();
        ziasList.add(zias);
        ziasList.add(zias2);
        insert ziasList;
        zias.improvement_action_step_source__c = zias.Id;
        zias2.improvement_action_step_source__c = zias2.Id;
        
        Implementation_Benchmark__c ib1 = new Implementation_Benchmark__c();
        ib1.Major_Improvement_Strategy__c = ue.Id;
        ib1.Public_Facing__c = false;
        ib1.Name = 'Test 1';
        ib1.UIP__c = u.Id;
        ib1.ZPIF_UIP_Identidier__c = 'af121dc0-0463-4912-a5b0-ec26b390b9f3';
                
        Implementation_Benchmark__c ib2 = new Implementation_Benchmark__c();
        ib2.Major_Improvement_Strategy__c = ue.Id;
        ib2.Public_Facing__c = false;
        ib2.Name = 'Test 2';
        ib2.UIP__c = u2.Id;
        ib2.ZPIF_UIP_Identidier__c = 'af121dc0-0463-4912-a5b0-ec26b390b9f4';
                
        List<Implementation_Benchmark__c> ibList = new List<Implementation_Benchmark__c>();
        ibList.add(ib1);
        ibList.add(ib2);
        insert ibList;
        
        ZPF_Implementation_Benchmark__c zib1 = new ZPF_Implementation_Benchmark__c();
        zib1.Major_Improvement_Strategy__c = zue.Id;
        zib1.Public_Facing__c = false;
        zib1.Name = 'Test 1';
        zib1.UIP__c = zu.Id;
        zib1.ZPIF_UIP_Identidier__c = 'af121dc0-0463-4912-a5b0-ec26b390b9f3';
                
        ZPF_Implementation_Benchmark__c zib2 = new ZPF_Implementation_Benchmark__c();
        zib2.Major_Improvement_Strategy__c = zue.Id;
        zib2.Public_Facing__c = false;
        zib2.Name = 'Test 2';
        zib2.UIP__c = zu2.Id;
        zib2.ZPIF_UIP_Identidier__c = 'af121dc0-0463-4912-a5b0-ec26b390b9f4';
                
        List<ZPF_Implementation_Benchmark__c> zibList = new List<ZPF_Implementation_Benchmark__c>();
        zibList.add(zib1);
        zibList.add(zib2);
        insert zibList;
        
        BenchMar_AtciontStep__c bas1 = new BenchMar_AtciontStep__c();
        bas1.Implementation_Benchmark__c = ib1.Id;
        bas1.Improvement_Action_Step__c = ias.Id;
        bas1.Public_Facing__c = false;
        bas1.ZPIF_UIP_Identidier__c = 'af121dc0-0463-4912-a5b0-ec26b390b9f3';
                
        BenchMar_AtciontStep__c bas2 = new BenchMar_AtciontStep__c();
        bas2.Implementation_Benchmark__c = ib2.Id;
        bas2.Improvement_Action_Step__c = ias2.Id;
        bas2.Public_Facing__c = false;
        bas2.ZPIF_UIP_Identidier__c = 'af121dc0-0463-4912-a5b0-ec26b390b9f4';
                
        List<BenchMar_AtciontStep__c> basList = new List<BenchMar_AtciontStep__c>();
        basList.add(bas1);
        basList.add(bas2);
        insert basList;
        
        ZPF_BenchMar_AtciontStep__c zbas1 = new ZPF_BenchMar_AtciontStep__c();
        zbas1.ZPF_Implementation_Benchmark__c = zib1.Id;
        zbas1.ZPF_Improvement_Action_Step__c = zias.Id;
        zbas1.Public_Facing__c = false;
        zbas1.ZPIF_UIP_Identidier__c = 'af121dc0-0463-4912-a5b0-ec26b390b9f3';
                
        ZPF_BenchMar_AtciontStep__c zbas2 = new ZPF_BenchMar_AtciontStep__c();
        zbas2.ZPF_Implementation_Benchmark__c = zib2.Id;
        zbas2.ZPF_Improvement_Action_Step__c = zias2.Id;
        zbas2.Public_Facing__c = false;
        zbas2.ZPIF_UIP_Identidier__c = 'af121dc0-0463-4912-a5b0-ec26b390b9f4';
                
        List<ZPF_BenchMar_AtciontStep__c> zbasList = new List<ZPF_BenchMar_AtciontStep__c>();
        zbasList.add(zbas1);
        zbasList.add(zbas2);
        insert zbasList;
               
        String pitRecordType1 = Schema.SObjectType.Performance_Indicator_Targets__c.getRecordTypeInfosByName().get('This Year\'s Target').getRecordTypeId();
        String pitRecordType2 = Schema.SObjectType.Performance_Indicator_Targets__c.getRecordTypeInfosByName().get('Prior Year Target').getRecordTypeId();
        
        Performance_Indicator_Targets__c pit = new Performance_Indicator_Targets__c();
        pit.UIP__c = u.Id;
        pit.Public_Facing__c = false;
        pit.Priority_Performance_Challenge_1__c = ue3.Id;
        pit.Major_Improvement_Strategy_1__c = ue.Id;
        pit.RecordTypeId = pitRecordType1;
        pit.ZPIF_UIP_Identidier__c = 'af121dc0-0463-4912-a5b0-ec26b390b9f3';
                
        Performance_Indicator_Targets__c pit2 = new Performance_Indicator_Targets__c();
        pit2.UIP__c = u2.Id;
        pit2.Public_Facing__c = false;
        pit2.Priority_Performance_Challenge_1__c = ue3.Id;
        pit2.Major_Improvement_Strategy_1__c = ue.Id;
        pit2.RecordTypeId = pitRecordType2;
        pit2.ZPIF_UIP_Identidier__c = 'af121dc0-0463-4912-a5b0-ec26b390b9f4';
                
        List<Performance_Indicator_Targets__c> pitList = new List<Performance_Indicator_Targets__c>();
        pitList.add(pit);
        pitList.add(pit2);
        insert pitList;
        
        String zpitRecordType1 = Schema.SObjectType.ZPF_Performance_Indicator_Targets__c.getRecordTypeInfosByName().get('This Year\'s Target').getRecordTypeId();
        String zpitRecordType2 = Schema.SObjectType.ZPF_Performance_Indicator_Targets__c.getRecordTypeInfosByName().get('Prior Year Target').getRecordTypeId();
        
        ZPF_Performance_Indicator_Targets__c zpit = new ZPF_Performance_Indicator_Targets__c();
        zpit.UIP__c = zu.Id;
        zpit.Public_Facing__c = false;
        zpit.Priority_Performance_Challenge_1__c = zue3.Id;
        zpit.Major_Improvement_Strategy_1__c = zue.Id;
        zpit.RecordTypeId = zpitRecordType1;
        zpit.ZPIF_UIP_Identidier__c = 'af121dc0-0463-4912-a5b0-ec26b390b9f3';
                
        ZPF_Performance_Indicator_Targets__c zpit2 = new ZPF_Performance_Indicator_Targets__c();
        zpit2.UIP__c = zu2.Id;
        zpit2.Public_Facing__c = false;
        zpit2.Priority_Performance_Challenge_1__c = zue3.Id;
        zpit2.Major_Improvement_Strategy_1__c = zue.Id;
        zpit2.RecordTypeId = zpitRecordType2;
        zpit2.ZPIF_UIP_Identidier__c = 'af121dc0-0463-4912-a5b0-ec26b390b9f4';
                
        List<ZPF_Performance_Indicator_Targets__c> zpitList = new List<ZPF_Performance_Indicator_Targets__c>();
        zpitList.add(zpit);
        zpitList.add(zpit2);
        insert zpitList;
        
        Performance_Indicator_Notable_Trends__c pint = new Performance_Indicator_Notable_Trends__c();
        pint.UIP__c = u.Id;
        pint.Notable_Trends_1__c = 'Test 1';
        pint.Root_Cause_1__c = ue2.Id;
        pint.Public_Facing__c = false;
        pint.ZPIF_UIP_Identidier__c = 'af121dc0-0463-4912-a5b0-ec26b390b9f3';
                
        Performance_Indicator_Notable_Trends__c pint2 = new Performance_Indicator_Notable_Trends__c();
        pint2.UIP__c = u2.Id;
        pint2.Notable_Trends_1__c = 'Test 2';
        pint2.Priority_Performance_Challenge_1__c = ue3.Id;
        pint2.Public_Facing__c = false;
        pint.ZPIF_UIP_Identidier__c = 'af121dc0-0463-4912-a5b0-ec26b390b9f4';
                
        List<Performance_Indicator_Notable_Trends__c> pintList = new List<Performance_Indicator_Notable_Trends__c>();
        pintList.add(pint);
        pintList.add(pint2);
        insert pintList;
        
        ZPF_Performance_Indicator_Notable_Trends__c zpint = new ZPF_Performance_Indicator_Notable_Trends__c();
        zpint.UIP__c = zu.Id;
        zpint.Notable_Trends_1__c = 'Test 1';
        zpint.Root_Cause_1__c = zue2.Id;
        zpint.Public_Facing__c = false;
        zpint.ZPIF_UIP_Identidier__c = 'af121dc0-0463-4912-a5b0-ec26b390b9f3';
                
        ZPF_Performance_Indicator_Notable_Trends__c zpint2 = new ZPF_Performance_Indicator_Notable_Trends__c();
        zpint2.UIP__c = zu2.Id;
        zpint2.Notable_Trends_1__c = 'Test 2';
        zpint2.Priority_Performance_Challenge_1__c = zue3.Id;
        zpint2.Public_Facing__c = false;
        zpint.ZPIF_UIP_Identidier__c = 'af121dc0-0463-4912-a5b0-ec26b390b9f4';
                
        List<ZPF_Performance_Indicator_Notable_Trends__c> zpintList = new List<ZPF_Performance_Indicator_Notable_Trends__c>();
        zpintList.add(zpint);
        zpintList.add(zpint2);
        insert zpintList;
        
        Supporting_Addenda_Forms__c saf = new Supporting_Addenda_Forms__c();
        Supporting_Addenda_Forms__c saf2 = new Supporting_Addenda_Forms__c();
        
        List<Supporting_Addenda_Forms__c> safList = new List<Supporting_Addenda_Forms__c>();
        safList.add(saf);
        safList.add(saf2);
        
        ZPF_Supporting_Addenda_Forms__c zsaf = new ZPF_Supporting_Addenda_Forms__c();
        ZPF_Supporting_Addenda_Forms__c zsaf2 = new ZPF_Supporting_Addenda_Forms__c();
        
        List<ZPF_Supporting_Addenda_Forms__c> zsafList = new List<ZPF_Supporting_Addenda_Forms__c>();
        zsafList.add(zsaf);
        zsafList.add(zsaf2);
                
        Attachment att = new Attachment();
        att.Name = 'Test 1';
        att.ParentId = u.id;
        att.Body = Blob.valueOf('Unit Test 1 Attachment Body');
        att.ContentType = 'application/pdf';
                
        Attachment att2 = new Attachment();
        att2.Name = 'Test 2';
        att2.ParentId = u2.id;
        att2.Body = Blob.valueOf('Unit Test 2 Attachment Body');
        att2.ContentType = 'application/pdf';
                
        List<Attachment> attList = new List<Attachment>();
        attList.add(att);
        attList.add(att2);
        insert attList;
        
        List<Id> idList = new List<Id>();
        idList.add(u.Id);
        idList.add(u2.Id);
        
        List<Id> zidList = new List<Id>();
        zidList.add(zu.Id);
        zidList.add(zu2.Id);
        
        System.Test.startTest();
        UIP_Cache_Upsert.updateZPIFCachews(idList);
        System.Test.stopTest();
   }
    
   static testMethod void additionalForCache() {
        String abc = UIP_Cache_Upsert.ObjectFields('UIP__c');
        UIP_Cache_Upsert.upsertToCache(new List<UIP__c>(), new List<UIP__c>());
        try { UIP_Cache_Upsert.insertToCache(new List<UIP_Contact__c>(), new List<UIP_Contact__c>()); } catch (Exception ex) {}
        try { UIP_Cache_Upsert.insertToCache(new List<Addendum__c>(), new List<Addendum__c>()); } catch (Exception ex) {}
        try { UIP_Cache_Upsert.insertToCache(new List<UIP_Element__c>(), new List<UIP_Element__c>()); } catch (Exception ex) {}
        try { UIP_Cache_Upsert.insertToCache(new List<Improvement_Action_Step__c>(), new List<Improvement_Action_Step__c>()); } catch (Exception ex) {}
        try { UIP_Cache_Upsert.insertToCache(new List<Implementation_Benchmark__c>(), new List<Implementation_Benchmark__c>()); } catch (Exception ex) {}
        try { UIP_Cache_Upsert.insertToCache(new List<BenchMar_AtciontStep__c>(), new List<BenchMar_AtciontStep__c>()); } catch (Exception ex) {}
    }
}