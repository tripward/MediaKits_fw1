component persistent="false" accessors="true" output="false" extends="InfluencerStatsService" {
	
	property name='APIPath' default="";
	property name='DeveloperAccount' default="";
	property name='DeveloperAccountPassword' default="";

	public any function init() {
		SUPER.init();
		return this;
	}
	
	public any function getStatsMap() {

		var stats = {};
		stats.pintrestResponse = '';
		stats.pintrestBoardCount = '';
		stats.pintrestFollowerCount = '';
		stats.pintrestSaveCount = '';
		return stats;
	}
	
	
	/*required string twitterUserName=''*/
	public any function getStats(required any account='') {
		/*WriteDump(var=arguments.account.getProfile().getpintrestUsername(),top=2,label='goo', abort=true);*/
		var stats = variables.getStatsMap();
		stats.fullcallResponse = variables.getGeneralInfoFeed(arguments.account).filecontent;
		
		
		local.expanded = deserializeJSON(stats.fullcallResponse);
		/*WriteDump(var=deserializeJSON(stats.fullcallResponse),top=5,label='goo', abort=true);*/
		/*WriteDump(var=pintreststats.fullcallResponse,top=2,label='goo', abort=true);*/
		/*stats.followers = THIS.getFollowerCountAsStruct(pintreststats.fullcallResponse);*/
		/*WriteDump(var=stats.fullcallResponse,top=2,label='goo', abort=true);*/
		
		stats.pintrestBoardCount = arrayLen(local.expanded.data.pins);
		stats.pintrestFollowerCount = local.expanded.data.user.follower_count;
		
		
		
		/*stats.pintrestSaveCount = local.expanded.data.user.SaveCount;*/
		
		
		
		
/*WriteDump(var=stats,top=2,label='goo', abort=true);*/
		return stats;
	}
	
	public any function getFollowerCountAsStruct(required any callResponse='') {

		var local.followersCFStruct = deserializeJSON(arguments.callResponse.filecontent);

		return local.followersCFStruct;
	}
	
	public any function getGeneralInfoFeed(required any account='') {

		var twitterStats = {};
		twitterstats.followers = 5;
		/*https://widgets.pinterest.com/v3/pidgets/users/#arguments.account.getProfile().gettwitterUserName()#/pins/*/
		cfhttp(url="https://widgets.pinterest.com/v3/pidgets/users/#arguments.account.getProfile().getPintrestUserName()#/pins/" ,result="local.callResponse");
		/*WriteDump(var=local.callResponse,top=2,label='goo', abort=true);*/
		return local.callResponse;
	}
	
}
