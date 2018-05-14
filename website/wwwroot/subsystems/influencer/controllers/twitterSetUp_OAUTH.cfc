<cfcomponent displayname="twitterSetUpMainController" persistent="false" accessors="true" output="false" extends="main">

		<cfproperty name="beanFactory">
		<cfproperty name="twitterSetUpService">
		<cfproperty name="InfluencerProfileService">
		<cfproperty name="provider" default="twitter">

	// ********************************* PAGES *******************************************
	<cfscript>
	
		public void function before(required struct rc) {
			SUPER.before(rc);
		}
		
		public void function default(required struct rc) {
		
		//todo: reuse
		include "/mediakits_env/providerData.properties.cfm";
		
		rc.twitterConnection = variables.beanFactory.getBean(variables.provider,
			{client_id  : '#variables.providerInfo[variables.provider].clientId#',
			client_secret       : '#variables.providerInfo[variables.provider].clientSecret#',
			authEndpoint        : '#variables.providerInfo[variables.provider].authEndpoint#',
			accessTokenEndpoint : '#variables.providerInfo[variables.provider].accessTokenEndpoint#',
			redirect_uri        : '#variables.providerInfo[variables.provider].redirect_uri#',
			request_token_path  : '#variables.providerInfo[variables.provider].request_token_path#'}
			);

		/*WriteDump(var=rc.twitterConnection,top=5,label='goo', abort=true);*/
		local.twitter_token_response = rc.twitterConnection.getRequestToken();
		
		
	
		if (structKeyExists(rc,'code')) {
			
			//
		local.twitter_combined_response = {};
		local.twitter_combined_response.set_date = now();
			
			//now that we have a code, go get the token
			local.twitter_token_response = rc.twitterConnection.makeAccessTokenRequest(code=rc.code);
			local.twitter_combined_response.Tokne_response = local.twitter_token_response;
			
			//if we fgot the token populate and save the profile
			if (local.twitter_token_response.success) {
				
				local.deserializedResponse = deserializeJSON(local.twitter_token_response.content);
				/*WriteDump(var=local.deserializedResponse,top=2,label='goo', abort=false);*/
				
				
				rc.influencerAccount.getProfile().settwitterLongLivedAccessToken(local.deserializedResponse.access_token);
				rc.influencerAccount.getProfile().settwitterLongLivedAccessTokenType(local.deserializedResponse.token_type);
				rc.influencerAccount.getProfile().settwitterLongLivedAccessTokenSetDate(now());
				
				// there's a built-in CFC that handles this in CF9+
				httpService = new http();
				httpService.setMethod( "get" );
				// and reference it here
				httpService.setUrl( "https://graph.twitter.com/me?access_token=#local.deserializedResponse.access_token#" );
				// this is the cfscript way to grab the response
				local.idresponse = httpResponse = httpService.send().getPrefix();
				/*WriteDump(var=local.idresponse,top=2,label='fgbbf', abort=true);*/
				local.twitter_combined_response.profile_response = local.idresponse;
				
				
				
				//
				local.twitter_profile_Response = deserializeJSON(local.idresponse.filecontent);
				/*WriteDump(var=local.twitter_profile_Response,top=2,label='goo', abort=true);*/
				if (local.idresponse.status_code IS '200') {            
	            	rc.influencerAccount.getProfile().settwitterID(local.twitter_profile_Response.id);            
	            }            
	            else {            
	            	//todo:error handling
	            	WriteDump(var=local.idresponse,top=2,label='in twittere profile call', abort=true);
	            }
				
				
				local.twitter_combined_response_serialized = serializeJSON(local.twitter_combined_response);
				rc.influencerAccount.getProfile().settwitterResponse(local.twitter_combined_response_serialized);
				
				
				
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
	
	<cffunction name="persisttwitterInfo" >
		
			<cfparam name="rc.errors" default="#arrayNew(1)#" >
			
			<cfif !len(trim(rc.twitterUserName))>
				<cfset arrayAppend(rc.errors,'please fill in username') />
			</cfif>
			
			<cfset rc.influencerAccount.getProfile().settwitterUsername(rc.twitterUserName) />
			<cfscript>

				// save profile
					variables.InfluencerProfileService.save(rc.influencerAccount.getProfile());
					ormFlush();
					
					variables.fw.redirect(action='influencer:main.default', preserve='all');

			</cfscript>

	</cffunction>

</cfcomponent>