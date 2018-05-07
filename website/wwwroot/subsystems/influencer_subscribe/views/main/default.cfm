<cfsilent>

	<cfscript>
		//request.layout = false;

		
	</cfscript>
</cfsilent>
<!---<cfdump var="#rc.newAccount#" label="cgi" abort="true" top="3" />--->
<cfoutput>
	<!---<div class="row">
		<div class="col-md-6">
			<h4>Add Registration</h4>
			<form role="form" method="post">
				<div class="form-group">
					<label for="fname">First Name</label>
					<input type="text" class="form-control" name="fname" value="#esapiEncode('html_attr', rc.newAccount.getFName())#" />
				</div>
				<div class="form-group">
					<label for="lname">Last Name</label>
					<input type="text" class="form-control" name="lname" value="#esapiEncode('html_attr', rc.newAccount.getLName())#" />
				</div>
				<input type="hidden" name="#variables.framework.action#" value="#getFullyQualifiedAction('app3:main.save')#" />
				<input type="hidden" name="id" value="#rc.newAccount.getID()#" />
				<button type="submit" class="btn btn-default" value="Save Registration">Submit</button>
			</form>
		</div>
	</div>--->
	<!---<cfset objectParams.render = "client" />--->
<!---<cfparam name="objectparams._p" default="1" >

<cfset objectParams.async = "false"/>--->
<cfinclude template="/layouts/messages.cfm" >

	<form action="#buildURL('influencer_subscribe:main.doSubscribe')#" role="form" method="post" enctype="multipart/form-data">
	
	<!---<div>
		<label for=”field”>Username</label>
		<input id=”firstname” type="text" name="username" value="#esapiEncode('html_attr', application.SU.decryptThis(rc.newAccount.getusername()))#" /> 
	</div>--->
	
	<div>
		<label for=”field”>Password</label>
		<input id=”password” type="password" name="password" value="#esapiEncode('html_attr', rc.newAccount.getfirstname())#" /> 
	</div>
	
	<div>
		<label for=”field”>Confirm Password</label>
		<input id=”passwordconfirm” type="password" name="passwordconfirm" value="#esapiEncode('html_attr', rc.passwordconfirm)#" /> 
	</div>
	
	<div>
		<label for=”field”>First Name</label>
		<input id=”firstname” type="text" name="firstname" value="#esapiEncode('html_attr', rc.newAccount.getfirstname())#" /> 
	</div>
	
	<div>
		<label for=”lastname”>Last Name</label>
		<input id=”lastname” type="text" name="lastname" value="#esapiEncode('html_attr', rc.newAccount.getlastname())#" /> 
	</div>
	
	<div>
		<label for=”email”>Email</label>
		<input id=”email” type="text" name="email" value="#esapiEncode('html_attr', rc.newAccount.getemail())#" /> 
	</div>
	
	<div>
		<label for=”address1”>Address 1</label>
		<input id=”address1” type="text" name="address1" value="#esapiEncode('html_attr', rc.newAccount.getaddress1())#" /> 
	</div>
	
	<div>
		<label for=”address2”>Address 2</label>
		<input id=”address2” type="text" name="address2" value="#esapiEncode('html_attr', rc.newAccount.getaddress2())#" /> 
	</div>
	
	<div>
		<label for=”city”>City</label>
		<input id=”city” type="text" name="city" value="#esapiEncode('html_attr', rc.newAccount.getcity())#" /> 
	</div>
	
	<div>
		<label for=”state”>State</label>
		<input id=”state” type="text" name="state" value="#esapiEncode('html_attr', rc.newAccount.getstate())#" /> 
	</div>
	
	<div>
		<label for=”zipcode”>Zip</label>
		<input id=”zipcode” type="text" name="zipcode" value="#esapiEncode('html_attr', rc.newAccount.getzipcode())#" /> 
	</div>
	
	<div>
		<label for=”subscription”>Subscription</label>
		<select id="subscription" name="subscription">
			<option value="">Subscription Length</option>
			<cfloop array="#rc.availableSubscriptions#" index="local.sub">
				<option value="#local.sub.getSubscriptionid()#">#local.sub.getname()#</option>
			</cfloop>
			
		</select>
		<!---<option value="2">12 Months</option>
			<option value="3">24 Months</option>--->
	</div>
	<input type="submit" name="submit" value="submit" />
</form>



</cfoutput>
