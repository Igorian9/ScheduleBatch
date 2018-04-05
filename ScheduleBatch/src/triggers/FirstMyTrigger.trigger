trigger FirstMyTrigger on Account (after insert) {
    Contact c = new Contact(AccountId = Trigger.new[0].Id, LastName= Trigger.new[0].Name+' Deafault');
    Database.insert(c);  
}