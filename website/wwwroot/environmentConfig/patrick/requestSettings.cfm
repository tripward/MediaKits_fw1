<cfscript>
	include '/environmentConfig/requestBaseSettings.cfm';

	//will reload the plug in arch on every request, use during dev
	request.isReloadOnEveryRequest = TRUE;
	
	//pathing section
	request.mediaFilesAbsolutePath = 'C:\vagrant\mediaFiles';
	
	//debugging section
	request.isShowErrorDebugging = TRUE;
	request.isShowSecurityDebugging = TRUE;
	request.isShowConfigDisplay = TRUE;

</cfscript>
