component persistent="false" accessors="true" output="false" extends="InfluencerStatsService" {
	
	property name='APIPath' default="";
	property name='DeveloperAccount' default="";
	property name='DeveloperAccountPassword' default="";

/*10156087191719596*/
	public any function init() {
		SUPER.init();
		return this;
	}
	
	public any function getStats(required any account='') {

		var facebookStats = {};
		
		facebookStats.total_count = variables.getFBInfo(arguments.account);

		return facebookStats;
	}
	
	public any function getFBInfo(required any account='') {

		var facebookResponse = {};
		var theToken = arguments.account.getProfile().getfacebookLongLivedAccessToken();
		/*WriteDump(var=theToken,top=2,label='goo', abort=true);*/
		cfhttp(url="https://graph.facebook.com/v2.1/#arguments.account.getProfile().getFacebookID()#/friends?access_token=#theToken#&client_id=2017613635228214&client_secret=dd9ce81152598daed05ea7bbc1209a1e" ,result="local.callResponse");
		/*WriteDump(var=local.callResponse,top=2,label='goo', abort=true);*/
		
		if (local.callResponse.statusCode IS "200 OK") {
			facebookResponse = deserializeJSON(local.callResponse.fileContent);
			/*WriteDump(var=facebookResponse,top=2,label='goo', abort=true);*/
		}        
		else {        
			facebookResponse.summary.total_count = "FB Summary Call Failed";
		}
		
		
		return facebookResponse.summary.total_count;
	}
	
	
}
