/**
** The Schedular to sent Email
**/
global class ScheduleEmail implements Schedulable {
	global void execute(SchedulableContext sc) {
		String soqlmail;
		String s = 'SELECT Email FROM Contact WHERE Email = :soqlmail';
	EmailBatch b = new EmailBatch(s);
		database.executebatch(b,1);
	}
}