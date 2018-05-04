component
	entityname="basebean"
	displayname="basebean"
	accessors="true"
	persistent="false"	{
		
	
	
	/*public any function initialConfigure() {

		for (local.theProp in collectAllProperties(getMetadata(THIS))) {
			theMethod = this["set" & local.theProp.name];
			
			if (structKeyExists(local.theProp,"type") AND listFindNoCase('string,date,numeric,integer', local.theProp.type)) {
				variables[local.theProp.name] = '';
			}
			
			if (structKeyExists(local.theProp,"default")) {
				theMethod(rTrim(trim(local.theProp.default)));
				variables[local.theProp.name] = local.theProp.default;
			}
			
			
		}

	}*/
	
	
	/*private array function collectAllProperties(required struct md,array props=ArrayNew(1)) {
		local.prop = 1;
		if (structKeyExists(arguments.md,"properties")) {
			for (local.prop=1; local.prop <= ArrayLen(arguments.md.properties); local.prop++) {
				if (not ArrayContains(arguments.props,arguments.md.properties[local.prop].name)) {
					arrayAppend(arguments.props,arguments.md.properties[local.prop]);
				}
			}
		}
		if (arguments.md.extends.fullname neq "WEB-INF.cftags.component") {
			arguments.props = collectAllProperties(arguments.md.extends,arguments.props);
		}
		return arguments.props;
	}*/


}
