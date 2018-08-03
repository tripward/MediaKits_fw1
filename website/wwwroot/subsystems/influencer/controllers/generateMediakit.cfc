/*

This file is part of mediakitsFunctions

Copyright 2010-2017 Stephen J. Withington, Jr.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0

*/
component displayname="generateMediaKitMainController" persistent="false" accessors="true" output="false" extends="main" {

	property name="beanFactory";
	property name='facebookService';
	property name='InstagramService';
	property name='pintrestService';
	property name='twitterService';

	// ********************************* PAGES *******************************************

	public void function before(required struct rc) {
		SUPER.before(rc);
		/*WriteDump(var=variables,top=2,label='goo', abort=true);*/
	}
	
	public void function default(required struct rc) {

		/*param rc.mediakitTemplate=1;*/
		param name="rc.mediakitTemplate" default="1";
		
		//todo:consider if we have the profile object, do we want to just create metod in profile that will return them as a list?
		rc.influencerDemos = variables.InfluencerProfileToDemographicsService.getProfileDemosAsList(rc.influencerAccount.getProfile().getinfluencerProfileid());
		rc.influencerCats = variables.InfluencerProfileToCategoriesService.getProfileCatsAsList(rc.influencerAccount.getProfile().getinfluencerProfileid());
		/*WriteDump(var=rc.influencerAccount.getProfile(),top=5,label='goo', abort=true);*/
		rc.socialStats = variables.InfluencerStatsService.getAllStats(rc.influencerAccount);
		/*WriteDump(var=rc.socialStats,top=5,label='goo', abort=true);*/
		
/*WriteDump(var=getServiceFactory().getBeanInfo(),top=10,label='goo', abort=false);*/
/*WriteDump(var=variables.getDefaultBeanFactory(),top=2,label='goo', abort=false);*/
/*WriteDump(var=getBeanFactory().getBeanInfo(),top=10,label='goo', abort=true);*/
			/*rc.influencerAccount = getBean('InfluencerAccount').loadBy(influenceraccountid=rc.influenceraccountid);
			rc.socialMediaStats = variables.getInfluencerStatsServices().getAllStats(rc.influencerAccount.getProfile());
			rc.demographics = variables.getDemographicsServices().getOptionList();
			rc.categories = variables.getCategoryServices().getOptionList();*/
		
		
	}

	
}
