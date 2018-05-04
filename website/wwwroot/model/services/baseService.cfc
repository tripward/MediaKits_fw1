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

	public any function getGUID() {
		var uuidLibObj = createobject("java", "java.util.UUID");
   		var guidStr = uuidLibObj.randomUUID().toString();
   		return guidStr;
	}
	
	 //end initialConfigure
	
	
	
	public any function getFBInfo(required any account='') {

		var facebookResponse = {};
		
		var local.hoo = cfhttp(url="https://graph.facebook.com/v2.1/me/friends?AccessToken=EAAcrAkgFkjYBAPa9R0icRxkzbklkAb3oYuN0S2AJhSYAAH7l9t9hITkzpjNNY1kaYkhhQIj5NJPGUTv5f3eEZAj8eOiHJhYrIeS4H09QcAkejJwztDzCLVZB4u1teHSl4NcAQmV3ijgyMiMIzRZBx9ZBA5dPeRoZD" ,result="local.callResponse");
		WriteDump(var=llocal.hoo,top=2,label='goo', abort=true);
		return local.callResponse;
	}
	
	
	

}


/*<cffunction name="configure" access="public" output="false" returntype="any" hint="I loop over all local nd and extended objects' properties, set defaults where possible and return a fully configured default object">


		<!---<cfdump var="#collectAllProperties(getMetadata(THIS))#" label="cgi" abort="true" />--->

		<cftry>

			<cfloop array="#collectAllProperties(getMetadata(THIS))#" index="local.theProp">

				<!---create the set method name--->
				<cfset var theMethod = this["set" & local.theProp.name] />

				<!---if it is a simple variable and there is a default value including empty string set it--->
				<cfif listFind("string",local.theProp.type) AND structKeyExists(local.theProp,"default")><!---numeric--->

					 <cftry>

						 <cfset theMethod(rTrim(trim(local.theProp.default))) />

						 <cfcatch type="any">
							 <cfdump var="#local.theProp.name#" label="k" abort="false" />
							 <cfdump var="#cfcatch#'" label="k" abort="true" />
							 <cfabort />
						 </cfcatch>

					</cftry>

				</cfif>

				<cfif local.theProp.type IS "numeric" AND structKeyExists(local.theProp,"default") AND len(trim(local.theProp.default))><!---numeric--->

					 <cftry>

						 <cfset theMethod(rTrim(trim(local.theProp.default))) />

						 <cfcatch type="any">
							 <cfdump var="#local.theProp.name#" label="k" abort="false" />
							 <cfdump var="#cfcatch#'" label="k" abort="true" />
							 <cfabort />
						 </cfcatch>

					</cftry>

				</cfif>

				<cfif listFind("boolean",local.theProp.type) AND structKeyExists(local.theProp,"default")><!---numeric--->

					 <cftry>

						<!---I'm not really sure I want to set a boolean if it doesn;t have a value in the database, howevr
						a boolean without a value isn't a boolean - it's an error--->
						<cfif len(local.theProp.default)>
							<cfset theMethod(rTrim(trim(local.theProp.default))) />
						<cfelse>
							<cfset theMethod(0) />
						</cfif>

						 <cfcatch type="any">
							 <cfif request.isShowErrorDebugging>
							 	<cfdump var="#local.theProp.name#" label="k" abort="false" />
							 	<cfdump var="#cfcatch#'" label="cfcatch" abort="true" />
							</cfif>
						 </cfcatch>

					</cftry>

				</cfif>

				<!---CF9 won't set a default value of an array--->
				<cfif listFind("array",local.theProp.type)>

					 <cftry>

						 <cfset theMethod(arrayNew(1)) />

						 <cfcatch type="any">
							 <cfif request.isShowErrorDebugging>
								 <cfdump var="#local.theProp#" label="k" abort="false" />
								 <cfdump var="#cfcatch#'" label="cfcatch" abort="true" />
							 </cfif>
						 </cfcatch>

					</cftry>

				</cfif>

			</cfloop>

			<!---<cfdump var="#this.getFormats()#" label="cgi" abort="true" />--->

			<cfcatch type="any">
				 <!---<cfdump var="#cgi#'" label="getMetaData(this)" abort="false" />--->
				 <cfif request.isShowErrorDebugging><cfdump var="#cfcatch#'" label="cfcatch in configure in basebean" abort="true" /></cfif>
			 </cfcatch>

			</cftry>
<!---<cfdump var="#arguments#" label="cgi" abort="false" />
<cfdump var="#this#" label="cgi" abort="true" />--->
		</cffunction>*/
