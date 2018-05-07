component persistent="false" accessors="true" output="false" extends="InfluencerStatsService" {
	
	property name='APIPath' default="";
	property name='DeveloperAccount' default="";
	property name='DeveloperAccountPassword' default="";

/*10156087191719596*/
	public any function init() {
		SUPER.init();
		return this;
	}
	/*required string twitterUserName=''*/
	public any function getStats(required any account='') {
/*WriteDump(var=arguments.account.getProfile().getinstagramUserName(),top=2,label='goo', abort=true);*/
		var twitterStats = {};
		/*https://www.instagram.com/#arguments.account.getProfile().getinstagramUserName()#/?__a=1*/
		cfhttp(url="https://www.instagram.com/#arguments.account.getProfile().getinstagramUserName()#/?__a=1" ,result="local.callResponse");
		/*WriteDump(var=local.callResponse,top=2,label='goo', abort=true);*/
		var twitterResponseAsStruct = deserializeJSON(local.callResponse.filecontent);
		/*WriteDump(var=twitterResponseAsStruct,top=6,label='goo', abort=true);*/
		/*twitterstats.fullcallResponse = THIS.getGeneralInfoFeed(arguments.account);
		twitterstats.followedBy = variables.getFollowerCount(twitterstats.fullcallResponse);*/
		

		return twitterResponseAsStruct;
	}
	
	public any function getFollowerCountAsStruct(required any callResponse='') {

		var local.followersCFStruct = deserializeJSON(arguments.callResponse.filecontent);

		return local.followersCFStruct[1] ;
	}
	  
	public void function persist(required string influenceraccountid='', required string InstagramUserName='') {

		try {
			
			
			QueryExecute("UPDATE influencerprofiles SET InstagramUserName = ( :InstagramUserName ) WHERE ( influenceraccountid = :influenceraccountid )",
			 {InstagramUserName={value='#arguments.InstagramUserName#', CFSQLType='cf_sql_char'}, influenceraccountid={value='#arguments.influenceraccountid#', CFSQLType='cf_sql_char'}});
			
			
		} catch (any e) {
			WriteDump(var=e,top=3,label='error catch instagramservice', abort=true);
		} 

	}
	
	public any function getGeneralInfoFeed(required any account='') {

		var twitterStats = {};
		twitterstats.followers = 5;
		
		cfhttp(url="https://cdn.syndication.twimg.com/widgets/followbutton/info.json?screen_names=#arguments.account.getProfile().gettwitterUserName()#" ,result="local.callResponse");
		/*WriteDump(var=local.callResponse,top=2,label='goo', abort=true);*/
		return local.callResponse;
	}
	
	public any function getInstagramInfo(required any account='') {
/*https://api.instagram.com/oauth/authorize/?client_id=1103427d58604857acddc36d731f4a3e&redirect_uri=http://mediakits.loc&response_type=code
trip.ward code = code=a105746eb8c24112a4e97aa8406fa49a*/
		var facebookResponse = {};
		var theToken = arguments.account.getProfile().getfacebookLongLivedAccessToken();
		/*WriteDump(var=theToken,top=2,label='goo', abort=true);*/
		cfhttp(url="https://graph.facebook.com/v2.1/#arguments.account.getProfile().getFacebookID()#/friends?access_token=#theToken#&client_id=2017613635228214&client_secret=dd9ce81152598daed05ea7bbc1209a1e" ,result="local.callResponse");
		WriteDump(var=local.callResponse,top=2,label='goo', abort=true);
		return local.callResponse;
	}
	
	
}

			
