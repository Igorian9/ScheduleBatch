trigger HelloWorld on Account (before insert) {
	System.debug('Hello World!');
    for(Account a : Trigger.new)
        a.Description = 'Hello World Description';
}