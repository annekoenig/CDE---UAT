public without sharing class DownloadAttachment {
	public String cnt { get; set; }
	public String cnt2 { get; set; }
	public String cntType { get; set; }
	public String name { get; set; }
	public String attId { get; set; }
	
	public DownloadAttachment() {
		attId = ApexPages.currentPage().getParameters().get('attId');
		Attachment att = [Select Id, Body, ContentType, Name FROM Attachment WHERE Id = :attId];
		System.debug('att::' + att);
		cntType = att.ContentType;
		name = EncodingUtil.urlEncode(att.Name, 'UTF-8');
		cnt = EncodingUtil.base64Encode(att.Body);
		//cnt2 = att.Body.toString();
	}
}