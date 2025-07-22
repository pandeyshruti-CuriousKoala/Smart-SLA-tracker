public with sharing class CaseRoutingHandler {
    public static void autoAssignAndSetSLA(List<Case> newCases) {

        //Fetch metadata records for lead assignment and SLA

        List<Case_Routing_Rule__mdt> rules = [SELECT Case_Type__c, Assigned_To_User__c FROM Case_Routing_Rule__mdt];
        List<Case_SLA_Rule__mdt> SLAs = [SELECT Priority__c, SLA_Hours__c FROM Case_SLA_Rule__mdt];

        //Create a Map of Case Type + Assignment and Metadata record

        Map<String, Case_Routing_Rule__mdt> routingMap = new Map<String, Case_Routing_Rule__mdt>(); 
        for(Case_Routing_Rule__mdt rule: rules) {

            //Extract the key
            String key = (String)rule.Case_Type__c;
           
            //Assign the metadata record
            routingMap.put(key, rule);
        }

        //Create a Map of Prioty  + SLA and Metadata record

        Map<String, Case_SLA_Rule__mdt> SLAMap = new Map<String, Case_SLA_Rule__mdt>(); 
        for(Case_SLA_Rule__mdt Sla: SLAs) {
            //Extract the key
            String key = (String)Sla.Priority__c;
           
            //Assign the metadata record
            SLAMap.put(key, Sla);
        }

        //Iterate through the cases and assign them based on the criteria defined in the metadata
        for(Case c: newCases) {
            if((c.Status == 'New') && c.Type != NULL && c.Priority != NULL) {
            
            String Casetype = c.Type;
            String Prioritytype = c.Priority;
            
            //If the key exists then the case can be assigned to the appropriate person 
            if(routingMap.containsKey(Casetype)) {
                Case_Routing_Rule__mdt rule = routingMap.get(Casetype);
                c.OwnerId = rule.Assigned_To_User__c;
            }
            //If the key exists then the SLA is populated according to  hours
            if(SLAMap.containsKey(Prioritytype)) {
                    Case_SLA_Rule__mdt sla = SLAMap.get(Prioritytype);
                    c.SLA_Deadline__c = System.now().addHours((Integer)sla.SLA_Hours__c);
                }
        
            
        }
        }  
}
}