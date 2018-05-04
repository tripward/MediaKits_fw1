
<cfoutput>
	<script>

		console.log(' Fetching FB information...for #session.influencerAccount.getProfile().getFacebookUserID()#. ');
		var userAccessToken = '#session.influencerAccount.getProfile().getfacebookLongLivedAccessToken()#';
		console.log(userAccessToken);
		FB.api('/#session.influencerAccount.getProfile().getfacebookID()#/friends', 'GET', {fields : 'link', access_token : userAccessToken}, function(response) {
			console.log('in second call');
			console.log(response);
			console.log(response.summary.total_count);
			document.getElementById("fbFriendCount").innerHTML=response.summary.total_count;
		});
			
	</script>
	
	<cfinclude template="/mediakits/includes/themes/mediakits/templates/inc/facebooks_Scripts_common.cfm" />
	
</cfoutput>

<!--- Dont judge me, below are a number of iterations all basically the same just retreiving different data points --->

<!--- console.log('Welcome  in profile first call!  Fetching your information...for #session.influencerAccount.getProfile().getFacebookID()#. ');
var userAccessToken = '#session.influencerAccount.getProfile().getfacebookLongLivedAccessToken()#';
console.log(userAccessToken);
FB.api('/me/friends', 'GET', { access_token : userAccessToken}, function(response) {
	console.log(response);
	console.log(response.summary.total_count);
	document.getElementById("fbFriendCount").innerHTML=response.summary.total_count;
}); --->
			
<!--- console.log('in me call!  Fetching your information...for #session.influencerAccount.getProfile().getFacebookID()#. ');
var userAccessToken2 = '#session.influencerAccount.getProfile().getfacebookLongLivedAccessToken()#';
console.log(userAccessToken2);
FB.api('/me', 'GET', {fields : 'link, name, email', access_token : userAccessToken2}, function(response) {
	console.log('in third call');
	console.log(response);
	console.log(response.summary.total_count);
	document.getElementById("fbFriendCount").innerHTML=response.summary.total_count;
}); --->


<!--- console.log('using user ID #session.influencerAccount.getProfile().getFacebookID()#. ');
var userid = '#session.influencerAccount.getProfile().getfacebookID()#';
console.log(userid);
FB.api("/#session.influencerAccount.getProfile().getfacebookID()#/friends", 'GET', { fields : 'link, name, email', access_token : userAccessToken },
	function (response) {
		console.log('in id based call');
		console.log(response);
	}); --->