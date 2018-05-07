component
	extends="baseBean"
	entityname="surfer"
	displayname="surfer"
	accessors="true"
	persistent="false" {

	// primary key
	property name="surferid" fieldtype="id" type="uuid" ormType='string' generator="uuid";

	// attributes
	property name="isLoggedIn" datatype="boolean" type="boolean"  length="2" default="0";
	property name="firstName" type="string"  length="20" default="0";
	property name="lastName" type="string"  length="20" default="0";
	property name="userName" type="string"  length="30" default="0";
	property name="influencerAccountID" type="string" length="36" default="";

}
