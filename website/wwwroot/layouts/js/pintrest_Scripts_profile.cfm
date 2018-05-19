<cfinclude template="pintrest_Scripts_common.cfm" />

https://api.pinterest.com/v1/users/ward5593/?access_token=#local.deserializedResponse.access_token#&client_secret=#variables.providerInfo[variables.provider].clientSecret#&fields=bio%2Ccounts%2Cusername';

https://api.pinterest.com/v1/users/#rc.influencerAccount.getProfile().getPintrestUserName()#/?access_token=#rc.influencerAccount.getProfile().getpintrestLongLivedAccessToken()#&client_secret=#variables.providerInfo['pintrest'].clientSecret#&fields=bio%2Ccounts%2Cusername';

https://api.pinterest.com/v1/users/ward5593/?access_token=AbnWZ7zVzcYRIAJYin_Jwv1uL8kDFTAXrdLvVyJE7Zo0_YA0GgAAAAA
<cfoutput>
	<script>
		/*function pintresttest(){*/
		
			$.ajax({
			  url: "https://api.pinterest.com/v1/users/ward5593/?access_token=AbnWZ7zVzcYRIAJYin_Jwv1uL8kDFTAXrdLvVyJE7Zo0_YA0GgAAAAA&fields=counts",
	
			}).done(function(data) {
			  console.log(data);
			  /*console.log(data['data']['counts']['pins']);*/
			  /*console.log(data[0]);
			  console.log(data.counts);*/
			  
			  
			  $("##pintrestPinsCount").text(data['data']['counts']['pins']);
			  $("##pintrestFollowingCount").text(data['data']['counts']['following']);
			  $("##pintrestFollowersCount").text(data['data']['counts']['followers']);
			  $("##pintrestBoardsCount").text(data['data']['counts']['boards']);
			});
		/*};*/
		
		
	</script>
</cfoutput>

<!---https://api.pinterest.com/oauth/?
    response_type=code&
    redirect_uri=https://mywebsite.com/connect/pinterest/&
    client_id=12345&
    scope=read_public,write_public&
    state=768uyFys
    
    https://api.pinterest.com/oauth/?response_type=code&redirect_uri=https://mywebsite.com/connect/pinterest/&client_id=4952900742051542490&scope=read_relationships,read_public&state=#rc.influencerAccount.getID()#
    
    --->
    

