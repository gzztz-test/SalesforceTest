global with sharing class TrelloRest
{
	global String requestToken()
	{
		String key;
		String token;
		Http h = new Http();
		HttpRequest req = new HttpRequest();
		HttpResponse res = new HttpResponse();
		req.setEndpoint('https://trello.com/1/authorize?key=d1a2d05b30f33b1e22181525fde2b122&name=trello-with-pm&expiration=never&response_type=token');
		req.setMethod('GET');
		System.debug('before body:'+req.getBody());
		res = h.send(req);
		System.debug('after body:'+res.getBody());
		return res.getBody();
	}
}