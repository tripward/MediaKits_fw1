component persistent="false" accessors="true" output="false" extends="baseService" {

	property name='ObjectType' type="string" default="InfluencerProfileToCategories";
	property name='tableName' type="string" default="InfluencerProfileToCategories";
	property name='ObjectIDProp' type="string" default="InfluencerProfileToCategoryid";
	
	public any function init() {
		
		SUPER.init();
		return this;
	}
	
	public any function getProfileCatsAsList(string influencerProfileid) {
		var local.idList = '';
		
		local.query = QueryExecute(("SELECT categoryid FROM #variables.tableName# WHERE InfluencerProfileID = :influencerProfileid"),{influencerProfileid=arguments.influencerProfileid});
		
		if (local.query.recordCount) {
			local.idList = valueList(local.query.categoryid);
		}

		return local.idList;
	}

	
	

}
