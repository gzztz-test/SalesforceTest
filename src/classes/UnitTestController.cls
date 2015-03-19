@isTest
private class UnitTestController {
	@isTest static void testHandleContactControllerContactInsert()
	{
		// Implement test code
		Account testAccount = TestDataFactory.createAccount('testAccount1');
		PageReference pageRef = Page.NewContact;
		Test.setCurrentPage(pageRef);
		pageRef.getParameters().put('AccountId', testAccount.Id);
        ApexPages.StandardController stdController = new ApexPages.StandardController(new Contact());
        HandleContactController testController = new HandleContactController(stdController);
        testController.c.lastname = 'testcontactname';
		testController.c.phone = '18888888888';
		testController.c.email = '12311414@1151.com';
        testController.ContactInsert();
        System.assertEquals(1,TestDataFactory.sizeOfContact(testAccount.Id));
	}

	@isTest static void testContactListControllarGetContacts()
	{
		Account testAccount  = TestDataFactory.createAccount('testAccount1');
		Contact testContact1 = TestDataFactory.createContact('tc1',testAccount.Id);
		Contact testContact2 = TestDataFactory.createContact('tc2',testAccount.Id);
		Contact testContact3 = TestDataFactory.createContact('tc3',testAccount.Id);
		ApexPages.StandardController setController = new ApexPages.StandardController(new Account());
		ContactListControllar testController = new ContactListControllar(setController);
		testController.AccountId = testAccount.id;
        testController.getContacts();
       	System.assertEquals(3,testController.Contacts.size());
       	testController.ContactId = testContact1.Id;
        testController.deleteContact();
        System.assertEquals(2,TestDataFactory.sizeOfContact(testAccount.Id));
	}
	//@isTest static void testContactListControllarDeleteContact(){
	//	Account testAccount  = TestDataFactory.createAccount('testAccount1');
	//	Contact testContact1 = TestDataFactory.createContact('tc1',testAccount.Id);
	//	Contact testContact2 = TestDataFactory.createContact('tc2',testAccount.Id);
	//	Contact testContact3 = TestDataFactory.createContact('tc3', testAccount.Id);
	//	 ApexPages.StandardController setController = new ApexPages.StandardController(new Account());
 //       ContactListControllar testController = new ContactListControllar(setController);
	//	testController.contId = testContact1.Id;
 //       testController.deleteContact();
 //     	System.assertEquals(2,TestDataFactory.sizeOfContact(testAccount.Id));
	//}
}