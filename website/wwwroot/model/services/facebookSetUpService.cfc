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
/*WriteDump(var=arguments.account.getProfile().gettwitterUserName(),top=2,label='goo', abort=true);*/
		var twitterStats = {};
		twitterstats.fullcallResponse = THIS.getGeneralInfoFeed(arguments.account);
		twitterstats.followers = THIS.getFollowerCountAsStruct(twitterstats.fullcallResponse);
		

		return twitterstats;
	}
	
	public any function getFollowerCountAsStruct(required any callResponse='') {

		var local.followersCFStruct = deserializeJSON(arguments.callResponse.filecontent);

		return local.followersCFStruct[1] ;
	}
	  
	public void function persistShortLivedAccessDataPoints(required string influenceraccountid='', required string FacebookID='', required string FacebookUsername='', required string facebookShortLivedAccessToken='') {

		try {
			/*var qryStr = "
			UPDATE custom_influencerprofiles 
			SET FacebookID = ( :FacebookID ),
			FacebookUsername = ( :FacebookUsername ),
			facebookShortLivedAccessToken = ( :facebookShortLivedAccessToken ),
			facebookShortLivedAccessTokenSetDate=( :facebookShortLivedAccessTokenSetDate )
			WHERE ( influenceraccountid = :influenceraccountid )
			";
			
			var q = New Query();
			q.setSQL(cleanSQL(qryStr));
			q.addParam(name="FacebookID", value="#arguments.FacebookID#", cfsqltype="cf_sql_char");
			q.addParam(name="FacebookUsername", value="#arguments.FacebookUsername#", cfsqltype="cf_sql_char");
			q.addParam(name="facebookShortLivedAccessToken", value="#arguments.facebookShortLivedAccessToken#", cfsqltype="cf_sql_char");
			q.addParam(name="facebookShortLivedAccessTokenSetDate", value="#createODBCDateTime(now())#", cfsqltype="cf_sql_datetime");
			q.addParam(name="influenceraccountid", value="#arguments.influenceraccountid#", cfsqltype="cf_sql_char");
	
			q.execute();*/
			/*WriteDump(var=#dbDateDateTime(now())#,top=2,label='goo', abort=true);*/
			QueryExecute("UPDATE custom_influencerprofiles SET FacebookID = ( :FacebookID ), FacebookUsername = ( :FacebookUsername ), facebookShortLivedAccessToken = ( :facebookShortLivedAccessToken ), facebookShortLivedAccessTokenSetDate=#now()# WHERE ( influenceraccountid = :influenceraccountid )",
			 {FacebookID={value='#arguments.FacebookID#', CFSQLType='cf_sql_char'}, FacebookUsername={value='#arguments.FacebookUsername#', CFSQLType='cf_sql_char'},facebookShortLivedAccessToken={value='#arguments.facebookShortLivedAccessToken#', CFSQLType='cf_sql_char'}, influenceraccountid={value='#arguments.influenceraccountid#', CFSQLType='cf_sql_char'}});
			
			/*QueryExecute("UPDATE custom_influencerprofiles SET FacebookID = ( :FacebookID ), FacebookUsername = ( :FacebookUsername ),facebookShortLivedAccessToken = ( :facebookShortLivedAccessToken ), facebookShortLivedAccessTokenSetDate=( :facebookShortLivedAccessTokenSetDate ) WHERE ( influenceraccountid = :influenceraccountid )",
			 {country={value='USA', CFSQLType=''}, country={value='USA', CFSQLType='CF_SQL_CLOB'}});*/
			
			/*QueryExecute("UPDATE custom_influencerprofiles SET FacebookID = ( :FacebookID ), FacebookUsername = ( :FacebookUsername ),facebookShortLivedAccessToken = ( :facebookShortLivedAccessToken ), facebookShortLivedAccessTokenSetDate=( :facebookShortLivedAccessTokenSetDate ) WHERE ( influenceraccountid = :influenceraccountid )",
			 {country={value='USA', CFSQLType=''}, country={value='USA', CFSQLType='CF_SQL_CLOB'}});*/


			/*QueryExecute("UPDATE custom_influencerprofiles SET FacebookID = ( :FacebookID ), FacebookUsername = ( :FacebookUsername ),facebookShortLivedAccessToken = ( :facebookShortLivedAccessToken ), facebookShortLivedAccessTokenSetDate=( :facebookShortLivedAccessTokenSetDate ) WHERE ( influenceraccountid = :influenceraccountid )",
			{country='USA'},
{datasource=”cfartgallery”, cachename=”employees”})*/
			
			/*QueryExecute("insert INTO custom_InfluencerProfileToCategories 
			(
				InfluencerProfileToCategoryid,
				InfluencerProfileID,
				categoryid
			)
			VALUES
			(
				'#CreateUUID()#',
				:InfluencerProfileID,
				:categoryid
			)
			
			",{InfluencerProfileID=arguments.profileID,categoryid=item});
		 }*/
			
			
		} catch (any e) {
			WriteDump(var=e,top=3,label='error catch fbsetservice', abort=true);
		} 

	}
	
	public void function persistLongLivedAccessDataPoints(required string influenceraccountid='', required string FacebookID='', required string FacebookUsername='', required string facebookShortLivedAccessToken='') {

		try {
			
			
			QueryExecute("UPDATE custom_influencerprofiles SET facebookLongLivedAccessTokenExpiresIn = ( :facebookLongLivedAccessTokenExpiresIn ), facebookLongLivedAccessToken = ( :facebookLongLivedAccessToken ), facebookLongLivedAccessTokenType = ( :facebookLongLivedAccessTokenType ), facebookLongLivedAccessTokenSetDate=#now()# WHERE ( influenceraccountid = :influenceraccountid )",
			 {facebookLongLivedAccessTokenExpiresIn={value='#arguments.facebookLongLivedAccessTokenExpiresIn#', CFSQLType='cf_sql_char'}, facebookLongLivedAccessToken={value='#arguments.facebookLongLivedAccessToken#', CFSQLType='cf_sql_char'},facebookLongLivedAccessTokenType={value='#arguments.facebookLongLivedAccessTokenType#', CFSQLType='cf_sql_char'}, influenceraccountid={value='#arguments.influenceraccountid#', CFSQLType='cf_sql_char'}});
			

			
			/*var qryStr = "
			UPDATE custom_influencerprofiles 
			SET 
			
			
			facebookLongLivedAccessTokenSetDate = ( :facebookLongLivedAccessTokenSetDate )
			WHERE ( influenceraccountid = :influenceraccountid )
			";
			
			var q = New Query();
			q.setSQL(cleanSQL(qryStr));
			q.addParam(name="facebookLongLivedAccessTokenExpiresIn", value="#arguments.facebookLongLivedAccessTokenExpiresIn#", cfsqltype="cf_sql_char");
			q.addParam(name="facebookLongLivedAccessToken", value="#arguments.facebookLongLivedAccessToken#", cfsqltype="cf_sql_char");
			q.addParam(name="facebookLongLivedAccessTokenType", value="#arguments.facebookLongLivedAccessTokenType#", cfsqltype="cf_sql_char");
			q.addParam(name="facebookLongLivedAccessTokenSetDate", value="#now()#", cfsqltype="cf_sql_datetime");
			q.addParam(name="influenceraccountid", value="#arguments.influenceraccountid#", cfsqltype="cf_sql_char");
	
			q.execute();*/
		} catch (any e) {
			WriteDump(var=e,top=3,label='error catch bbsetupervice', abort=true);
		} 

	}
	
	public any function getGeneralInfoFeed(required any account='') {

		var twitterStats = {};
		twitterstats.followers = 5;
		
		cfhttp(url="https://cdn.syndication.twimg.com/widgets/followbutton/info.json?screen_names=#arguments.account.getProfile().gettwitterUserName()#" ,result="local.callResponse");
		/*WriteDump(var=local.callResponse,top=2,label='goo', abort=true);*/
		return local.callResponse;
	}
	
	public any function getFBInfo(required any account='') {

		var facebookResponse = {};
		var theToken = arguments.account.getProfile().getfacebookLongLivedAccessToken();
		/*WriteDump(var=theToken,top=2,label='goo', abort=true);*/
		cfhttp(url="https://graph.facebook.com/v2.1/#arguments.account.getProfile().getFacebookID()#/friends?access_token=#theToken#&client_id=2017613635228214&client_secret=dd9ce81152598daed05ea7bbc1209a1e" ,result="local.callResponse");
		
		return local.callResponse;
	}
	
	
}

			/*<cfhttp url="https://graph.facebook.com/v2.3/oauth/access_token?grant_type=fb_exchange_token&client_id=2017613635228214&client_secret=dd9ce81152598daed05ea7bbc1209a1e&fb_exchange_token=#rc.facebookShortLivedAccessToken#&redirect_uri=http://mediakits.loc/infuencer-profile/edit-facebook-connection/?influenceraccountid=rc.influenceraccountid&wedidit=true" method="get" result="local.result">*/
			/*var foo = variables.InfluencerProfileService.getFBInfo(rc.influencerAccount);
			WriteDump(var=variables,top=2,label='goo', abort=true);*/
			/*WriteDump(var=rc.influencerAccount.getProfile(),top=2,label='goo', abort=true);*/
			/*var theToken = rc.influencerAccount.getProfile().getfacebookShortLivedAccessToken();*/
			/*var theToken = 'EAAcrAkgFkjYBAAyFV7IWS6G02ZBoFqP3UlwoQ32GlHCuYqX23LNUpP9NM0zZCuwKp9CrZCOxQQRl8OUwJMDhiw8bHhk2gfTdkDq5HNN6eGeZCRaKlbeSJzgfjgSI3ZCDOzACiaOyTXT6ZAZCbStiAgedqVoXfWAaFbwgpxoEHF9W6ZC1VI6jy9kDbiy2w1C2ajTGq4DGYcUD9QZDZD';*/
			/*cfhttp(url="https://graph.facebook.com/v2.1/#rc.influencerAccount.getProfile().getFacebookID()#/friends?Access_Token=#theToken#&client_id=2017613635228214" , method="get", result="local.callResponse");
			WriteDump(var=local.callResponse,top=2,label='goo', abort=true);*/

/* QueryExecute("UPDATE INTO custom_influencerprofiles
			(
				FacebookID,
				FacebookUsername,
				facebookShortLivedAccessToken,
				facebookShortLivedAccessTokenSetUpdate
				
			)
			VALUES
			(
				':FacebookID',
				:FacebookUsername,
				:facebookShortLivedAccessToken,
				#now()#
			)
			
			",{FacebookID=arguments.FacebookID,FacebookUsername=arguments.FacebookUsername,facebookShortLivedAccessToken=arguments.facebookShortLivedAccessToken}); */
