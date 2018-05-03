component
	extends="baseBean"
	table="InfluencerProfileToDemographics"
	entityname="InfluencerProfileToDemographics"
	displayname="InfluencerProfileToDemographics"
	accessors="true"
	persistent="true" {

	// primary key
	property name="InfluencerProfileToDemographicsid" fieldtype="id";
	
	// attributes
	property name="fieldsToBeUpdatedByStruct" datatype="varchar" persistent="false" length="1000" default="discountPercent,discountDuration,discountStart,subscriptionStart,isActive,transactionid" ;

	// relationships
	property name="profile" fkcolumn="InfluencerProfileID" cfc="InfluencerProfile" fieldtype="many-to-one" cascade="delete";
	property name="demographic" fkcolumn="demographicID" cfc="demographic" fieldtype="many-to-one" cascade="none";
	
	public any function getID(struct myStruct) {
		return variables.getInfluencerProfileToDemographicsid();
	}

}
