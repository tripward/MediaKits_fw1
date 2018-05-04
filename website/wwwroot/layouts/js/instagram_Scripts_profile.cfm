<cfoutput><!---<code class="language-JS">--->
	<script>
		
		
		var token = '1103427d58604857acddc36d731f4a3e';
		
		$.ajax({
		  url: 'https://api.instagram.com/v1/users/self',
		  dataType: 'jsonp',
		  type: 'GET',
		  data: {
		    access_token: token
		  },
		  success: function(data) {
		    var follows = data['data']['counts']['followed_by'];
		    $("##instagram-followers").text(follows);
		    console.log(data);
		  },
		  error: function(data) {
		    console.log(data);
		  }
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

