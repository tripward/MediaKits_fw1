component
displayname="influencerMainController"
extends="main"
accessors=true {

	property InfluencerPressLinksService;
	property InfluencerProfileService;
    
    public void function persistPressLink(required struct rc) {

		rc.PressLink = variables.InfluencerPressLinksService.new();
		
		variables.fw.populate(cfc=rc.PressLink);
		
		
		rc.validationMessages = rc.PressLink.validate();
		if (!structIsEmpty(rc.validationMessages)) {
			variables.fw.redirect(action='influencer:main.default', preserve='ALL');
			abort;
		} else {

			rc.PressLink.setInfluencerProfile(rc.influencerAccount.getProfile());
			rc.influencerAccount.getProfile().addPressLink(rc.PressLink);
			/*WriteDump(var=rc.award,top=2,label='goo', abort=false);
			WriteDump(var=rc.influencerAccount.getProfile(),top=4,label='goo', abort=true);*/
			
			variables.InfluencerPressLinksService.save(rc.PressLink);
			variables.InfluencerProfileService.save(rc.influencerAccount.getProfile());
			ormFlush();
			variables.fw.redirect(action='influencer:main.default', preserve='none');
			abort;
		}

	}

	
	
}
