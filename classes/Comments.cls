public without sharing class Comments {
    public String currentId { get; set; }
    public UIP__c uip { get; set; }
    public CDE_Feedback_Review__c cdeFeedbackRev { get; set; }
    public List<CDE_Feedback_Review__c> cdeFeedbackRevList { get; set; }
    public List<CDE_Feedback__c> cdeFeedbackList { get; set; }
    public Map<Id, List<CDE_Feedback__c>> cdeFeedbackMap { get; set; }
    public boolean isfeedback { get; set; }
    public Integer feedbackNumber { get; set; }
    public Integer feedbackCount { get; set; }
    
    public String activeMenu { get; set; }
    public String activeSubMenu { get; set; }
    public boolean isCommunityUser { get; set; }
    
    public String timeline{get;set;}
    public String timeline1{get;set;}
    public String timeline2{get;set;}
    public String timeline3{get;set;}
    public String timeline4{get;set;}
    
    public Boolean fbq1True{get;set;}
    public Boolean fbq1False{get;set;}
    public Boolean fbq2True{get;set;}
    public Boolean fbq2False{get;set;}
    public Boolean fbq3True{get;set;}
    public Boolean fbq3False{get;set;}
    public Boolean fbq4True{get;set;}
    public Boolean fbq4False{get;set;}
    public Boolean fbq5True{get;set;}
    public Boolean fbq5False{get;set;}
    
    public Boolean submitForApproval{get;set;}
    public Boolean currentUserFlag{get;set;}
    public Boolean recordUnderApproval{get;set;}
    public Boolean approvedFlag{get;set;}
    public List<CDE_Feedback__c> cdeFeedbackListofUIP { get; set; }
    public CDE_Feedback__c feedbackOfCurrentYear { get; set; }
    public CDE_Feedback__c feedbackOfLastYear { get; set; }
    
    public void popuateSummaryFeedbackTable()
    {
        if(fbq1True==True)
        {
            feedbackOfCurrentYear.Feedback_Question1__c=true;
            fbq1True=false;
            fbq1False=false;
        }
        if(fbq1False==True)
        {
            feedbackOfCurrentYear.Feedback_Question1__c=false;
            fbq1True=false;
            fbq1False=false;
        }
        if(fbq2True==True)
        {
            feedbackOfCurrentYear.Feedback_Question2__c=true;
            fbq2True=false;
            fbq2False=false;
        }
        if(fbq2False==True)
        {
            feedbackOfCurrentYear.Feedback_Question2__c=false;
            fbq2True=false;
            fbq2False=false;
        }
        if(fbq3True==True)
        {
            feedbackOfCurrentYear.Feedback_Question3__c=true;
            fbq3True=false;
            fbq3False=false;
        }
        if(fbq3False==True)
        {
            feedbackOfCurrentYear.Feedback_Question3__c=false;
            fbq3True=false;
            fbq3False=false;
        }
        if(fbq4True==True)
        {
            feedbackOfCurrentYear.Feedback_Question4__c=true;
            fbq4True=false;
            fbq4False=false;
        }
        if(fbq4False==True)
        {
            feedbackOfCurrentYear.Feedback_Question4__c=false;
            fbq4True=false;
            fbq4False=false;
        }
        if(fbq5True==True)
        {
            feedbackOfCurrentYear.Feedback_Question5__c=true;
            fbq5True=false;
            fbq5False=false;
        }
        if(fbq5False==True)
        {
            feedbackOfCurrentYear.Feedback_Question5__c=false;
            fbq5True=false;
            fbq5False=false;
        }
        Upsert feedbackOfCurrentYear;
        
    }
    
    public void populateTimeLine()
    {
        if(timeline=='none')
        {
            timeline1='';
            timeline2='';
            timeline3='';
            timeline4='';
        }
        if(timeline=='value1')
        {
            timeline1='April 15, 2016';
            timeline2='Submit most current version of UIP to CDE for public posting on SchoolView.';
            timeline3='June 30, 2016';
            timeline4='Submit UIP to CDE for additional review to ensure that required changes were addressed.';
        }
        else if(timeline=='value2')
        {
            timeline1='April 15, 2016';
            timeline2='Submit most current version of UIP to CDE for public posting on SchoolView.';
            timeline3='Jan 15, 2017';
            timeline4='(If applicable) Required changes must be addressed.Jan 15, 2017';
        }
        else if(timeline=='value3')
        {
           timeline1='April 15, 2016';
           timeline2='Submit most current version of UIP to CDE for public posting on SchoolView.';
           timeline3='';
           timeline4='';
        }
        
    }
    
    public Comments() {
    System.debug('In Constructor');
        activeMenu = SectionUtil.setActiveMenu();
        activeSubMenu = SectionUtil.setActiveSubMenu();
        isCommunityUser = SectionUtil.isCommunityUser();
        
        Map<String,String> params = ApexPages.currentPage().getParameters();
        currentId = params.get('id');
        
        if (params.containsKey('feedback')) {
            feedbackNumber = Integer.valueOf(params.get('feedback'));
        } else {
            feedbackNumber = 1;
        }
        selectUIP();
        selectCdeFeedbackRev();
        
        feedbackCount = cdeFeedbackRevList.size();
        if (feedbackCount > 0) {
            isfeedback = true;
            cdeFeedbackRev = cdeFeedbackRevList[feedbackNumber - 1];
            cdeFeedbackList = [SELECT Id, Name, Comments__c, Section_Reference__c, Worksheet_Reference__c, UIP__c, CDE_Feedback_Review__c FROM CDE_Feedback__c WHERE CDE_Feedback_Review__c IN :cdeFeedbackRevList];
            cdeFeedbackMap = new Map<Id, List<CDE_Feedback__c>>();
            
            for (CDE_Feedback__c c : cdeFeedbackList) {
                if (!cdeFeedbackMap.containsKey(c.CDE_Feedback_Review__c)) {
                    cdeFeedbackMap.put(c.CDE_Feedback_Review__c, new List<CDE_Feedback__c>());
                }
                cdeFeedbackMap.get(c.CDE_Feedback_Review__c).add(c);
            }
            for (CDE_Feedback_Review__c cr : cdeFeedbackRevList) {
                if (!cdeFeedbackMap.containsKey(cr.Id)) {
                    cdeFeedbackMap.put(cr.Id, new List<CDE_Feedback__c>());
                }
            }
            System.debug('cdeFeedbackMap:::' + cdeFeedbackMap);
        } else {
            isfeedback = false;
        }
        selectCdeFeedback();
        populateTimeLine();
        submitForApproval=true;
        System.debug('****feedbackOfCurrentYear'+feedbackOfCurrentYear);
        checkApproval();
        System.debug('****submitForApproval'+submitForApproval);
    }
    public void checkApproval()
    {
        if(feedbackOfCurrentYear.ID!=null)
        {
            System.debug('****feedbackOfCurrentYear.ID'+feedbackOfCurrentYear.ID);
            List<ProcessInstance> processes=[Select ID,TargetObjectId,Status from ProcessInstance where TargetObjectId=:feedbackOfCurrentYear.ID];
            System.debug('Process:'+processes);
            if(processes.size()!=0)
            {
                for(ProcessInstance p:processes)
                {
                    System.debug('****p.status'+p.status);
                    if(p.status=='Pending')
                    {
                        submitForApproval=false;
                        recordUnderApproval=true;
                        System.debug('*****recordUnderApproval*****'+recordUnderApproval);
                        List<ProcessInstanceWorkitem> workitems = [select id,actorid,ProcessInstanceId from ProcessInstanceWorkitem where ProcessInstanceId=:p.id];
                        if(workitems.size()!=0)
                        {
                            System.debug('workitems[0].actorId:'+workitems[0].actorId);
                            System.debug('Userinfo.getUserId():'+Userinfo.getUserId());
                            if(Userinfo.getUserId()==workitems[0].actorId)
                                currentUserFlag=true;
                        }
                    }
                    if(p.status=='Approved')
                    {
                       approvedFlag=true; 
                    }
                }
            }
        }
    }
    public void selectUIP() {
        String soql = 'SELECT FOCUS_TYPE__c, Diagnostic_Review_Grant_Type__c, SIS_Grant__c, X21st_Century__c, CGP_PLAN_TYPE__c, usip_READ_type__c, A_TTL_RATING_OFFICIAL__c, TIG_TYPE__c, SCHOOL_NUMBER__c ';
        soql += ', SCHOOL_NAME__r.Name, SCHOOL_NAME__r.SCHOOL_NUMBER__c,DISTRICT_NAME__r.Name,  DISTRICT_NAME__r.DIST_NUMBER__c,UIP_Annual_CDE_Plan__r.April_Deadline__c, UIP_Annual_CDE_Plan__r.Blank_Template_Released__c, UIP_Annual_CDE_Plan__r.January_Deadline__c, UIP_Annual_CDE_Plan__r.October_Deadline__c, UIP_Annual_CDE_Plan__r.Section_1_Data_Populated__c, UIP_Annual_CDE_Plan__r.Section_1_Update__c, RecordType.Name ';
        soql += ', UIP_Annual_CDE_Plan__r.Academic_Achievement_Measures_Metrics__c, UIP_Annual_CDE_Plan__r.Academic_Growth_Median_Growth_Perc__c, UIP_Annual_CDE_Plan__r.Academic_Growth_Gaps_Median_Growth_Perc__c, UIP_Annual_CDE_Plan__r.Graduation_Rate_Expectation__c, UIP_Annual_CDE_Plan__r.Disaggregated_Grad_Rate_Expectation__c, UIP_Annual_CDE_Plan__r.Dropout_Rate_Expectation__c, UIP_Annual_CDE_Plan__r.Mean_CO_ACT_Composite_Score_Expecation__c, UIP_Annual_CDE_Plan__r.Plan_Type_Assignment_ID_Process__c, UIP_Annual_CDE_Plan__r.Title_I_Focus_School_ID_Process__c, UIP_Annual_CDE_Plan__r.TIG_ID_Process__c, UIP_Annual_CDE_Plan__r.CGP_ID_Process__c ';
        soql += ' FROM UIP__c WHERE Id = \'' + currentId + '\'';
        uip = Database.query(soql);
        System.debug('uip:::' + uip);
    }
    
    public void selectCdeFeedbackRev() {
        String soql = SectionUtil.getFieldsQuery('CDE_Feedback_Review__c');
        soql += ' FROM CDE_Feedback_Review__c WHERE UIP__c = \'' + currentId + '\' order by Review_Period__c';
        cdeFeedbackRevList = Database.query(soql);
        System.debug('cdeFeedbackRevList:::' + cdeFeedbackRevList);
    }
    
    Integer year=Date.Today().year();
    public void selectCdeFeedback() 
    {
        
        List<String> yearList=new List<String>();
        //feedbackOfCurrentYear=new CDE_Feedback__c();
        yearList.add(String.valueOf(year));
        yearList.add(String.valueOf(year-1));
        String soql = SectionUtil.getFieldsQuery('CDE_Feedback__c');
        soql += ',Level1_Approver__r.id FROM CDE_Feedback__c WHERE UIP__c = \'' + currentId + '\' AND Feedback_Year__c IN:yearList';
        cdeFeedbackListofUIP = Database.query(soql);
        System.debug('Test CDE:'+cdeFeedbackListofUIP);
        for(CDE_Feedback__c c:cdeFeedbackListofUIP)
        {
            if(c.Feedback_Year__c == String.valueOf((year-1)))
            {
                feedbackOfLastYear=c;
            }
            if(c.Feedback_Year__c == String.valueOf(year))
            {
                feedbackOfCurrentYear=c;
            }
        }
        if(feedbackOfCurrentYear==null)
        {
            feedbackOfCurrentYear=new CDE_Feedback__c(); 
        } 
        
    }
    
    public void saveCurrentFeedback()
    {
       if(feedbackOfCurrentYear.UIP__c==null)
        {
            //feedbackOfCurrentYear=new CDE_Feedback__c();
            feedbackOfCurrentYear.Feedback_Year__c=String.valueOf(year);
            feedbackOfCurrentYear.UIP__c=currentId;
            system.debug('****feedbackOfCurrentYear****'+feedbackOfCurrentYear);
            system.debug('****currentId****'+currentId);
            system.debug('****year****'+String.valueOf(year));
            upsert feedbackOfCurrentYear;
        }
        else
        {
            update feedbackOfCurrentYear;
        }
    }
    public boolean displayPopup {get; set;}
    public void populateApprovers()
    {
        displayPopup = true;
    }
    public void submit() 
    {
        if(feedbackOfCurrentYear.ID!=null)
        {
            feedbackOfCurrentYear.SubmitFlag__c=true;
             update feedbackOfCurrentYear;
        }
    }
    public void submitReq()
    {
        //dc.Level1_Approver__c='005900000033XNP';
        update feedbackOfCurrentYear;
        Approval.ProcessSubmitRequest req=new Approval.ProcessSubmitRequest();
        req.setObjectId(feedbackOfCurrentYear.id);
        Approval.ProcessResult result =Approval.process(req);
        submitForApproval=false;
    }
    public ID getWorkItemId()
    {
        Id retVal = null;
        if(feedbackOfCurrentYear.ID!=null)
        {
            ProcessInstanceWorkitem workItem =[Select Id from ProcessInstanceWorkitem where ProcessInstance.TargetObjectId =: feedbackOfCurrentYear.ID];
            retVal =workitem.id;
        }
        return retVal;
    }
    public void approveReq()
    {
        if(feedbackOfCurrentYear.ID!=null)
        {
            Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
            req.setComments('Approve request');
            req.setAction('Approve');
            //req.setNextApproverIds(new Id[] {feedbackOfCurrentYear.Level1_Approver__r.id});
            req.setWorkitemId(getWorkItemId());
            Approval.ProcessResult result =  Approval.process(req);
            recordUnderApproval=false;
            currentUserFlag=false;
            checkApproval();
            
        }
    }
    public void rejectReq()
    {
        if(feedbackOfCurrentYear.ID!=null)
        {
            Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
            req.setComments('Rejected request');
            req.setAction('Reject');
            req.setWorkitemId(getWorkItemId());
            Approval.ProcessResult result =  Approval.process(req);
            recordUnderApproval=false;
            currentUserFlag=false;
            checkApproval();
            
           
        }
    }
}