component
	extends="baseBean"
	table="InfluencerProfileToCategories"
	entityname="InfluencerProfileToCategories"
	displayname="InfluencerProfileToCategories"
	accessors="true"
	persistent="true" {

	// primary key
	property name="InfluencerProfileToCategoryid" fieldtype="id" type="uuid" ormType='string' generator="uuid";
	
	// attributes
	property name="fieldsToBeUpdatedByStruct" datatype="varchar" persistent="false" length="1000" default="discountPercent,discountDuration,discountStart,subscriptionStart,isActive,transactionid" ;

	// relationships
	property name="profile" fkcolumn="InfluencerProfileID" cfc="InfluencerProfile" fieldtype="many-to-one" cascade="none";
	property name="category" fkcolumn="categoryid" cfc="category" fieldtype="many-to-one" cascade="none";

		
	public any function getID(struct myStruct) {
		return variables.InfluencerProfileToCategoryid();
	}

}
