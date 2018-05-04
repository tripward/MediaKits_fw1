component accessors=true {
    property greetingService;
    property InfluencerSubscriptionService;
    property InfluencerAccountService;
    property greetingService;
    
    public void function default(required struct rc) {
		param name="rc.name" default="anonymous";
        rc.name = variables.greetingService.greet( rc.name );
	}
    
    public void function subscribeForm(required struct rc) {
		
		
		param name="rc.passwordconfirm" default="";
				
		rc.availableSubscriptions = variables.InfluencerSubscriptionService.list();
		rc.newInfluencerAccount = variables.influencerAccountService.new();
		
	}
	
}
