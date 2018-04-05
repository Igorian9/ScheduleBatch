public class Codes {

    public void setCodes(){
    	List<Account> accounts = [SELECT Id, Country__c, Country_Code__c FROM Account];
		Map<String, Country_Codes__c> cc = Country_Codes__c.getall();
		for(Account acc : accounts){
       		if(cc.containsKey('USA')){
  				acc.Country_Code__c = '12212-3333';
        	}
        }
        Database.update(accounts);
    }
}