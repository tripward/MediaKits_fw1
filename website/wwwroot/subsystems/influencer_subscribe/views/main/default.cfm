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
    
    <div class="row">
        <div class="col-md-6 centered">

	       <form action="#buildURL('influencer_subscribe:main.doSubscribe')#" role="form" method="post" enctype="multipart/form-data">
	
               <h1>Subscribe</h1>
	<!---<div>
		<label for="field">Username</label>
		<input id="firstname" type="text" name="username" value="#esapiEncode('html_attr', application.SU.decryptThis(rc.newAccount.getusername()))#" /> 
	</div>--->
	
	<div class="field">
		<input id="password" type="password" name="password" value="#esapiEncode('html_attr', rc.newAccount.getfirstname())#"  required pattern=".{1,}" /> 
		<label for="field">Password</label>
	</div>
	
	<div class="field">
		<input id="passwordconfirm" type="password" name="passwordconfirm" value="#esapiEncode('html_attr', rc.passwordconfirm)#"  required pattern=".{1,}" /> 
		<label for="field">Confirm Password</label>
	</div>
	
	<div class="field">
		<input id="firstname" type="text" name="firstname" value="#esapiEncode('html_attr', rc.newAccount.getfirstname())#"  required pattern=".{1,}" />
		<label for="field">First Name</label> 
	</div>
	
	<div class="field">
		<input id="lastname" type="text" name="lastname" value="#esapiEncode('html_attr', rc.newAccount.getlastname())#"  required pattern=".{1,}" /> 
		<label for="lastname">Last Name</label>
	</div>
	
	<div class="field">
		<input id="email" type="text" name="email" value="#esapiEncode('html_attr', rc.newAccount.getemail())#"  required pattern=".{1,}" /> 
		<label for="email">Email</label>
	</div>
	
	<div class="field">
		<input id="address1" type="text" name="address1" value="#esapiEncode('html_attr', rc.newAccount.getaddress1())#"  required pattern=".{1,}" /> 
		<label for="address1">Address 1</label>
	</div>
	
	<div class="field">
		<input id="address2" type="text" name="address2" value="#esapiEncode('html_attr', rc.newAccount.getaddress2())#" required pattern=".{1,}"  /> 
		<label for="address2">Address 2</label>
	</div>
	
	<div class="field">
		<input id="city" type="text" name="city" value="#esapiEncode('html_attr', rc.newAccount.getcity())#"  required pattern=".{1,}" /> 
		<label for="city">City</label>
	</div>
	
	<div class="field">
		<input id="state" type="text" name="state" value="#esapiEncode('html_attr', rc.newAccount.getstate())#" required pattern=".{1,}"  /> 
		<label for="state">State</label>
	</div>
	
	<div class="field">
		<input id="zipcode" type="text" name="zipcode" value="#esapiEncode('html_attr', rc.newAccount.getzipcode())#"  required pattern=".{1,}" /> 
		<label for="zipcode">Zip</label>
	</div>
	
	<div class="field">
		<select id="subscription" name="subscription">
			<option value="">Subscription Length</option>
			<cfloop array="#rc.availableSubscriptions#" index="local.sub">
				<option value="#local.sub.getSubscriptionid()#">#local.sub.getname()#</option>
			</cfloop>
			
		</select>
		<!---<option value="2">12 Months</option>
			<option value="3">24 Months</option>--->
	</div>
	<button class="right" type="submit" name="submit" value="submit">Submit</button>
</form>

        </div>
    </div>

</cfoutput>
