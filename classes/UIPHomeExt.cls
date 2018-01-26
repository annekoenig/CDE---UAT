public class UIPHomeExt {
    
    public String currentId { get ; set; }
    public UIP__c uip { get; set; }
    public boolean isCommunityUser { get; set; }
    public boolean isAdminUser { get; set; }
    public boolean isSuccessfullyMsg { get; set; }
    public String ErrorMessage {get;set;}
   
        
    public UIPHomeExt(ApexPages.StandardController stdController) {
                
                currentId = SectionUtil.getUipId();
                System.debug('### uipId =' + currentId);
                uip = [SELECT Turnaround__c, TIG_Turnaround__c, TIG_Transformation__c, Review_Required__c, TIG_Restart__c, TIG_Closure__c, Title_1_School_Wide__c, TextAreaRich_Test__c, ESEA__c, Gifted_Education__c, TIG_Closure_Complete__c, TIG_Transformation_Complete__c, Turnaround_Complete__c, ESEA_Complete__c, Gifted_Education_Complete__c, Title_I_School_Wide_Complete__c, Title_III_Complete__c, TIG_Turnaround_Complete__c, Student_Grad_Completion_Plan__c, Student_Grad_Completion_Plan_Complete__c,Title_III__c, Section_IV_Action_Planning_Complete__c, Section_IV_Target_Setting_Complete__c FROM UIP__c WHERE Id = :currentId];
    }
    
        public UIPHomeExt() {
                
               currentId = SectionUtil.getUipId();
                System.debug('### uipId =' + currentId);
                uip = [SELECT Turnaround__c, TIG_Turnaround__c, TIG_Transformation__c, Review_Required__c, TIG_Restart__c, TIG_Closure__c, Title_1_School_Wide__c, TextAreaRich_Test__c, ESEA__c, Gifted_Education__c, TIG_Closure_Complete__c, TIG_Transformation_Complete__c, Turnaround_Complete__c, ESEA_Complete__c, Gifted_Education_Complete__c, Title_I_School_Wide_Complete__c, Title_III_Complete__c, TIG_Turnaround_Complete__c, Student_Grad_Completion_Plan__c, Student_Grad_Completion_Plan_Complete__c,Title_III__c, Section_IV_Action_Planning_Complete__c, Section_IV_Target_Setting_Complete__c FROM UIP__c WHERE Id = :currentId];
       }
        
        public PageReference submitForSchoolReview() {
                
                // error messages
                String richtextstr = string.valueof(uip.TextAreaRich_Test__c);
                if(richtextstr != null && richtextstr.length() > 0)
                        richtextstr = richtextstr.replaceall('<[^>]+>','');
                if(string.isblank(richtextstr)){
                        ErrorMessage = 'UIP cannot be accepted becuse required elements are missing:  Narrative field must be filled in.';
                        isSuccessfullyMsg = false;
                        return null;
                }
                if(uip.Section_IV_Action_Planning_Complete__c == false) {
                        ErrorMessage = 'UIP cannot be accepted becuse required elements are missing: Action Plan must be complete and ready to submit.';
                        isSuccessfullyMsg = false;
                        return null;
                }
                if(uip.Section_IV_Target_Setting_Complete__c == false) {
                        ErrorMessage = 'UIP cannot be accepted becuse required elements are missing: Target setting must be complete and ready to submit.';
                        isSuccessfullyMsg = false;
                        return null;
                }
                if((uip.TIG_Closure__c == 'Yes' && uip.TIG_Closure_Complete__c == false) || 
                   (uip.TIG_Restart__c == 'Yes' && uip.TIG_Restart_Complete__c == false) || 
                   (uip.TIG_Transformation__c == 'Yes' && uip.TIG_Transformation_Complete__c == false) || 
                   (uip.TIG_Turnaround__c == 'Yes' && uip.TIG_Turnaround_Complete__c == false) || 
                   (uip.Title_1_School_Wide__c == 'Yes' && uip.Title_I_School_Wide_Complete__c == false) || 
                   (uip.Title_III__c == 'Yes' && uip.Title_III_Complete__c == false) || 
                   (uip.Turnaround__c == 'Yes' && uip.Turnaround_Complete__c == false) || 
                   (uip.ESEA__c == 'Yes' && uip.ESEA_Complete__c == false) || 
                   //(uip.Gifted_Education__c == 'Yes' && uip.Gifted_Education_Complete__c == false) || 
                   (uip.Student_Grad_Completion_Plan__c == 'Yes' && uip.Student_Grad_Completion_Plan_Complete__c == false)){
                        ErrorMessage = 'UIP cannot be accepted because required elements are missing:  All addenda must be complete and ready to submit.';
                        isSuccessfullyMsg = false;
                        return null;
                }
                // submitRecord('Final');
                if (uip.Review_Required__c) {
                        uip.Review_Required__c = false;
                }
                uip.Conga_School_Template_Flag__c = true;
                uip.UIP_Status__c = 'Submitted for Posting';
                uip.Public_Facing__c = true;
                Savepoint sp = Database.setSavepoint();
                try {
                    System.debug('uip '+uip);
                    update uip;
                    System.debug('*********uip.Id*********'+uip.Id);
                    Id[] upid = new Id[]{};
                    upid.add(uip.Id);
                    System.debug('upid '+upid);
                    UIP_Cache_Upsert.updateZPIFCachews(upid);   
                } catch (DMLException e) {
                    ErrorMessage = 'Operation Failed:' + e.getMessage() + '(' + e.getStackTraceString() + ')';
                    isSuccessfullyMsg = false;
                    Database.rollback(sp);
                    return null;
                }
                isSuccessfullyMsg = true;
                return null;
        }         
}