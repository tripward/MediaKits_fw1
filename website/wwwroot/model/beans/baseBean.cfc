component
	entityname="basebean"
	displayname="basebean"
	extends="model.baseObject" 
	accessors="true"	{
		
	variables.validationMessages = structNew();
		
	public any function init( ) {

		return this;
	}
	
	public any function setDates() {
		
		variables.datemodified = Now();

		/*if ( !Len(variables.datecreated) ) {
			variables.datecreated = Now();
		}*/
				
		return this;
	}
	
	public any function getvalidationMessages() {
		
		return variables.validationMessages;
	}
		
	


}
