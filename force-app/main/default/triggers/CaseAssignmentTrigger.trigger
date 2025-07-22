trigger CaseAssignmentTrigger on Case (before insert, before update) {
    If(Trigger.isBefore){
        List<Case> CaseList = new List<Case>();

        If(Trigger.isInsert){
            
            
            for (Case cs : Trigger.new) {
                //if any of the below field has a vaue null
                if((cs.Type == NULL || cs.Priority == NULL) || cs.Status == NULL){
                    cs.addError('Not a valid data. Please check case type, priority or status.');
                
                }else{
                    //updated for new status
                    if(cs.Status == 'New'){
                    CaseList.add(cs);
                    }else{
                        //for other status add error
                        cs.addError('Case cannot be created in this status');
                    }
                }
                
            }
        }
       CaseRoutingHandler.autoAssignAndSetSLA(CaseList); 
    }
        If(Trigger.isUpdate){
            List<Case> updateCase = new List<Case>();
            for(Integer i = 0; i < Trigger.new.size(); i++) {
                Case oldCase = Trigger.old[i];
                Case NewCase = Trigger.new[i];
                //if sla not violated then status can be changed
                if(oldCase.SLA_Violation__c == false && (oldCase.SLA_Deadline__c > Datetime.now() && NewCase.SLA_Deadline__c > Datetime.now()) ){
                    if((NewCase.Type == NULL || NewCase.Priority == NULL) || NewCase.Status == NULL){
                        NewCase.addError('Not a valid data. Please check case type or priority.');
                    }else{
                        //if tried update in new status only
                        if(oldCase.Type != NewCase.Type || oldCase.Priority != NewCase.Priority){
                            if(oldCase.Status == 'New' || NewCase.Status == 'New') {
                                updateCase.add(NewCase);
                            }else{
                                //if field update other than new status
                                NewCase.addError('You can\'t edit these fields for this status');
                            }
                        }else{
                            //if status changed from new /WORKING to escalated
                            if((oldCase.Status == 'Closed' && (NewCase.Status =='Working' || NewCase.Status =='New'))|| (oldCase.Status == 'Working' && NewCase.Status =='New')){
                                NewCase.addError('You can\'t change to this status');
                            }
                        }
                    }
                
                }else if(oldCase.SLA_Violation__c == true && oldCase.SLA_Deadline__c <= Datetime.now() ){
                    NewCase.addError('Your SLA is breached. You cant take any action on this case');
                }
            }
            CaseRoutingHandler.autoAssignAndSetSLA(updateCase);
        }
                
 }