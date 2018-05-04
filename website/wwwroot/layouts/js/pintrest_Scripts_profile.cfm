<cfinclude template="/mediakits/includes/themes/mediakits/templates/inc/pintrest_Scripts_common.cfm" />


<cfoutput>
	<script>
		function pintresttest(){
		
			$.ajax({
			  url: " https://api.pinterest.com/oauth/?response_type=code&redirect_uri=https://mywebsite.com/connect/pinterest/&client_id=4952900742051542490&scope=read_relationships,read_public&state=#session.influencerAccount.getID()#",
	
			}).done(function(data) {
			  console.log(data);
			  $("##twitter-followers").text(data[0]['followers_count']);
			});
		};
		
		
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
    

