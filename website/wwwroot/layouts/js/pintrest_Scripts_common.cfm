<!---<cfdump var="#session.influenceraccount.getID()#" label="cgi" abort="true" top="3" />--->

<cfoutput>

	<script>
		  window.pAsyncInit = function() {
        PDK.init({
            appId: "4952900742051542490",
            cookie: false
        });
    };

(function(d, s, id){
    var js, pjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) {return;}
    js = d.createElement(s); js.id = id;
    js.src = "//assets.pinterest.com/sdk/sdk.js";
    pjs.parentNode.insertBefore(js, pjs);
}(document, 'script', 'pinterest-jssdk'));
	</script>
	

</cfoutput>