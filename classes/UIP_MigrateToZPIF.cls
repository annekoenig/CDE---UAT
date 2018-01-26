public class UIP_MigrateToZPIF {
    public static void InsertToCache(List<UIP__c> updUIPs){
			string fieldsAPIname = '';
      		fieldsAPIname=ObjectFields('UIP__c');        
            String qry = 'Select '+fieldsAPIname+',RecordType.DeveloperName from UIP__c where Id = :updUIPs';
			LIST<UIP__c> uips = Database.query(qry);
        	//qry = 'Select '+fieldsAPIname+' from ZPIF_UIP__c where Id = :updUIP';
        	LIST<ZPIF_UIP__c> zuips = new LIST<ZPIF_UIP__c>();//Database.query(qry);
        	List<String> fields = fieldsAPIname.split(',');
        	List<RecordType> recs = [SELECT Id,DeveloperName,Name FROM RecordType WHERE sobjecttype = 'ZPIF_UIP__c'];
        	Map<String,Id> mapRecId = new Map<String,Id>();
        	for(RecordType rec:recs) 
                mapRecId.put(rec.DeveloperName, rec.Id);
        for(UIP__c uip:uips){
            ZPIF_UIP__c zUIP = new ZPIF_UIP__c();
            for(String field:fields){
                if(field.equalsIgnoreCase('RecordTypeId')){
                    system.debug('Inside zUIP: '+field);
                    //zUIP.RecordTypeId = mapRecId.get(zUIP.RecordType.DeveloperName);
                }else{
                    system.debug('Inside field: '+field);
                	zUIP.put(field,uip.get(field));
                }
            }
            zuips.add(zUIP);
        }
        if(zuips.size()>0)
        insert zuips;
    }
    //Getting the fields from object
     public static String ObjectFields(String ObjectNameval){
        string fieldsVal = '';
        SObjectType objToken = Schema.getGlobalDescribe().get(ObjectNameval);
        DescribeSObjectResult objDef = objToken.getDescribe();
        Map<String, SObjectField> fields = objDef.fields.getMap();
           Set<String> fieldSet = fields.keySet();
           for(string f : fieldSet){
                if((f.contains('__c') || f.contains('__C')) && !fields.get(f).getDescribe().isCalculated())
                   fieldsVal += f +',';
           }   
           if(fieldsVal.endsWith(','))
           fieldsVal= fieldsVal.substring(0,fieldsVal.length()-1);
           return fieldsVal;
        }           
}