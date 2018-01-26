trigger UIP_All on UIP__c (before insert, before update, after insert, after update) {
    public Map<String, String> addendumRTMap = SectionUtil.getPiRtValueMap('Addendum__c');
    
    if (trigger.isBefore && (trigger.isInsert || trigger.isUpdate)) {
        if (!SectionUtil.stopTrigger) {
            updateAddendaForCombinedPlans();
        }
    }
    if (trigger.isAfter && (trigger.isInsert || trigger.isUpdate)) {
        createAddenda();
    }
    
    public void updateAddendaForCombinedPlans() {
        SectionUtil.stopTrigger = true;
        Set<String> distNumberSet = new Set<String>();
        Set<String> distNumberForDeleteSet = new Set<String>();
        Set<String> schoolForDeleteSet = new Set<String>();
        String rtSchoolId = Schema.SObjectType.UIP__c.getRecordTypeInfosByName().get('School UIP').getRecordTypeId();
        String rtAecId = Schema.SObjectType.UIP__c.getRecordTypeInfosByName().get('AEC UIP').getRecordTypeId();
        for (UIP__c uip : trigger.new) {
            system.debug(uip.DIST_NUMBER__c + '&&' + uip.RecordTypeId + '&&' + trigger.isInsert);
            if (uip.DIST_NUMBER__c != null && (uip.RecordTypeId == rtSchoolId || uip.RecordTypeId == rtAecId) && (trigger.isInsert || (trigger.isUpdate && trigger.oldMap.get(uip.Id).Combined_Plan__c != uip.Combined_Plan__c))) {
                if (uip.Combined_Plan__c == true) {
                    distNumberSet.add(uip.DIST_NUMBER__c);
                } else {
                    distNumberForDeleteSet.add(uip.DIST_NUMBER__c);
                    schoolForDeleteSet.add(uip.Id);
                    uip.District_UIP_for_Combined_Plans__c = null;
                }
            }
        }
        String rtDistrictId = Schema.SObjectType.UIP__c.getRecordTypeInfosByName().get('District UIP').getRecordTypeId();
        if (distNumberSet.size() > 0 || distNumberForDeleteSet.size() > 0) {
            List<UIP__c> uipDistrictList = [SELECT Id, DIST_NUMBER__c FROM UIP__c WHERE RecordTypeId = :rtDistrictId AND (DIST_NUMBER__c IN :distNumberSet OR DIST_NUMBER__c IN :distNumberForDeleteSet)];
            Map<String, List<UIP__c>> districtUipMap = new Map<String, List<UIP__c>>();
            Map<String, List<UIP__c>> districtUipForDeleteMap = new Map<String, List<UIP__c>>();
            for (UIP__c uip : uipDistrictList) {
                if (distNumberSet.contains(uip.DIST_NUMBER__c)) {
                    if (!districtUipMap.containsKey(uip.DIST_NUMBER__c)) {
                        districtUipMap.put(uip.DIST_NUMBER__c, new List<UIP__c>());
                    }
                    districtUipMap.get(uip.DIST_NUMBER__c).add(uip);
                }
                if (distNumberForDeleteSet.contains(uip.DIST_NUMBER__c)) {
                    if (!districtUipForDeleteMap.containsKey(uip.DIST_NUMBER__c)) {
                        districtUipForDeleteMap.put(uip.Id, new List<UIP__c>());
                    }
                    districtUipForDeleteMap.get(uip.Id).add(uip);
                }
            }
            addAddendaForCombinedPlan(districtUipMap, rtSchoolId, rtAecId);
            deleteAddendaForCombinedPlan(districtUipForDeleteMap, schoolForDeleteSet);
        }
        
        updateAddendaForCombinedPlans2015();
        updateAddendaForCombinedPlans2016();
    }
    
    public void updateAddendaForCombinedPlans2015() {
        SectionUtil.stopTrigger = true;
        Set<String> distNumberSet = new Set<String>();
        Set<String> distNumberForDeleteSet = new Set<String>();
        Set<String> schoolForDeleteSet = new Set<String>();
        String rtSchoolId = Schema.SObjectType.UIP__c.getRecordTypeInfosByName().get('School UIP 2015').getRecordTypeId();
        String rtAecId = Schema.SObjectType.UIP__c.getRecordTypeInfosByName().get('AEC UIP 2015').getRecordTypeId();
        for (UIP__c uip : trigger.new) {
            system.debug(uip.DIST_NUMBER__c + '&&' + uip.RecordTypeId + '&&' + trigger.isInsert);
            if (uip.DIST_NUMBER__c != null && (uip.RecordTypeId == rtSchoolId || uip.RecordTypeId == rtAecId) && (trigger.isInsert || (trigger.isUpdate && trigger.oldMap.get(uip.Id).Combined_Plan__c != uip.Combined_Plan__c))) {
                if (uip.Combined_Plan__c == true) {
                    distNumberSet.add(uip.DIST_NUMBER__c);
                } else {
                    distNumberForDeleteSet.add(uip.DIST_NUMBER__c);
                    schoolForDeleteSet.add(uip.Id);
                    uip.District_UIP_for_Combined_Plans__c = null;
                }
            }
        }
        String rtDistrictId = Schema.SObjectType.UIP__c.getRecordTypeInfosByName().get('District UIP 2015').getRecordTypeId();
        if (distNumberSet.size() > 0 || distNumberForDeleteSet.size() > 0) {
            List<UIP__c> uipDistrictList = [SELECT Id, DIST_NUMBER__c FROM UIP__c WHERE RecordTypeId = :rtDistrictId AND (DIST_NUMBER__c IN :distNumberSet OR DIST_NUMBER__c IN :distNumberForDeleteSet)];
            Map<String, List<UIP__c>> districtUipMap = new Map<String, List<UIP__c>>();
            Map<String, List<UIP__c>> districtUipForDeleteMap = new Map<String, List<UIP__c>>();
            for (UIP__c uip : uipDistrictList) {
                if (distNumberSet.contains(uip.DIST_NUMBER__c)) {
                    if (!districtUipMap.containsKey(uip.DIST_NUMBER__c)) {
                        districtUipMap.put(uip.DIST_NUMBER__c, new List<UIP__c>());
                    }
                    districtUipMap.get(uip.DIST_NUMBER__c).add(uip);
                }
                if (distNumberForDeleteSet.contains(uip.DIST_NUMBER__c)) {
                    if (!districtUipForDeleteMap.containsKey(uip.DIST_NUMBER__c)) {
                        districtUipForDeleteMap.put(uip.Id, new List<UIP__c>());
                    }
                    districtUipForDeleteMap.get(uip.Id).add(uip);
                }
            }
            addAddendaForCombinedPlan(districtUipMap, rtSchoolId, rtAecId);
            deleteAddendaForCombinedPlan(districtUipForDeleteMap, schoolForDeleteSet);
        }
    }
    public void updateAddendaForCombinedPlans2016() {
        SectionUtil.stopTrigger = true;
        Set<String> distNumberSet = new Set<String>();
        Set<String> distNumberForDeleteSet = new Set<String>();
        Set<String> schoolForDeleteSet = new Set<String>();
        String rtSchoolId = Schema.SObjectType.UIP__c.getRecordTypeInfosByName().get('School UIP 2016').getRecordTypeId();
        String rtAecId = Schema.SObjectType.UIP__c.getRecordTypeInfosByName().get('AEC UIP 2016').getRecordTypeId();
        for (UIP__c uip : trigger.new) {
          system.debug(uip.DIST_NUMBER__c + '&&' + uip.RecordTypeId + '&&' + trigger.isInsert);
          if (uip.DIST_NUMBER__c != null && (uip.RecordTypeId == rtSchoolId || uip.RecordTypeId == rtAecId) && (trigger.isInsert || (trigger.isUpdate && trigger.oldMap.get(uip.Id).Combined_Plan__c != uip.Combined_Plan__c))) {
            if (uip.Combined_Plan__c == true) {
              distNumberSet.add(uip.DIST_NUMBER__c);
            } else {
              distNumberForDeleteSet.add(uip.DIST_NUMBER__c);
              schoolForDeleteSet.add(uip.Id);
              uip.District_UIP_for_Combined_Plans__c = null;
            }
          }
        }
        String rtDistrictId = Schema.SObjectType.UIP__c.getRecordTypeInfosByName().get('District UIP 2016').getRecordTypeId();
        if (distNumberSet.size() > 0 || distNumberForDeleteSet.size() > 0) {
          List<UIP__c> uipDistrictList = [SELECT Id, DIST_NUMBER__c FROM UIP__c WHERE RecordTypeId = :rtDistrictId AND (DIST_NUMBER__c IN :distNumberSet OR DIST_NUMBER__c IN :distNumberForDeleteSet)];
          Map<String, List<UIP__c>> districtUipMap = new Map<String, List<UIP__c>>();
          Map<String, List<UIP__c>> districtUipForDeleteMap = new Map<String, List<UIP__c>>();
          for (UIP__c uip : uipDistrictList) {
            if (distNumberSet.contains(uip.DIST_NUMBER__c)) {
              if (!districtUipMap.containsKey(uip.DIST_NUMBER__c)) {
                districtUipMap.put(uip.DIST_NUMBER__c, new List<UIP__c>());
              }
              districtUipMap.get(uip.DIST_NUMBER__c).add(uip);
            }
            if (distNumberForDeleteSet.contains(uip.DIST_NUMBER__c)) {
              if (!districtUipForDeleteMap.containsKey(uip.DIST_NUMBER__c)) {
                districtUipForDeleteMap.put(uip.Id, new List<UIP__c>());
              }
              districtUipForDeleteMap.get(uip.Id).add(uip);
            }
          }
          addAddendaForCombinedPlan(districtUipMap, rtSchoolId, rtAecId);
          deleteAddendaForCombinedPlan(districtUipForDeleteMap, schoolForDeleteSet);
        }
      }
    
    public void addAddendaForCombinedPlan(Map<String, List<UIP__c>> districtUipMap, String rtSchoolId, String rtAecId) {
        List<Addendum__c> newAddList = new List<Addendum__c>();
        Addendum__c newaddendum;
        for (UIP__c uip : trigger.new) {
            if ((uip.RecordTypeId == rtSchoolId || uip.RecordTypeId == rtAecId) && uip.Combined_Plan__c == true && (trigger.isInsert || (trigger.isUpdate && trigger.oldMap.get(uip.Id).Combined_Plan__c != uip.Combined_Plan__c))) {
                if (districtUipMap.containsKey(uip.DIST_NUMBER__c)) {
                    uip.District_UIP_for_Combined_Plans__c = districtUipMap.get(uip.DIST_NUMBER__c)[0].Id;
                    if (uip.Turnaround__c == 'Yes') {
                        //districtUipMap.get(uip.DIST_NUMBER__c)[0].Turnaround__c = 'Yes';
                        newaddendum = new Addendum__c();
                        newaddendum.RecordTypeId = addendumRTMap.get('Dist/Sch Turnaround');
                        newaddendum.UIP__c = districtUipMap.get(uip.DIST_NUMBER__c)[0].Id;
                        newaddendum.School_UIP__c = uip.Id;
                        newaddendum.Name = 'Dist/Sch Turnaround for ' + uip.Name;
                        newAddList.add(newaddendum);
                    }
                    if (uip.TIG_Turnaround__c == 'Yes') {
                        //districtUipMap.get(uip.DIST_NUMBER__c)[0].TIG_Turnaround__c = 'Yes';
                        newaddendum = new Addendum__c();
                        newaddendum.RecordTypeId = addendumRTMap.get('TIG Turnaround');
                        newaddendum.UIP__c = districtUipMap.get(uip.DIST_NUMBER__c)[0].Id;
                        newaddendum.School_UIP__c = uip.Id;
                        newaddendum.Name = 'TIG Turnaround for ' + uip.Name;
                        newAddList.add(newaddendum);
                    }
                    if (uip.TIG_Transformation__c == 'Yes') {
                        //districtUipMap.get(uip.DIST_NUMBER__c)[0].TIG_Transformation__c = 'Yes';
                        newaddendum = new Addendum__c();
                        newaddendum.RecordTypeId = addendumRTMap.get('TIG Transformation');
                        newaddendum.UIP__c = districtUipMap.get(uip.DIST_NUMBER__c)[0].Id;
                        newaddendum.School_UIP__c = uip.Id;
                        newaddendum.Name = 'TIG Transformation for ' + uip.Name;
                        newAddList.add(newaddendum);
                    }
                    if (uip.TIG_Closure__c == 'Yes') {
                        //districtUipMap.get(uip.DIST_NUMBER__c)[0].TIG_Closure__c = 'Yes';
                        newaddendum = new Addendum__c();
                        newaddendum.RecordTypeId = addendumRTMap.get('TIG Closure');
                        newaddendum.UIP__c = districtUipMap.get(uip.DIST_NUMBER__c)[0].Id;
                        newaddendum.School_UIP__c = uip.Id;
                        newaddendum.Name = 'TIG Closure for ' + uip.Name;
                        newAddList.add(newaddendum);
                    }
                    if (uip.Title_1_School_Wide__c == 'Yes') {
                        //districtUipMap.get(uip.DIST_NUMBER__c)[0].Title_1_School_Wide__c = 'Yes';
                        newaddendum = new Addendum__c();
                        newaddendum.RecordTypeId = addendumRTMap.get('Title I');
                        newaddendum.UIP__c = districtUipMap.get(uip.DIST_NUMBER__c)[0].Id;
                        newaddendum.School_UIP__c = uip.Id;
                        newaddendum.Name = 'Title I for ' + uip.Name;
                        newAddList.add(newaddendum);
                    }
                    if (uip.Turnaround_Complete__c) {
                        districtUipMap.get(uip.DIST_NUMBER__c)[0].Turnaround_Complete__c = true;
                    }
                    if (uip.TIG_Turnaround_Complete__c) {
                        districtUipMap.get(uip.DIST_NUMBER__c)[0].TIG_Turnaround_Complete__c = true;
                    }
                    if (uip.TIG_Transformation_Complete__c) {
                        districtUipMap.get(uip.DIST_NUMBER__c)[0].TIG_Transformation_Complete__c = true;
                    }
                    if (uip.TIG_Closure_Complete__c) {
                        districtUipMap.get(uip.DIST_NUMBER__c)[0].TIG_Closure_Complete__c = true;
                    }
                    if (uip.Title_I_School_Wide_Complete__c) {
                        districtUipMap.get(uip.DIST_NUMBER__c)[0].Title_I_School_Wide_Complete__c = true;
                    }
                }
            }
            system.debug('newAddList:::' + newAddList);
        }
        
        List<UIP__c> districtUipsForUpdate = new List<UIP__c>();
        for (String distNumber : districtUipMap.keySet()) {
            districtUipsForUpdate.add(districtUipMap.get(distNumber)[0]);
        }
        
        try {
            if (districtUipsForUpdate.size() > 0) {
                update districtUipsForUpdate;
            }
            system.debug('newAddList:::' + newAddList);
            if (newAddList.size() > 0) {
                insert newAddList;
            }
        } catch (DMLException e) {
            trigger.new[0].addError(e.getMessage());
            return;
        }
    }
    
    public void deleteAddendaForCombinedPlan(Map<String, List<UIP__c>> districtUipForDeleteMap, Set<String> schoolForDeleteSet) {
        List<Addendum__c> addForDeleteList = [SELECT Id FROM Addendum__c WHERE UIP__c IN :districtUipForDeleteMap.keySet() AND School_UIP__c IN :schoolForDeleteSet];
        try {
            if (addForDeleteList.size() > 0) {
                delete addForDeleteList;
            }
        } catch (DMLException e) {
            trigger.new[0].addError(e.getMessage());
            return;
        }
    }
    
    public void createAddenda() {
        List<Addendum__c> addendaList = new List<Addendum__c>();
        Set<Id> uipIds = new Set<Id>();
        for (UIP__c uip : trigger.new) {
            uipIds.add(uip.Id);
            //if (uip.Combined_Plan__c == true) {
            //  uipIds.add(uip.District_UIP_for_Combined_Plans__c);
            //}
        }
        
        List<Addendum__c> existingAddendum = [SELECT Id, UIP__c, RecordTypeId FROM Addendum__c WHERE UIP__c IN :uipIds];
        Map<Id,Set<Id>> addendumMap = new Map<Id,Set<Id>>();
        
        for (Addendum__c a : existingAddendum) {
            if (!addendumMap.containsKey(a.UIP__c)) {
                addendumMap.put(a.UIP__c, new Set<Id>());
            }
            addendumMap.get(a.UIP__c).add(a.RecordTypeId);
        }
        
        Addendum__c newAddendum;
        List<Addendum__c> newAddList = new List<Addendum__c>();
        List<Addendum__c> newAddForDistrictList = new List<Addendum__c>();
        for (UIP__c uip : trigger.new) {
            if ((uip.ESEA__c == 'Yes' || uip.ESEA__c == 'Recommended') && (addendumMap.isEmpty() || !addendumMap.get(uip.Id).contains(addendumRTMap.get('DIST ESEA Supporting Addendum')))) {
                newaddendum = new Addendum__c();
                newaddendum.RecordTypeId = addendumRTMap.get('DIST ESEA Supporting Addendum');
                newaddendum.UIP__c = uip.Id;
                newaddendum.Name = 'DIST ESEA Supporting Addendum';
                newAddList.add(newaddendum);
                if (uip.Combined_Plan__c == true && uip.District_UIP_for_Combined_Plans__c != null) {
                    newaddendum = getNewAddendumForDistrict(uip, 'DIST ESEA Supporting Addendum');
                    newAddForDistrictList.add(newaddendum);
                }
            }
            if ((uip.Gifted_Education__c == 'Yes' || uip.Gifted_Education__c == 'Recommended') && (addendumMap.isEmpty() || !addendumMap.get(uip.Id).contains(addendumRTMap.get('DIST Gifted Program')))) {
                newaddendum = new Addendum__c();
                newaddendum.RecordTypeId = addendumRTMap.get('DIST Gifted Program');
                newaddendum.UIP__c = uip.Id;
                newaddendum.Name = 'DIST Gifted Program';
                newAddList.add(newaddendum);
                if (uip.Combined_Plan__c == true && uip.District_UIP_for_Combined_Plans__c != null) {
                    newaddendum = getNewAddendumForDistrict(uip, 'DIST Gifted Program');
                    newAddForDistrictList.add(newaddendum);
                }
            }
            if ((uip.Student_Grad_Completion_Plan__c == 'Yes' || uip.Student_Grad_Completion_Plan__c == 'Recommended') && (addendumMap.isEmpty() || !addendumMap.get(uip.Id).contains(addendumRTMap.get('DIST SGCP Addendum')))) {
                newaddendum = new Addendum__c();
                newaddendum.RecordTypeId = addendumRTMap.get('DIST SGCP Addendum');
                newaddendum.UIP__c = uip.Id;
                newaddendum.Name = 'DIST SGCP Addendum';
                newAddList.add(newaddendum);
                if (uip.Combined_Plan__c == true && uip.District_UIP_for_Combined_Plans__c != null) {
                    newaddendum = getNewAddendumForDistrict(uip, 'DIST SGCP Addendum');
                    newAddForDistrictList.add(newaddendum);
                }
            }
            if ((uip.Title_III__c == 'Yes' || uip.Title_III__c == 'Recommended') && (addendumMap.isEmpty() || !addendumMap.get(uip.Id).contains(addendumRTMap.get('DIST Title III Improvement Addendum')))) {
                newaddendum = new Addendum__c();
                newaddendum.RecordTypeId = addendumRTMap.get('DIST Title III Improvement Addendum');
                newaddendum.UIP__c = uip.Id;
                newaddendum.Name = 'DIST Title III Improvement Addendum';
                newAddList.add(newaddendum);
                if (uip.Combined_Plan__c == true && uip.District_UIP_for_Combined_Plans__c != null) {
                    newaddendum = getNewAddendumForDistrict(uip, 'DIST Title III Improvement Addendum');
                    newAddForDistrictList.add(newaddendum);
                }
            }
            if ((uip.Turnaround__c == 'Yes' || uip.Turnaround__c == 'Recommended') && (addendumMap.isEmpty() || !addendumMap.get(uip.Id).contains(addendumRTMap.get('Dist/Sch Turnaround')))) {
                newaddendum = new Addendum__c();
                newaddendum.RecordTypeId = addendumRTMap.get('Dist/Sch Turnaround');
                newaddendum.UIP__c = uip.Id;
                newaddendum.Name = 'Dist/Sch Turnaround';
                newAddList.add(newaddendum);
                if (uip.Combined_Plan__c == true && uip.District_UIP_for_Combined_Plans__c != null) {
                    newaddendum = getNewAddendumForDistrict(uip, 'Dist/Sch Turnaround');
                    newAddForDistrictList.add(newaddendum);
                }
            }
            if ((uip.TIG_Closure__c == 'Yes' || uip.TIG_Closure__c == 'Recommended') && (addendumMap.isEmpty() || !addendumMap.get(uip.Id).contains(addendumRTMap.get('TIG Closure')))) {
                newaddendum = new Addendum__c();
                newaddendum.RecordTypeId = addendumRTMap.get('TIG Closure');
                newaddendum.UIP__c = uip.Id;
                newaddendum.Name = 'TIG Closure';
                newAddList.add(newaddendum);
                if (uip.Combined_Plan__c == true && uip.District_UIP_for_Combined_Plans__c != null) {
                    newaddendum = getNewAddendumForDistrict(uip, 'TIG Closure');
                    newAddForDistrictList.add(newaddendum);
                }
            }
            if ((uip.TIG_Transformation__c == 'Yes' || uip.TIG_Transformation__c == 'Recommended') && (addendumMap.isEmpty() || !addendumMap.get(uip.Id).contains(addendumRTMap.get('TIG Transformation')))) {
                newaddendum = new Addendum__c();
                newaddendum.RecordTypeId = addendumRTMap.get('TIG Transformation');
                newaddendum.UIP__c = uip.Id;
                newaddendum.Name = 'TIG Transformation';
                newAddList.add(newaddendum);
                if (uip.Combined_Plan__c == true && uip.District_UIP_for_Combined_Plans__c != null) {
                    newaddendum = getNewAddendumForDistrict(uip, 'TIG Transformation');
                    newAddForDistrictList.add(newaddendum);
                }
            }
            if ((uip.TIG_Turnaround__c == 'Yes' || uip.TIG_Turnaround__c == 'Recommended') && (addendumMap.isEmpty() || !addendumMap.get(uip.Id).contains(addendumRTMap.get('TIG Turnaround')))) {
                newaddendum = new Addendum__c();
                newaddendum.RecordTypeId = addendumRTMap.get('TIG Turnaround');
                newaddendum.UIP__c = uip.Id;
                newaddendum.Name = 'TIG Turnaround';
                newAddList.add(newaddendum);
                if (uip.Combined_Plan__c == true && uip.District_UIP_for_Combined_Plans__c != null) {
                    newaddendum = getNewAddendumForDistrict(uip, 'TIG Turnaround');
                    newAddForDistrictList.add(newaddendum);
                }
            }
            if ((uip.Title_1_School_Wide__c == 'Yes' || uip.Title_1_School_Wide__c == 'Recommended') && (addendumMap.isEmpty() || !addendumMap.get(uip.Id).contains(addendumRTMap.get('Title I')))) {
                newaddendum = new Addendum__c();
                newaddendum.RecordTypeId = addendumRTMap.get('Title I');
                newaddendum.UIP__c = uip.Id;
                newaddendum.Name = 'Title I';
                newAddList.add(newaddendum);
                if (uip.Combined_Plan__c == true && uip.District_UIP_for_Combined_Plans__c != null) {
                    newaddendum = getNewAddendumForDistrict(uip, 'Title I');
                    newAddForDistrictList.add(newaddendum);
                }
            }
        }
        System.debug('newAddList::' + newAddList);
        try {
            if (newAddList.size() > 0) {
                insert newAddList;
            }
            if (newAddForDistrictList.size() > 0) {
                insert newAddForDistrictList;
            }
        } catch (DMLException e) {
            trigger.new[0].addError(e.getMessage());
        }
    }
    
    public Addendum__c getNewAddendumForDistrict(UIP__c uip, String addendumRT) {
        Addendum__c newaddendum = new Addendum__c();
        newaddendum.RecordTypeId = addendumRTMap.get(addendumRT);
        newaddendum.UIP__c = uip.District_UIP_for_Combined_Plans__c;
        newaddendum.School_UIP__c = uip.Id;
        newaddendum.Name = addendumRT + ' for ' + uip.Name;
        return newaddendum;
    }
}