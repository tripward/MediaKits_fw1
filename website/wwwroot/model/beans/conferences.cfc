component
	extends="baseBean"
	table="conferences"
	entityname="conference"
	displayname="conference"
	accessors="true"
	persistent="true" {

	// primary key
	property name="conferenceid" fieldtype="id" type="uuid" ormType='string' generator="uuid";

	// attributes
	property name="name" datatype="varchar" required="true" length="50" default="";
	property name="keywords" datatype="varchar" length="255" default="";
	property name="Date" datatype="date";
	property name="description" datatype="varchar" length="1000" default="";
	property name="datecreated" datatype="datetime" nullable=true;
	property name="datemodified" datatype="datetime" nullable=true;

	//common
	property name="fieldsToBeUpdatedByStruct" persistent="false"    datatype="varchar" length="1000" default="name,keywords,description" ;

	//relationships
	property name="InfluencerProfile" fkcolumn="influencerProfileid" cfc="InfluencerProfile" fieldtype="many-to-one" cascade="all";
		
	public any function validate() {
		
		if ( !Len(variables.name)){
			structInsert(variables.validationMessages,'name', 'Conference Name is required');
		}
		
		if ( !Len(variables.Date)){
				structInsert(variables.validationMessages,'Date', 'Conference Date is required');
			}
		
		return variables.validationMessages;
	}

	
	// Custom Methods
		
		public any function getID() {
			return variables.conferenceid;
		}
		
		public any function populateFromForm(required struct submittedForm) {
			
			
			
			if (structKeyExists(arguments.submittedForm, 'keywords')) {
				this.setkeywords(arguments.submittedForm.keywords);
			}
			
			if (structKeyExists(arguments.submittedForm, 'description')) {
				this.setdescription(arguments.submittedForm.description);
			}
			
			if (structKeyExists(arguments.submittedForm, 'name')) {
				this.setName(arguments.submittedForm.name);
			}
			
			if (structKeyExists(arguments.submittedForm, 'date')) {
				this.setdate(arguments.submittedForm.date);
			}
			
			if (structKeyExists(variables, 'conferenceid') AND len(trim(variables.conferenceid))) {
				this.setdatemodified(now());
			} else {
				this.setdatecreated(now());
			}
			
			
			/*WriteDump(var=THIS,top=2,label='goo', abort=true);*/
			return THIS;
		}

		// @end Custom Methods
}
