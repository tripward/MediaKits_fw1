
<!---<cfif cgi.scriPT_NAME IS '/pintrestAuthDesitation.cfm'>--->
	<!---<cfdump var="#url#" label="cgi" abort="false" top="3" />
	<cfdump var="#cgi#" label="cgi" abort="true" top="3" />--->
	<!---variables.fw.redirect(action='influencer:pintrestSetUp.default', preserve='all');--->
	
<!---</cfif>--->
<cflocation url="https://#cgi.servER_NAME#/index.cfm?action=influencer:pintrestSetup.default&code=#url.code#&state=#url.state#" >
<!---https://#cgi.servER_NAME#/index.cfm?action=influencer:pintrestSetup.default&code=#url.code#&state=#url.state#--->