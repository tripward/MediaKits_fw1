<!---<cfdump var="#form#" label="cgi" abort="false" />
<cfdump var="#url#" label="cgi" abort="true" />--->

<cfif !structIsEmpty(form) OR !structIsEmpty(url)>

	<!---<cfdump var="#cgi#" label="cgi" abort="true" />--->
	<!---!structKeyExists(form,"q") AND --->
	<cfif structKeyExists(form,"csrfToken")>
		<cfset application.SU.csrfCheck(session.sessionID,form.csrfToken) />
		<!---<cfdump var="#cgi#" label="cgi" abort="true" />--->
	</cfif>
	<!--- !structKeyExists(url,"q") AND --->
	<cfif structKeyExists(url,"csrfToken")>
		<!---<cfdump var="#cgi#" label="cgi" abort="true" />--->
		<cfset application.SU.csrfCheck(session.sessionID,url.csrfToken) />
		<!---<cfdump var="#server#" label="cgi" abort="true" />--->
	</cfif>
</cfif>

