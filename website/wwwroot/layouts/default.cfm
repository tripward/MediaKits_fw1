<cfsilent>
	<cfparam name="rc.title" default="I am a default title" />
</cfsilent>

	
<cfinclude template="html_head.cfm" />
<body>
<cfoutput>
		<cfinclude template="navbar.cfm" />
		<h1>#rc.title#</h1>
		<cfoutput>#body#</cfoutput>	<!--- body is result of views --->
		<p style="font-size: small;">
			Powered by FW/1 version <cfoutput>#variables.framework.version#</cfoutput>.<br />
			This request took <cfoutput>#getTickCount() - rc.startTime#</cfoutput>ms.
		</p>
		
</cfoutput>
<cfinclude template="footer.cfm" />
<cfinclude template="html_foot.cfm" />
