component persistent="false" accessors="true" output="false" extends="baseService" {

	property name='ObjectType' type="string" default="InfluencerProfileToDemographics";
	property name='tableName' type="string" default="InfluencerProfileToDemographics";
	property name='ObjectIDProp' type="string" default="InfluencerProfileToDemographicsid";
	
	public any function init() {
		
		SUPER.init();
		return this;
	}
	
	public any function getProfileDemosAsList(string influencerProfileid) {
		var local.idList = '';
		
		local.query = QueryExecute(("SELECT demographicid FROM #variables.tableName# WHERE InfluencerProfileID = :influencerProfileid"),{influencerProfileid=arguments.influencerProfileid});
		
		if (local.query.recordCount) {
			local.idList = valueList(local.query.demographicid);
		}

		return local.idList;
	}

	
	

}
