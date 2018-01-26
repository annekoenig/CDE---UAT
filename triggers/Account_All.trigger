trigger Account_All on Account (before update) {
	if(Trigger.isUpdate) {
		for(Account curAcct : Trigger.new) {
			if(curAcct.Name == 'Account' && trigger.oldMap.get(curAcct.Id).Name != curAcct.Name) {
				curAcct.Name = trigger.oldMap.get(curAcct.Id).Name;
				curAcct.OwnerId = trigger.oldMap.get(curAcct.Id).OwnerId;
			}
		}
	}
	if(Trigger.isUpdate || Trigger.isInsert) {
		for(Account curAcct : Trigger.new) {
			String acctNum = null;
			if(curAcct.DIST_NUMBER__c != null) {
				acctNum = curAcct.DIST_NUMBER__c;
				if(curAcct.SCHOOL_NUMBER__c != null) {
					acctNum = acctNum + '-' + curAcct.SCHOOL_NUMBER__c;
				}
			}
			if(acctNum != null) {
				curAcct.AccountNumber = acctNum;
			}
		}
	}
}