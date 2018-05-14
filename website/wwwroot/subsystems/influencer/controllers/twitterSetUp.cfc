<cfcomponent displayname="twitterSetUpMainController" persistent="false" accessors="true" output="false" extends="main">

		<cfproperty name="beanFactory">
		<cfproperty name="twitterSetUpService">
		<cfproperty name="InfluencerProfileService">
		<cfproperty name="provider" default="twitter">

	// ********************************* PAGES *******************************************
	<cfscript>
	
		public void function before(required struct rc) {
			SUPER.before(rc);
		}
		
		public void function default(required struct rc) {
			
		}
		
		public any function getGeneralInfoFeed(required any profile) {

			var twitterStats = {};
			twitterstats.followers = 5;
			/*WriteDump(var=arguments.Profile,top=2,label='goo', abort=true);*//*#arguments.Profile.gettwitterUserName()#*/
			cfhttp(url="https://cdn.syndication.twimg.com/widgets/followbutton/info.json?screen_names=#arguments.Profile.gettwitterUserName()#" ,result="local.callResponse");
			/*WriteDump(var=local.callResponse,top=2,label='goo', abort=true);*/
			return local.callResponse;
		}
	
	</cfscript>
	
	<cffunction name="persistTwitterInfo" >
		
			<cfparam name="rc.errors" default="#arrayNew(1)#" >
			
			<cfif !len(trim(rc.twitterUserName))>
				<cfset arrayAppend(rc.errors,'please fill in username') />
			</cfif>
			
			<cfset rc.influencerAccount.getProfile().setTwitterUsername(rc.twitterUserName) />
			<cfscript>

				// save profile
					variables.InfluencerProfileService.save(rc.influencerAccount.getProfile());
					ormFlush();
					
					variables.fw.redirect(action='influencer:main.default', preserve='all');

			</cfscript>

	</cffunction>

</cfcomponent>