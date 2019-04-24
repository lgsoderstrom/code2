({
	init : function(component, event, helper) {
        var action = component.get("c.getAttachments");
        action.setParams({
            "bidId" : component.get("v.recordId")
        });
        console.log('tester commit!');
        console.log('tester commit!');
        console.log('tester commit!');
        console.log(action);
        action.setCallback(this, function(response){
            var state = response.getState();
            if (component.isValid() && state === "SUCCESS") {
               component.set("v.attachments", response.getReturnValue());
                component.set("v.isInit", true);
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);		
	}
})


public without sharing class BidAttachmentListController {
    
    @auraEnabled
    public static list <String> getAttachments(Id bidId) {
        system.debug('bidId: ' + bidId);
        list <String> oppAttachments = new list <String>(); 
        list <Bids__c> bidRecord = [Select Opportunity__c FROM Bids__c WHERE Id = :bidId];
        
        system.debug('bidRecord: ' + bidRecord);
        
        if(bidRecord.size() > 0){
            system.debug('in bid record');
            for (ContentDocumentLink docLink : [Select ContentDocumentId, LinkedEntityId
                                               FROM ContentDocumentLink
                                                WHERE LinkedEntityId = :bidRecord[0].Opportunity__c]){
                                                    oppAttachments.add(docLink.ContentDocumentId);
                                                }
        }
        
        
        system.debug('oppAttachments: ' + oppAttachments);
        
        return oppAttachments; 

    }
}


