component persistent="false" accessors="true" output="false" extends="InfluencerStatsService" {

	property name='APIPath' default="";
	property name='Consumer_Key' default="YByaJpLNecsBPNGAM43IGonDa";
	property name='Consumer_Secret' default="Wl41aDR4ijKuRtL49E1Jtd5qCaT3iAgB8zBt0N2DkiSnuLJ72A";
	property name='owner_ID' default="254108700";
	property name='Access_Token' default="254108700-Vh4TDI0pFSFbVJyCdVEFJhWKMgDCNEUYqn1Wbf1z";
	property name='Access_Token_Secret' default="AtzrNfbucRFlFJo0hnFOCRK445PbmJO0q3DDvVtRQ2G3e";
	
	public any function init() {
		SUPER.init();
		return this;
	}
	/*required string twitterUserName=''*/
	public any function getStats(required any account) {
/*WriteDump(var=arguments.account.getProfile().gettwitterUserName(),top=2,label='goo', abort=true);*/
		var twitterStats = {};
		twitterstats.fullcallResponse = variables.getGeneralInfoFeed(arguments.account);
		
		if (twitterstats.fullcallResponse.statusCode IS '200 OK') {        
			variables.persistResponse(influenceraccountid=arguments.account.getID(), pull=twitterstats.fullcallResponse.fileContent);
		}
		else {
			WriteOutput("twitter call failed");
			WriteDump(var=twitterstats.fullcallResponse,top=2,label='twitterstats.fullcallResponse', abort=true);
		}
		
		twitterstats.rawFileContent = deserializeJSON(twitterstats.fullcallResponse.filecontent);
		twitterstats.asStruct = twitterstats.rawFileContent[1];
		
		/*WriteDump(var=twitterstats,top=2,label='goo', abort=true);*/
		
		

		return twitterstats;
	}
	
	
	
	public any function getGeneralInfoFeed(required any account) {

		var twitterStats = {};
		/*twitterstats.followers = 5;*/
		/*WriteDump(var=arguments.Profile,top=2,label='goo', abort=true);*//*#arguments.Profile.gettwitterUserName()#*/
		
		/*cfhttp(url="https://api.twitter.com/1.1/users/show.json?screen_name=twitterdev" ,result="local.callResponse");*//*#arguments.account.getProfile().gettwitterUserName()#*/
		cfhttp(url="https://cdn.syndication.twimg.com/widgets/followbutton/info.json?screen_names=tripward" ,result="local.callResponse");
		
		/*https://api.twitter.com/1.1/users/lookup.json?screen_name=@tripward*/
		
		
		/*WriteDump(var=local.callResponse,top=2,label='hhhhhh', abort=true);*/
		return local.callResponse;
	}
	
	public any function getFollowerCountAsStruct(required any callResponse='') {

		var local.followersCFStruct = deserializeJSON(arguments.callResponse.filecontent);

		return local.followersCFStruct[1] ;
	}
	
	public void function persist(required string influenceraccountid='', required string twitterUserName='', required string twitterFollowedByCount='', required string twitterLastUpdate='') {

		try {
			
			/*WriteDump(var=#dbDateDateTime(now())#,top=2,label='goo', abort=true);*/
			QueryExecute("UPDATE influencerprofiles SET twitterUserName = ( :twitterUserName ), twitterFollowedByCount = ( :twitterFollowedByCount ), twitterLastUpdate=#now()# WHERE ( influenceraccountid = :influenceraccountid )",
			 {twitterUserName={value='#arguments.twitterUserName#', CFSQLType='cf_sql_char'},twitterFollowedByCount={value='#arguments.twitterFollowedByCount#', CFSQLType='cf_sql_char'}, influenceraccountid={value='#arguments.influenceraccountid#', CFSQLType='cf_sql_char'}});
			
			
			
			
		} catch (any e) {
			WriteDump(var=e,top=3,label='error catch twitterservice', abort=true);
		} 

	}
	
	public void function persistInitial(required string influenceraccountid='', required string twitterUserName='') {

		try {
			
			/*WriteDump(var=#dbDateDateTime(now())#,top=2,label='goo', abort=true);*/
			QueryExecute("UPDATE influencerprofiles SET twitterUserName = ( :twitterUserName ), twitterLastUpdate=#now()# WHERE ( influenceraccountid = :influenceraccountid )",
			 {twitterUserName={value='#arguments.twitterUserName#', CFSQLType='cf_sql_char'}, influenceraccountid={value='#arguments.influenceraccountid#', CFSQLType='cf_sql_char'}});
			
			
			
			
		} catch (any e) {
			WriteDump(var=e,top=3,label='error catch twitterservice', abort=true);
		} 

	}
	
	public void function persistResponse(required string influenceraccountid='', required string twitterResponse='') {

		try {
			
			/*WriteDump(var=#dbDateDateTime(now())#,top=2,label='goo', abort=true);*/
			QueryExecute("UPDATE influencerprofiles SET twitterResponse = ( :twitterResponse ), twitterResponseDate=#createODBCDate(now())# WHERE ( influenceraccountid = :influenceraccountid )",
			 {twitterResponse={value='#arguments.twitterResponse#', CFSQLType='cf_sql_char'}, influenceraccountid={value='#arguments.influenceraccountid#', CFSQLType='cf_sql_char'}});
			
			
			
			
		} catch (any e) {
			WriteDump(var=e,top=3,label='error catch twitterservice', abort=true);
		} 

	}
	

}
