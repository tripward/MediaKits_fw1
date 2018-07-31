<cfscript>
	include '/environmentConfig/requestBaseSettings.cfm';
	
	//will reload the plug in arch on every request, use during dev
	request.isReloadOnEveryRequest = TRUE;

	
	//debugging section
	request.isShowErrorDebugging = TRUE;
	request.isShowSecurityDebugging = TRUE;
	request.isShowConfigDisplay = TRUE;
	
	request.appkeys = {};
	request.appkeys.facebook.appid = '2017613635228214';
	request.appkeys.facebook.token = '2017613635228214|73VLp8BDijmsEYks68esMXSMIf4';
	request.appkeys.facebook.secretKey = 'dd9ce81152598daed05ea7bbc1209a1e';
	
	

</cfscript>



