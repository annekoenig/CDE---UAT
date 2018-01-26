public without sharing class Section1 {
    public String currentId { get; set; }
    private UIP__c uip2;
    public UIP__c uip { 
        get {
            if (uip2 == null) {
                uip2 = selectUIP();
            }
            return uip2;
        }
    }
    public UIP_Annual_CDE_Plan__c uipPlan { get; set; }
    
    public boolean showElementary_AA { get; set; }
    public boolean showMS_AA { get; set; }
    public boolean showHS_AA { get; set; }
    public Integer sectionsNumber_AA { get; set; }
    
    public boolean showElementary_AA_AEC { get; set; }
    public boolean showMS_AA_AEC { get; set; }
    public boolean showHS_AA_AEC { get; set; }
    public Integer sectionsNumber_AA_AEC { get; set; }
    
    public boolean showElementary_AA_AEC_2 { get; set; }
    public boolean showMS_AA_AEC_2 { get; set; }
    public boolean showHS_AA_AEC_2 { get; set; }
    public Integer sectionsNumber_AA_AEC_2 { get; set; }
    
    public boolean showElementary_AG { get; set; }
    public boolean showMS_AG { get; set; }
    public boolean showHS_AG { get; set; }
    public Integer sectionsNumber_AG { get; set; }
    
    public boolean showElementary_AG_AEC { get; set; }
    public boolean showMS_AG_AEC { get; set; }
    public boolean showHS_AG_AEC { get; set; }
    public Integer sectionsNumber_AG_AEC { get; set; }
    
    public boolean showElementary_AG_AEC_2 { get; set; }
    public boolean showMS_AG_AEC_2 { get; set; }
    public boolean showHS_AG_AEC_2 { get; set; }
    public Integer sectionsNumber_AG_AEC_2 { get; set; }
    
    public boolean showPostsecondary { get; set; }
    public boolean showPostsecondary_AEC { get; set; }
    public boolean showStateAccountability { get; set; }
    public Integer studentNumber_AEC { get; set; }
    
    public boolean showEnglishLanguage_District{ get; set; }
    public boolean showStateAccountability_District { get; set; }
    public boolean showESEAccountability_District { get; set; }
    
    public UIP_Contact__c dummyStandardContact { get; set; }
    
    public String selectedContact { get; set; }
    public List<UIP_Contact__c> uipContactsList { get; set; }
    public Map<Id, UIP_Contact__c> uipDummyContactsMap { get; set; }
    
    public boolean isCommunityUser { get; set; }
    
    public boolean isNewContact { get; set; }
    public boolean isEditContact { get; set; }
    public boolean isPageChanged { get; set; }
    
    public Section1(ApexPages.StandardController stdController) {
        isCommunityUser = SectionUtil.isCommunityUser();
        currentId = SectionUtil.getUipId();
        initSection();
        //displayActionStepSaveOrder();
        //displayImplementationBenchMarkSaveOrder();
    }
    
    public void initSection() {
        //selectUIP();
        uip2 = null;
        showSections();
        selectUIPContacts();
    }
    
    public UIP__c selectUIP() {
        String soql = SectionUtil.getFieldsQuery('UIP__c');
        soql += ', RecordType.Name, SCHOOL_NAME__r.Name, DISTRICT_NAME__r.Name, UIP_Annual_CDE_Plan__r.April_Deadline__c, UIP_Annual_CDE_Plan__r.Blank_Template_Released__c, UIP_Annual_CDE_Plan__r.January_Deadline__c, UIP_Annual_CDE_Plan__r.October_Deadline__c, UIP_Annual_CDE_Plan__r.Section_1_Data_Populated__c, UIP_Annual_CDE_Plan__r.Section_1_Update__c';
        soql += ', UIP_Annual_CDE_Plan__r.Academic_Achievement_Measures_Metrics__c, UIP_Annual_CDE_Plan__r.Academic_Growth_Median_Growth_Perc__c, UIP_Annual_CDE_Plan__r.Academic_Growth_Gaps_Median_Growth_Perc__c, UIP_Annual_CDE_Plan__r.Graduation_Rate_Expectation__c, UIP_Annual_CDE_Plan__r.Disaggregated_Grad_Rate_Expectation__c, UIP_Annual_CDE_Plan__r.Dropout_Rate_Expectation__c, UIP_Annual_CDE_Plan__r.Mean_CO_ACT_Composite_Score_Expecation__c, UIP_Annual_CDE_Plan__r.Plan_Type_Assignment_ID_Process__c, UIP_Annual_CDE_Plan__r.Title_I_Focus_School_ID_Process__c, UIP_Annual_CDE_Plan__r.TIG_ID_Process__c, UIP_Annual_CDE_Plan__r.CGP_ID_Process__c,UIP_Annual_CDE_Plan__r.School_s_on_Accountability_Clock__c, UIP_Annual_CDE_Plan__r.This_School_Year__c, UIP_Annual_CDE_Plan__r.Next_School_Year__c ';
        soql += ' FROM UIP__c WHERE Id = \'' + currentId + '\'';
        return Database.query(soql);
    }
    
    public void updateUIP() {
        try {
            update uip;
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            return;
        }
        //selectUIP();
        uip2 = null;
    }
    
    public void selectUIPContacts() {
        uipContactsList = [SELECT Id, First_Name__c, Last_Name__c, Title__c, Phone__c, Email__c, Mailing_Street__c, Mailing_City__c, Mailing_State_Province__c, Mailing_Zip_Postal_Code__c, UIP__c FROM UIP_Contact__c WHERE UIP__c = :currentId];
        uipDummyContactsMap = new Map<Id, UIP_Contact__c>();
        for (UIP_Contact__c c : uipContactsList) {
            uipDummyContactsMap.put(c.Id, new UIP_Contact__c());
        }
    }
    
    public void showSections() {
        
        ////////////////////
        sectionsNumber_AA = 0;
        if (uip.TARG_E_ACH_PA_PCT_READ__c == null && uip.E_ACH_PA_PCT_READ__c == null && 
            uip.TARG_E_ACH_PA_PCT_MATH__c == null && uip.E_ACH_PA_PCT_MATH__c == null && 
            uip.TARG_E_ACH_PA_PCT_WRITE__c == null && uip.E_ACH_PA_PCT_WRITE__c == null && 
            uip.TARG_E_ACH_PA_PCT_SCI__c == null && uip.E_ACH_PA_PCT_SCI__c == null ) {
                showElementary_AA = false;
            } else {
                showElementary_AA = true;
                sectionsNumber_AA++;
            }
        
        if (uip.TARG_M_ACH_PA_PCT_READ__c == null && uip.M_ACH_PA_PCT_READ__c == null && 
            uip.TARG_M_ACH_PA_PCT_MATH__c == null && uip.M_ACH_PA_PCT_MATH__c == null && 
            uip.TARG_M_ACH_PA_PCT_WRITE__c == null && uip.M_ACH_PA_PCT_WRITE__c == null && 
            uip.TARG_M_ACH_PA_PCT_SCI__c == null && uip.M_ACH_PA_PCT_SCI__c == null ) {
                showMS_AA = false;
            } else {
                showMS_AA = true;
                sectionsNumber_AA++;
            }
        
        if (uip.TARG_H_ACH_PA_PCT_READ__c == null && uip.H_ACH_PA_PCT_READ__c == null && 
            uip.TARG_H_ACH_PA_PCT_MATH__c == null && uip.H_ACH_PA_PCT_MATH__c == null && 
            uip.TARG_H_ACH_PA_PCT_WRITE__c == null && uip.H_ACH_PA_PCT_WRITE__c == null && 
            uip.TARG_H_ACH_PA_PCT_SCI__c == null && uip.H_ACH_PA_PCT_SCI__c == null ) {
                showHS_AA = false;
            } else {
                showHS_AA = true;
                sectionsNumber_AA++;
            }
        
        /////////////////AEC
        sectionsNumber_AA_AEC = 0;
        if (uip.Stat_AddMeas_1_subj1_MeetCutE__c == null && uip.Stat_AddMeas_1_subj1_Result_E__c == null && 
            uip.Stat_AddMeas_1_subj2_MeetCutE__c == null && uip.Stat_AddMeas_1_subj2ResultE__c == null && 
            uip.Stat_AddMeas_1_subj3_MeetCutE__c == null && uip.Stat_AddMeas_1_subj3_ResultE__c == null && 
            uip.Stat_AddMeas_1_subj4_MeetCutE__c == null && uip.Stat_AddMeas_1_subj4_ResultE__c == null ) {
                showElementary_AA_AEC = false;
            } else {
                showElementary_AA_AEC = true;
                sectionsNumber_AA_AEC++;
            }
        
        if (uip.Stat_AddMeas_1_subj1_MeetCut_M__c == null && uip.Stat_AddMeas_1_subj1_ResultM__c == null && 
            uip.Stat_AddMeas_1_subj2_MeetCutM__c == null && uip.Stat_AddMeas_1_subj2_ResultM__c == null && 
            uip.Stat_AddMeas_1_subj3_MeetCutM__c == null && uip.Stat_AddMeas_1_subj3_ResultM__c == null && 
            uip.Stat_AddMeas_1_subj4_MeetCutM__c == null && uip.Stat_AddMeas_1_subj4_ResultM__c == null ) {
                showMS_AA_AEC = false;
            } else {
                showMS_AA_AEC = true;
                sectionsNumber_AA_AEC++;
            }
        
        if (uip.Stat_AddMeas_1_subj1_MeetCut_H__c == null && uip.Stat_AddMeas_1_subj1_ResultH__c == null && 
            uip.Stat_AddMeas_1_subj2_MeetCutH__c == null && uip.Stat_AddMeas_1_subj2ResultH__c == null && 
            uip.Stat_AddMeas_1_subj3_MeetCutH__c == null && uip.Stat_AddMeas_1_subj3_ResultH__c == null && 
            uip.Stat_AddMeas_1_subj4_MeetCutH__c == null && uip.Stat_AddMeas_1_subj4_ResultH__c == null ) {
                showHS_AA_AEC = false;
            } else {
                showHS_AA_AEC = true;
                sectionsNumber_AA_AEC++;
            }
        
        /////////////////AEC2
        sectionsNumber_AA_AEC_2 = 0;
        if (uip.Stat_AddMeas_2_subj1_MeetCutE__c == null && uip.Stat_AddMeas_2_subj1_ResultE__c == null && 
            uip.Stat_AddMeas_2_subj2_MeetCutH__c == null && uip.Stat_AddMeas_2_subj2_ResultE__c == null ) {
                showElementary_AA_AEC_2 = false;
            } else {
                showElementary_AA_AEC_2 = true;
                sectionsNumber_AA_AEC_2++;
            }
        
        if (uip.Stat_AddMeas_2_subj1_MeetCutM__c == null && uip.Stat_AddMeas_2_subj1_ResultM__c == null && 
            uip.Stat_AddMeas_2_subj2_MeetCutM__c == null && uip.Stat_AddMeas_2_subj2_ResultM__c == null ) {
                showMS_AA_AEC_2 = false;
            } else {
                showMS_AA_AEC_2 = true;
                sectionsNumber_AA_AEC_2++;
            }
        
        if (uip.Stat_AddMeas_2_subj1_MeetCutH__c == null && uip.Stat_AddMeas_2_subj1_ResultH__c == null && 
            uip.Stat_AddMeas_2_subj2_MeetCutH__c == null && uip.Stat_AddMeas_2_subj2_ResultH__c == null ) {
                showHS_AA_AEC_2 = false;
            } else {
                showHS_AA_AEC_2 = true;
                sectionsNumber_AA_AEC_2++;
            }
        
        ////////////////////////
        sectionsNumber_AG = 0;
        if (uip.E_GRO_AGP_READ__c == null && uip.E_GRO_MGP_READ__c == null && 
            uip.E_GRO_AGP_MATH__c == null && uip.E_GRO_MGP_MATH__c == null && 
            uip.E_GRO_AGP_WRITE__c == null && uip.E_GRO_MGP_WRITE__c == null && 
            uip.E_GRO_MGP_ELP__c == null ) {
                showElementary_AG = false;
            } else {
                showElementary_AG = true;
                sectionsNumber_AG++;
            }
        
        if (uip.M_GRO_AGP_READ__c == null && uip.M_GRO_MGP_READ__c == null && 
            uip.M_GRO_AGP_MATH__c == null && uip.M_GRO_MGP_MATH__c == null && 
            uip.M_GRO_AGP_WRITE__c == null && uip.M_GRO_MGP_WRITE__c == null && 
            uip.M_GRO_MGP_ELP__c == null ) {
                showMS_AG = false;
            } else {
                showMS_AG = true;
                sectionsNumber_AG++;
            }
        
        if (uip.H_GRO_AGP_READ__c == null && uip.H_GRO_MGP_READ__c == null && 
            uip.H_GRO_AGP_MATH__c == null && uip.H_GRO_MGP_MATH__c == null && 
            uip.H_GRO_AGP_WRITE__c == null && uip.H_GRO_MGP_WRITE__c == null && 
            uip.H_GRO_MGP_ELP__c == null ) {
                showHS_AG = false;
            } else {
                showHS_AG = true;
                sectionsNumber_AG++;
            }
        
        ////////////////////////AEG
        sectionsNumber_AG_AEC = 0;
        if (uip.Grow_AddMeas_1_subj1_MeetCutE__c == null && uip.Grow_AddMeas_1_subj1_ResultE__c == null && 
            uip.Grow_AddMeas_1_subj2_MeetCutE__c == null && uip.Grow_AddMeas_1_subj2_ResultE__c == null && 
            uip.Grow_AddMeas_1_subj3_MeetCutE__c == null && uip.Grow_AddMeas_1_subj3_ResultE__c == null && 
            uip.Grow_AddMeas_1_subj4_MeetCutE__c == null && uip.Grow_AddMeas_1_subj4_ResultE__c == null) {
                showElementary_AG_AEC = false;
            } else {
                showElementary_AG_AEC = true;
                sectionsNumber_AG_AEC++;
            }
        
        if (uip.Grow_AddMeas_1_subj1_MeetCutM__c == null && uip.Grow_AddMeas_1_subj1_ResultM__c == null && 
            uip.Grow_AddMeas_1_subj2_MeetCutM__c == null && uip.Grow_AddMeas_1_subj2_ResultH__c == null && 
            uip.Grow_AddMeas_1_subj3_MeetCutM__c == null && uip.Grow_AddMeas_1_subj3_ResultM__c == null && 
            uip.Grow_AddMeas_1_subj4_MeetCutM__c == null && uip.Grow_AddMeas_1_subj4_ResultM__c == null) {
                showMS_AG_AEC = false;
            } else {
                showMS_AG_AEC = true;
                sectionsNumber_AG_AEC++;
            }
        
        if (uip.Grow_AddMeas_1_subj1_MeetCutH__c == null && uip.Grow_AddMeas_1_subj1_ResultH__c == null && 
            uip.Grow_AddMeas_1_subj2_MeetCutH__c == null && uip.Grow_AddMeas_1_subj2_ResultM__c == null && 
            uip.Grow_AddMeas_1_subj3_MeetCutH__c == null && uip.Grow_AddMeas_1_subj3_ResultH__c == null && 
            uip.Grow_AddMeas_1_subj4_MeetCutH__c == null && uip.Grow_AddMeas_1_subj4_ResultH__c == null) {
                showHS_AG_AEC = false;
            } else {
                showHS_AG_AEC = true;
                sectionsNumber_AG_AEC++;
            }
        
        ////////////////////////AEG2
        sectionsNumber_AG_AEC_2 = 0;
        if (uip.Grow_AddMeas_2_subj1_MeetCutE__c == null && uip.Grow_AddMeas_2_subj1_ResultE__c == null && 
            uip.Grow_AddMeas_2_subj2_MeetCutE__c == null && uip.Grow_AddMeas_2_subj2_ResultE__c == null ) {
                showElementary_AG_AEC_2 = false;
            } else {
                showElementary_AG_AEC_2 = true;
                sectionsNumber_AG_AEC_2++;
            }
        
        if (uip.Grow_AddMeas_2_subj1_MeetCutM__c == null && uip.Grow_AddMeas_2_subj1_ResultM__c == null && 
            uip.Grow_AddMeas_2_subj2_MeetCutM__c == null && uip.Grow_AddMeas_2_subj2_ResultM__c == null ) {
                showMS_AG_AEC_2 = false;
            } else {
                showMS_AG_AEC_2 = true;
                sectionsNumber_AG_AEC_2++;
            }
        
        if (uip.Grow_AddMeas_2_subj1_MeetCutH__c == null && uip.Grow_AddMeas_2_subj1_ResultH__c == null && 
            uip.Grow_AddMeas_2_subj2_MeetCutH__c == null && uip.Grow_AddMeas_2_subj2_ResultH__c == null ) {
                showHS_AG_AEC_2 = false;
            } else {
                showHS_AG_AEC_2 = true;
                sectionsNumber_AG_AEC_2++;
            }
        
        ////////////////////////////////////
        if (uip.TARG_PS_DROP_RATE__c == null && uip.PS_DROP_RATE__c == null && 
            uip.TARG_PS_ACT_SCORE__c == null && uip.PS_ACT_SCORE__c == null && 
            uip.PS_GRAD_RATING__c == null && uip.PS_GRAD_DSAG_RATING__c == null && 
            uip.PS_DROP_RATING__c == null && uip.PS_ACT_RATING__c == null && 
            uip.x1_3_POST_SEC_RATING__c == null ) {
                showPostsecondary = false;
            } else {
                showPostsecondary = true;
            }
        
        if (uip.UAIP_TARG_PS_COMP_BEST_CR__c == null && uip.UAIP_PS_COMP_BEST_CR__c == null && uip.PS_GRAD_RATING__c == null &&
            uip.TARG_PS_DROP_RATE__c == null && uip.PS_DROP_RATE__c == null && uip.PS_DROP_RATING__c == null &&
            uip.TARG_PS_ACT_SCORE__c == null && uip.PS_ACT_SCORE__c == null && uip.PS_ACT_RATING__c == null &&
            uip.PWR_AddMeas_1_MeetCut__c == null && uip.PWR_AddMeas_1_Result__c == null && uip.PWR_AddMeas_1_Rating__c == null &&
            uip.PWR_AddMeas_2_MeetCut__c == null && uip.PWR_AddMeas_2_Result__c == null && uip.PWR_AddMeas_2_Rating__c == null &&
            uip.x1_3_POST_SEC_RATING__c == null ) {
                showPostsecondary_AEC = false;
            } else {
                showPostsecondary_AEC = true;
            }
        
        studentNumber_AEC = 0;
        if (uip.STENG_AddMeas_1_MeetCutE__c != null) {
            studentNumber_AEC++;
        }
        if (uip.STENG_AddMeas_1_ResultM__c != null) {
            studentNumber_AEC++;
        }
        if (uip.STENG_AddMeas_1_ResultH__c != null) {
            studentNumber_AEC++;
        }
        
        if (uip.A_TTL_RATING_OFFICIAL__c == null && uip.RATING_DIRECTIONS__c == null && 
            uip.FOCUS_TYPE__c == null && uip.FOCUS_DIRECTIONS__c == null && 
            uip.TIG_TYPE__c == null && uip.TIG_DIRECTIONS__c == null && 
            uip.Diagnostic_Review_Grant_Type__c == null && uip.Diagnostic_Review_Grant_Instructions__c == null && 
            uip.SIS_Grant__c == null && uip.SIS_Grant_Instructions__c == null && 
            uip.CGP_PLAN_TYPE__c == null && uip.CGP_PLAN_DIRECTIONS__c == null) {
                showStateAccountability = false;
            } else {
                showStateAccountability = true;
            }
        
        if (uip.AMAO1_RATING__c == null && uip.AMAO2_RATE__c == null && 
            uip.AMAO3_RATING_READ__c == null && uip.AMAO_3_Write_Rating__c == null && 
            uip.AMAO3_RATING_MATH__c == null && uip.AMAO3_RATING_ELL_GRAD__c == null && 
            uip.AMAO3_RATING_PARTIC__c == null && uip.AMAO1_MEETS_EXP__c == null && 
            uip.AMAO2_MEETS_EXP__c == null && uip.AMAO3_MEETS_EXP__c == null) {
                showEnglishLanguage_District = false;
            } else {
                showEnglishLanguage_District = true;
            }
        
        if (uip.A_TTL_RATING_OFFICIAL__c == null && uip.RATING_DIRECTIONS__c == null && 
            uip.SCHLS_ON_CLOCK_NUM__c == null && uip.SCHLS_ON_CLOCK_DIRECTIONS__c == null && 
            uip.GRAD_PLAN_TYPE__c == null && uip.GRAD_PLAN_DIRECTIONS__c == null && 
            uip.GIFTED_TYPE__c == null && uip.GIFTED_DIRECTIONS__c == null) {
                showStateAccountability_District = false;
            } else {
                showStateAccountability_District = true;
            }
        
        if (uip.TITLE1A_TYPE__c == null && uip.TITLE1A_DIRECTIONS__c == null && 
            uip.TITLE2A_TYPE__c == null && uip.TITLE2A_DIRECTIONS__c == null && 
            uip.TITLE3_TYPE__c == null && uip.TITLE3_DIRECTIONS__c == null && 
            uip.TIG_Type__c == null && uip.TIG_DIRECTIONS__c == null) {
                showESEAccountability_District = false;
            } else {
                showESEAccountability_District = true;
            }
        
    }
    
    public void Save() {
        try {
            update uip;
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            return;
        }
        isPageChanged = false;
    }
    
    public void NewContact() {
        dummyStandardContact = new UIP_Contact__c();
        dummyStandardContact.UIP__c = currentId;
        isNewContact = true;
    }
    
    public void CancelNewContact() {
        isNewContact = false;
    }
    
    public void EditContact() {
        isEditContact = true;
        String editContactId = ApexPages.currentPage().getParameters().get('editContactId');
        //uipDummyContactsMap.put(editContactId, [SELECT Id, FirstName, LastName, Title, Phone, Email, MailingStreet, MailingCity, MailingState, MailingPostalCode, MailingCountry, UIP__c FROM Contact WHERE Id = :editContactId]);
        uipDummyContactsMap.put(editContactId, [SELECT Id, First_Name__c, Last_Name__c, Title__c, Phone__c, Email__c, Mailing_Street__c, Mailing_City__c, Mailing_State_Province__c, Mailing_Zip_Postal_Code__c, UIP__c FROM UIP_Contact__c WHERE Id = :editContactId]);
    }
    
    public void CancelEditContact() {
        isEditContact = false;
    }
    
    public void SaveEditContact() {
        String contactId = ApexPages.currentPage().getParameters().get('contactId');
        
        try {
            update uipDummyContactsMap.get(contactId);
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            return;
        }
        isEditContact = false;
        selectUIPContacts();
    }
    
    public void AddContact() {
        if (dummyStandardContact.Last_Name__c == null || dummyStandardContact.Last_Name__c == '') {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'Last Name: please enter a value'));
            return;
        }
        try {
            insert dummyStandardContact;
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            return;
        }
        isNewContact = false;
        selectUIPContacts();
    }
    
    public void DeleteContact() {
        Id contactId = ApexPages.currentPage().getParameters().get('contactId');
        UIP_Contact__c cont = [SELECT Id FROM UIP_Contact__c WHERE Id= :contactId];
        
        try {
            delete cont;
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            return;
        }
        selectUIPContacts();
    }
    
    public PageReference DownloadWord_S2() {
        PageReference pageRef = new PageReference('/apex/Section2_ExportWord');
        pageRef.getParameters().put('id', uip.Id);
        return pageRef;
    }
    
    public PageReference DownloadExcel_S1() {
        PageReference pageRef = new PageReference('/apex/Section1_ExportExcel');
        pageRef.getParameters().put('id', uip.Id);
        return pageRef;
    }
    
    public PageReference DownloadExcel_S1_District() {
        PageReference pageRef = new PageReference('/apex/Section1_District_ExportExcel');
        pageRef.getParameters().put('id', uip.Id);
        return pageRef;
    }
    
    public PageReference DownloadExcel_S1_AEC() {
        PageReference pageRef = new PageReference('/apex/Section1_AEC_ExportExcel');
        pageRef.getParameters().put('id', uip.Id);
        return pageRef;
    }
    /*public void ClearFormatting1() {
	uip.Related_Grant_Awards__c = uip.Related_Grant_Awards__c.replaceAll('<[^>]+>',' ');
	}
	public void ClearFormatting2() {
	uip.SST_Expedited_Review__c = uip.SST_Expedited_Review__c.replaceAll('<[^>]+>',' ');
	}
	public void ClearFormatting3() {
	uip.External_Evaluator__c = uip.External_Evaluator__c.replaceAll('<[^>]+>',' ');
	}*/
    public void setPageChanged() {
        isPageChanged = true;
    }   
}