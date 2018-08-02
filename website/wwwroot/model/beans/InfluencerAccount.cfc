component
	extends="baseBean"
	table="InfluencerAccounts"
	entityname="InfluencerAccount"
	displayname="InfluencerAccount"
	accessors="true"
	persistent="true" {

	// primary key
	property name="influenceraccountid" fieldtype="id" type="uuid" ormType='string' generator="uuid";

	// attributes
	property name="firstname" datatype="varchar" length="255" required=true message="First Name is required." default="";
	property name="lastname" datatype="varchar" length="255" required=true message="Last Name is required." default="";
	property name="email" datatype="varchar" length="255" required=true message="Email is required." default="";
	property name="password" datatype="varchar" length="255" required=true message="password is required." default="";
	property name="datecreated" datatype="datetime" nullable=true;
	property name="datemodified" datatype="datetime" nullable=true;
	property name="isActive" datatype="boolean" default=1;
	property name="address1" datatype="varchar" length="255" required=true message="Address1 is required." default=""; // Home, Office, Mobile, etc.
	property name="address2" datatype="varchar" length="255" default="";
	property name="address3" datatype="varchar" length="255" default="";
	property name="address4" datatype="varchar" length="255" default="";
	property name="city" datatype="varchar" length="255" default="";
	property name="state" datatype="varchar" length="255" default="";
	property name="zipcode" datatype="varchar" length="255" default="";
	property name="country" datatype="varchar" length="255" default="";
	property name="discountPercent" datatype="numeric" length="3" nullable=true;
	property name="discountDuration" datatype="numeric" length="3" nullable=true;
	property name="discountStart" datatype="date" length="25" nullable=true;
	property name="subscriptionStart" datatype="date" length="25" nullable=true;
	property name="fieldsToBeUpdatedByStruct" persistent="false"    datatype="varchar" length="1000" default="firstname,lastname,email,address1,address2,address3,address4,city,state,zipcode,country" ;
	property name="influencerloggedIn" datatype="boolean" default="0" persistent="false";


	// relationships
	property name="profile" fieldtype="one-to-one" cfc="InfluencerProfile"  mappedby="InfluencerAccount" cascade="delete" inverse="true" lazy="false"    ;
	property name="InfluencerSubscriptionToAccounts" fieldtype="one-to-many" cfc="InfluencerSubscriptionToAccount" cascade="delete";

	/*property
		name="phonenumbers"
		singularname="phonenumber"
		cfc="influencerphonenumber"
		fieldtype="one-to-many"
		loadkey="influencerid"
		fkcolumn="influencerid"
		cascade="delete"
		orderby="phonetype";*/
		
		
		
		// Custom Validations
		public any function validate() {
			
			
			if ( !Len(variables.firstName)){
				structInsert(variables.validationMessages,'firstName', 'First Name is required');
			}
			
			if ( !Len(variables.lastName)){
				structInsert(variables.validationMessages,'lastName', 'Last Name is required');
			}
			
			if ( !Len(variables.email)){
				structInsert(variables.validationMessages,'email', 'Email is required');
			}

			if (!structIsEmpty(variables.validationMessages)) {
				SUPER.setDates();
			}
			
			return variables.validationMessages;
		}

		// Custom Methods
			
			
			public any function getid() {
				return variables.influenceraccountid;
			}
			
			/*public any function getProfile() {
				return getBean('InfluencerProfile').loadBy(influenceraccountid=this.getID());
			}*/

		// @end Custom Methods
}
