<cfscript>
variables.providerInfo = {
	'default': {
		'clientId'    : '1234567890',
		'clientSecret': 'XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXX',
		'redirect_uri': 'http://redirect.fake'
	},
	'facebook': {
		'clientId'    : '2017613635228214',
		'clientSecret': 'dd9ce81152598daed05ea7bbc1209a1e',
		'authEndpoint'        : 'https://www.facebook.com/v3.0/dialog/oauth',
		'accessTokenEndpoint' : 'https://graph.facebook.com/v3.0/oauth/access_token',
		'redirect_uri': 'http://mediakits.loc/index.cfm?action=#encodeForURL("influencer:facebookSetup.default")#'
	},
	'instagram': {
		'clientId'    : '1103427d58604857acddc36d731f4a3e',
		'clientSecret': 'c636b4296bc84f00832877839c5b418d',
		'authEndpoint'        : 'https://api.instagram.com/oauth/authorize',
		'accessTokenEndpoint' : 'https://api.instagram.com/oauth/access_token',
		'redirect_uri': 'http://mediakits.loc/index.cfm?action=influencer:InstagramSetup.default'
	},
	'twitter': {
		'clientId'    : 'YByaJpLNecsBPNGAM43IGonDa',//On twitter reffered to as consumer Key
		'clientSecret': 'Wl41aDR4ijKuRtL49E1Jtd5qCaT3iAgB8zBt0N2DkiSnuLJ72A',//On twitter reffered to as consumer secret
		'authEndpoint'        : '	https://api.twitter.com/oauth/authorize',
		'accessTokenEndpoint' : 'https://api.twitter.com/oauth/access_token',
		'redirect_uri': 'http://mediakits.loc/index.cfm?action=influencer:twitterSetup.default',
		'request_token_path': 'https://api.twitter.com/oauth/request_token'
	},
	'pintrest': {
		'clientId'    : '4952900742051542490',//On twitter reffered to as app id
		'clientSecret': '61265f3a64a98a12a6975202fc8f1d7a786c6d8e2b297f8a284c7bf45044e10d',//On twitter reffered to as consumer secret
		'authEndpoint'        : 'https://api.pinterest.com/oauth/',
		'accessTokenEndpoint' : 'https://api.pinterest.com/v1/oauth/token',
		'redirect_uri': 'https://mediakits.loc/apiCatches/pintrestAuthDesitation.cfm'
	},
	'linkedin': {
		'clientId'    : '77xcc3lwwi4s6o',//On twitter reffered to as app id
		'clientSecret': 'CjowW6oz6gyj2DJH',//On twitter reffered to as consumer secret
		'authEndpoint'        : 'https://api.pinterest.com/oauth/',
		'accessTokenEndpoint' : 'https://api.pinterest.com/v1/oauth/token',
		'redirect_uri': 'https://mediakits.loc/apiCatches/pintrestAuthDesitation.cfm'
	}
};
</cfscript>

<!---https://dev.twitter.com/web/sign-in/implementing--->
<!---

This properties file can be extended should you wish to test the providers using real 
application data.

Simply add a new struct to the `variables.providerInfo` above with the 
name of the provider (which must match the value used in the associated test suite) and 
apply your clientId, clientSecret and redirect_uri values to that struct.

If no match for a specific provider is found, the tests will use the default dummy values.

For example:

variables.providerInfo = {
	'default': {
		'clientId'    : '1234567890',
		'clientSecret': 'XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXX',
		'redirect_uri': 'http://redirect.fake'
	},
	'facebook': {
		'clientId'    : '2343243243232',
		'clientSecret': 'ffew9832908e9w08v09w8v908ew09v8w',
		'redirect_uri': 'http://127.0.0.1:8080/tests/oauth2request.cfm'
	},
	'microsoft': {
		'clientId'    : '9517fec8-135908-wekhewkh-i889e7cioew',
		'clientSecret': 'kwjehiowhceowcuilewhc',
		'redirect_uri': 'http://127.0.0.1:8080/tests/oauth2request.cfm'
	}
};

--->