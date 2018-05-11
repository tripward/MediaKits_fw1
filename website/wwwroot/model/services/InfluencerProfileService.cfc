component persistent="false" accessors="true" output="false" extends="baseService" {

	property name='beanfactory';
	property name='ObjectType' type="string" default="InfluencerProfile";
	property name='tableName' type="string" default="InfluencerProfile";
	property name='ObjectIDProp' type="string" default="InfluencerProfileid";
	property name='tablename' type="string" default="InfluencerProfile";

	public any function init() {
		SUPER.init();
		return this;
	}
	
	public any function updateCategories(required any profile, required any categories) {
		
		THIS.deleteInfluencercategories(arguments.profile.getID());
		THIS.insertInfluencercategories(arguments.profile.getID(),arguments.categories);
			
	}
	
	public any function deleteInfluencerCategories(required any profileID) {
		
		myResult=QueryExecute("DELETE FROM InfluencerProfileToCategories WHERE InfluencerProfileID=:profileID",{profileID=arguments.profileID});

	}
	
	public any function insertInfluencerCategories(required any profileID, required any categories) {

		 for (item in listToArray(arguments.categories, ",")) {
		 	QueryExecute("insert INTO InfluencerProfileToCategories 
			(
				InfluencerProfileToCategoryid,
				InfluencerProfileID,
				categoryid
			)
			VALUES
			(
				'#CreateUUID()#',
				:InfluencerProfileID,
				:categoryid
			)
			
			",{InfluencerProfileID=arguments.profileID,categoryid=item});
		 }

	}
	
	public any function updateDemographics(required any profile, required any newDemographics) {
		
		THIS.deleteInfluencerDemographics(arguments.profile.getID());
		THIS.insertInfluencerDemographics(arguments.profile.getID(),arguments.newDemographics);
			
	}
	
	public any function deleteInfluencerDemographics(required any profileID) {
		
		myResult=QueryExecute("DELETE FROM influencerprofiletodemographics WHERE InfluencerProfileID=:profileID",{profileID=arguments.profileID});

	}
	
	public any function insertInfluencerDemographics(required any profileID, required any newDemographics) {

		 for (item in listToArray(arguments.newDemographics, ",")) {
		 	QueryExecute("insert INTO influencerprofiletodemographics 
			(
				InfluencerProfileToDemographicsid,
				InfluencerProfileID,
				demographicid
			)
			VALUES
			(
				'#CreateUUID()#',
				:InfluencerProfileID,
				:demographicid
			)
			
			",{InfluencerProfileID=arguments.profileID,demographicid=item});
		 }

	}
	
}
