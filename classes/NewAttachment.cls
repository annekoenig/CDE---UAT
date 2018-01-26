public without sharing class NewAttachment {
	public Attachment att { get; set; }
	public boolean closeWindow { get; set; }
	public String currentId { get; set; }

	public NewAttachment() {
		currentId = ApexPages.currentPage().getParameters().get('id');
		att = new Attachment();
		closeWindow = false;
	}
	
	public void Save() {
		att.ParentId = currentId;
		att.isPrivate = false;
		closeWindow = true;
		try {
			insert att;
			att = new Attachment();
		} catch (DMLException e) {
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            return;
		}
	}
}