public without sharing class NewESEAForm {
	
	public Supporting_Addenda_Forms__c supAddendum { get; set; }
	private String currentId;
	private String addendumId;
	private String eseaId;
	
	public boolean isNewElem { get; set; }
	public boolean isDeleteError { get; set; }
    public boolean closeWindow { get; set; }
	
	public NewESEAForm() {
		Map<String,String> params = ApexPages.currentPage().getParameters();
		isDeleteError = false;
        closeWindow = false;
		
		if (params.containsKey('id')) {
			currentId = params.get('id');
		}
		if (params.containsKey('addendumId')) {
			addendumId = params.get('addendumId');
		}
		if (params.containsKey('eseaId')) {
			eseaId = params.get('eseaId');
		}
		if (params.containsKey('isNewElem')) {
			isNewElem = boolean.valueOf(params.get('isNewElem'));
		}
		
		selectAddendum();
		
		if (isNewElem) {
			supAddendum = new Supporting_Addenda_Forms__c();
			supAddendum.Addendum__c = addendumId;
		}
	}
	
	public void selectAddendum() {
		if (eseaId != null && eseaId != '') {
			String soql = SectionUtil.getFieldsQuery('Supporting_Addenda_Forms__c');
			soql += ' FROM Supporting_Addenda_Forms__c WHERE Id = \'' + eseaId + '\'';
			supAddendum = Database.query(soql);
		}
	}
	
	public void Save() {
		try {
			upsert supAddendum;
		} catch (DMLException e) {
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            return;
		}
        closeWindow = true;
	}
	
	public void DeleteQuestion() {
		isDeleteError = true;
	}
	
	public void DeleteSupAddendum() {
		try {
			delete supAddendum;
		} catch (DMLException e) {
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            return;
		}
	}
}