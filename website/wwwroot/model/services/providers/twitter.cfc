component extends="model.services.oauth2" accessors="true" {

	property name="client_id" type="string";
	property name="client_secret" type="string";
	property name="authEndpoint" type="string";
	property name="accessTokenEndpoint" type="string";
	property name="redirect_uri" type="string";
	property name="request_token_path" type="string";
	
	/**
	* I return an initialized instagram object instance.
	* @client_id The client ID for your application.
	* @client_secret The client secret for your application.
	* @authEndpoint The URL endpoint that handles the authorisation.
	* @accessTokenEndpoint The URL endpoint that handles retrieving the access token.
	* @redirect_uri The URL to redirect the user back to following authentication.
	**/
	public twitter function init(
		required string client_id, 
		required string client_secret, 
		required string authEndpoint = 'https://api.instagram.com/oauth/authorize', 
		required string accessTokenEndpoint = 'https://api.instagram.com/oauth/access_token',
		required string redirect_uri,
		required string request_token_path
	)
	{
		super.init(
			client_id           = arguments.client_id, 
			client_secret       = arguments.client_secret, 
			authEndpoint        = arguments.authEndpoint, 
			accessTokenEndpoint = arguments.accessTokenEndpoint, 
			redirect_uri        = arguments.redirect_uri,
			request_token_path  = arguments.request_token_path
			
		);
		//
		setrequest_token_path( arguments.request_token_path );
		return this;
	}


	public string function getRequestToken(
		array scope = [],
		string state
	){
		

		var httpService = new http();
	    httpService.setMethod( "post" ); 
	    httpService.setCharset( "utf-8" );
	    httpService.setUrl( getAccessTokenEndpoint() );
	    
	    var oauth_signature_type = 'PLAINTEXT';
	    var oauth_signature = 'PLAINTEXT';   
	    
	    
	    httpService.addParam( type="header", name=item[ 'oauth_consumer_key' ],  value=item[ '#client_id#' ] );
	    httpService.addParam( type="header", name=item[ 'oauth_signature_method' ],  value=item[ '#client_id#' ] );
	    /*httpService.addParam( type="header", name=item[ 'name' ],  value=item[ 'value' ] );
	    httpService.addParam( type="header", name=item[ 'name' ],  value=item[ 'value' ] );
	    httpService.addParam( type="header", name=item[ 'name' ],  value=item[ 'value' ] );*/
	    /*if( arrayLen( arguments.headers ) ){
	    	for( var item in arguments.headers ){
	    		httpService.addParam( type="header", name=item[ 'name' ],  value=item[ 'value' ] );
	    	}
	    }*/
	    var encodedPath = encodeForURL("http://mediakits.loc/index.cfm");
	    
	    httpService.addParam( type="formfield", name="oauth_callback", 	 value='#encodedPath#' );
	    /*httpService.addParam( type="formfield", name="client_secret", value=getClient_secret() );
	    httpService.addParam( type="formfield", name="code", 		 value=arguments.code );
	    httpService.addParam( type="formfield", name="redirect_uri",  value=getRedirect_uri() );*/
	    /*WriteDump(var=httpService.getParams(),top=8,label='goo', abort=true);*/
	    
	    /*if( arrayLen( arguments.formfields ) ){
	    	for( var item in arguments.formfields ){
	    		httpService.addParam( type="formfield", name=item[ 'name' ],  value=item[ 'value' ] );
	    	}
	    }*/
	    var result = httpService.send().getPrefix();
		WriteDump(var=result,top=4,label='goo', abort=true);
		
		/*https://developer.twitter.com/en/docs/basics/authentication/api-reference/request_token
		https://developer.twitter.com/en/docs/basics/authentication/guides/authorizing-a-request
		https://oauth.net/core/1.0/#encoding_parameters
		https://oauth.net/core/1.0/#anchor9*/
		
		/*var httpService = new http();
	    httpService.setMethod( "post" ); 
	    httpService.setCharset( "utf-8" );
	    httpService.setUrl( getrequest_token_path() );*/
	    
	    /*httpService.addParam( type="formfield", name="client_id", 	 value=getClient_id() );
	    httpService.addParam( type="formfield", name="client_secret", value=getClient_secret() );
	    httpService.addParam( type="formfield", name="code", 		 value=arguments.code );
	    httpService.addParam( type="formfield", name="redirect_uri",  value=getRedirect_uri() );*/
	    /*WriteDump(var=httpService.getParams(),top=8,label='goo', abort=true);*/
	    
	    /*if( arrayLen( arguments.formfields ) ){
	    	for( var item in arguments.formfields ){
	    		httpService.addParam( type="formfield", name=item[ 'name' ],  value=item[ 'value' ] );
	    	}
	    }*/

	    /*WriteDump(var=getrequest_token_path(),top=2,label='goo', abort=true);
	    WriteDump(var=httpService.getUrl(),top=2,label='goo', abort=true);
	    var result = httpService.send().getPrefix();*/
	    /*WriteDump(var=result,top=2,label='goo', abort=true);*/
	    
		return super.buildRedirectToAuthURL( sParams );
	}
	
	
	
	/**
	* I return the URL as a string which we use to redirect the user for authentication.
	* @scope An optional array of values to pass through for scope access.
	* @state A unique string value of your choice that is hard to guess. Used to prevent CSRF.
	**/
	public string function buildRedirectToAuthURL(
		array scope = [],
		string state
	){
		var sParams = {
			'response_type' = 'code'
		};
		
		if( len( arguments.state ) ){
			structInsert( sParams, 'state', arguments.state );
		}

		if( arrayLen( arguments.scope ) ){
			structInsert( sParams, 'scope', arrayToList( arguments.scope, ' ' ) );
		}
		if( len( arguments.state ) ){
			structInsert( sParams, 'state', arguments.state );
		}
		return super.buildRedirectToAuthURL( sParams );
	}

	/**
	* I make the HTTP request to obtain the access token.
	* @code The code returned from the authentication request.
	**/
	public struct function makeAccessTokenRequest(
		required string code
	){
		var aFormFields = [
			{
				'name'  = 'grant_type',
				'value' = 'authorization_code'
			}
		];
		return super.makeAccessTokenRequest(
			code       = arguments.code,
			formfields = aFormFields
		);
	}

}