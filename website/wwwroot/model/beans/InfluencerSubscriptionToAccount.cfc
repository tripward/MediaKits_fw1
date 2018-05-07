component
	extends="baseBean"
	table="InfluencerSubscriptionToAccount"
	entityname="InfluencerSubscriptionToAccount"
	displayname="InfluencerSubscriptionToAccount"
	accessors="true"
	persistent="true" {

	// primary key
	property name="InfluencerSubscriptionToAccountid" fieldtype="id" type="uuid" ormType='string' generator="uuid";
	// attributes
	property name="discountPercent" datatype="numeric" length="3" nullable=true;
	property name="discountDuration" datatype="numeric" length="3" nullable=true;
	property name="discountStart" datatype="date" length="25" nullable=true;
	property name="subscriptionStart" datatype="date" length="25" nullable=true;
	property name="isActive" datatype="boolean" default=1;
	property name="paymentGateway" datatype="varchar" length="1000" default="";
	property name="transactionid" datatype="varchar" length="1000" default="";
	property name="datecreated" datatype="datetime" nullable=true;
	property name="datemodified" datatype="datetime" nullable=true;
	property name="fieldsToBeUpdatedByStruct" datatype="varchar" persistent="false" length="1000" default="discountPercent,discountDuration,discountStart,subscriptionStart,isActive,transactionid" ;

	property name="account" fkcolumn="influenceraccountid" cfc="InfluencerAccount" fieldtype="many-to-one" cascade="none";
	property name="subscription" fkcolumn="IInfluencerSubscriptionID" cfc="InfluencerSubscriptions" fieldtype="many-to-one" cascade="none";
		
	/*property
		name="subscription"
		relatesTo="InfluencerSubscription"
		fieldtype="many-to-one"
		cascade="none"
		fkcolumn="IInfluencerSubscriptionID";*/
		
		public any function getID(struct myStruct) {
			return variables.getInfluencerSubscriptionToAccountid();
		}

}
