trigger PerformanceIndicatorTargets on Performance_Indicator_Targets__c (before update) {

for(Performance_Indicator_Targets__c im: Trigger.new){
    if(im.Public_Facing__c == TRUE && Trigger.oldmap.get(im.Id).Public_Facing__c == TRUE){
        im.Public_Facing__c = FALSE;
    }
}
}