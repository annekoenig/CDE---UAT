trigger ImprovementActionStep on Improvement_Action_Step__c (before update,after insert,before insert) {

for(Improvement_Action_Step__c im: Trigger.new){
    if(im.Public_Facing__c == TRUE && Trigger.oldmap!=null && Trigger.oldmap.get(im.Id).Public_Facing__c == TRUE){
        im.Public_Facing__c = FALSE;
    }
    //if(trigger.isUpdate)
    	//im.Improvement_Action_Step_Source__c=im.id+'';
	}
}