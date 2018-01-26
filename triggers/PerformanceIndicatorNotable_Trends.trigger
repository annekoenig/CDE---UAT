trigger PerformanceIndicatorNotable_Trends on Performance_Indicator_Notable_Trends__c (before update) {

for(Performance_Indicator_Notable_Trends__c im: Trigger.new){
    if(im.Public_Facing__c == TRUE && Trigger.oldmap.get(im.Id).Public_Facing__c == TRUE){
        im.Public_Facing__c = FALSE;
    }
}
}