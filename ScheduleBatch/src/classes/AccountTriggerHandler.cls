public class AccountTriggerHandler {
    
    public void OnBeforeInsert(List<Account> tNew){
        Contact c = new Contact(AccountId = tNew[0].Id, LastName= tNew[0].Name+' Deafault');
    	Database.insert(c);  
        for(Account a : tNew){
       		if(a.Match_Billing_Address__c == true)
           	 	a.ShippingPostalCode = a.BillingPostalCode;
      
    	}
    }
    public void OnBeforeDelete(Map<Id, Account> tOldMap){
  	  for (Account a : [SELECT Id FROM Account WHERE Id IN (SELECT AccountId FROM Opportunity) AND Id IN :tOldMap.values()]) {
        	tOldMap.get(a.Id).addError('Cannot delete account with related opportunities.');
   	 	}
    }

}