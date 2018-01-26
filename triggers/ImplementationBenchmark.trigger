trigger ImplementationBenchmark on Implementation_Benchmark__c (before update) {
for(Implementation_Benchmark__c im: Trigger.new){
    if(im.Public_Facing__c == TRUE && Trigger.oldmap.get(im.Id).Public_Facing__c == TRUE){
        im.Public_Facing__c = FALSE;
    }
}
}