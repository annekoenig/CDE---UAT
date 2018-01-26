trigger UIPElement on UIP_Element__c (before update) {

for(UIP_Element__c im: Trigger.new){
    if(im.Public_Facing__c == TRUE && Trigger.oldmap.get(im.Id).Public_Facing__c == TRUE){
        im.Public_Facing__c = FALSE;
    }
}
}