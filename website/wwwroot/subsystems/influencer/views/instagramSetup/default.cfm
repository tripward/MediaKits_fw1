<cfsilent>
	<cfscript>
	</cfscript>
</cfsilent>

<cfoutput>
	
<h4>instagram Connection Info</h4>
<div>instagram Permissions Needed:</div>
<ul>
	<li>Email Address</li>
	<li>Follower Count</li>
</ul>

<cfscript>
rc.aScope = [
	'public_profile',
	'email'	]
</cfscript>

<cfinclude template="/mediakits_env/providerData.properties.cfm" >, scope=rc.aScope
<!---<cfdump var="#rc.instagramConnection.buildRedirectToAuthURL( state='session.surfer.influencerAccount', scope=rc.aScope )#" label="cgi" abort="true" top="3" />--->
<a href="#rc.instagramConnection.buildRedirectToAuthURL( state='#session.surfer.getinfluencerAccountID()#' )#">Login and Authenticate</a>
<div class="">click me</div>

<!---<form action="/index.cfm?action=influencer:instagram.getFBID" role="form" method="post" enctype="multipart/form-data">
	<!---<input type="hidden" name="#variables.framework.action#" value="#getFullyQualifiedAction('instagramSetup:main.getFBID')#" />--->
	<input type="hidden" name="influenceraccountid" value="#rc.influencerAccount.getID()#" />
	<input type="hidden" id="instagramID" name="instagramID" value="" />
	<input type="hidden" id="instagramShortLivedAccessToken" name="instagramShortLivedAccessToken" value="" />
	
	<div id="instagram" class="form-group">
		<h4>Step 1</h4>
		<label for="instagramUserName">instagram Username</label>
		<input id="instagramUserName" class="form-control" type="text" size="20" name="instagramUserName" value="#rc.influencerAccount.getProfile().getinstagramUserName()#" />
		
		<label for="instagramBusinesspageLink">Business Link</label>
		<input id="instagramBusinesspageLink" class="form-control" type="text" size="80" name="instagramBusinesspageLink" value="#rc.influencerAccount.getProfile().getinstagramBusinesspageLink()#" />

		<h4>Step 2</h4>
		<div onclick="FBLogin();">Click here to retrieve/login to instagram Information</div>

		<h4>Step 3</h4>
		<button  class="btn btn-default" value="do login" type="submit" >Submit</button>
		
	</div>

</form>--->

</cfoutput>