component
	extends="baseBean"
	table="awards"
	entityname="award"
	displayname="award"
	accessors="true"
	persistent="true" {

	// primary key
	property name="awardid" fieldtype="id";

	// attributes
	property name="name" datatype="varchar" required="true" length="50" default="";
	property name="keywords" datatype="varchar" length="255" default="";
	property name="PresentedBy" datatype="varchar" length="1000" default="";
	property name="PresentedDate" datatype="date";
	property name="description" datatype="varchar" length="1000" default="";
	property name="datecreated" datatype="datetime" nullable=true;
	property name="datemodified" datatype="datetime" nullable=true;

	//common
	property name="fieldsToBeUpdatedByStruct" persistent="false"    datatype="varchar" length="1000" default="name,keywords,description" ;

	// relationships
	property name="InfluencerProfile" fkcolumn="influencerProfileid" cfc="InfluencerProfile" fieldtype="many-to-one" cascade="none";
		
	// Custom Validations
	public any function validate() {
		var obj = super.validate();
		var errors = obj.getErrors();

		if ( !Len(obj.get('name')) ) {
			structInsert(errors,'username','Award Name is required');
		}

		return errors;
	}
	
	public any function getProfileDisplay() {
			
			savecontent variable="myContent" {

			}
			
			
			/*WriteDump(var=THIS,top=2,label='goo', abort=true);*/
			return myContent;
		}

	// Custom Methods
		
		public any function getID() {
			return get('awardid');
		}
		
		public any function populateFromForm(required struct submittedForm) {
			
			
			
			if (structKeyExists(arguments.submittedForm, 'PresentedBy')) {
				this.setPresentedBy(arguments.submittedForm.PresentedBy);
			}
			
			if (structKeyExists(arguments.submittedForm, 'PresentedDate')) {
				this.setPresentedDate(arguments.submittedForm.PresentedDate);
			}
			
			if (structKeyExists(arguments.submittedForm, 'description')) {
				this.setdescription(arguments.submittedForm.description);
			}
			
			if (structKeyExists(arguments.submittedForm, 'name')) {
				this.setName(arguments.submittedForm.name);
			}
			
			if (structKeyExists(variables, 'awardid') AND len(trim(variables.awardid))) {
				this.setdatemodified(now());
			} else {
				this.setdatecreated(now());
			}
			
			
			/*WriteDump(var=THIS,top=2,label='goo', abort=true);*/
			return THIS;
		}
		

		// @end Custom Methods
}
