<cfscript>

	//will reload the plug in arch on every request, use during dev
	request.isReloadOnEveryRequest = FALSE;
	
	//pathing section
	request.mediaFilesAbsolutePath = '';
	
	//debugging section
	request.isShowErrorDebugging = FALSE;
	request.isShowSecurityDebugging = FALSE;
	request.isShowConfigDisplay = FALSE;

</cfscript>
