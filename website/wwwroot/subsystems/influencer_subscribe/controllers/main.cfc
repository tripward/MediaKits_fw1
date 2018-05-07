component displayname="influencerSubscribeMainController" extends="subsystems.basecontroller" accessors=true {
    
    property greetingService;
    property beanFactory;
    property InfluencerSubscriptionService;
    property InfluencerAccountService;
    property SecurityService;
    property InfluencerSubscriptionToAccountService;
    property InfluencerProfileService;
    property paymentGatewayService;
    
    public function init(fw) {
        variables.fw = fw;
        rc.errors = {};
    }
    
    /*public void function default(required struct rc) {
		param name="rc.name" default="anonymous";
        rc.name = variables.greetingService.greet( rc.name );
	}*/
	
	public void function before(required struct rc) {
		SUPER.before(arguments.rc);

	}
    
    public void function default(required struct rc) {
		
		
		param name="rc.passwordconfirm" default="";
		
		
		if (!structKeyExists(rc,'newAccount')) {
			rc.newAccount = variables.influencerAccountService.new();
		}
		
		rc.availableSubscriptions = variables.InfluencerSubscriptionService.list();
		
	}
	
	public void function doSubscribe(required struct rc) {
		
		
		//validation
		if (variables.InfluencerAccountService.doesAccountExist(rc.email)) {
			structInsert(rc.validationMessages,'accountExists','Account Already Exists');
		}
		if (!variables.SecurityService.isPasswordComplex(rc.password)) {
			structInsert(rc.validationMessages,'passwordComplexity','Password Complexity');
		}
		/*i think i should should add this to the validate function however because it is a dependancy one is always created, need to think through that*/
		if (!len(rc.subscription)) {
			structInsert(rc.validationMessages,'subscription','Subscription is required.');            
		}
			
		//somewhat of a place holder to pass the info to payment gate way
		rc.paymentInfo = variables.paymentGatewayService.setUpPayment(rc);
		
		
		//if the payment went through we can create the account
		if (rc.paymentInfo.isSuccess) {
	
			/* this was a try to see if i can pass in a struct and if it will populate it */
			rc.newSubInfo = {};
			rc.newSubInfo.password = rc.password;
			rc.newSubInfo.email = rc.email;
			rc.newSubInfo.username = rc.email;
			rc.newSubInfo.firstname = rc.firstname;
			rc.newSubInfo.lastname = rc.lastname;
			rc.newSubInfo.address1 = rc.address1;
			rc.newSubInfo.address2 = rc.address2;
			rc.newSubInfo.city = rc.state;
			rc.newSubInfo.state = rc.state;
			rc.newSubInfo.zipcode = rc.zipcode;

			/* create the new account bean and populate it with what we have so we can prefill the form if there are validation isses*/
			rc.newAccount = variables.InfluencerAccountService.new();
			variables.fw.populate(cfc=rc.newAccount, keys='#structKeyList(rc.newSubInfo)#');

			/*run a quick validation to see if we can create the account */
			structAppend(rc.validationMessages, rc.newAccount.validate());

			/*if we have validation issues, go back to the sub form*/
			if (!structIsEmpty(rc.validationMessages) OR !structIsEmpty(rc.errors)) {
				variables.fw.redirect(action='influencer_subscribe:main.default', preserve='all');
				abort;
			}

			//set up the subscription
			rc.selectedSubscription = variables.InfluencerSubscriptionService.get(rc.subscription);
			/*WriteDump(var=rc.selectedSubscription,top=2,label='goo', abort=true);*/
			rc.mynewSubAcct = variables.InfluencerSubscriptionToAccountService.new();
			rc.mynewSubAcct.setAccount(rc.newAccount);
			rc.mynewSubAcct.setsubscription(rc.selectedSubscription);
			rc.newAccount.addInfluencerSubscriptionToAccounts(rc.mynewSubAcct);
			//save subscription
			variables.InfluencerSubscriptionToAccountService.save(rc.mynewSubAcct);

			//go get new profile
			rc.newInfluencerProfile = variables.InfluencerProfileService.new();
			rc.newInfluencerProfile.setInfluencerAccount(rc.newAccount);
			rc.newAccount.setprofile(rc.newInfluencerProfile);
			//save profile
			variables.InfluencerProfileService.save(rc.newInfluencerProfile);
			
			//save account
			variables.InfluencerAccountService.save(rc.newAccount);
			
			//write everything to db
			ormFlush();
			/*WriteDump(var=rc.newAccount.getProfile(),top=2,label='fsdvdv', abort=true);*/
			
			//populate surfer so we can send them right over to profile
			lock name="lockName" timeout="3" {
				local.surferPropQry = variables.InfluencerAccountService.getSurferProperties(rc.newAccount.getEmail());
				session.surfer.setfirstName(local.surferPropQry.firstName);
				session.surfer.setlastName(local.surferPropQry.lastName);
				session.surfer.setuserName(local.surferPropQry.email);
				session.surfer.setinfluencerAccountID(local.surferPropQry.influencerAccountID);
				session.surfer.setsurferid(createUUID());
				session.surfer.setisLoggedIn(1);
			}
			
			//send to profile
			variables.fw.redirect(action='influencer:main.default', preserve='all');
			
		}
		else {
			WriteOutput("payment Failed");abort;
		}

	}
	
}
