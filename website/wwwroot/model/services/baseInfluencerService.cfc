/*

This file is part of mediakitsFunctions

Copyright 2010-2017 Stephen J. Withington, Jr.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0

*/
component persistent="false" accessors="true" output="false" extends="baseService" {

	public void function init() {
		SUPER.init();
	}
	
	public any function getIterator() {
		/*WriteDump(variables);abort;*/
		try {if (!structkeyExists(variables,'#variables.iteratorVariableName#')) {        
			variables.myIterator = variables.getFeed('#variables.ObjectType#').where().getIterator();
		}} catch (any e) {
			WriteDump('error in iterator for #variables.ObjectType#');
			WriteDump(var=e,top=3,label='error catch baseinfservice', abort=true);
		} 
		return variables.myIterator;
	}
	
	public any function getIteratorByCriteria() {
		/*WriteDump(variables['#variables.ObjectType#s']);abort;*/
		try {if (!structkeyExists(variables,'#variables.iteratorVariableName#')) {        
			variables.myIterator = variables.getFeed('#variables.ObjectType#').where().getIterator();
		}} catch (any e) {
			WriteDump('error in iterator for #variables.ObjectType#');
			WriteDump(var=e,top=3,label='error catch baseinfservice', abort=true);
		} 
		return variables.myIterator;
	}
	
	// getSpeakersFeed (assumes you have a pre-defined feed/content collection named 'Speakers')
	/*public any function getFeed(feedName=variables.iteratorVariableName) {
		/*WriteDump(var=arguments,top=2,label='goo', abort=true);*/
		/*WriteDump(var=variables.factory.getBean(variables.ObjectType).loadBy(name=arguments.feedName),top=2,label='goo', abort=true);*/
		//return variables.factory.getBean(variables.ObjectType).loadBy(name=arguments.feedName);
	//}*/
	
	public any function get(string id='') {
		var result = '';
		if ( Len( trim( arguments.id )) ) {
			/*result = variables.factory.getBean(variables.ObjectType).loadBy(influenceraccountid=arguments.id);*/
			
			filtercriteria = "#variables.ObjectIDProp#=#arguments.id#";
			WriteDump(var=filtercriteria,top=1,abort=true);
			/*result = variables.factory.getBean(variables.ObjectType).loadBy(filtercriteria);*/
			result = variables.factory.getBean(variables.ObjectType).loadBy(subscriptionid=arguments.id);
			WriteDump(var=arguments.id,top=1,abort=false);
			WriteDump(var=result,top=1,abort=true);
		} else {
			result = new();
		};
		return result;
	}
	
	public struct function list() {
		return variables.getIterator();
	}
	
	public any function new() {
		return variables.factory.getBean(variables.ObjectType);
	}
	
	public boolean function delete(required string id) {
		
	}

}
