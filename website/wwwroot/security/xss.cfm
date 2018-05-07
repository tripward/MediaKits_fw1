

<!---Check form fields for xss--->
<cfif !structIsEmpty(form)>
	<cfset application.SU.decodeScope(form) />
	<cfset application.SU.xssCheck(form) />
</cfif>

<!---Check url fields for xss--->
<cfif !structIsEmpty(url)>
	<cfset application.SU.decodeScope(url) />
	<cfset application.SU.xssCheck(url) />
</cfif>

<cfset application.SU.xssStringCheck(cgi.scrIPT_NAME) />
<cfset application.SU.xssStringCheck(cgi.quERY_STRING) />
<cfset application.SU.xssStringCheck(cgi.hTTP_REFERER) />
