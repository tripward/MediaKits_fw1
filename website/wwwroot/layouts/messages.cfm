<!---<cfdump var="#rc#" label="rc.errors" abort="true" top="3" />--->
<!---<cfdump var="#rc.errors#" label="rc.errors" abort="false" top="3" />
<cfdump var="#rc.messages#" label="rc.messages" abort="false" top="3" />--->
<cfoutput>
	
	<cfif structKeyExists(rc, 'errors') AND !structIsEmpty(rc.errors)>
		<div class="alert alert-info">
			<a class="close" data-dismiss="alert" href="##">&times;</a>
			<cfdump var="#rc.errors#" label="rc.errors" abort="false" top="3" />
		</div>
	</cfif>
	
	<cfif structKeyExists(rc, 'messages') AND arrayLen(rc.messages)>
		<div class="alert alert-info">
			<a class="close" data-dismiss="alert" href="##">&times;</a>
			<!---#rc.messages#--->
			<cfdump var="#rc.messages#" label="cgi" abort="false" top="3" />
		</div>
	</cfif>
	
	<cfif structKeyExists(rc, 'validationMessages') AND !structIsEmpty(rc.validationMessages)>
		<div class="alert alert-info">
			<a class="close" data-dismiss="alert" href="##">&times;</a>
			<cfdump var="#rc.validationMessages#" label="cgi" abort="false" top="3" />
		</div>
	</cfif>
	
	
</cfoutput>