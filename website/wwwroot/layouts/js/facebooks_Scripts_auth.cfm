<!---<cfinclude template="/layouts/js/facebooks_Scripts_common.cfm" />--->

<cfoutput>
	<script>
	
	  function statusChangeCallback(response) {
	    console.log('statusChangeCallback');
	    console.log(response);
	    if (response.status === 'connected') {
	    	/*alert(response.authResponse.accessToken);*/
	    	$("##facebookShortLivedAccessToken").val(response.authResponse.accessToken);
	    	$("##FacebookID").val(response.authResponse.userID);
	    	
	    } else if (response.status === 'not_authorized') {
	      FB.login(function(response) {
	        statusChangeCallback2(response);
	      }, {scope: 'public_profile,email'});
	
	    } else {
	      /*alert("not connected, not logged into facebook, we don't know");*/
	      console.log('person not logged into fb at the moment');
	    }
	  }
	
	  function checkLoginState() {
	    FB.getLoginStatus(function(response) {
	      statusChangeCallback(response);
	    });
	  }
	  
	  function FBLogin()
			{
		      FB.login(function(response) {
		         if (response.authResponse) 
		         {
		             getUserInfo(); //Get User Information.
		          } else
		          {
		           alert('Authorization failed.');
		          }
		       },{scope: 'public_profile,email',return_scopes: true});
		}
		
		function getUserInfo() {
		    FB.api('/me', function(response) {
		      /*$("##fbid").val(response.id);*/
		      
	      	checkLoginState();
			    
		    });
		    
		    
		}
		
	
	  
	  
	  /*$(document).ready(function() {
	    FB.init({
	      appId      : '2017613635228214',
	      xfbml      : true,
	      version    : 'v2.12'
	    });
	    checkLoginState();
	  });*/
	
	</script>
	
	<cfinclude template="/layouts/js/facebooks_Scripts_common.cfm" />
	

</cfoutput>