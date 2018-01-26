trigger  BenchMarAtciontStep on BenchMar_AtciontStep__c (before update) {
for(BenchMar_AtciontStep__c im: Trigger.new){
    if(im.Public_Facing__c == TRUE && Trigger.oldmap.get(im.Id).Public_Facing__c == TRUE){
        im.Public_Facing__c = FALSE;
    }
}
}