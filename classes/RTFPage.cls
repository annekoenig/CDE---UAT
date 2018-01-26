public without sharing class RTFPage {
    public String currentId { get; set; }
    public UIP__c uip { get; set; }
    public String target { get; set; }
    public boolean closeWindow { get; set; }
    public boolean closeReflexionWindow { get; set; }
    
    public RTFPage() {
        system.debug('params::' + ApexPages.currentPage().getParameters().get('target'));
        currentId = ApexPages.currentPage().getParameters().get('id');
        target = EncodingUtil.urlDecode(ApexPages.currentPage().getParameters().get('target'), 'UTF-8');
        system.debug('target:::' + target);
        selectUIP();
    }
    
    public void selectUIP() {
        uip = [SELECT Id, Name, Turnaround__c, TIG_Turnaround__c, TIG_Transformation__c, Section_1__c, Section_1_Percent_Complete__c, ESEA__c, Gifted_Education__c, Student_Grad_Completion_Plan__c, Title_III__c,
               Section_2__c, Section_2_Percent_Complete__c, Section_3__c, Section_3_Percent_Complete__c, Section_4__c, Section_4_Percent_Complete__c, DIST_NUMBER__c, 
               TIG_Restart__c, TIG_Closure__c, TIG_Transformation_Percent_Complete__c, TIG_Closure_Percent_Complete__c, Turnaround_Percent_Complete__c, 
               TIG_Restart_Percent_Complete__c, TIG_Turnaround_Percent_Complete__c, Title_1_School_Wide__c, Title_1_Percent_Complete__c,
               SCHOOL_NAME__r.Name, City__c, DISTRICT_NAME__r.Name, A_TTL_RATING_OFFICIAL__c,
               UIP_Annual_CDE_Plan__c, UIP_Annual_CDE_Plan__r.April_Deadline__c, UIP_Annual_CDE_Plan__r.Blank_Template_Released__c, 
               UIP_Annual_CDE_Plan__r.January_Deadline__c, UIP_Annual_CDE_Plan__r.October_Deadline__c, 
               UIP_Annual_CDE_Plan__r.Next_School_Year__c, UIP_Annual_CDE_Plan__r.This_School_Year__c,
               UIP_Annual_CDE_Plan__r.Section_1_Data_Populated__c, UIP_Annual_CDE_Plan__r.Section_1_Update__c, RecordType.Name,
               Section_II_Complete__c, Section_III_Worksheet_1_Complete__c, Section_III_Worksheet_2_Complete__c, Section_III_Data_Narrative_Complete__c, Section_IV_Action_Planning_Complete__c, Section_IV_Target_Setting_Complete__c,
               TextAreaRich_Test__c, Target_Reflection__c, TIG_Turnaround_Complete__c, Student_Graduation_and_Completion_Plan__c, TIG_Closure_Complete__c,
               Turnaround_Complete__c, TIG_Transformation_Complete__c, Title_I_School_Wide_Complete__c, Title_III_Complete__c, Gifted_Education_Complete__c, SCHOOL_NUMBER__c,
               ESEA_Complete__c, Student_Grad_Completion_Plan_Complete__c, Narrative_Academic_Achievement_Targets__c, Narrative_Additional__c,
               Narrative_Academic_Growth_Targets__c, Narrative_Academic_Growth_Gaps_Target__c, Narrative_Postsecondary_Workforce_Target__c,
               Narrative_English_Lang_Dev_Attain_Target__c, Narrative_Student_Engagement_Target__c, Performance_Challenge_Narrative__c,
               Root_Cause_Narrative__c, Narrative_Disaggregated_Achievement__c, Narrative_Other__c, Narrative_Student_Behavior__c FROM UIP__c WHERE Id = :currentId];
    }
    
    public void SaveReflexion() {
        System.debug('start:::' + uip.Narrative_Academic_Growth_Targets__c);
        try {
            update uip;
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            return;
        }
        selectUIP();
        System.debug('end:::' + uip.Target_Reflection__c);
        closeWindow = true;
    }
    
    public void SaveNarrative() {
        try {
            update uip;
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            return;
        }
        selectUIP();
        closeReflexionWindow = true;
    }
    
    /*public void ClearFormattingNarrative() {
	if (target == 'Academic Achievement (Status)') {
	uip.Narrative_Academic_Achievement_Targets__c= uip.Narrative_Academic_Achievement_Targets__c.replaceAll('<[^>]+>',' ');
	} else if (target == 'Academic Growth') {
	uip.Narrative_Academic_Growth_Targets__c= uip.Narrative_Academic_Growth_Targets__c.replaceAll('<[^>]+>',' ');
	} else if (target == 'Academic Growth Gaps') {
	uip.Narrative_Academic_Growth_Gaps_Target__c= uip.Narrative_Academic_Growth_Gaps_Target__c.replaceAll('<[^>]+>',' ');
	} else if (target == 'Postsecondary & Workforce Readiness') {
	uip.Narrative_Postsecondary_Workforce_Target__c= uip.Narrative_Postsecondary_Workforce_Target__c.replaceAll('<[^>]+>',' ');
	} else if (target == 'English Language Development and Attainment') {
	uip.Narrative_English_Lang_Dev_Attain_Target__c= uip.Narrative_English_Lang_Dev_Attain_Target__c.replaceAll('<[^>]+>',' ');
	} else if (target == 'Student Engagement') {
	uip.Narrative_Student_Engagement_Target__c= uip.Narrative_Student_Engagement_Target__c.replaceAll('<[^>]+>',' ');
	} else if (target == 'Brief Description') {
	uip.TextAreaRich_Test__c= uip.TextAreaRich_Test__c.replaceAll('<[^>]+>',' ');
	} else if (target == 'Current Performance') {
	uip.Target_Reflection__c= uip.Target_Reflection__c.replaceAll('<[^>]+>',' ');
	} else if (target == 'Priority Performance Challenges') {
	uip.Performance_Challenge_Narrative__c= uip.Performance_Challenge_Narrative__c.replaceAll('<[^>]+>',' ');
	} else if (target == 'Root Causes') {
	uip.Root_Cause_Narrative__c= uip.Root_Cause_Narrative__c.replaceAll('<[^>]+>',' ');
	} else if (target == 'Additional Narrative') {
	uip.Narrative_Additional__c= uip.Narrative_Additional__c.replaceAll('<[^>]+>',' ');
	}
	}*/
    
    public void Cancel() {
        closeWindow = true;
    }
    
    public void CancelNarrative() {
        closeReflexionWindow = true;
    }
}