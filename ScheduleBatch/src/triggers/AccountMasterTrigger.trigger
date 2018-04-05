trigger AccountMasterTrigger on Account (before insert, after insert, after delete) {
    
    AccountTriggerHandler handler = new AccountTriggerHandler();
    if (Trigger.isInsert) {
        if (Trigger.isBefore) {
                handler.OnBeforeInsert(Trigger.new);
            }
        } else if (Trigger.isAfter) {
       
        } else if (Trigger.isDelete) {
        if(Trigger.isBefore) {
            handler.OnBeforeDelete(Trigger.oldMap);
        }
	}
}