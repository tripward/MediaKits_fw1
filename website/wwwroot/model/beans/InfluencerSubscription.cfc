component
	extends="baseBean"
	table="InfluencerSubscriptions"
	entityname="InfluencerSubscriptions"
	displayname="InfluencerSubscriptions"
	accessors="true"
	persistent="true" {

	// primary key
	property name="Subscriptionid" fieldtype="id" type="uuid" ormType='string' generator="uuid";
	
	// attributes
	property name="name" datatype="varchar" length="255" required=true message="Name is required." default=""; // Home, Office, Mobile, etc.
	property name="level" datatype="varchar" length="1000" default="";
	property name="description" datatype="varchar" length="1000" default="";
	property name="sort_order" datatype="numeric" validate="numeric" length="3" default="1";
	property name="duration" datatype="numeric" validate="numeric" length="3" default="12";
	property name="cost" datatype="double" length="8"  nullable=true;
	property name="isActive" datatype="boolean" default=1;
	property name="isOffered" datatype="boolean" default=1;
	property name="paymentGateway" datatype="varchar" length="1000" default="";
	property name="transactionid" datatype="varchar" length="1000" default="";
	property name="fieldsToBeUpdatedByStruct" datatype="varchar" length="1000" persistent="false" default="name,level,description,sort_order,duration,cost,isActive,isOffered,state,zipcode,country" ;

	// relationships
	property name="InfluencerSubscriptionToAccount" fkcolumn="InfluencerSubscriptionToAccountID" singularname="InfluencerSubscriptionToAccount" cfc="InfluencerSubscriptionToAccount" fieldtype="one-to-many" cascade="delete";
	
	public any function getID(struct myStruct) {
		return get('Subscriptionid');
	}

}
