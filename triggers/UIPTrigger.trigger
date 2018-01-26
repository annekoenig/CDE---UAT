trigger UIPTrigger on UIP__c (before delete) {
 if (Trigger.isBefore) {
 		try
 		{
            if (Trigger.isDelete) {  
            	List<String>  uipIdentifiers = new List<String>();
                for(UIP__c uip:Trigger.Old){
                	if(uip.ZPIF_UIP_Identidier__c != null && uip.ZPIF_UIP_Identidier__c != '')
                		uipIdentifiers.add(uip.ZPIF_UIP_Identidier__c);
                }
            }
            String qry1 = 'Select ZPIF_UIP_Identidier__c,Id from ZPIF_UIP__c where ZPIF_UIP_Identidier__c IN :uipIdentifiers';
        	LIST<ZPIF_UIP__c> ExstngZuips = Database.query(qry1);
        	if(!ExstngZuips.isEmpty() && ExstngZuips.size()>0)
        		delete ExstngZuips;
        }Catch(Exception e){
        	system.debug('Errors in Deleting ZPIF_UIP__c record: '+e.getMessage());
        }
 	}
}