<cfcomponent displayname="instagramSetUpMainController" persistent="false" accessors="true" output="false" extends="main">

		<cfproperty name="beanFactory">
		<cfproperty name="instagramSetUpService">
		<cfproperty name="InfluencerProfileService">
		<cfproperty name="provider" default="instagram">

	// ********************************* PAGES *******************************************
<cfscript>
	
	public void function before(required struct rc) {
		SUPER.before(rc);
	}
	
	public void function default(required struct rc) {
		
		//todo: reuse
		include "/mediakits_env/providerData.properties.cfm";

		//
		local.instagram_combined_response = {};
		local.instagram_combined_response.set_date = now();
		
		rc.instagramConnection = variables.beanFactory.getBean('instagram',
			{client_id  : '#variables.providerInfo[variables.provider].clientId#',
			client_secret       : '#variables.providerInfo[variables.provider].clientSecret#',
			authEndpoint       : '#variables.providerInfo[variables.provider].authEndpoint#',
			accessTokenEndpoint       : '#variables.providerInfo[variables.provider].accessTokenEndpoint#',
			redirect_uri        : '#variables.providerInfo[variables.provider].redirect_uri#'
			}
			);
	
		if (structKeyExists(rc,'code')) {
			
			//now that we have a code, go get the token
			local.instagram_token_response = rc.instagramConnection.makeAccessTokenRequest(code=rc.code);
			
			//if we fgot the token populate and save the profile
			if (local.instagram_token_response.success) {
				
				local.deserializedResponse = deserializeJSON(local.instagram_token_response.content);
				/*WriteDump(var=local.deserializedResponse,top=2,label='goo', abort=false);*/
				
				rc.influencerAccount.getProfile().setinstagramAccessToken(local.deserializedResponse.access_token);
				rc.influencerAccount.getProfile().setinstagramUserid(local.deserializedResponse.user.id);
				rc.influencerAccount.getProfile().setinstagramUserName(local.deserializedResponse.user.username);
				rc.influencerAccount.getProfile().setinstagramprofile_picture(local.deserializedResponse.user.profile_picture);
				rc.influencerAccount.getProfile().setinstagramLastUpdate(now());
				/*WriteDump(var=rc.influencerAccount.getProfile(),top=2,label='goo', abort=false);*/
				
				//go get the follwer count so we can populate the db
				local.httpService = new http();
				local.httpService.setMethod( "get" );
				local.httpService.setUrl( "https://api.instagram.com/v1/users/self/?access_token=#local.deserializedResponse.access_token#" );
				local.profileResponse = local.httpResponse = httpService.send().getPrefix();
				/*WriteDump(var=local.profileResponse,top=2,label='goo', abort=true);*/
				
				if (local.profileResponse.status_code IS '200') {
					local.profile_response_deserialized = deserializeJSON(local.profileResponse.fileContent);
					/*WriteDump(var=local.profile_response_deserialized,top=5,label='goo', abort=true);*/
					rc.influencerAccount.getProfile().setinstagrammedia(local.profile_response_deserialized.data.counts.media);
					rc.influencerAccount.getProfile().setinstagramfollows(local.profile_response_deserialized.data.counts.follows);
					rc.influencerAccount.getProfile().setinstagramfollowed_by(local.profile_response_deserialized.data.counts.followed_by);
				}
				else {
					WriteOutput("instagram profile call called");abort;
				}

				// save profile
				variables.InfluencerProfileService.save(rc.influencerAccount.getProfile());
				ormFlush();
				
				variables.fw.redirect(action='influencer:main.default', preserve='all');
		
				
			}
			else {
				WriteOutput("instagram access token call failed");abort;
			}
			
			
			
		}    
		/*else {    
			WriteOutput("payment Failed");abort;}*/    
		
	
		}
	</cfscript>
	
	<cffunction name="getFBID" >
		<cftry>
			
			<cfparam name="rc.errors" default="#arrayNew(1)#" >
			
			
			<cfif !len(trim(rc.instagramUserName))>
				<cfset arrayAppend(rc.errors,'please fill in username') />
			</cfif>
			
			<cfscript>
				var myResult = "";
				rc.influencerAccount = getBean('InfluencerAccount').loadBy(influenceraccountid=rc.influenceraccountid);
			</cfscript>
			
			<cfset variables.instagramSetUpService.persistShortLivedAccessDataPoints(influenceraccountid="#rc.influenceraccountid#",instagramID=#rc.instagramID#,instagramUsername=#rc.instagramUsername#,instagramShortLivedAccessToken=#rc.instagramShortLivedAccessToken#) />
			
			<cfhttp url="https://graph.instagram.com/v2.3/oauth/access_token?grant_type=fb_exchange_token&client_id=2017613635228214&client_secret=dd9ce81152598daed05ea7bbc1209a1e&fb_exchange_token=#rc.instagramShortLivedAccessToken#&redirect_uri=http://mediakits.loc/infuencer-profile/edit-instagram-connection/?influenceraccountid=rc.influenceraccountid&wedidit=true" method="get" result="local.result">
			<!---<cfdump var="#local.result#" label="cgi" abort="true" top="3" />--->
			
			<cfif local.result.statuscode IS '200 OK'>
				<cfset local.filecontent = deserializeJSON(local.result.Filecontent) />
				<!---<cfdump var="#local.filecontent#" label="cgi" abort="true" top="3" />--->
				<cfset variables.instagramSetUpService.persistLongLivedAccessDataPoints(influenceraccountid="#rc.influenceraccountid#",instagramLongLivedAccessTokenExpiresIn=#local.filecontent.expires_in#,instagramLongLivedAccessToken=#local.filecontent.access_token#,instagramLongLivedAccessTokenType=#local.filecontent.token_type#) />
			</cfif>
			
			<cfset variables.fw.redirect(path='/infuencer-profile/', action='influencer:main.getProfile', preserve='ALL', queryString='influenceraccountid=#session.influencerAccount.getID()#') />
		
	      <cfcatch type="any" >
			<cfdump var="#cfcatch#" label="cfcatch" abort="false"  />
			<cfdump var="#arguments#" label="arguments" abort="true"  />
			
		</cfcatch>
	</cftry>


	</cffunction>
	
	<cffunction name="persistinstagramSetup" >
		<cfdump var="#rc#" label="cgi" abort="true" top="3" />
		<cfscript>
			var myResult = "";
			rc.influencerAccount = getBean('InfluencerAccount').loadBy(influenceraccountid=rc.influenceraccountid);
		</cfscript>
		
		 <!---https://www.instagram.com/dialog/oauth?client_id=2017613635228214&redirect_uri=http://mediakits.loc/infuencer-profile/edit-instagram-connection/?influenceraccountid=%27C5785E75-8002-7D59-D5A99B33670A71CA%27&trip=true&scope=public_profile,email&state=fb&response_type=code--->
		 
		<!--- <cfhttp url="graph.instagram.com/?ids=platform,me" method="get" result="myResult">--->
		
		<!---<cflogin>
		<cfoauth
			type="instagram"
			clientID = "2017613635228214"
			secretkey = "dd9ce81152598daed05ea7bbc1209a1e"
			result = "myResult"
			state="fb"
			scope="public_profile,email"
			redirecturi="http://mediakits.loc/infuencer-profile/edit-instagram-connection/?influenceraccountid=#rc.influenceraccountid#&trip=true">

			/*#res.other.username#*/
			<cfloginuser name="king@werwards.com" password="#myResult.access_token#" roles="user"/>
		</cflogin>--->
		<!---<cflocation url="http://localhost:8500/doc/index.cfm">--->
		
		
		
		<cfscript>
			session.fbinfo = myResult;
		</cfscript>
		
		<cfdump var="#myResult#" label="cgi" abort="false" top="3" />
		<cfdump var="#session#" label="cgi" abort="true" top="3" />
		
		
	</cffunction>
	
	<cffunction name="getLongLivedToken" >
		https://developers.instagram.com/docs/instagram-login/access-tokens/expiration-and-extension
		GET /oauth/access_token?  
	    grant_type=fb_exchange_token&           
	    client_id={app-id}&
	    client_secret={app-secret}&
	    fb_exchange_token={short-lived-token} 
		
		
	</cffunction>
	
	<!---https://www.instagram.com/dialog/oauth?client_id=2017613635228214&redirect_uri=http://mediakits.loc/infuencer-profile/edit-instagram-connection/?influenceraccountid=%27C5785E75-8002-7D59-D5A99B33670A71CA%27&trip=true&scope=public_profile,email&state=fb&response_type=code--->
		 <!---<cfdump var="#rc.instagramaccesstoken#" label="cgi" abort="true" top="3" />--->
		 <!---<cfhttp url="graph.instagram.com/?ids=platform,me" method="get" result="myResult">--->
		
		<!---<cfhttp url="https://graph.instagram.com/v2.3/oauth/access_token?" method="get" result="local.result"> 
			<cfhttpparam type="url" name="client_id" value="2017613635228214"> <!------>
			<cfhttpparam type="url" name="redirect_uri" value="http://mediakits.loc/infuencer-profile/edit-instagram-connection/?influenceraccountid=rc.influenceraccountid&wedidit=true)"> 
			<cfhttpparam type="url" name="client_secret" value="dd9ce81152598daed05ea7bbc1209a1e"> 
			<cfhttpparam type="url" name="code" value="#rc.instagramaccesstoken#">
			<cfhttpparam type="url" name="wedidit" value="true">  
		</cfhttp>---->
		
		<!---found this on 
		https://developers.instagram.com/docs/instagram-login/access-tokens/expiration-and-extension--->
		<!---GET /oauth/access_token?  
    grant_type=fb_exchange_token&           
    client_id={app-id}&
    client_secret={app-secret}&
    fb_exchange_token={short-lived-token}--->
	

</cfcomponent>