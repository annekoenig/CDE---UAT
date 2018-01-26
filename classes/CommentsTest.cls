@isTest
public class CommentsTest 
{
    static testMethod void myUnitTest() 
    {    
        Account a = new Account();
        a.Name = 'Name';
        insert a;
        
        UIP_Annual_CDE_Plan__c uac = new UIP_Annual_CDE_Plan__c();
        insert uac;
        
        UIP__c u = new UIP__c();
        u.DISTRICT_NAME__c = a.Id;
        u.UIP_Annual_CDE_Plan__c = uac.Id;
        insert u;
        
        CDE_Feedback__c feedback=new CDE_Feedback__c();
        feedback.UIP__c=u.id;
        feedback.Feedback_Year__c=String.valueOf(Date.Today().year());
        insert feedback;
        
        CDE_Feedback__c feedback1=new CDE_Feedback__c();
        feedback1.UIP__c=u.id;
        feedback1.Feedback_Year__c=String.valueOf((Date.Today().year())-1);
        insert feedback1;
        
        CDE_Feedback_Review__c rev = new CDE_Feedback_Review__c();
        rev.UIP__c = u.Id;
        insert rev;
        
        
        Test.setCurrentPage(Page.Collaboration_Chatter);
        ApexPages.currentPage().getParameters().put('id', u.Id);
        ApexPages.currentPage().getParameters().put('feedback', '1');
        Comments ctrl = new Comments();
        ctrl.timeline='none';
        ctrl.fbq1True=True;
        ctrl.fbq2True=True;
		ctrl.fbq3True=True;
		ctrl.fbq4True=True;
		ctrl.popuateSummaryFeedbackTable();
        ctrl.fbq1False=True;
        ctrl.fbq2False=True;
        ctrl.fbq3False=True;
        ctrl.fbq4False=True;
        ctrl.timeline1='';
        ctrl.timeline2='';
        ctrl.timeline3='';
        ctrl.timeline4='';
        ctrl.currentUserFlag=NULL;
        ctrl.recordUnderApproval=NULL;
        ctrl.approvedFlag=NULL;
        ctrl.popuateSummaryFeedbackTable();
        ctrl.populateApprovers();
        ctrl.submit();
        ctrl.saveCurrentFeedback();

        
        Comments ctrl1 = new Comments();
        ctrl.timeline='none';
        ctrl.populateTimeLine();
        ctrl.timeline='value1';
        ctrl.populateTimeLine();
        ctrl.timeline='value2';
        ctrl.populateTimeLine();
        ctrl.timeline='value3';
        ctrl.populateTimeLine();
        
		delete feedback;
        
        CDE_Feedback__c feedback2=new CDE_Feedback__c();
        feedback2.Feedback_Year__c=String.valueOf(Date.Today().year());
        ctrl.feedbackOfCurrentYear=feedback2;
        ctrl.saveCurrentFeedback();
        try {
        	ctrl.submitReq();
        } catch (Exception ex) {}
        try {
        	ctrl.getWorkItemId();
        } catch (Exception ex) {}
        try {
        	ctrl.approveReq();
        } catch (Exception ex) {}
        try {
        	ctrl.rejectReq();
        } catch (Exception ex) {}
    }
}