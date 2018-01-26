@isTest
private class BenchMarActionStepTest {

    static testMethod void testBenchMarActionStep() {
        // TO DO: implement unit test
        BenchMar_AtciontStep__c junction = new BenchMar_AtciontStep__c();
        
        Implementation_Benchmark__c impBen = new Implementation_Benchmark__c();
        insert impBen;
        
        Improvement_Action_Step__c ias = new Improvement_Action_Step__c();
        insert ias;
        
        junction.Implementation_Benchmark__c = impBen.id;
        junction.Improvement_Action_Step__c = ias.id;
        junction.ZPIF_UIP_Identidier__c = 'ZPIP_UIP_1234';
        
        insert junction;

        junction.Public_Facing__c = true;
        update junction;
    }
}