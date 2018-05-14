<cfoutput>
	<script>
		
		var twitter_username = '#rc.influencerAccount.getProfile().getTwitterUserName()#';
	
		$.ajax({
		  url: "https://cdn.syndication.twimg.com/widgets/followbutton/info.json?screen_names=" + twitter_username,
		  dataType: 'json',
		  crossDomain: true
		}).done(function(data) {
		  console.log(data);
		  $("##twitter-followers").text(data[0]['followers_count']);
		});
		
	</script>
</cfoutput>

<!---<cfoutput>
	<script>
		
		var twitter_username = '#session.influencerAccount.getProfile().gettwitterUserName()#';
	
		$.ajax({
		  url: "https://cdn.syndication.twimg.com/widgets/followbutton/info.json?screen_names=" + twitter_username,
		  dataType: 'jsonp',
		  crossDomain: true
		}).done(function(data) {
		  $("##twitter-followers").text(data[0]['followers_count']);
		});
		
	</script>
</cfoutput>--->

