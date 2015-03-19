/**
** The Batch to sent email
**/
global class EmailBatch implements Database.Batchable<sObject> {
	Messaging.SingleEmailMessage mail;
	String query;
	
	Contact c ;

	
	global EmailBatch(String q) {
		query = q;
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		String soqlemail = 'gzztz@163.com';
		System.debug(query);
		return Database.getQueryLocator(query);
	}

   	global void execute(Database.BatchableContext BC, List<sObject> scope) {
   		c = new Contact();
		mail = new Messaging.SingleEmailMessage();
   		String [] toAddresses = new String[scope.size()];
   		System.debug(scope.size());
   		Integer i = 0;
   		for(sObject s : scope){
   			c = (Contact)s;
   			toAddresses[i] = c.Email;
   			i++;
   		}
		mail.setToAddresses(toAddresses);
		mail.setSubject('recived?');
		mail.setPlainTextBody('hahahahaha');
		Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
	}
	
	global void finish(Database.BatchableContext BC) {
		System.debug('done!');
	}
	
}