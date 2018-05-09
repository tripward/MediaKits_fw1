<cfsilent>
	<cfscript>
	</cfscript>
</cfsilent>

<cfoutput>
	
<h4>Facebook Connection Info</h4>
<div>Facebook Permissions Needed:</div>
<ul>
	<li>Email Address</li>
	<li>Total Friend Count</li>
	<li>Facebook business Page URL</li>
</ul>

<form action="/index.cfm?action=influencer:facebook.getFBID" role="form" method="post" enctype="multipart/form-data">
	<!---<input type="hidden" name="#variables.framework.action#" value="#getFullyQualifiedAction('FacebookSetup:main.getFBID')#" />--->
	<input type="hidden" name="influenceraccountid" value="#rc.influencerAccount.getID()#" />
	<input type="hidden" id="FacebookID" name="FacebookID" value="" />
	<input type="hidden" id="facebookShortLivedAccessToken" name="facebookShortLivedAccessToken" value="" />
	
	<div id="facebook" class="form-group">
		<h4>Step 1</h4>
		<label for="facebookUserName">Facebook Username</label>
		<input id="facebookUserName" class="form-control" type="text" size="20" name="facebookUserName" value="#rc.influencerAccount.getProfile().getfacebookUserName()#" />
		
		<label for="facebookBusinesspageLink">Business Link</label>
		<input id="facebookBusinesspageLink" class="form-control" type="text" size="80" name="facebookBusinesspageLink" value="#rc.influencerAccount.getProfile().getfacebookBusinesspageLink()#" />

		<h4>Step 2</h4>
		<div onclick="FBLogin();">Click here to retrieve/login to Facebook Information</div>

		<h4>Step 3</h4>
		<button  class="btn btn-default" value="do login" type="submit" >Submit</button>
		
	</div>

</form>

</cfoutput>