/*
 * The UnitTest of ContactHandleController.
 *
 */
@isTest
private class ContactHandleControllerTest {
	@isTest static void test_insertContact()
	{
		Account testAccount = TestDataFactory.createAccount('testAccount1');
		PageReference pageRef = Page.NewContact;
		Test.setCurrentPage(pageRef);
		pageRef.getParameters().put('AccountId', testAccount.Id);
        ApexPages.StandardController stdController = new ApexPages.StandardController(new Contact());
        ContactHandleController testController = new ContactHandleController(stdController);
        testController.contact.lastname = 'testcontactname';
		testController.contact.phone = '18888888888';
		testController.contact.email = '12311414@1151.com';
        testController.ContactInsert();
        System.assertEquals(1,TestDataFactory.sizeOfContact(testAccount.Id));
	}
	
}