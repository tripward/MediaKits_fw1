component
	extends="baseBean"
	table="presslinks"
	entityname="presslink"
	displayname="presslink"
	accessors="true"
	persistent="true" {

	// primary key
		property name="presslinkid" fieldtype="id" type="uuid" ormType='string' generator="uuid";

	// attributes
		property name="name" datatype="varchar" required="true" length="50" default="";
		property name="keywords" datatype="varchar" length="255" default="";
		property name="publication" datatype="varchar" length="1000" default="";
		property name="DisplayDate" datatype="date";
		property name="description" datatype="varchar" length="1000" default="";

		
	//common
	property name="fieldsToBeUpdatedByStruct" persistent="false"    datatype="varchar" length="1000" default="name,keywords,description" ;
		
	// hidden
		
		property name="datecreated" datatype="datetime" nullable=true;
		property name="datemodified" datatype="datetime" nullable=true;


		property name="InfluencerProfile" fkcolumn="influencerProfileid" cfc="InfluencerProfile" fieldtype="many-to-one" cascade="all";
		
		
	// Custom Validations
	public any function validate() {
			
			if ( !Len(variables.name)){
				structInsert(variables.validationMessages,'name', 'Name is required');
			}
			if ( !Len(variables.DisplayDate)){
				structInsert(variables.validationMessages,'DisplayDate', 'Display Date is required');
			}
			
			return variables.validationMessages;
		}

	// Custom Methods
		
		public any function getID() {
			return variables.presslinkid;
		}
		
		public any function populateFromForm(required struct submittedForm) {
			
			
			
			if (structKeyExists(arguments.submittedForm, 'publication')) {
				this.setpublication(arguments.submittedForm.publication);
			}
			
			if (structKeyExists(arguments.submittedForm, 'DisplayDate')) {
				this.setDisplayDate(arguments.submittedForm.DisplayDate);
			}
			
			if (structKeyExists(arguments.submittedForm, 'keywords')) {
				this.setkeywords(arguments.submittedForm.keywords);
			}
			
			if (structKeyExists(arguments.submittedForm, 'description')) {
				this.setdescription(arguments.submittedForm.description);
			}
			
			if (structKeyExists(arguments.submittedForm, 'name')) {
				this.setName(arguments.submittedForm.name);
			}
			
			if (structKeyExists(variables, 'presslinkid') AND len(trim(variables.presslinkid))) {
				this.setdatemodified(now());
			} else {
				this.setdatecreated(now());
			}
			
			
			/*WriteDump(var=THIS,top=2,label='goo', abort=true);*/
			return THIS;
		}
		
		

		// @end Custom Methods
}
