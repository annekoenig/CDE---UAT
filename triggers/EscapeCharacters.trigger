trigger EscapeCharacters on UIP__c (before insert, before update) {

    List<UIPfields__c> fields = [SELECT Id, Name, Field_API_Name__c FROM UIPfields__c];

    for(UIP__c uip : Trigger.new) {
        for (UIPfields__c fieldLine : fields) {
            try {
                //uip.put(fieldLine.Field_API_Name__c, ((string)uip.get(fieldLine.Field_API_Name__c)).replace('"', '\'\'').replace('”', '\'\'').replace('“', '\'\'').replace('&quot;', '&#39;&#39;'));
            	uip.put(fieldLine.Field_API_Name__c, ((string)uip.get(fieldLine.Field_API_Name__c)).replace('”', '\'\'').replace('“', '\'\'').replace('&quot;', '&#39;&#39;'));
            } catch(Exception ex) {
                // This means a field is wrong, it's not supported or it's not a text field
                // So we'll ignore it
            }
        }
    }

}