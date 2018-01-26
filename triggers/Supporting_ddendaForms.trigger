trigger  Supporting_ddendaForms on Supporting_Addenda_Forms__c (before update) {

for(Supporting_Addenda_Forms__c im: Trigger.new){
    if(im.Public_Facing__c == TRUE && Trigger.oldmap.get(im.Id).Public_Facing__c == TRUE){
        im.Public_Facing__c = FALSE;
    }
}
}