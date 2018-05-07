component displayname="influencerLoginMainController" extends="subsystems.basecontroller" accessors=true {

	property SecurityService;
	property InfluencerAccountService;
	
	public void function default(required struct rc) {
		
	}
	
	public void function doLogin(required struct rc) {

			if (!len(trim(rc.username))) {
				structInsert(rc.errors,'username','Username is required');
			}
			
			if (!len(trim(rc.password))) {
				structInsert(rc.errors,'password','password is required');
			}
			
			rc.securedPassword = variables.SecurityService.securePassword(rc.password);
			
			if (!structIsEmpty(rc.errors)) {
				variables.fw.redirect(action='influencer_login:main.default', preserve='all');
				abort;
			}
			
			else {
				
					local.influencerAccountQry = variables.InfluencerAccountService.getByLoginCreds(username=rc.username,password=rc.securedPassword);

					if (!local.influencerAccountQry.RecordCount) {
						structInsert(rc.errors,'noaccount','No Account Exists with that username/email address and password');
						variables.fw.redirect(action='influencer_login:main.default', preserve='all');
						abort;
					} else {
						
						lock name="lockName" timeout="3" {
							session.surfer.setSurferid(createUUID());
							session.surfer.setIsLoggedIn(1);
							session.surfer.setinfluencerAccountID(local.influencerAccountQry.influencerAccountID);
						} /* end lock*/
						
						structDelete(rc,'password');
						structDelete(rc,'securedPassword');

						variables.fw.redirect(action='influencer:main.default', preserve='ALL', queryString='influenceraccountid=#local.influencerAccountQry.influencerAccountID#');
						
						abort;
					}	
				
				
			} /* end error IF*/	
			
			
	}
	
	
}
