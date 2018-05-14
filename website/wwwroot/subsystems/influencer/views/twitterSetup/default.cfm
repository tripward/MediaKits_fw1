<cfsilent>
	<cfinclude template="/mediakits_env/providerData.properties.cfm" >
</cfsilent>

<cfoutput>
	
<h4>twitter Connection Info</h4>
<div>twitter Permissions Needed:</div>
<ul>
	<li>Email Address</li>
	<li>Follower Count</li>
</ul>

, scope=rc.aScope 
<!---<a href="#rc.facebookConnection.buildRedirectToAuthURL(  )#">Login and Authenticate</a>--->


<form action="/index.cfm?action=influencer:twitterSetup.persistTwitterInfo" role="form" method="post" enctype="multipart/form-data">
	<input type="hidden" name="influenceraccountid" value="#rc.influencerAccount.getID()#" />
	
	<div id="twitter" class="form-group">
		<label for="twitterUserName">twitter Username</label>
		<input id="twitterUserName" class="form-control" type="text" size="20" name="twitterUserName" value="#rc.influencerAccount.getProfile().gettwitterUserName()#" />
		<button  class="btn btn-default" value="do login" type="submit" >Submit</button>
		
	</div>

</form>

</cfoutput>
	