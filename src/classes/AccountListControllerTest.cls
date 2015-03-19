/**
** The Unit Test of AccountListController
**/
@isTest
private class AccountListControllerTest {
	
	@isTest static void test_insertAccount() {
		ApexPages.StandardController stdController = new ApexPages.StandardController(new Account());
		AccountListController testController = new AccountListController(stdController);
		testController.account.Name = 'testAccount1';
		testController.account.Phone = '1231312313132';
		testController.insertAccount();
		System.assertEquals(1,TestDataFactory.sizeofAccount());
	}
	
	@isTest static void test_get_deleteContact() 
	{
		Account testAccount  = TestDataFactory.createAccount('testAccount1');
		Contact testContact1 = TestDataFactory.createContact('tc1',testAccount.Id);
		Contact testContact2 = TestDataFactory.createContact('tc2',testAccount.Id);
		Contact testContact3 = TestDataFactory.createContact('tc3',testAccount.Id);
		ApexPages.StandardController setController = new ApexPages.StandardController(new Account());
		AccountListController testController = new AccountListController(setController);
		testController.AccountId = testAccount.id;
        testController.getContacts();
       	System.assertEquals(3,testController.Contacts.size());
       	//Test deleteContact()
        testController.deleteContact();
        testController.ContactId = testContact1.Id;
        System.assertEquals(2,TestDataFactory.sizeOfContact(testAccount.Id));
	}
}