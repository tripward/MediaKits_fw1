<cfsilent>
	<cfparam name="rc.title" default="I am a default title" />
</cfsilent>

	
<cfinclude template="html_head.cfm" />
<body>
<cfoutput>
		<cfinclude template="navbar.cfm" />
        <div id="content">
            <cfoutput>#body#</cfoutput>	<!--- body is result of views --->
            <p id="page_load_info" style="font-size: small;">
                Powered by FW/1 version <cfoutput>#variables.framework.version#</cfoutput>.<br />
                This request took <cfoutput>#getTickCount() - rc.startTime#</cfoutput>ms.
            </p>
        </div>
		
</cfoutput>
<cfinclude template="footer.cfm" />
<cfinclude template="html_foot.cfm" />
