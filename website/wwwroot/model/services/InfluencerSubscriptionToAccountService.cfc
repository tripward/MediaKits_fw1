component persistent="false" accessors="true" output="false" extends="baseService" {

	property name='ObjectType' type="string" default="InfluencerSubscriptionToAccount";
	property name='tableName' type="string" default="InfluencerSubscriptionToAccount";
	property name='ObjectIDProp' type="string" default="InfluencerSubscriptionToAccountid";
	
	
	public any function init() {
		
		SUPER.init();
		return this;
	}
	
	
	
	public any function list() {
		local.list = entityLoad('InfluencerSubscriptions');
		return entityLoad('InfluencerSubscriptions');
	}

	
	

}
