component
	extends="baseBean"
	table="demographics"
	entityname="demographic"
	displayname="demographic"
	accessors="true"
	persistent="true" {

	// primary key
	property name="demographicid" fieldtype="id";

	// attributes
	property name="name" datatype="varchar" required="true" length="50" default="";
	property name="keywords" datatype="varchar" length="255" default="";
	property name="description" datatype="varchar" length="1000" default="";
	property name="datecreated" datatype="datetime" nullable=true;
	property name="datemodified" datatype="datetime" nullable=true;

	//common
	property name="fieldsToBeUpdatedByStruct" persistent="false"    datatype="varchar" length="1000" default="name,keywords,description" ;

	//relationships
	property name="InfluencerProfileToDemographics" singularname="demographic" cfc="InfluencerProfileToDemographics" linktable="influencerprofiletodemographics" fieldtype="one-to-many" cascade="none";

	// Custom Validations
	public any function validate() {
		var obj = super.validate();
		var errors = obj.getErrors();

		// Hidden Form Fields
			obj.set('datemodified', Now());

			if ( !Len(obj.get('datecreated')) ) {
				obj.set('datecreated', Now());
			}

		return this;
	}

	// Custom Methods
		
		public any function getID() {
			return get('demographicid');
		}
		
		public any function populateFromForm(required struct submittedForm) {
			
			
			
			if (structKeyExists(arguments.submittedForm, 'keywords')) {
				this.setkeywords(arguments.submittedForm.keywords);
			}
			
			if (structKeyExists(arguments.submittedForm, 'description')) {
				this.setdescription(arguments.submittedForm.description);
			}
			
			if (structKeyExists(arguments.submittedForm, 'name')) {
				this.settwitterUserName(arguments.submittedForm.name);
			}
			
			
			/*WriteDump(var=THIS,top=2,label='goo', abort=true);*/
			return THIS;
		}

		// @end Custom Methods
}
