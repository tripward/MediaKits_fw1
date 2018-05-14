<cfcomponent displayname="pintrestSetUpMainController" persistent="false" accessors="true" output="false" extends="main">

		<cfproperty name="beanFactory">
		<cfproperty name="pintrestSetUpService">
		<cfproperty name="InfluencerProfileService">
		<cfproperty name="provider" default="pintrest">

	// ********************************* PAGES *******************************************
<cfscript>
	
	public void function before(required struct rc) {
		SUPER.before(rc);
	}
	
	public void function default(required struct rc) {
		
		//todo: reuse
		include "/mediakits_env/providerData.properties.cfm";
		
		/*if (structKeyExists(rc,'hoo')) {        
        	WriteOutput("I like apples"); abort;   
        }        
        else {        
        	WriteOutput("payment Failed");abort;        
        }*/

		//
		local.pintrest_combined_response = {};
		local.pintrest_combined_response.set_date = now();
		
		rc.pintrestConnection = variables.beanFactory.getBean('pintrest',
			{client_id  : '#variables.providerInfo[variables.provider].clientId#',
			client_secret       : '#variables.providerInfo[variables.provider].clientSecret#',
			authEndpoint        : '#variables.providerInfo[variables.provider].authEndpoint#',
			accessTokenEndpoint : '#variables.providerInfo[variables.provider].accessTokenEndpoint#',
			redirect_uri        : '#variables.providerInfo[variables.provider].redirect_uri#'}
			);
	
		if (structKeyExists(rc,'code')) {
			/*WriteDump(var=rc,top=2,label='goo', abort=true);*/
			
			
			//now that we have a code, go get the token
			local.pintrest_token_response = rc.pintrestConnection.makeAccessTokenRequest(code=rc.code);
			local.pintrest_combined_response.Tokne_response = local.pintrest_token_response;
			WriteDump(var=local.pintrest_token_response,top=2,label='goo', abort=true);
			//if we fgot the token populate and save the profile
			if (local.pintrest_token_response.success) {
				
				local.deserializedResponse = deserializeJSON(local.pintrest_token_response.content);
				/*WriteDump(var=local.deserializedResponse,top=2,label='goo', abort=false);*/
				
				
				rc.influencerAccount.getProfile().setpintrestLongLivedAccessToken(local.deserializedResponse.access_token);
				rc.influencerAccount.getProfile().setpintrestLongLivedAccessTokenType(local.deserializedResponse.token_type);
				rc.influencerAccount.getProfile().setpintrestLongLivedAccessTokenSetDate(now());
				
				// there's a built-in CFC that handles this in CF9+
				httpService = new http();
				httpService.setMethod( "get" );
				// and reference it here
				httpService.setUrl( "https://graph.pintrest.com/me?access_token=#local.deserializedResponse.access_token#" );
				// this is the cfscript way to grab the response
				local.idresponse = httpResponse = httpService.send().getPrefix();
				/*WriteDump(var=local.idresponse,top=2,label='fgbbf', abort=true);*/
				local.pintrest_combined_response.profile_response = local.idresponse;
				
				
				
				//
				local.pintrest_profile_Response = deserializeJSON(local.idresponse.filecontent);
				/*WriteDump(var=local.pintrest_profile_Response,top=2,label='goo', abort=true);*/
				if (local.idresponse.status_code IS '200') {            
	            	rc.influencerAccount.getProfile().setpintrestID(local.pintrest_profile_Response.id);            
	            }            
	            else {            
	            	//todo:error handling
	            	WriteDump(var=local.idresponse,top=2,label='in pintreste profile call', abort=true);
	            }
				
				
				local.pintrest_combined_response_serialized = serializeJSON(local.pintrest_combined_response);
				rc.influencerAccount.getProfile().setpintrestResponse(local.pintrest_combined_response_serialized);
				
				
				
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
	
	<cffunction name="getpintrestID" >
		<cftry>
			
			<cfparam name="rc.errors" default="#arrayNew(1)#" >
			
			
			<cfif !len(trim(rc.pintrestUserName))>
				<cfset arrayAppend(rc.errors,'please fill in username') />
			</cfif>
			
			<cfscript>
				var myResult = "";
				rc.influencerAccount = getBean('InfluencerAccount').loadBy(influenceraccountid=rc.influenceraccountid);
			</cfscript>
			
			<cfset variables.pintrestSetUpService.persistShortLivedAccessDataPoints(influenceraccountid="#rc.influenceraccountid#",pintrestID=#rc.pintrestID#,pintrestUsername=#rc.pintrestUsername#,pintrestShortLivedAccessToken=#rc.pintrestShortLivedAccessToken#) />
			
			<cfhttp url="https://graph.pintrest.com/v2.3/oauth/access_token?grant_type=pintrest_exchange_token&client_id=2017613635228214&client_secret=dd9ce81152598daed05ea7bbc1209a1e&pintrest_exchange_token=#rc.pintrestShortLivedAccessToken#&redirect_uri=http://mediakits.loc/infuencer-profile/edit-pintrest-connection/?influenceraccountid=rc.influenceraccountid&wedidit=true" method="get" result="local.result">
			<!---<cfdump var="#local.result#" label="cgi" abort="true" top="3" />--->
			
			<cfif local.result.statuscode IS '200 OK'>
				<cfset local.filecontent = deserializeJSON(local.result.Filecontent) />
				<!---<cfdump var="#local.filecontent#" label="cgi" abort="true" top="3" />--->
				<cfset variables.pintrestSetUpService.persistLongLivedAccessDataPoints(influenceraccountid="#rc.influenceraccountid#",pintrestLongLivedAccessTokenExpiresIn=#local.filecontent.expires_in#,pintrestLongLivedAccessToken=#local.filecontent.access_token#,pintrestLongLivedAccessTokenType=#local.filecontent.token_type#) />
			</cfif>
			
			<cfset variables.fw.redirect(path='/infuencer-profile/', action='influencer:main.getProfile', preserve='ALL', queryString='influenceraccountid=#session.influencerAccount.getID()#') />
		
	      <cfcatch type="any" >
			<cfdump var="#cfcatch#" label="cfcatch" abort="false"  />
			<cfdump var="#arguments#" label="arguments" abort="true"  />
			
		</cfcatch>
	</cftry>


	</cffunction>
	
	<cffunction name="persistpintrestSetup" >
		<cfdump var="#rc#" label="cgi" abort="true" top="3" />
		<cfscript>
			var myResult = "";
			rc.influencerAccount = getBean('InfluencerAccount').loadBy(influenceraccountid=rc.influenceraccountid);
		</cfscript>
		
		 <!---https://www.pintrest.com/dialog/oauth?client_id=2017613635228214&redirect_uri=http://mediakits.loc/infuencer-profile/edit-pintrest-connection/?influenceraccountid=%27C5785E75-8002-7D59-D5A99B33670A71CA%27&trip=true&scope=public_profile,email&state=pintrest&response_type=code--->
		 
		<!--- <cfhttp url="graph.pintrest.com/?ids=platform,me" method="get" result="myResult">--->
		
		<!---<cflogin>
		<cfoauth
			type="pintrest"
			clientID = "2017613635228214"
			secretkey = "dd9ce81152598daed05ea7bbc1209a1e"
			result = "myResult"
			state="pintrest"
			scope="public_profile,email"
			redirecturi="http://mediakits.loc/infuencer-profile/edit-pintrest-connection/?influenceraccountid=#rc.influenceraccountid#&trip=true">

			/*#res.other.username#*/
			<cfloginuser name="king@werwards.com" password="#myResult.access_token#" roles="user"/>
		</cflogin>--->
		<!---<cflocation url="http://localhost:8500/doc/index.cfm">--->
		
		
		
		<cfscript>
			session.pintrestinfo = myResult;
		</cfscript>
		
		<cfdump var="#myResult#" label="cgi" abort="false" top="3" />
		<cfdump var="#session#" label="cgi" abort="true" top="3" />
		
		
	</cffunction>
	
	<cffunction name="getLongLivedToken" >
		https://developers.pintrest.com/docs/pintrest-login/access-tokens/expiration-and-extension
		GET /oauth/access_token?  
	    grant_type=pintrest_exchange_token&           
	    client_id={app-id}&
	    client_secret={app-secret}&
	    pintrest_exchange_token={short-lived-token} 
		
		
	</cffunction>
	
	<!---https://www.pintrest.com/dialog/oauth?client_id=2017613635228214&redirect_uri=http://mediakits.loc/infuencer-profile/edit-pintrest-connection/?influenceraccountid=%27C5785E75-8002-7D59-D5A99B33670A71CA%27&trip=true&scope=public_profile,email&state=pintrest&response_type=code--->
		 <!---<cfdump var="#rc.pintrestaccesstoken#" label="cgi" abort="true" top="3" />--->
		 <!---<cfhttp url="graph.pintrest.com/?ids=platform,me" method="get" result="myResult">--->
		
		<!---<cfhttp url="https://graph.pintrest.com/v2.3/oauth/access_token?" method="get" result="local.result"> 
			<cfhttpparam type="url" name="client_id" value="2017613635228214"> <!------>
			<cfhttpparam type="url" name="redirect_uri" value="http://mediakits.loc/infuencer-profile/edit-pintrest-connection/?influenceraccountid=rc.influenceraccountid&wedidit=true)"> 
			<cfhttpparam type="url" name="client_secret" value="dd9ce81152598daed05ea7bbc1209a1e"> 
			<cfhttpparam type="url" name="code" value="#rc.pintrestaccesstoken#">
			<cfhttpparam type="url" name="wedidit" value="true">  
		</cfhttp>---->
		
		<!---found this on 
		https://developers.pintrest.com/docs/pintrest-login/access-tokens/expiration-and-extension--->
		<!---GET /oauth/access_token?  
    grant_type=pintrest_exchange_token&           
    client_id={app-id}&
    client_secret={app-secret}&
    pintrest_exchange_token={short-lived-token}--->
	

</cfcomponent>