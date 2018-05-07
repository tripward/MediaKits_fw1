/*

This file is part of mediakitsFunctions

Copyright 2010-2017 Stephen J. Withington, Jr.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0

*/
component displayname="InfluencerPressLinksService" persistent="false" accessors="true" output="false" extends="baseService" {
	
	property name='beanfactory';
	property name='ObjectType' type="string" default="presslinks";
	property name='tableName' type="string" default="presslinks";
	property name='ObjectIDProp' type="string" default="presslinkid";
	
	public void function init() {
		SUPER.init();
	}
	
	
}
