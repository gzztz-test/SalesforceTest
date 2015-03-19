/*
 * The class to get Instance_Url and Access_Token
 */
public with sharing class TimeCard
{
	public HttpRequest req{ set; get;}
	public HttpResponse res;
	public Http h;
	public OAuth2 oauth;
	public String consumerKey;
	public String pmUserName;
	public String pmPassword;
	public String consumerSec;

	public TimeCard()
	{
		h = new Http();
		req = new HttpRequest();
		res = new HttpResponse();
		consumerKey = '3MVG98dostKihXN4k0RE5FX2xkw9nr2g6AMWEolJxTK4BkGku.Tgqd7FA_m_5u4GN1zNFXQ_T5zqXcnMdsmrh';
		pmUserName = 'aaron.lau@pm.meginfo.com.dev';
		pmPassword = 'forDev.2011';
		consumerSec = '2665119990617377622';
	}
	public void getOAuth()
	{
		String reqBody = 'grant_type=password&client_id=' + consumerKey + '&client_secret=' + consumerSec + '&username=' + pmUserName + '&password=' + pmPassword;
		req.setEndpoint('https://test.salesforce.com/services/oauth2/token');
		req.setMethod('POST');
		req.setBody(reqBody);
		res = h.send(req);
		OAuth2 objAuth = (OAuth2)JSON.deserialize(res.getbody(), OAuth2.class);
		System.debug('resp'+res.getBody());
		if(String.isBlank(objAuth.Access_Token) || String.isBlank(objAuth.Instance_Url))
        {
            oauth = null;
        }
        else
        {
           oauth = objAuth;
        }
  		SandboxInfo__c info = new SandboxInfo__c();
		info.Name = 'test2';
		info.Instance_Url__c = oauth.Instance_Url;
		info.Access_Token__c = oauth.Access_Token;
		upsert info Name;
    }



	public class OAuth2
	{
		//public OAuth{}
    	public String Id { get; set; }
        public String Issued_At { get; set; }
        public String Token_Type{ get; set; }
        public String Instance_Url { get; set; }
        public String Signature { get; set; }
        public String Access_Token { get; set; }
	}

}