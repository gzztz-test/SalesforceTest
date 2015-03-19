public with sharing class ContactHandleController
{
    public Contact contact { get; set; }
    public List<Contact> Contacts { get; set; }
    public String contactId;
    public ContactHandleController(ApexPages.StandardController controller)
    {
        contactId = ApexPages.currentPage().getParameters().get('contactId');
        contact = new Contact();
        this.contact = (Contact)controller.getRecord();
        if(contactId != null){
            Contacts = [select Id, Phone, Lastname, Email, AccountId from Contact where Id = :contactId];
            contact = Contacts[0];
        }
    }
    public PageReference ContactInsert()
    {
        String accountId = ApexPages.currentPage().getParameters().get('AccountId');
        contact.AccountId = accountId;
        try
        {
            insert contact;
            return null;
        }
        catch(DmlException ex)
        {
            ApexPages.addMessages(ex);
        }
        return null;
    }
    public PageReference editContact()
    {
        try
        {
            update contact;
            return null;
        }
        catch(DmlException ex){
           ApexPages.addMessages(ex);
           return null;
        }
    }



}