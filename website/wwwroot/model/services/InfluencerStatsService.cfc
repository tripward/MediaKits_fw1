/*

This file is part of mediakitsFunctions

Copyright 2010-2017 Stephen J. Withington, Jr.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0

*//* extends="plugins.mediakitsFunctions.influencer.model.services.baseInfluencerService"*/
component displayname="InfluencerStatsService" persistent="false" extends="baseService" accessors="true" output="false" {
	
	property name="beanFactory"; // use if you need access to the beanFactory
	property name='facebookService';
	property name='InstagramService';
	property name='pintrestService';
	property name='twitterService';
	
	public any function init() {
		SUPER.init();

		setfacebookService(variables.factory.getBean('facebookService'));
		setInstagramService(variables.factory.getBean('InstagramService'));
		setpintrestService(variables.factory.getBean('pintrestService'));
		settwitterService(variables.factory.getBean('twitterService'));

		return this;
	}
	
	public struct function getAllStats(required any account) {
		/*WriteDump(var=variables,top=2,label='goo', abort=true);*/

		local.socialMediaStats = {};
		
		if (len(trim(arguments.account.getProfile().getinstagramUserName()))){
			local.socialMediaStats.instagram.stats = variables.InstagramService.getStats(arguments.account);
		}
		
		if (len(trim(arguments.account.getProfile().getFacebookUsername()))){
			local.socialMediaStats.facebook.stats = variables.facebookService.getStats(arguments.account);
			
		}
		
		if (len(trim(arguments.account.getProfile().getPintrestUserName()))){
			local.socialMediaStats.pintrest.stats = variables.pintrestService.getStats(arguments.account);
		}
		
		if (len(trim(arguments.account.getProfile().getTwitterUserName()))){
			local.socialMediaStats.twitter.stats = variables.twitterService.getStats(arguments.account);
		}

		return local.socialMediaStats;
	}

	
}
