<cfcomponent displayname="FacebookSetUpMainController" persistent="false" accessors="true" output="false" extends="main">

		<cfproperty name="beanFactory">
		<cfproperty name="facebookSetUpService">
		<cfproperty name="InfluencerProfileService">
		<cfproperty name="provider" default="facebook">

	// ********************************* PAGES *******************************************
<cfscript>
	
	public void function before(required struct rc) {
		SUPER.before(rc);
	}
	
	public void function default(required struct rc) {
		
		//todo: reuse
		include "/mediakits_env/providerData.properties.cfm";

		//
		local.FB_combined_response = {};
		local.FB_combined_response.set_date = now();
		
		rc.facebookConnection = variables.beanFactory.getBean('facebook',
			{client_id  : '#variables.providerInfo[variables.provider].clientId#',
			client_secret       : '#variables.providerInfo[variables.provider].clientSecret#',
			authEndpoint        : '#variables.providerInfo[variables.provider].authEndpoint#',
			accessTokenEndpoint : '#variables.providerInfo[variables.provider].accessTokenEndpoint#',
			redirect_uri        : '#variables.providerInfo[variables.provider].redirect_uri#'}
			);
	
		if (structKeyExists(rc,'code')) {
			
			//now that we have a code, go get the token
			local.facebook_token_response = rc.facebookConnection.makeAccessTokenRequest(code=rc.code);
			local.FB_combined_response.Tokne_response = local.facebook_token_response;
			
			//if we fgot the token populate and save the profile
			if (local.facebook_token_response.success) {
				
				local.deserializedResponse = deserializeJSON(local.facebook_token_response.content);
				/*WriteDump(var=local.deserializedResponse,top=2,label='goo', abort=false);*/
				
				
				rc.influencerAccount.getProfile().setfacebookLongLivedAccessToken(local.deserializedResponse.access_token);
				rc.influencerAccount.getProfile().setfacebookLongLivedAccessTokenType(local.deserializedResponse.token_type);
				rc.influencerAccount.getProfile().setfacebookLongLivedAccessTokenSetDate(now());
				
				// there's a built-in CFC that handles this in CF9+
				httpService = new http();
				httpService.setMethod( "get" );
				// and reference it here
				httpService.setUrl( "https://graph.facebook.com/me?access_token=#local.deserializedResponse.access_token#" );
				// this is the cfscript way to grab the response
				local.idresponse = httpResponse = httpService.send().getPrefix();
				/*WriteDump(var=local.idresponse,top=2,label='fgbbf', abort=true);*/
				local.FB_combined_response.profile_response = local.idresponse;
				
				
				
				//
				local.fb_profile_Response = deserializeJSON(local.idresponse.filecontent);
				/*WriteDump(var=local.fb_profile_Response,top=2,label='goo', abort=true);*/
				if (local.idresponse.status_code IS '200') {            
	            	rc.influencerAccount.getProfile().setFacebookID(local.fb_profile_Response.id);            
	            }            
	            else {            
	            	//todo:error handling
	            	WriteDump(var=local.idresponse,top=2,label='in facebooke profile call', abort=true);
	            }
				
				
				local.FB_combined_response_serialized = serializeJSON(local.FB_combined_response);
				rc.influencerAccount.getProfile().setfacebookResponse(local.FB_combined_response_serialized);
				
				
				
				// save profile
				variables.InfluencerProfileService.save(rc.influencerAccount.getProfile());
				ormFlush();
				
				variables.fw.redirect(action='influencer:main.default', preserve='all');
		
				
			}
			else {
				WriteOutput("payment Failed");abort;
			}
			
			
			
		}    
		/*else {    
			WriteOutput("payment Failed");abort;}*/    
		
	
		}
	</cfscript>
	
	<cffunction name="getFBID" >
		<cftry>
			
			<cfparam name="rc.errors" default="#arrayNew(1)#" >
			
			
			<cfif !len(trim(rc.facebookUserName))>
				<cfset arrayAppend(rc.errors,'please fill in username') />
			</cfif>
			
			<cfscript>
				var myResult = "";
				rc.influencerAccount = getBean('InfluencerAccount').loadBy(influenceraccountid=rc.influenceraccountid);
			</cfscript>
			
			<cfset variables.facebookSetUpService.persistShortLivedAccessDataPoints(influenceraccountid="#rc.influenceraccountid#",FacebookID=#rc.FacebookID#,FacebookUsername=#rc.FacebookUsername#,facebookShortLivedAccessToken=#rc.facebookShortLivedAccessToken#) />
			
			<cfhttp url="https://graph.facebook.com/v2.3/oauth/access_token?grant_type=fb_exchange_token&client_id=2017613635228214&client_secret=dd9ce81152598daed05ea7bbc1209a1e&fb_exchange_token=#rc.facebookShortLivedAccessToken#&redirect_uri=http://mediakits.loc/infuencer-profile/edit-facebook-connection/?influenceraccountid=rc.influenceraccountid&wedidit=true" method="get" result="local.result">
			<!---<cfdump var="#local.result#" label="cgi" abort="true" top="3" />--->
			
			<cfif local.result.statuscode IS '200 OK'>
				<cfset local.filecontent = deserializeJSON(local.result.Filecontent) />
				<!---<cfdump var="#local.filecontent#" label="cgi" abort="true" top="3" />--->
				<cfset variables.facebookSetUpService.persistLongLivedAccessDataPoints(influenceraccountid="#rc.influenceraccountid#",facebookLongLivedAccessTokenExpiresIn=#local.filecontent.expires_in#,facebookLongLivedAccessToken=#local.filecontent.access_token#,facebookLongLivedAccessTokenType=#local.filecontent.token_type#) />
			</cfif>
			
			<cfset variables.fw.redirect(path='/infuencer-profile/', action='influencer:main.getProfile', preserve='ALL', queryString='influenceraccountid=#session.influencerAccount.getID()#') />
		
	      <cfcatch type="any" >
			<cfdump var="#cfcatch#" label="cfcatch" abort="false"  />
			<cfdump var="#arguments#" label="arguments" abort="true"  />
			
		</cfcatch>
	</cftry>


	</cffunction>
	
	<cffunction name="persistFacebookSetup" >
		<cfdump var="#rc#" label="cgi" abort="true" top="3" />
		<cfscript>
			var myResult = "";
			rc.influencerAccount = getBean('InfluencerAccount').loadBy(influenceraccountid=rc.influenceraccountid);
		</cfscript>
		
		 <!---https://www.facebook.com/dialog/oauth?client_id=2017613635228214&redirect_uri=http://mediakits.loc/infuencer-profile/edit-facebook-connection/?influenceraccountid=%27C5785E75-8002-7D59-D5A99B33670A71CA%27&trip=true&scope=public_profile,email&state=fb&response_type=code--->
		 
		<!--- <cfhttp url="graph.facebook.com/?ids=platform,me" method="get" result="myResult">--->
		
		<!---<cflogin>
		<cfoauth
			type="Facebook"
			clientID = "2017613635228214"
			secretkey = "dd9ce81152598daed05ea7bbc1209a1e"
			result = "myResult"
			state="fb"
			scope="public_profile,email"
			redirecturi="http://mediakits.loc/infuencer-profile/edit-facebook-connection/?influenceraccountid=#rc.influenceraccountid#&trip=true">

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
		https://developers.facebook.com/docs/facebook-login/access-tokens/expiration-and-extension
		GET /oauth/access_token?  
	    grant_type=fb_exchange_token&           
	    client_id={app-id}&
	    client_secret={app-secret}&
	    fb_exchange_token={short-lived-token} 
		
		
	</cffunction>
	
	<!---https://www.facebook.com/dialog/oauth?client_id=2017613635228214&redirect_uri=http://mediakits.loc/infuencer-profile/edit-facebook-connection/?influenceraccountid=%27C5785E75-8002-7D59-D5A99B33670A71CA%27&trip=true&scope=public_profile,email&state=fb&response_type=code--->
		 <!---<cfdump var="#rc.facebookaccesstoken#" label="cgi" abort="true" top="3" />--->
		 <!---<cfhttp url="graph.facebook.com/?ids=platform,me" method="get" result="myResult">--->
		
		<!---<cfhttp url="https://graph.facebook.com/v2.3/oauth/access_token?" method="get" result="local.result"> 
			<cfhttpparam type="url" name="client_id" value="2017613635228214"> <!------>
			<cfhttpparam type="url" name="redirect_uri" value="http://mediakits.loc/infuencer-profile/edit-facebook-connection/?influenceraccountid=rc.influenceraccountid&wedidit=true)"> 
			<cfhttpparam type="url" name="client_secret" value="dd9ce81152598daed05ea7bbc1209a1e"> 
			<cfhttpparam type="url" name="code" value="#rc.facebookaccesstoken#">
			<cfhttpparam type="url" name="wedidit" value="true">  
		</cfhttp>---->
		
		<!---found this on 
		https://developers.facebook.com/docs/facebook-login/access-tokens/expiration-and-extension--->
		<!---GET /oauth/access_token?  
    grant_type=fb_exchange_token&           
    client_id={app-id}&
    client_secret={app-secret}&
    fb_exchange_token={short-lived-token}--->
	

</cfcomponent>