/**
** The Controller of AccountPage
**/
public with sharing class AccountListController
{
    private List<Account> allAccount;
    private ApexPages.StandardSetController standardCon;

    public AccountListController(ApexPages.StandardController controller)
    {
        Account = new Account();
        Contacts = new List<MassContact>();
        Accounts = new List<MassAccount>();
        allAccount = new List<Account>();
        AccountId = null;
        ContactId = null;
        standardCon = new ApexPages.StandardSetController([select Id, Name from Account limit 1000]);
        standardCon.setPageSize(5);
        standardCon.setPageNumber(1);
        for(sObject s : standardCon.getRecords())
        {
            Accounts.add(new MassAccount((Account)s,false));
        }
    }

    public List<MassAccount> Accounts { get; set; }
    public List<MassContact> Contacts { get; set; }
    public String AccountId { get; set; }
    public Id ContactId { get; set; }
    public Account Account { get; set; }
    public Integer TurnTo { get; set; }
    public String KeyWord { get; set; }

    public void getContacts()
    {
        contacts = new List<MassContact>();
        try
        {
            for(Contact c : [select Id, Phone, Name, Email, AccountId from Contact where AccountId = :AccountId limit 1000])
            {
                Contacts.add(new MassContact(c, false));
            }
        }
        catch(DmlException ex)
        {
            ApexPages.addMessages(ex);
        }
    }

    public void deleteContact()
    {
        try
        {
            for(Integer i = 0; i < Contacts.size(); i++)
            {
                if(Contacts[i].contact.Id == ContactId)
                {
                    Contacts.remove(i);
                    break;
                }
            }
            delete new Contact(Id=ContactId);
        }
        catch(DmlException ex)
        {
            ApexPages.addMessages(ex);
        }
    }

    public void insertAccount()
    {
        try
        {
            insert Account;
        }
        catch(DmlException ex)
        {
            ApexPages.addMessages(ex);
        }
        allAccount.addAll([select Name, Id from Account where Id = :Account.Id limit 1000]);
        standardCon = new ApexPages.StandardSetController(allAccount);
    }

    //Paging
    public void pageList()
    {
        Accounts.clear();
        for(sObject a : standardCon.getRecords())
        {
            Accounts.add(new MassAccount((Account)a,false));
        }
    }

    public List<MassAccount> getAccounts()
    {
        return Accounts;
    }

    public void nextPage()
    {
        if(standardCon.getHasNext())
        {
            standardCon.next();
            pageList();
        }
    }

    public void previousPage()
    {
        if(standardCon.getHasPrevious())
        {
            standardCon.previous();
            pageList();
        }
    }

    public void firstPage()
    {
        standardCon.first();
        pageList();
    }

    public void lastPage()
    {
        standardCon.last();
        pageList();
    }

    public Integer getCurrentPage()
    {
        return standardCon.getPageNumber();
    }

    public Integer getTotalPage()
    {
        Integer pageCount;
        if(standardCon.getPageSize() != 0)
        {
            pageCount = standardCon.getResultSize()/standardCon.getPageSize();
        }
        if(pageCount == 0)
        {
            return pageCount;
        }
        else
        {
            pageCount += 1;
            return pageCount;
        }
    }

    public Boolean getHasPrevious()
    {
       return standardCon.getHasPrevious();
    }

    public Boolean getHasNext()
    {
        return standardCon.getHasNext();
    }

    public void turnToPage()
    {
        standardCon.setPageNumber(TurnTo);
        pageList();
    }

    public void searchAccount()
    {
        String s = '%' + keyWord + '%';
        Accounts.clear();
        for(Account a:[select Id,Name from Account where Name like :s])
        {
            Accounts.add(new MassAccount(a,false));
        }
    }

    public void massDeleteAccount()
    {
        List<Account> deleteAccounts = new List<Account>();
        for(Integer i=0;i<Accounts.size();i++)
        {
            if(Accounts[i].DeleteFlag){
                deleteAccounts.add(Accounts[i].account);
                Accounts.remove(i);
                i--;
            }
        }
        try
        {
            delete deleteAccounts;
        }
        catch(DmlException ex)
        {
            ApexPages.addMessages(ex);
        }

    }

     public void massDeleteContact()
    {
        List<Contact> deleteContacts = new List<Contact>();
        for(Integer i=0;i<contacts.size();i++)
        {
            if(contacts[i].DeleteFlag)
            {
                deleteContacts.add(contacts[i].contact);
                contacts.remove(i);
                i--;
            }
        }
        try
        {
            delete deleteContacts;
        }
        catch(DmlException ex)
        {
            ApexPages.addMessages(ex);
        }
    }

    public class MassContact
    {
        public Boolean DeleteFlag { get; set; }
        public Contact contact { get; set; }
        public MassContact( Contact con, Boolean del)
        {
            this.contact = con;
            this.DeleteFlag = del;
        }
    }

    public class MassAccount
    {
        public Boolean DeleteFlag { get; set; }
        public Account account { get; set; }

        public MassAccount(Account acc, Boolean del)
        {
            this.Account = acc;
            this.DeleteFlag = del;
        }
    }



}