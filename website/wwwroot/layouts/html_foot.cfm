<cfoutput>
	<!--- Bootstrap JavaScript --->
	<script src="css/bootstrap/js/bootstrap.min.js"></script>
    <!--- Theme JavaScript --->
    <!---<script src="#$.siteConfig('themeAssetPath')#/js/theme/theme.min.js"></script>--->

	<cfif structKeyExists(session,'influencerAccount') AND listLast(cgi.pATH_INFO, '/') IS 'infuencer-profile'>
		
		<cfif len(trim(session.influencerAccount.getProfile().getFacebookID()))>
			<cfinclude template="js/facebooks_Scripts_profile.cfm" />
		</cfif>
		
		<cfif len(trim(session.influencerAccount.getProfile().getinstagramUserName()))>
			<cfinclude template="js/instagram_Scripts_profile.cfm" />
		</cfif>
		
		<cfif len(trim(session.influencerAccount.getProfile().gettwitterUserName()))>
			<cfinclude template="js/twitter_Scripts_profile.cfm" />
		</cfif>
		
		<cfif len(trim(session.influencerAccount.getProfile().getPintrestUserName()))>
			<cfinclude template="js/pintrest_Scripts_profile.cfm" />
		</cfif>
		
	</cfif>
	
	<cfif listLast(cgi.pATH_INFO, '/') IS 'edit-facebook-connection'>
		<cfinclude template="js/facebooks_Scripts_auth.cfm" />
	</cfif>
	
	<cfif listLast(cgi.pATH_INFO, '/') IS 'edit-pintrest-connection'>
		<cfinclude template="js/pintrest_Scripts_auth.cfm" />
		<script async defer src="//assets.pinterest.com/js/pinit.js"></script>
	</cfif>
	
	


	</body>
</html>
</cfoutput>