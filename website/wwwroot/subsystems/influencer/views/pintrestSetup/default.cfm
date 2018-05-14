<cfsilent>
	<cfinclude template="/mediakits_env/providerData.properties.cfm" >
</cfsilent>

<cfoutput>
	
<h4>pintrest Connection Info</h4>
<div>pintrest Permissions Needed:</div>
<ul>
	<li>Email Address</li>
	<li>Follower Count</li>
</ul>
scope='read_public,read_relationships'

<cfscript>
rc.aScope = [
	'read_public',
	'read_relationships'	]
</cfscript>


<a href="#rc.pintrestConnection.buildRedirectToAuthURL(state='#session.surfer.getinfluencerAccountID()#',scope=rc.aScope)#">Login and Authenticate</a>

<!---<form action="/index.cfm?action=influencer:pintrestSetup.persistPintrestInfo" role="form" method="post" enctype="multipart/form-data">
	
	<div id="pintrest" class="form-group">
		<label for="pintrestUserName">pintrest Username</label>
		<input id="pintrestUserName" class="form-control" type="text" size="20" name="pintrestUserName" value="#rc.influencerAccount.getProfile().getpintrestUserName()#" />
		<button  class="btn btn-default" value="do login" type="submit" >Submit</button>
		
	</div>

</form>--->

</cfoutput>
	