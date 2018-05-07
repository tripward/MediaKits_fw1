<cfsilent>

</cfsilent>

<cfoutput>

<cfinclude template="/layouts/messages.cfm" >

<div class="row">
	<div class="col-md-6">
		<h4>login</h4>
		<!---<form role="form" method="post">--->
		<form action="#buildURL('influencer_login:main.doLogin')#" role="form" method="post" enctype="multipart/form-data">
			<div class="form-group">
				<label for="Username">Username</label>
				<input id="username" class="form-control" type="text" name="username" value="" />
			</div>
			<div class="form-group">
				<label for="password">password</label>
				<input id="password" class="form-control" type="text" name="password" value="" />
			</div>
			
			<button type="submit" class="btn btn-default" value="Save Registration">Submit</button>
		</form>
	</div>
</div>


</cfoutput>
