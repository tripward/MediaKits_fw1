component
displayname="influencerMainController"
extends="main"
accessors=true {

	property InfluencerAwardsService;
	property InfluencerProfileService;
    
    public void function persistAward(required struct rc) {

		rc.award = variables.InfluencerAwardsService.new();
		
		variables.fw.populate(cfc=rc.award);
		
		
		rc.validationMessages = rc.award.validate();
		if (!structIsEmpty(rc.validationMessages)) {
			variables.fw.redirect(action='influencer:main.default', preserve='ALL');
			abort;
		} else {

			rc.award.setInfluencerProfile(rc.influencerAccount.getProfile());
			rc.influencerAccount.getProfile().addAward(rc.award);
			/*WriteDump(var=rc.award,top=2,label='goo', abort=false);
			WriteDump(var=rc.influencerAccount.getProfile(),top=4,label='goo', abort=true);*/
			
			variables.InfluencerAwardsService.save(rc.award);
			variables.InfluencerProfileService.save(rc.influencerAccount.getProfile());
			ormFlush();
			variables.fw.redirect(action='influencer:main.default', preserve='none');
			abort;
		}

	}

	
	
}
