component
displayname="influencerMainController"
extends="main"
accessors=true {

	property InfluencerConferenceService;
	property InfluencerProfileService;
    
    public void function persistConference(required struct rc) {

		rc.Conference = variables.InfluencerConferenceService.new();
		
		variables.fw.populate(cfc=rc.Conference);
		
		
		rc.validationMessages = rc.Conference.validate();
		if (!structIsEmpty(rc.validationMessages)) {
			variables.fw.redirect(action='influencer:main.default', preserve='ALL');
			abort;
		} else {

			rc.Conference.setInfluencerProfile(rc.influencerAccount.getProfile());
			rc.influencerAccount.getProfile().addConference(rc.Conference);
			/*WriteDump(var=rc.award,top=2,label='goo', abort=false);
			WriteDump(var=rc.influencerAccount.getProfile(),top=4,label='goo', abort=true);*/
			
			variables.InfluencerConferenceService.save(rc.Conference);
			variables.InfluencerProfileService.save(rc.influencerAccount.getProfile());
			ormFlush();
			variables.fw.redirect(action='influencer:main.default', preserve='none');
			abort;
		}

	}

	
	
}
