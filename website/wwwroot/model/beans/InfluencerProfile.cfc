component
	extends="baseBean"
	table="influencerProfiles"
	entityname="influencerProfile"
	displayname="influencerProfile"
	accessors="true"
	persistent="true" {

	// primary key
	property name="influencerProfileid" fieldtype="id" type="uuid" ormType='string' generator="uuid";

	// influencerProfile attributes		
	property name="keywords" datatype="varchar" length="255" default="";
	property name="description" datatype="varchar" length="1000" default="";
	
	property name="lastStatUdate" datatype="datetime";
	
	property name="twitterUserName" datatype="varchar" length="50" default="";
	property name="twitterPassword" datatype="varchar" length="50" default="";
	property name="twitterResponse" datatype="varchar" length="3000" default="";
	property name="twitterResponseDate" datatype="dateTime";
	property name="twitterFollowedByCount" type="numeric" datatype="numeric" length="10" default="0";
	property name="twitterFollowingCount" type="numeric" datatype="numeric" length="10" default="0";
	property name="twitterLastUpdate" datatype="dateTime";

	property name="instagramUserid" datatype="varchar" length="50" default="";
	property name="instagramUserName" datatype="varchar" length="50" default="";
	property name="instagramprofile_picture" datatype="varchar" length="250" default="";
	property name="instagramResponse" datatype="varchar" length="3000" default="";
	property name="instagramAccessToken" datatype="varchar" length="1000" default="";
	property name="instagramAccessTokenSetUpdate" datatype="dateTime" ;
	property name="instagrammedia" type="numeric" datatype="numeric" length="10" default="0";
	property name="instagramfollows" type="numeric" datatype="numeric" length="10" default="0";
	property name="instagramfollowed_by" type="numeric" datatype="numeric" length="10" default="0";
	property name="instagramLastUpdate" datatype="dateTime" ;
	
	property name="FacebookID" datatype="varchar" length="50" default="";
	property name="FacebookUsername" datatype="varchar" length="50" default="";
	property name="facebookPassword" datatype="varchar" length="50" default="";
	property name="facebookShortLivedAccessToken" datatype="varchar" length="1000" default="";
	property name="facebookShortLivedAccessTokenSetDate" datatype="DATETIME" ;
	property name="facebookLongLivedAccessToken" datatype="varchar" length="1000" default="";
	property name="facebookLongLivedAccessTokenType" datatype="varchar" length="1000" default="";
	property name="facebookResponse" datatype="varchar" length="3000" default="";
	property name="facebookLongLivedAccessTokenExpiresIn" datatype="varchar" length="50" default="";
	property name="facebookLongLivedAccessTokenSetDate" datatype="dateTime" ;
	property name="facebookFriendsCount" type="numeric" datatype="numeric" length="10" default="0";
	property name="facebookBusinesspageLink" datatype="varchar" length="255" default="";
	property name="facebookStatsLastUpdate" datatype="dateTime" ;
	
	property name="pintrestUserName" datatype="varchar" length="50" default="";
	property name="pintrestPassword" datatype="varchar" length="50" default="";
	property name="pintrestid" datatype="varchar" length="50" default="";
	property name="pintrestLongLivedAccessToken" datatype="varchar" length="1000" default="";
	property name="pintrestLongLivedAccessTokenType" datatype="varchar" length="1000" default="";
	property name="pintrestLongLivedAccessTokenSetDate" datatype="dateTime" ;
	property name="pintrestUserURL" datatype="varchar" length="1000" default="";
	property name="PintrestResponse" datatype="varchar" length="3000" default="";
	property name="pintrestPinsCount" type="numeric" datatype="numeric" length="10" default="0";
	property name="pintrestfollowingCount" type="numeric" datatype="numeric" length="10" default="0";
	property name="pintrestfollowersCount" type="numeric" datatype="numeric" length="10" default="0";
	property name="pintrestboardsCount" type="numeric" datatype="numeric" length="10" default="0";
	property name="pintrestLastUpdate" datatype="dateTime";
	
	
	property name="mediakitTemplateID" type="numeric" datatype="numeric" default="1";
	
	
	property name="googleAnalyticsUsername" datatype="varchar" length="50" default="";
	property name="googleAnalyticsPassword" datatype="varchar" length="50" default="";
	property name="googleLastUpdate" datatype="dateTime" ;
	
	property name="blogURL" datatype="varchar" length="100" default="";
	property name="webURL" datatype="varchar" length="100" default="";
	
	property name="headshotFilename" datatype="varchar" length="100" default="";
	property name="BaseInfluenceZipCode" datatype="varchar" length="11" default="";
	property name="BaseInfluencerRadius" datatype="varchar" length="255" default="";
	property name="BaseInfluencelat" datatype="varchar" length="255" default="";
	property name="BaseInfluencelong" datatype="varchar" length="255" default="";
	property name="datecreated" datatype="datetime" nullable=true;
	property name="datemodified" datatype="datetime" nullable=true;
		
	property name="fieldsToBeUpdatedByStruct" persistent="false"    datatype="varchar" length="1000" default="firstname,lastname,email,address1,address2,address3,address4,city,state,zipcode,country" ;

	// relationships
	property name="InfluencerAccount" fkcolumn="influenceraccountid" cfc="InfluencerAccount" fieldtype="one-to-one" cascade="delete";
	property name="InfluencerProfileToDemographics" singularname="demographic" cfc="InfluencerProfileToDemographics" fieldtype="one-to-many" cascade="delete";
	property name="InfluencerProfileToCategories" singularname="category" cfc="InfluencerProfileToCategories" fieldtype="one-to-many" cascade="delete";
	property name="awards" singularname="award" cfc="awards" fieldtype="one-to-many" cascade="delete";
	property name="presslinks" singularname="presslink" cfc="presslinks" fieldtype="one-to-many" cascade="delete";
	property name="conferences" singularname="conference" cfc="conferences" fieldtype="one-to-many" cascade="delete";

	// Custom Validations
	public any function validate() {

			
		return variables.validationMessages;
	}

	// Custom Methods
		public any function getFullName() {
			return get('namefirst') & ' ' & get('namelast');
		}
		
		public any function getID() {
			return variables.influencerProfileid;
		}
		
		public any function populateFromForm(required struct submittedForm) {
			
			
			
			if (structKeyExists(arguments.submittedForm, 'keywords')) {
				this.setkeywords(arguments.submittedForm.keywords);
			}
			
			if (structKeyExists(arguments.submittedForm, 'description')) {
				this.setdescription(arguments.submittedForm.description);
			}
			
			if (structKeyExists(arguments.submittedForm, 'twitterUserName')) {
				this.settwitterUserName(arguments.submittedForm.twitterUserName);
			}
			
			if (structKeyExists(arguments.submittedForm, 'twitterPassword')) {
				this.settwitterPassword(application.su.encryptThis(arguments.submittedForm.twitterPassword));
			}
			
			if (structKeyExists(arguments.submittedForm, 'twitterFollowersCount')) {
				this.settwitterFollowersCount(arguments.submittedForm.twitterFollowersCount);
			}
			
			if (structKeyExists(arguments.submittedForm, 'twitterLastUpdate')) {
				if (this.gettwitterLastUpdate IS NOT arguments.submittedForm.twitterLastUpdate) {
					this.settwitterLastUpdate(arguments.submittedForm.twitterLastUpdate);
				}
			}
			
			if (structKeyExists(arguments.submittedForm, 'pintrestUserName')) {
				
				this.setpintrestUserName(arguments.submittedForm.pintrestUserName);
				/*WriteDump(var=this.,top=2,label='goo', abort=true);*/
				
			}

			if (structKeyExists(arguments.submittedForm, 'pintrestPassword')) {
				this.setpintrestPassword(application.su.encryptThis(arguments.submittedForm.pintrestPassword));
			}
			
			if (structKeyExists(arguments.submittedForm, 'pintrestFollowersCount')) {
				this.setpintrestFollowersCount(arguments.submittedForm.pintrestFollowersCount);
			}
			
			if (structKeyExists(arguments.submittedForm, 'pintrestLastUpdate')) {
				if (this.getpintrestLastUpdate IS NOT arguments.submittedForm.pintrestLastUpdate) {
					this.setpintrestLastUpdate(arguments.submittedForm.pintrestLastUpdate);
				}
			}
			
			if (structKeyExists(arguments.submittedForm, 'instagramUserName')) {
				this.setinstagramUserName(arguments.submittedForm.instagramUserName);
			}
			
			if (structKeyExists(arguments.submittedForm, 'instagramPassword')) {
				this.setinstagramPassword(application.su.encryptThis(arguments.submittedForm.instagramPassword));
			}
			
			if (structKeyExists(arguments.submittedForm, 'instagramFollowersCount')) {
				this.setinstagramFollowersCount(arguments.submittedForm.instagramFollowersCount);
			}
			
			if (structKeyExists(arguments.submittedForm, 'instagramLastUpdate')) {
				if (this.getinstagramLastUpdate IS NOT arguments.submittedForm.instagramLastUpdate) {
					this.setinstagramLastUpdate(arguments.submittedForm.instagramLastUpdate);
				}
			}
			
			
			if (structKeyExists(arguments.submittedForm, 'FacebookUsername')) {
				this.setFacebookUsername(arguments.submittedForm.FacebookUsername);
			}
			
			if (structKeyExists(arguments.submittedForm, 'facebookPassword')) {
				this.setfacebookPassword(application.su.encryptThis(arguments.submittedForm.facebookPassword));
			}
			
			if (structKeyExists(arguments.submittedForm, 'facebookFriendsCount')) {
				this.setfacebookFriendsCount(arguments.submittedForm.facebookFriendsCount);
			}
			
			if (structKeyExists(arguments.submittedForm, 'facebookBusinesspageLink')) {
				this.setfacebookBusinesspageLink(arguments.submittedForm.facebookBusinesspageLink);
			}
			
			if (structKeyExists(arguments.submittedForm, 'facebookLastUpdate')) {
				if (this.getfacebookLastUpdate IS NOT arguments.submittedForm.facebookLastUpdate) {
					this.setfacebookLastUpdate(arguments.submittedForm.facebookLastUpdate);
				}
			}
			
			if (structKeyExists(arguments.submittedForm, 'googleAnalyticsUsername')) {
				this.setgoogleAnalyticsUsername(arguments.submittedForm.googleAnalyticsUsername);
			}
			
			if (structKeyExists(arguments.submittedForm, 'googleAnalyticsPassword')) {
				this.setgoogleAnalyticsPassword(application.su.encryptThis(arguments.submittedForm.googleAnalyticsPassword));
			}
			
			if (structKeyExists(arguments.submittedForm, 'googleLastUpdate')) {
				if (this.getgoogleLastUpdate IS NOT arguments.submittedForm.googleLastUpdate) {
					this.setgoogleLastUpdate(arguments.submittedForm.googleLastUpdate);
				}
			}
			
			if (structKeyExists(arguments.submittedForm, 'blogURL')) {
				this.setblogURL(arguments.submittedForm.blogURL);
			}
			
			if (structKeyExists(arguments.submittedForm, 'webURL')) {
				this.setwebURL(arguments.submittedForm.webURL);
			}
			
			if (structKeyExists(arguments.submittedForm, 'BaseInfluenceZipCode')) {
				this.setBaseInfluenceZipCode(arguments.submittedForm.BaseInfluenceZipCode);
			}
		
			if (structKeyExists(arguments.submittedForm, 'BaseInfluencerRadius')) {
				this.setBaseInfluencerRadius(arguments.submittedForm.BaseInfluencerRadius);
			}
			
			if (structKeyExists(arguments.submittedForm, 'BaseInfluencelat')) {
				this.setBaseInfluencelat(arguments.submittedForm.BaseInfluencelat);
			}
			
			if (structKeyExists(arguments.submittedForm, 'BaseInfluencelong')) {
				this.setBaseInfluencelong(arguments.submittedForm.BaseInfluencelong);
			}
			
			if (structKeyExists(arguments.submittedForm, 'mediakitTemplateID')) {
				/*WriteDump(var=arguments.submittedForm.mediakitTemplateID,top=2,label='goo', abort=true);*/
				this.setmediakitTemplateID(arguments.submittedForm.mediakitTemplateID);
			}
			
			/*WriteDump(var=THIS,top=2,label='goo', abort=true);*/
			return THIS;
		}

		// @end Custom Methods
}
