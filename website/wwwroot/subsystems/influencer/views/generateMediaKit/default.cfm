<cfsilent>

	<cfscript>
		//request.layout = false;

	</cfscript>
</cfsilent>
<cfoutput>
<!---<cfdump var="#rc.influencerAccount.getProfile().getmediakitTemplateID()#" label="cgi" abort="false" top="3" />

<cfdump var="#rc.influencerAccount#" label="cgi" abort="true" top="3" />--->

<cfswitch expression="" >
	<cfcase value="1"><cfinclude template="mediakit_template_1.cfm" ></cfcase>
	<cfdefaultcase><cfinclude template="mediakit_template_1.cfm" ></cfdefaultcase>
</cfswitch>
	
</cfoutput>
