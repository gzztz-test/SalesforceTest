public with sharing class TrelloController {
    public Trello__c trollo{ set; get; }

    // The extension constructor initializes the private member
    // variable mysObject by using the getRecord method from the standard
    // controller.
    public TrelloController()
    {
        trollo = new Trello__c();
    }

    public String catchToken()
    {

        return 'Hello ';
    }
}