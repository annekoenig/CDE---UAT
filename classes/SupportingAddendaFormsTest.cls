@isTest
private class SupportingAddendaFormsTest {

    static testMethod void testSupportingAddendaForms() {
        // TO DO: implement unit test
        Supporting_Addenda_Forms__c addenda = new Supporting_Addenda_Forms__c();
        
        Addendum__c addendum = new Addendum__c();
        insert addendum;        
        
        addenda.Addendum__c = addendum.id;
        addenda.ZPIF_UIP_Identidier__c = 'ZPIP_UIP_1234';
        addenda.Crosswalk_of_Description_in_Action_Plan__c = 'Description';
        addenda.Description_of_Proposed_Activity__c = 'Proposed_Activity';
        addenda.Title_IA_PPC_Proposed_Amount__c = 20.00;
        addenda.Title_IIA_Proposed_Amount__c = 30.00;
        addenda.Title_III_Proposed_Amount__c = 40.00;
        
        insert addenda;

        addenda.Public_Facing__c = true;
        update addenda;
    }
}