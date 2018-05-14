<cfcomponent displayname="pintrestSetUpMainController" persistent="false" accessors="true" output="false" extends="main">

		<cfproperty name="beanFactory">
		<cfproperty name="pintrestSetUpService">
		<cfproperty name="InfluencerProfileService">
		<cfproperty name="provider" default="pintrest">

	// ********************************* PAGES *******************************************
	<cfscript>
	
		public void function before(required struct rc) {
			SUPER.before(rc);
		}
		
		public void function default(required struct rc) {
			
		}
		
	</cfscript>
	
	<cffunction name="persistpintrestInfo" >
		
			<cfparam name="rc.errors" default="#arrayNew(1)#" >
			
			<cfif !len(trim(rc.pintrestUserName))>
				<cfset arrayAppend(rc.errors,'please fill in username') />
			</cfif>
			
			<cfset rc.influencerAccount.getProfile().setpintrestUsername(rc.pintrestUserName) />
			<cfscript>

				// save profile
					variables.InfluencerProfileService.save(rc.influencerAccount.getProfile());
					ormFlush();
					
					variables.fw.redirect(action='influencer:main.default', preserve='all');

			</cfscript>

	</cffunction>

</cfcomponent>