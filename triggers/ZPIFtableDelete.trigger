trigger ZPIFtableDelete on ZPIF_UIP__c (before delete) {
    
    List<ZPF_UIP_Element__c> uipelem {get;set;}
    List<ZPF_UIP_Contact__c> uipcon {get;set;}
    List<ZPF_Performance_Indicator_Targets__c> uippit {get;set;}
    List<ZPF_Performance_Indicator_Notable_Trends__c> uippint {get;set;}
    List<ZPF_Improvement_Action_Step__c> uipias {get;set;}
    List<ZPF_Implementation_Benchmark__c> uipib {get;set;}
    List<ZPF_Addendum__c> uipa {get;set;}
    List<ZPF_BenchMar_AtciontStep__c> uipba {get;set;}
    List<Attachment> uipatt {get;set;}
    
    if (Trigger.isBefore) {
        if (Trigger.isDelete) {
            // In a before delete trigger, the trigger accesses the records that will be deleted with the Trigger.old list.
            for (ZPIF_UIP__c a : Trigger.old) {
                uipelem = [Select Id, UIP__c from ZPF_UIP_Element__c where UIP__c = :a.Id];
                uipcon = [Select Id, UIP__c from ZPF_UIP_Contact__c where UIP__c = :a.Id];
                uippit = [Select Id, UIP__c from ZPF_Performance_Indicator_Targets__c where UIP__c = :a.Id];
                uippint = [Select Id, UIP__c from ZPF_Performance_Indicator_Notable_Trends__c where UIP__c = :a.Id];
                uipias = [Select Id, UIP__c from ZPF_Improvement_Action_Step__c where UIP__c = :a.Id];
                uipatt = [Select Id from Attachment where ParentId = :a.Id];
                List<Id> uipiasid = new List<Id>();
                for(ZPF_Improvement_Action_Step__c u : uipias){uipiasid.add(u.Id);}
                uipib = [Select Id, UIP__c from ZPF_Implementation_Benchmark__c where UIP__c = :a.Id];
                List<Id> uipibid = new List<Id>();
                for(ZPF_Implementation_Benchmark__c u : uipib){uipibid.add(u.Id);}
                uipa = [Select Id, UIP__c from ZPF_Addendum__c where UIP__c = :a.Id];
                uipba = [Select Id from ZPF_BenchMar_AtciontStep__c where ZPF_Implementation_Benchmark__c IN :uipibid or ZPF_Improvement_Action_Step__c IN :uipiasid];
                delete uipelem;
                delete uipcon;
                delete uippit;
                delete uippint;
                delete uipias;
                delete uipib;
                delete uipa;
                delete uipba;
                delete uipatt;
            }
        }
    }   
}