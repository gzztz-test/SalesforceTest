/*
 *The controller of the ChartDisplay
 *
 */
public class ChartDisplayController
{
    public List<TeamMemberInfo> Data
    {
        get
        {
            return getChartData();
        }
        set;
    }

    public String Url;
    public String Token;

    public List<TeamMemberInfo> getChartData()
    {
        Url = SandboxInfo__c.getInstance('test2').Instance_Url__c;
        Token = SandboxInfo__c.getInstance('test2').Access_Token__c;
        //get totalHours
        HttpResponse response = new HttpResponse();
        HttpRequest request = new HttpRequest();
        String q = 'select Id, Name, totalHours__c from TeamMember__c where Project__c = '+'\'a0JS0000003jprMMAQ\'';
        PageReference theUrl = new PageReference(Url + '/services/data/v29.0/query');
        theUrl.getParameters().put('q', q);
        request.setEndpoint(theUrl.getUrl());
        request.setMethod('GET');
        request.setHeader('Authorization', 'Bearer ' + Token);
        response = (new Http()).send(request);
        TeamMemberData data = (TeamMemberData)JSON.deserialize(response.getBody().replace('"TotalHours__c":', '"TotalHours_c":'), TeamMemberData.class);
        //get hour percentage
        Decimal allHours = 0.0;
        for(TeamMemberInfo teamMember : data.records)
        {
            allHours = allHours + teamMember.TotalHours_c;
        }
        for(TeamMemberInfo teamMember : data.records)
        {
            if(allHours != 0.0)
            {
                teamMember.HourPercent = teamMember.TotalHours_c/allHours*100;
            }
            else
            {
                teamMember.HourPercent = 0.0;
            }
        }
        //get current month hours
        HttpResponse res = new HttpResponse();
        HttpRequest req = new HttpRequest();
        String query = 'select TeamMember__c, Hours__c from TimeCard__c where Date__c = this_Month and Project__c = '+'\'a0JS0000003jprMMAQ\'' ;
        PageReference thisUrl = new PageReference(Url + '/services/data/v29.0/query');
        thisUrl.getParameters().put('q', query);
        req.setEndpoint(thisUrl.getUrl());
        req.setMethod('GET');
        req.setHeader('Authorization', 'Bearer ' + Token);
        res = (new Http()).send(req);
        System.debug(res.getBody());
        TimeCardJson timeCardData = (TimeCardJson)JSON.deserialize(res.getBody().replace('"TeamMember__c":', '"TeamMember_c":').replace('"Hours__c":', '"Hours_c":'), TimeCardJson.class);
        System.debug(timeCardData);
        for(TeamMemberInfo teamMember : data.records)
        {
            teamMember.CurrentHours = 0.0;
            for(TimeCardInfo timeCard : timeCardData.records)
            {
                if(timeCard.TeamMember_c.equals(teamMember.Id))
                {
                    teamMember.CurrentHours = teamMember.CurrentHours + timeCard.Hours_c;
                }
            }
            System.debug(teamMember.CurrentHours);
        }

        return data.records;
    }

    // Wrapper class
    public class TeamMemberData
    {
        public Integer totalSize { get; set; }
        public List<TeamMemberInfo> records { get; set; }
    }
    public class TeamMemberInfo
    {
        public String Id { get; set; }
        public String Name { get; set; }
        public Decimal TotalHours_c { get; set; }
        public Decimal HourPercent { get; set; }
        public Decimal CurrentHours { get; set; }
        public TeamMemberInfo(String id, String name, Decimal totalHours, Decimal hourPercent, Decimal currentHours)
        {
            this.Id = id;
            this.Name = name;
            this.TotalHours_c = totalHours;
            this.HourPercent = hourPercent;
            this.CurrentHours = currentHours;
        }

    }

    public class TimeCardJson
    {
        public Integer totalSize { get; set; }
        public List<TimeCardInfo> records { get; set; }
    }

    public class TimeCardInfo
    {
        public String TeamMember_c { get; set; }
        public Decimal Hours_c { get; set; }
    }

}