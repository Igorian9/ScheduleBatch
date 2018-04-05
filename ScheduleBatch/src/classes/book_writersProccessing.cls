global class book_writersProccessing implements Database.Batchable<SObject>, Database.Stateful {

	private Integer JunctionCount = 0;

	global book_writersProccessing() {

	}

	global Database.QueryLocator start(Database.BatchableContext context) {
		return Database.getQueryLocator('SELECT Id, Author__c FROM Book__c WHERE IsBookNeedToBeProceed__c = TRUE');
	}

	global void execute(Database.BatchableContext context, List<Book__c> scope) {
		Set<String> book_writers = new Set<String> ();
		for (Book__c book : scope) {
			book_writers.add(book.Author__c); 
		}
		List<Writer__c> writers = [SELECT Id, Name FROM Writer__c WHERE Name = :book_writers];
		List<BooksToWriters__c> book_to_writers_list = addBooksAndWritersToBookToWritersList(writers, scope);
		upsert scope;
		upsert book_to_writers_list;
	}

	private List<BooksToWriters__c> addBooksAndWritersToBookToWritersList(List<Writer__c> writers, List<Book__c> scope) {
		List<BooksToWriters__c> book_to_writers_list = new List<BooksToWriters__c> ();
		for (Book__c book : scope) {
			for (Writer__c writer : writers) {
				BooksToWriters__c junction_object = new BooksToWriters__c();
				if (book.Author__c == writer.Name) {
					book.IsBookNeedToBeProceed__c = false;
					junction_object.Writers__c = writer.Id;
					junction_object.Books__c = book.Id;
					JunctionCount++;
					book_to_writers_list.add(junction_object);
				}
			}
		}
		return book_to_writers_list;
	}

	global void finish(Database.BatchableContext context) {
		Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
		message.toAddresses = new String[] { 'igor.igorovuich@gmail.com' };
		message.optOutPolicy = 'FILTER';
		message.subject = 'Junction';
		message.plainTextBody = 'Has been created ' + JunctionCount + ' junction objects.';
		Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage> { message };
		Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
		if (results[0].success) {
			System.debug('The email was sent successfully.');
		} else {
			System.debug('The email failed to send: ' + results[0].errors[0].message);
		}
	}
}