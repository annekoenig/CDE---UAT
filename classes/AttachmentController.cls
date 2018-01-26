/****************ERSAttachmentController********************************************************************************
 * Created By: Elena Bucataru                    
 * Created Date: 2015                      
 * Description: This is the controller for Level35_ERSReportPage. 
 *    When the user accesses the ERS Report tab under Level 3-5 menu, the Attachment related to the Application 
 *    via ERS_Report_Attachment__c object will be displayed
 *****************************************************************************************************************/
public with sharing class AttachmentController {
  	public String docId { get; set; }
  	public Attachment att { get; set; }
    public Document_Review_Feedback_Form__c currentDoc { get; set; }
    public List<SelectOption> archivedApplications { get; set; }
    public String selectedDoc { get; set; }
    public Boolean displayArchivedPicklist { get; set; }
  	public Map<Id,String> idToArchiveDate { get; set; }
    
  public AttachmentController() {
    docId = ApexPages.currentPage().getParameters().get('id');
    currentDoc = [SELECT Id FROM Document_Review_Feedback_Form__c WHERE Id = :docId];
    selectedDoc = currentDoc.Id;
    reselectRecords();
  }
  
  public void reselectRecords() {
    
    List<Attachment> AttList = [SELECT Id FROM Attachment WHERE ParentId = :selectedDoc limit 1];
    if (AttList.size() > 0) {
    	att = AttList[0];            
      	}
    }
}