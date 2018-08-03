component displayname="influencerMainController" extends="subsystems.basecontroller" accessors=true {
    property InfluencerAccountService;
    property demographicsService;
    property InfluencerProfileToDemographicsService;
    property InfluencerProfileToCategoriesService;
    property categoryService;
    property InfluencerStatsService;
    property InfluencerProfileService;

    
    public void function before(required struct rc) {
		SUPER.before(arguments.rc);
		
		lock name="lockName" timeout="3" {
			
			if (!structKeyExists(session,'surfer') OR !session.surfer.getisLoggedIn()) {
				variables.fw.redirect(action='influencer_login:main.default', preserve='all');
				abort;
			}
			
			rc.influencerAccount = variables.InfluencerAccountService.get(id=session.surfer.getInfluenceraccountid());
			/*WriteDump(var=rc.influencerAccount.getProfile(),top=2,label='goo', abort=true);*/
			if (isNull(rc.influencerAccount)) {
				/*account Doesnt exist, the account ID may have been comprimised*/
				variables.fw.redirect(action='influencer_login:main.default', preserve='all');
				abort;
			}
			
		}

	}
    
    
    public void function default(required struct rc) {
		
		
		
		//get values to build out select boxes
		rc.demographicOptions = variables.demographicsService.getOptionList();
		rc.categoriesOptions = variables.categoryService.getOptionList();

		//todo:consider if we have the profile object, do we want to just create metod in profile that will return them as a list?
		rc.influencerDemos = variables.InfluencerProfileToDemographicsService.getProfileDemosAsList(rc.influencerAccount.getProfile().getinfluencerProfileid());
		rc.influencerCats = variables.InfluencerProfileToCategoriesService.getProfileCatsAsList(rc.influencerAccount.getProfile().getinfluencerProfileid());

		rc.socialStats = variables.InfluencerStatsService.getAllStats(rc.influencerAccount);
		/*WriteDump(var=rc.socialStats,top=5,label='goo', abort=true);*/
			/*rc.socialStats = variables.InfluencerStatsService.getAllStats(rc.influencerAccount);*/
			/*WriteDump(var=rc.socialStats.twitter.stats.asStruct.followers_count,top=7,label='hhhh', abort=false);
			WriteDump(var=rc.socialStats.instagram.stats.user.followed_by.count,top=7,label='hhhh', abort=false);*/
			
			/*rc.influencerAccount.getProfile().settwitterFollowedByCount(rc.socialStats.twitter.stats.asStruct.followers_count);
			rc.influencerAccount.getProfile().setinstagramFollowersCount(rc.socialStats.instagram.stats.user.followed_by.count);
			WriteDump(var=rc.influencerAccount.getProfile(),top=7,label='hhhh', abort=true);*/
			
		
	}
	
	public void function persistProfile(required struct rc) {


		rc.profile = rc.influencerAccount.getprofile();
		//todo: validation
		variables.fw.populate(cfc=rc.influencerAccount);
		variables.fw.populate(cfc=rc.profile);
		

		
		if (structKeyExists(rc,'demographics')) {        
			variables.InfluencerProfileService.updateDemographics(profile=rc.influencerAccount.getProfile(),newDemographics=rc.demographics);
		}
		
		if (structKeyExists(rc,'categories')) { 
			variables.InfluencerProfileService.updateCategories(profile=rc.influencerAccount.getProfile(),Categories=rc.categories);
		}
		
		if (structKeyExists(rc,'headshotFilename') AND len(rc.headshotFilename)) {
			WriteDump(var=rc.headshotFilename,top=2,label='rccccc', abort=false);
			
			
			rc.uploadedFile = fileUpload( getTempDirectory(), "headshotFilename", "image/jpeg,image/pjpeg", "MakeUnique" );
			//todo: eh: around file 

			/*WriteDump(var='#getTempDirectory()##rc.uploadedFile.serverFile#',top=2,label='goo', abort=true);*/
			
			if (len(trim(rc.influencerAccount.getProfile().getheadshotFilename())) AND fileExists('#application.mediaConfig.headShotAbsolutePath#\#rc.influencerAccount.getProfile().getheadshotFilename()#')) {
				fileDelete('#application.mediaConfig.headShotAbsolutePath#\#rc.influencerAccount.getProfile().getheadshotFilename()#');
			}
			
			
			fileMove("#getTempDirectory()##rc.uploadedFile.serverFile#", application.mediaConfig.headShotAbsolutePath);
			
			rc.profile.setheadshotFilename('#rc.uploadedFile.serverFile#');
		}
		
		
		/*myFile = expandPath( "somefile.txt" );
		data = "I'm going to create a file object";
		FileWrite( "fileObj", data );
		newFileObj = FileRead( "fileObj" );
		writeDump(var=newFileObj);*/ // OR write direct to file myFile = expandPath( "somefile.txt" ); data = "I'm going to write to direct to file"; FileWrite(myFile, data);
		
		
		
		
		rc.validationMessages = rc.profile.validate();
		/*if we have validation issues, go back to the sub form*/
		if (!structIsEmpty(rc.validationMessages) OR !structIsEmpty(rc.errors)) {
			variables.fw.redirect(action='influencer_subscribe:main.default', preserve='all');
			abort;
		}
		
		//save account
		variables.InfluencerAccountService.save(rc.influencerAccount);
		// save profile
		variables.InfluencerProfileService.save(rc.profile);
		
		
		ormFlush();
		/*if (structIsEmpty(rc.profile.getErrors())) {
			rc.profile.save();
			rc.message = arrayAppend(rc.messages, 'profile Saved');
		} else {
			WriteDump(var= rc.profile,top=2,label='goo', abort=true);	
		
		}*/
		
		variables.fw.redirect(action='influencer:main.default', preserve='all');
	}
	
	
	
}
