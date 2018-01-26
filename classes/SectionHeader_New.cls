public class SectionHeader_New {

    public UIP__c uip { get; set; }
    
    public boolean isCommunityUser { get; set; }
    public String activeMenu { get; set; }
    public String activeSubMenu { get; set; }
    Map<String,String> section1Map  { get; set; }
    public List<Section3.AddendumWrapper> addWList { get; set; }
    public Integer countAddendum { get; set; }
    public boolean isSection3 { get; set; }
    public string picklistvalue { get;set; }
    public List<UIP__c> UIPSchoolList { get; set; }
    
    public SectionHeader_New(ApexPages.StandardController stdController) {
        uip = [SELECT Id, Name, RecordType.Name, DISTRICT_NAME__r.Name, DIST_NUMBER__c, A_TTL_RATING_OFFICIAL__c, SCHOOL_NUMBER__c 
               FROM UIP__c WHERE Id = :SectionUtil.getUipId()];
        isCommunityUser = SectionUtil.isCommunityUser();
        activeMenu = SectionUtil.setActiveMenu();
        activeSubMenu = SectionUtil.setActiveSubMenu();
        section1Map = getSection1Map();
        selectAllAddendums();
        countAddendum = addWList.size();
        isSection3 = false;
        if (activeMenu == 'Section3') {
            isSection3 = true;
        }
        userDataCode();
        
    }
    
    public void userDataCode(){
     Id usId = UserInfo.getUserId();
        System.debug('usId '+usId);
     UIPSchoolList = [SELECT Name, Id, SCHOOL_NAME__c FROM UIP__c where SCHOOL_NAME__c IN (SELECT AccountId FROM User WHERE Id = :usId)];
     System.debug('UIPSchoolList '+UIPSchoolList);
    }
    
     public List<SelectOption> getschoolData() {
       
       List<SelectOption> options = new List<SelectOption>();
       for(UIP__c e : UIPSchoolList)
       {
         options.add(new SelectOption(e.Name, e.Name));
       }
       return options;
    }
    
    public pagereference redirect()
	{
    	Id pgId;
    	for(UIP__c e : UIPSchoolList)
    	{
        	if(e.Name == picklistvalue)
        	{
           	pgId  = e.Id;
        	}
    	}
    	PageReference pageRef = new PageReference('/?id='+pgId);
    	//pageRef.getParameters().put('Id', pgId);
    	pageRef.setRedirect(true);
    	return pageRef;
	}
    
    public Map<String,String> getSection1Map() {
        Map<String,String> sect1Map = new Map<String,String>();
        sect1Map.put('AEC UIP','Section1_AEC');
        sect1Map.put('District UIP','Section1_District');
        sect1Map.put('School UIP','Section1');
        sect1Map.put('AEC UIP 2015','Section1_AEC_2015');
        sect1Map.put('District UIP 2015','Section1_District_2015');
        sect1Map.put('School UIP 2015','Section1_2015');
        sect1Map.put('AEC UIP 2016','Section1_AEC_2015');
        sect1Map.put('District UIP 2016','Section1_District_2015');
        sect1Map.put('School UIP 2016','Section1_2015');
        sect1Map.put('AEC UIP 2017','Section1_AEC_2015');
        sect1Map.put('District UIP 2017','Section1_District_2015');
        sect1Map.put('School UIP 2017','Section1_2015');
        sect1Map.put('Network 2016','Section1_2015');
        
        return sect1Map;
    }
    
    public void selectAllAddendums() {
        
        String soql = SectionUtil.getFieldsQuery('Addendum__c');
        soql += ',RecordType.Name, UIP__r.SCHOOL_NAME__r.Name, School_UIP__r.SCHOOL_NAME__r.Name';
        soql += ' FROM Addendum__c WHERE UIP__c = \'' + uip.Id + '\'';
        List<Addendum__c> addList = Database.query(soql);
        system.debug('addList:::' + addList);
        addWList = new List<Section3.AddendumWrapper>();
        Map<Integer, Section3.AddendumWrapper> addWPositionMap = new Map<Integer, Section3.AddendumWrapper>();
        Section3.AddendumWrapper addW;
        Integer i = 1;
        Set<Id> addEseaSet = new Set<Id>();
        Map<String,String> params = ApexPages.currentPage().getParameters();
        if (params.containsKey('rt')) {
            String currentRequestURL = params.get('rt');
            System.debug('Current request URL: ' + currentRequestURL);
            String currentRT = '';
            Map<String,String> addRTMap = getAddendumRTMap();
            for (String key : addRTMap.KeySet()) {
                if (currentRequestURL.containsIgnoreCase(key)) {
                    currentRT = addRTMap.get(key);
                    break;
                }
            }
            system.debug('currentRT:::' + currentRT);
            for (Integer k = 0; k < addList.size(); k++) {
                system.debug('addList.get(k):::' + addList.get(k));
                system.debug('addList.get(k).RecordType.Name:::' + addList.get(k).RecordType.Name);
                if (addList.get(k).RecordType.Name == currentRT) {
                    if (currentRT == 'DIST ESEA Supporting Addendum') {
                        addEseaSet.add(addList.get(k).Id);
                    }
                    addW = new Section3.AddendumWrapper(addList.remove(k), i);
                    addW.addURL = currentRequestURL;
                    addWList.add(addW);
                    addWPositionMap.put(i, addW);
                    System.debug('Test123:'+addW.addURL );
                    i++;
                    break;
                }
            }
        }
        system.debug('addWList:::' + addWList);
        for (Addendum__c add : addList) {
            addW = new Section3.AddendumWrapper(add, i);
            if (add.RecordType.Name == 'DIST ESEA Supporting Addendum') {
                addW.addURL = 'Addenda_DIST_ESEA_Supporting';
                addEseaSet.add(add.Id);
            } else if (add.RecordType.Name == 'Dist/Sch Turnaround') {
                addW.addURL = 'Addenda_DistSch_Turnaround';
            } else if (add.RecordType.Name == 'DIST Gifted Program') {
                addW.addURL = 'Addenda_DIST_Gifted_Program';
            } else if (add.RecordType.Name == 'Title I') {
                addW.addURL = 'Addenda_SCHTitle1_SW';
            } else if (add.RecordType.Name == 'DIST SGCP Addendum') {
                addW.addURL = 'Addenda_DIST_SGCP';
            } else if (add.RecordType.Name == 'DIST Title III Improvement Addendum') {
                addW.addURL = 'Addenda_DIST_Title_III_Improvement';
            } else if (add.RecordType.Name == 'TIG Turnaround') {
                addW.addURL = 'Addenda_TIGTurnaround';
            } else if (add.RecordType.Name == 'TIG Closure') {
                addW.addURL = 'Addenda_TIGClosure';
            } else if (add.RecordType.Name == 'TIG Transformation') {
                addW.addURL = 'Addenda_TIGTransformation';
            }
            if (add.UIP__r.SCHOOL_NAME__r.Name != null && add.UIP__r.SCHOOL_NAME__r.Name != '') {
                addW.schoolName = add.UIP__r.SCHOOL_NAME__r.Name;
            } else if (add.School_UIP__r.SCHOOL_NAME__r.Name != null && add.School_UIP__r.SCHOOL_NAME__r.Name != '') {
                addW.schoolName = add.School_UIP__r.SCHOOL_NAME__r.Name;
            }
            addWList.add(addW);
            addWPositionMap.put(i, addW);
            i++;
        }
        /*
        system.debug('addWList:::' + addWList);
        system.debug('isPublicUIPVFPage:::' + isPublicUIPVFPage());
        if(!isPublicUIPVFPage())
        {
          if (addWList.size() > 0) {
              addendum = addWList[addPosition - 1].addendum;
              if (addendum.RecordType.Name == 'DIST ESEA Supporting Addendum') {
                  selectSupportingAddenda(addendum.Id);
              }
          }
        }
        else
        {
           if (addEseaSet.size() > 0)
           {
             addendum = addWList[addPosition - 1].addendum;
             selectSupportingAddendaForPublicUIP(addEseaSet);
           }
        }
		*/      
    }
    
    public Map<String,String> getAddendumRTMap() {
        Map<String,String> addendumMap = new Map<String,String>();
        addendumMap.put('Addenda_DIST_ESEA_Supporting','DIST ESEA Supporting Addendum');
        addendumMap.put('Addenda_DistSch_Turnaround','Dist/Sch Turnaround');
        addendumMap.put('Addenda_DIST_Gifted_Program','DIST Gifted Program');
        addendumMap.put('Addenda_SCHTitle1_SW','Title I');
        addendumMap.put('Addenda_DIST_SGCP','DIST SGCP Addendum');
        addendumMap.put('Addenda_DIST_Title_III_Improvement','DIST Title III Improvement Addendum');
        addendumMap.put('Addenda_TIGTurnaround','TIG Turnaround');
        addendumMap.put('Addenda_TIGClosure','TIG Closure');
        addendumMap.put('Addenda_TIGTransformation','TIG Transformation');
        return addendumMap;
    }
}