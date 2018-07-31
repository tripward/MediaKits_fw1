<cfsilent>

</cfsilent>


<cfoutput>

<cfinclude template="/layouts/messages.cfm" >

<div class="row">
	<div class="col-md-6 centered">
		<!---<form role="form" method="post">--->
        <div id="login-form" class="pane">
		      <form action="#buildURL('influencer_login:main.doLogin')#" role="form" method="post" enctype="multipart/form-data">
            
		    <h1>Login</h1>
			<div class="field">
				<input id="username" type="text" required pattern=".{1,}" name="username" value="" />
				<label for="username">Username</label>
			</div>
			<div class="field">
				<input id="password" type="password" required pattern=".{1,}" name="password" value="" />
				<label for="password">Password</label>
			</div>
			
			<button type="submit" class="right" value="Save Registration">Submit</button>
		</form>
        </div>
	</div>
</div>


</cfoutput>
