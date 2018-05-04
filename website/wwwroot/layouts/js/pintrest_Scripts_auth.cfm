<cfinclude template="/mediakits/includes/themes/mediakits/templates/inc/pintrest_Scripts_common.cfm" />


<script>
  function login() {  
//login
PDK.login({ scope : 'read_relationships,read_public,write_public' }, function(response){
if (!response || response.error) {
//  alert('Error occurred');
                } else {
PDK.request('/v1/me/', function (result) {
if (!result || result.error) {
//alert('Error occurred');
              } else {
     var text = result.data.first_name;
     var value = PDK.getSession().accessToken;
     var additionalData = result.data.id

     //Create the option
     var option = new Option(text, value);
     pages.add(option);

     //create the data-id attribute, add it to the option
     var attribute = document.createAttribute("data-id");
     option.setAttributeNode(attribute);

     //Assign the respective data to the data-id attribute
     option.dataset['id'] = additionalData;

//PDK.logout();
}});
}

});
};
		
</script>

