public with sharing class CurrentPerformanceAttachmentController {
    public String docId { get; set; }
    public Attachment att { get; set; }
    public UIP__c currentDoc { get; set; }
    public List<SelectOption> archivedApplications { get; set; }
    public String selectedDoc { get; set; }
    public Boolean displayArchivedPicklist { get; set; }
    public Map<Id,String> idToArchiveDate { get; set; }
    
  public CurrentPerformanceAttachmentController() {
    docId = ApexPages.currentPage().getParameters().get('id');
    currentDoc = [SELECT Id FROM UIP__c WHERE Id = :docId];
    selectedDoc = currentDoc.Id;
    reselectRecords();
  }
  
  public void reselectRecords() {
    
    List<Attachment> AttList = [SELECT Id FROM Attachment WHERE ParentId = :selectedDoc AND Description = 'Performance Framework' limit 1];
    if (AttList.size() > 0) {
        att = AttList[0];            
        }
    }
}