/*

This file is part of mediakitsFunctions

Copyright 2010-2017 Stephen J. Withington, Jr.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0

*/
component displayname="baseService" extends="model.baseObject"  persistent="false" accessors="true" output="false"  {

	property name="factory"; // use if you need access to the beanFactory
	property name="datasource" default="mediakits";

	
	public any function init() {

		variables.setFactory(application['framework.one'].factory);
		
		return this;
	}
	
	public string function dbDateDateTime(required string dateToformat)
		
		{
		return dateTimeFormat(arguments.dateToformat, "YYYY-MM-DD HH:MM:SS");
		}

	public any function getNewID() {
   		return CreateGUID();
	}
	
	public any function getGUID() {
		var uuidLibObj = createobject("java", "java.util.UUID");
   		var guidStr = uuidLibObj.randomUUID().toString();
   		return guidStr;
	}
	
	public any function getUUID() {
		var uuidLibObj = createobject("java", "java.util.UUID");
   		var guidStr = uuidLibObj.randomUUID().toString();
   		return createUUID();
	}
	
	public any function list() {
		local.list = entityLoad(variables.ObjectType);
		return local.list;
	}
	
	public void function save(required any saveObj) {
		entitySave(arguments.saveObj);
	}
	
	public any function get(required any id) {
		local.entity = entityLoadByPK(variables.ObjectType, arguments.id);
		return local.entity;
	}

	
	public any function new() {
		return variables.factory.getBean(variables.ObjectType);
	}
	
	 //end initialConfigure
	
	
	
	public any function getFBInfo(required any account='') {

		var facebookResponse = {};
		
		var local.hoo = cfhttp(url="https://graph.facebook.com/v2.1/me/friends?AccessToken=EAAcrAkgFkjYBAPa9R0icRxkzbklkAb3oYuN0S2AJhSYAAH7l9t9hITkzpjNNY1kaYkhhQIj5NJPGUTv5f3eEZAj8eOiHJhYrIeS4H09QcAkejJwztDzCLVZB4u1teHSl4NcAQmV3ijgyMiMIzRZBx9ZBA5dPeRoZD" ,result="local.callResponse");
		WriteDump(var=llocal.hoo,top=2,label='goo', abort=true);
		return local.callResponse;
	}
	
	
}

