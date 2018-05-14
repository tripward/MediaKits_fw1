dbsfdvdfvd
<cfdump var="#cgi#" label="cgi" abort="true" top="3" />
<cfif cgi.scriPT_NAME IS '/pintrestAuthDesitation.cfm'>
	<cfset rc.hoo = "" />
	<cfdump var="#rc#" label="cgi" abort="true" top="3" />
	variables.fw.redirect(action='influencer:pintrestSetUp.default', preserve='all');
	
</cfif>