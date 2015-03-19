/**
** The class provide function to generate data for unit test
**/
global class TestDataFactory 
{
	public static  Contact createContact(String ln,String aid)
	{
		// Implement test code
		Contact c = new Contact(lastname = ln,accountid = aid,phone = '1333333333',email = '3123131@144.com');
		insert c;
		return c;
	}
	public static Account createAccount(String aName)
	{
		Account a = new Account(name = 'aName');
		insert a;
		return a;
	}
	public static Integer sizeOfContact(String aid)
	{
		//List<Contact> contacts = new List<Contact>();
		//for(Contact c : [SELECT id,name,AccountId FROM Contact WHERE AccountId = :aid]){
  //      	contacts.add(c);
  //      }
  //      Integer i = contacts.size();
		return [select Id, Name, AccountId from Contact where AccountId = :aid].size();
	}
	public static Integer sizeofAccount()
	{
		return	[select Id, Name from Account].size();
	}
}