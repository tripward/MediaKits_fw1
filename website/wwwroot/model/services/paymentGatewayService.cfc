<cfcomponent displayname="paymentGatewayService" extends="baseService" persistent="false" accessors="true" hint="" output="false"><!--- extends="main"--->

	<cffunction name="init" access="public" output="false" returntype="any">

		<!---<cfset setbeanfactory(application['framework.one'].factory) />
		<cfset this.configure()>--->

		<cfreturn THIS />
	</cffunction>

	<cffunction name="setUpPayment" output="true" hint="Returns an list of data types">
		<cfargument name="subscriptionCriteria" type="struct">
		<cfset local.paymentInfo = {} />
		<!---<cfdump var="#local.paymentInfo#" label="cgi" abort="true" top="3" />--->
		<cfset local.paymentInfo.isSuccess = true />
		<cfset local.paymentInfo.transactionid = '1234567890' />
		<cfset structAppend(local.paymentInfo,arguments.subscriptionCriteria) />

	    <cfreturn local.paymentInfo />
	</cffunction>
	
</cfcomponent>