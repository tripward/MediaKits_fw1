/*

This file is part of mediakitsFunctions

Copyright 2010-2017 Stephen J. Withington, Jr.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0

*/
component displayname="InfluencerAwardssService" persistent="false" accessors="true" output="false" extends="baseService" {
	
	property name='beanfactory';
	property name='ObjectType' type="string" default="awards";
	property name='tableName' type="string" default="awards";
	property name='ObjectIDProp' type="string" default="awardid";
	
	public void function init() {
		SUPER.init();
	}
	
	
}
