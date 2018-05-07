<cfcomponent displayname="SecurityService" extends="baseService" accessors="true" hint="I provide">

	<cfproperty name="securityConfig" type="struct" />
	<cfset variables.attackMessagePath = "/attackMessage" />
	<cfset variables.maxLoginAttempt = 9 />
	<cfset variables.theKey = "zPV4CysY92/PvYvMZQ6cPA==" />
	<!---// Path can be absolute or relative to the application cfc path.--->
	<cfset variables.antisamypolicy = "" />
	<cfset variables.securityConfig = "" />
	
	

	<cffunction name="init" access="public" returntype="any">
		<cfargument name="securityConfig" type="struct" required="true" default="#structNew()#" />
		<!---<cfdump var="#arguments#" label="cgi" abort="true" top="3" />--->
		<!---<cfparam name="arguments.securityConfig.antispamyPath" default="" type="string" />--->
		
		<cfset variables.setsecurityConfig(arguments.securityConfig) />
		
		<!---<cfset variables.antisamypolicy = arguments.securityConfig.antispamyPath />--->
		
		<cfreturn THIS />
	</cffunction>


	<cffunction name="xssCheck" returntype="void" access="public">
		<cfargument name="scope" type="struct" required="true" />
		<cfset var key = "" />
		<cfloop collection="#arguments.scope#" item="local.key">
			<cfif IsSimpleValue(arguments.scope[local.key])>
				
				<cfset variables.xssStringCheck(arguments.scope[local.key]) />
				<cfset variables.validateHTML(arguments.scope[local.key]) />
			</cfif>
		</cfloop>

	</cffunction>
	
	<cffunction name="securePassword" returntype="string" access="public">
		<cfargument name="passwordToSecure" type="string" required="true" />

		<cfreturn  arguments.passwordToSecure />
	</cffunction>
	
	<cffunction name="isPasswordComplex" returntype="string" access="public">
		<cfargument name="passwordToCheck" type="string" required="true" />
		<cfset local.isComplex = TRUE />
		<cfreturn  local.isComplex />
	</cffunction>
	
	<cffunction name="decodeScope" access="public" returntype="void" output="false">
		<cfargument name="scope" type="struct" required="true" />
		<cfset var key = "" />
		<cfloop collection="#arguments.scope#" item="local.key">
			<cfif IsSimpleValue(arguments.scope[local.key])>
				<cftry>
				<!--- do not allow multiple and mixed encodings, most likely an attack --->
				<cfset arguments.scope[local.key] = canonicalize(arguments.scope[local.key], true, true) />
				
				<cfcatch type="any">
					<!--- if logging actual string, encoded it properly for context. 
					Truncating cfcatch.logmessage so value is not included --->
					 <cfif request.isShowSecurityDebugging>
						<cfdump var="#local.key#" label="cfcatch in" abort="false" top="3" />
						<cfdump var="#cfcatch#" label="cfcatch in" abort="false" top="3" />
						<cfdump var="#arguments.scope#" label="cfcatch in" abort="true" top="3" />
					<cfelse>
						<cfset reloacteToMessage("canonicalize") />
					</cfif>
					<!---<cflog file="encodingErrors" text="#key# - #Left(cfcatch.LogMessage, Find(' in', cfcatch.LogMessage))#" type="error" application="true" />--->
					<cfset arguments.scope[key] = "" />
				</cfcatch>
				
				</cftry>
			</cfif>
			</cfloop>
	</cffunction>
	
	<cffunction name="validateHTML" access="public" returntype="void" output="false">
		<cfargument name="stringToCheck" type="string" required="true" />

		<cftry>
		<!--- do not allow multiple and mixed encodings, most likely an attack --->

		<cfset local.isSafe = isSafeHTML(arguments.stringToCheck, variables.securityConfig.getantisamypolicy())>
		
		<cfif !local.isSafe>
			<!---<cfdump var="#local.isSafe#" label="cgi" abort="true" top="3" />--->
			<cfset reloacteToMessage("notValidHTML","#arguments.stringToCheck#") />
		</cfif>
		
		<!---<cfset local.SafeHTML = getSafeHTML(arguments.stringToCheck, variables.antisamypolicy, true)>
		<cfdump var="#local.SafeHTML#" label="cgi" abort="true" top="3" />--->
		
		<cfcatch type="any">
			<!--- if logging actual string, encoded it properly for context. 
			Truncating cfcatch.logmessage so value is not included --->
			 <cfif request.isShowSecurityDebugging>
				<cfdump var="#arguments.stringToCheck#" label="cfcatch in validhtml" abort="false" top="3" />
				<cfdump var="#cfcatch#" label="cfcatch in" abort="true" top="10" />
			<cfelse>
				
			</cfif>
			<!---<cflog file="encodingErrors" text="#key# - #Left(cfcatch.LogMessage, Find(' in', cfcatch.LogMessage))#" type="error" application="true" />--->
			<cfset arguments.stringToCheck = "" />
		</cfcatch>
		
		</cftry>
			
	</cffunction>
	
	<cffunction name="xssStringCheck" returntype="void" access="public">
		<cfargument name="input" type="string" default="" />

	<!--- XSS: check for closing tags in the URL (' " and >') (" %22 and > %3E)
	 check for prompt(..); prompt%28..%29  '(' => is %28 ')' => is %29
	check for 'onmouseover'
	check for alert(...--->


	<!---ATTENTION: the security scan looks for embeded amapsands trying to catch someone inserting there own urls vars to get a catacantenation. However we have links to external links to sites that use url vars. So the question is
	how can we tell if the link is one our developer insterted or a bad person. We hanlde this on internal links by specifing the acctible vars, but for external links and the volume of them it is impossible to tell. So for
	now to fix these external links I need remove %26 from the catch.--->
	<cfset local.foo = '"<%|>|\[|%22%3E|base64|prompt%28[^.]*%29|prompt[(.)]|onmouseover|alert[(]|alert%28|alter[(]|alter%28|javascript:|javascript%3a' />
	<!---<cfif REFindNoCase('1%3Cobject|&lt;object|<object|1%3Cembed|&lt;embed|<embed|1%3Cscript|&lt;script|<script|1%3Capplet|&lt;applet|<applet|meta|1%3Ciframe|&lt;iframe|<iframe|1%3Cprompt|&lt;prompt|<prompt|:prompt',arguments.input)>--->
	<cfif REFindNoCase(local.foo,arguments.input)>
		<!---<cfdump var="#REFindNoCase(local.foo,arguments.input)#" label="cgi" abort="false" /><br />
		<cfdump var="#left(arguments.input,REFindNoCase(local.foo,arguments.input))#" label="cgi" abort="false" /><br />
		<cfdump var="#arguments.input#" label="cgi" abort="true" />--->
		<cfset reloacteToMessage("xss") />
	</cfif>

	<!--- query string too long, buffer overflow --->
	<!---<cfif len(cgi.QUERY_STRING) GT 2000>
		That wasn't very nice
		<cfabort />
	</cfif>--->

	</cffunction>
	
	<cffunction name="bufferOverFlow" returntype="void" access="public">
		<cfargument name="scope" type="struct" default="" />

		<!--- query string too long, buffer overflow --->
		<cfif len(arguments.scope.QUERY_STRING) GT 2000>
			<cfset reloacteToMessage("buffer overflow") />
		</cfif>

	</cffunction>
	
	<cffunction name="hasHPP" access="public" returntype="boolean">
		<cfargument name="acceptedVars" type="string" default="" />
		<cfargument name="theStruct" type="struct" default="structNew()" />
		<cfset local.theReturn = 0 />
		<!---<cfdump var="#arguments#" label="arguments" abort="true" />--->
		<!---list of fields that could be passed from any page--->
		<!---submit.x,submit.y are values that are added when using an image as the submit button type="image"--->
		<cfset local.baseAcceptibleVars = "q,csrfToken,init,reloadapp,FIELDNAMES,spell,submit.x,submit.y,submit,path" />
		<!---combine common and page specfifc fields --->
		<cfset local.acceptedVars = listAppend(arguments.acceptedVars,local.baseAcceptibleVars) />
		<!---<cfdump var="#local.acceptedVars#" label="local.acceptedVars" abort="true" />--->

		<!---loop over to check if the submitted fields are all part of the acceptable fields--->
		<cfloop list="#structKeyList(arguments.theStruct)#" index="local.theKey">

			<!---q is the field for the gsa search, because it is on so many pages the var paramed in the app.cfc so it always exists.
			I could have godne to every page that has accepted var list and add it or just escape here--->
			<!---csrfToken should also be added to every url var string and as above instead of adding to every acceptVarList--->
			<cfif !listFindNoCase(local.acceptedVars,local.theKey)>
				<cfif request.isShowSecurityDebugging>
					<cfdump var="#arguments#" label="cgi" abort="false" />
					<cfdump var="local.theKey is not accepted: #local.theKey#" label="cgi" abort="false" /><br>
					<cfdump var="arguments.acceptedVars: #arguments.acceptedVars#" label="cgi" abort="false" />
					<cfdump var="on page: #cgi.path_info#" label="cgi" abort="true" /> <!--- script_nameh --->
				</cfif>
				<cfset local.theReturn = 1 />
				<cfset reloacteToMessage("hpp") />
			</cfif>

		</cfloop>

		<!---<cfdump var="#cgi#" label="cgi" abort="true" />--->
		<cfreturn local.theReturn>
	</cffunction>

	<cffunction name="csrfCheck" access="public" returntype="boolean">
		<cfargument name="sessionJSID" type="string" default="" />
		<cfargument name="fieldValue" type="string" default="" />
		<cfset local.theReturn = 1 />
		<!---<cfdump var="#arguments#" label="cgi" abort="true" />--->
		<!--- COMMENTED OUT TO TEST THE SCANNER DPF--->
		<cfif arguments.fieldValue IS NOT arguments.sessionJSID>
			<cfset reloacteToMessage("csrf") />
		</cfif>
		<!---<cfdump var="#cgi#" label="cgi" abort="true" />--->
		<!---<cfdump var="#cgi#" label="cgi" abort="true" />--->
		<cfreturn local.theReturn>
	</cffunction>


    <cffunction name="incrementLoginCounter" access="public" returntype="void">
		<cfargument name="sessionVar" type="any" default="">

		<cfset arguments.sessionVar.loginattempts++ />
		<cfif arguments.sessionVar.loginattempts GTE variables.maxLoginAttempt>
			<!---<cfset reloacteToMessage(type="loginCount",message="You've unsuccessfully logged in too many times. You're account is locked for 30 minutes.") />--->
			<cflocation url="/accountlocked/" addtoken="false" />
			<cfabort />
		</cfif>
	</cffunction>

	<cffunction name="isListOfNumerics" access="public" returntype="void">
		<cfargument name="theList" type="string" default="">
		<cfargument name="theDelim" type="string" default=",">

		<cfloop list="#arguments.theList#" delimiters="#arguments.theDelim#" index="local.theListVal">
			<cfif !isNumeric(local.theListVal)>
				<!---<cfdump var="#cgi#" label="cgi" abort="true" />--->
				<cfset reloacteToMessage("listOfNum") />
			</cfif>
		</cfloop>
	</cffunction>

	<cffunction name="isListOfNumericsByScope" access="public" returntype="void">
		<cfargument name="scope" type="struct" default="#structNew()#">
		<cfargument name="varsToCheck" type="string" default=",">


		<cfloop list="#arguments.varsToCheck#" index="local.listIdx">
			<cfif structKeyExists(arguments.scope,"#local.listIdx#") AND len(arguments.scope["#local.listIdx#"])>
				<cfset isListOfNumerics(arguments.scope["#local.listIdx#"]) />
			</cfif>
		</cfloop>

	</cffunction>


	<!---i'm really not sure the functionality belongs here. i think the check should be here, but the functionality. The gsa object should be doing the checks themselves.--->
	<cffunction name="isGSAStringAltered" access="public" returntype="void">
		<cfargument name="searchString" type="struct" default="#structNew()#">
		<cfargument name="configsettings" type="struct" default="#structNew()#">
		<!---<cfdump var="#arguments#" label="cgi" abort="true" />--->


		<!---verify data types - there are a ton of data types and most are just varchar to it's tough. If you find a new datatype that needs to be checked add it here--->
		<!---<cfif structKeyExists(arguments.searchString,"ip") AND !isValidIP(arguments.searchString.ip)>
			<cflocation url="#variables.attackMessagePath#?issue=GSASearchStringAltered1" addtoken="false" statuscode="302" />
			<cfabort />
		</cfif>--->


		<!---build list of possible values--->
		<cfset local.possibleFields = structKeyList(arguments.configsettings) />
		<!---<cfset local.possibleFields = listAppend(local.possibleFields,"q") />--->
		<!---<cfset local.possibleFields = listAppend(local.possibleFields,local.fieldsReturnedFromGSA) />--->
		<!---<cfdump var="#arguments.searchString#" label="cgi" abort="true" />--->


    	<cfset hasHPP(structKeyList(arguments.configsettings),arguments.searchString) />

		<!---This check is to make sure all gsa settings are the same as the config to make sure noone modified them--->
		<!---<cfloop collection="#arguments.searchString#" item="local.listIdx">
			<cfif !listFind(arguments.configsettings.requestSpecificSettings,local.listIdx) AND structKeyExists(arguments.configsettings,"#local.listIdx#") AND arguments.searchString[#local.listIdx#] IS NOT arguments.configsettings[#local.listIdx#]>
				<cfdump var="#local.listIdx# #arguments.searchString[local.listIdx]#" label="cgi" abort="true" />
				<cflocation url="#variables.attackMessagePath#?issue=GSASearchStringAltered_#local.listIdx#_is_#arguments.searchString[local.listIdx]#" addtoken="false" statuscode="302" />
				<cfabort />
			</cfif>
		</cfloop>--->




	</cffunction>

	<cffunction name="isValidIP" access="public" returntype="boolean">
		<cfargument name="ipToCheck" type="string" default="">
		<cfset local.isValidIP = FALSE />
		<!---uncomment to check if a specific ip is valid--->
		<!---<cfset arguments.ipToCheck = "0.0.0.0" />--->
		<cfset local.ipRegEx = "\b(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b" />


		<cfif isValid("regex",arguments.ipToCheck,local.ipRegEx)>
			<cfset local.isValidIP = TRUE />
		</cfif>

		<!---<cfdump var="#local.foo#" label="cgi" abort="true" />--->
		<cfreturn local.isValidIP />
	</cffunction>

	<cffunction name="resetLoginCounter" access="public" returntype="void">
		<cfargument name="sessionVar" type="any" default="">
		
		<cfset arguments.sessionVar.loginattempts = 0 />
	</cffunction>
	
	<cffunction name="reloacteToMessage" access="public" returntype="void">
       <!---<cfheader statuscode="200" statustext="That wasn't very nice" />--->
       <cfargument name="type" type="string" default="">
       <cfargument name="Message" type="string" default="">
       
       <cfif request.isShowSecurityDebugging>
           <cfdump var="#arguments#" label="security catch in security util relocate message" abort="true" />
       </cfif>

       
       <!---removing for the time being because the scanner started to bolt on malicious 
       strings, but the attack page is escapted from security checking. figured 
       we've already caught the bad code and stoping the processing. if we did chek
       it you could fall into too many redirects if the malious code is int he url scope'--->
       <!---?type=#arguments.type#--->
       <cflocation url="#variables.attackMessagePath#?fromHandler=1" addtoken="false" statuscode="302" /> <!---&message='#urlEncodedFormat(arguments.message)#'--->
       <cfabort />
    </cffunction>

	<cffunction name="getKey" returntype="any" hint="" output="false">
		<cfreturn variables.theKey />
	</cffunction>

	<cffunction name="encryptThis" returntype="any" hint="" output="false">
		<cfargument name="toEncrypt" default="default" type="string" />

		<cfif !len(arguments.toEncrypt)>
			<cfset arguments.toEncrypt = "default" />
		</cfif>
		<!---<cfdump var="#getKey()#" label="cgi" abort="false" />--->

		<cfset local.foo = encrypt(arguments.toEncrypt, getKey(), 'AES','Hex') />
		<!---<cfdump var="#local.foo#" label="local.foo" abort="true" />--->

		<cfreturn encrypt(arguments.toEncrypt, getKey(), 'AES','Hex') />
	</cffunction>

	<cffunction name="decryptThis" returntype="any" hint="" output="false">
		<cfargument name="toDecrypt" default="default" type="string" />
		<cfif !len(arguments.toDecrypt)>
			<cfset arguments.toDecrypt = "default" />
		</cfif>
		<cfreturn decrypt(arguments.toDecrypt, getKey(), 'AES','Hex') />
	</cffunction>

<cffunction name="isBlocked" returntype="void" hint="" output="false">
	<cfargument name="struct" required="true" default="" />


	<cfif isBlockedIP(cgi)>
			<cflog file="#This.Name#_BlockedIP_record" type="warning" text="User Info: #cgi.REMOTE_ADDR#;#cgi.HTTP_USER_AGENT#;path=#cgi.scrIPT_NAME#?#cgi.queRY_STRING#">
			<cfabort />
		</cfif>
</cffunction>

<cffunction name="isBlockedIP" returntype="string" hint="" output="false">
	<cfargument name="struct" required="true" default="" />



	<cfset local.isBlocked = FALSE />

	<cfif !structKeyExists(variables,"IPArray")>
		<cfset local.IPArray = arrayNew(1)/>
		
		<!---this si the sate of az, but at times they hammer the site--->
		<!---<cfset arrayAppend(local.IPArray,"207.108.136.254") />--->
		<cfset arrayAppend(local.IPArray,"217.31.57.5") />
		<cfset arrayAppend(local.IPArray,"112.198.64.36") />
		<cfset arrayAppend(local.IPArray,"172.2.22.202") />
		<cfset arrayAppend(local.IPArray,"192.99.7.80") /><!---192.99.70.80--->
		<!---<cfset arrayAppend(local.IPArray,"127.0.0.1") />--->

		<!---Create a container so the variable doesn't have to be created over and over again - although think I need to put this int he app scope instead but i am calling it before the app is set up--->
		<cfset variables.IPArray = local.IPArray />
	</cfif>

	<!---NOTE: notice the return her so we don't have to go through the rest of the methed--->
	<cfif arrayFindNoCase(variables.IPArray,arguments.struct.REMOTE_ADDR)>
		<cfset local.isBlocked = TRUE />
	</cfif>

	<!--- i need to also handle blocks but i need to get this out now --->

	<!---We we get this far - it's false--->
	<cfreturn local.isBlocked />
</cffunction>

<cffunction name="isBot" returntype="string" hint="" output="false">
	<cfargument name="struct" required="true" default="" />

	<!---NOTICE: I'm not a big fan of it but I have mulpe returns in this method.
	I did this because this will be run on every request and I'm trying to short circiut it whereever I can--->

	<!---I wanted to get this in relativily quickly and i don't have the icf gsa user agent but I do have the IP, although it seems reasonable to have an IPS based check as well--->

	<cfset local.isBot = FALSE />

	<!---<cfif !structKeyExists(variables,"botNameArray")>
		<cfset local.botNameArray = arrayNew(1)/>
		<!---icf gsa--->
			<!---ATTENTION: in the IIS logs there are + signs, cf on the other hand strips out the plus signs--->
		<!---<cfset arrayAppend(local.botNameArray,"ICF-VNUCHGOOGLE+(Enterprise;+T3-B3AXF4BT8YWGG;+TMSClientHosting@icfi.com)") />--->
		<cfset arrayAppend(local.botNameArray,"ICF-VNUCHGOOGLE (Enterprise; T3-B3AXF4BT8YWGG; TMSClientHosting@icfi.com)") />
		<!---Googlebot gsa--->
		<cfset arrayAppend(local.botNameArray,"Mozilla/5.0 (compatible; Googlebot/2.1; http://www.google.com/bot.html)") />

		<!--- bingbot --->
		<cfset arrayAppend(local.botNameArray,"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)") />
		<cfset arrayAppend(local.botNameArray,"Mozilla/5.0 (compatible; bingbot/2.0;  http://www.bing.com/bingbot.htm)") />


		<!---hhs gsa--->
		<cfset arrayAppend(local.botNameArray,"HHSGoogle (Enterprise; T3-D5UNDAT38WSQZ; robert.calabro@hhs.gov,pedro.catacora@hhs.gov,olexiy.karakcheyev@hhs.gov)") />--->


		<!---<!---icf gsa--->
			<!---ATTENTION: in the IIS logs there are + signs, cf on the other hand strips out the plus signs--->
		<!---<cfset arrayAppend(local.botNameArray,"ICF-VNUCHGOOGLE+(Enterprise;+T3-B3AXF4BT8YWGG;+TMSClientHosting@icfi.com)") />--->
		<cfset arrayAppend(local.botNameArray,"ICF-VNUCHGOOGLE") />
		<!---Googlebot gsa--->
		<cfset arrayAppend(local.botNameArray,"Googlebot") />
		<!--- bingbot --->
		<cfset arrayAppend(local.botNameArray,"bingbot") />
		<!---hhs gsa--->
		<cfset arrayAppend(local.botNameArray,"HHSGoogle") />

		<!---Create a container so the variable doesn't have to be created over and over again - although think I need to put this int he app scope instead but i am calling it before the app is set up--->
		<cfset variables.botNameArray = local.botNameArray />
	</cfif>

	<!---NOTE: notice the return her so we don't have to go through the rest of the methed--->
	<cfloop array="#local.botNameArray#" index="local.botarrayIdx">
		<cfif arguments.struct.HTTP_USER_AGENT CONTAINS local.botarrayIdx>
			<cfreturn TRUE />
		</cfif>
	</cfloop>

	<cfif arrayFindNoCase(variables.botNameArray,arguments.struct.HTTP_USER_AGENT)>
		<cfdump var="#cgi#" label="cgi" abort="true" />
		<cfreturn TRUE />
	</cfif>--->

	<!---I didn't want to do a contains, but even though i have the full user agent list above googlebot, etc were still crawling as well as diallowed dirs--->
	<cfif !structKeyExists(variables,"botShortNameArray")>
		<cfset local.botShortNameArray = arrayNew(1)/>
		<!---icf gsa--->
		<!---ATTENTION: in the IIS logs there are + signs, cf on the other hand strips out the plus signs out of the user agent--->
		<cfset arrayAppend(local.botShortNameArray,"ICF-VNUCHGOOGLE") />
		<!---Googlebot gsa--->
		<cfset arrayAppend(local.botShortNameArray,"Googlebot") />

		<!--- bingbot --->
		<cfset arrayAppend(local.botShortNameArray,"bingbot") />

		<!--- spbot --->
		<cfset arrayAppend(local.botShortNameArray,"spbot") />

		<!--- YandexBot --->
		<cfset arrayAppend(local.botShortNameArray,"YandexBot") />

		<!--- AhrefsBot --->
		<cfset arrayAppend(local.botShortNameArray,"AhrefsBot") />

		<!--- bingbot --->
		<cfset arrayAppend(local.botShortNameArray,"isBadBoy") />

		<!--- majestic, there maybe variations of this - majestic12. just having the first part is enough --->
		<cfset arrayAppend(local.botShortNameArray,"majestic") />

		<!---hhs gsa--->
		<cfset arrayAppend(local.botShortNameArray,"HHSGoogle") />
		<!---Create a container so the variable doesn't have to be created over and over again - although think I need to put this int he app scope instead but i am calling it before the app is set up--->
		<cfset variables.botShortNameArray = local.botShortNameArray />
	</cfif>


	<!---NOTE: notice the return here so we don't have to go through the rest of the methed--->
	<cfloop array="#variables.botShortNameArray#" index="local.shortNameIndx" >
		<cfif findNoCase(local.shortNameIndx,arguments.struct.HTTP_USER_AGENT)>
			<!---<cfdump var="#cgi#" label="cgi" abort="true" />--->
			<cfreturn TRUE />
		</cfif>
	</cfloop>



	<!---keeping this in so if we want to filter on an IP it's here--->
	<cfif !structKeyExists(variables,"botIPArray")>
		<cfset local.botIPArray = arrayNew(1)/>

		<!---icf whats up--->
		<cfset arrayAppend(local.botIPArray,"50.76.14.102") />

		<!---not sure who this is but they crawl our site heavily and request 4 pages a sec --->
		<cfset arrayAppend(local.botIPArray,"66.68.181.94") />


		<!---<cfset arrayAppend(local.botIPArray,"10.24.6.7") />--->
		<!---<cfset arrayAppend(local.botIPArray,"199.223.19.6") />--->
		<!---Create a container so the variable doesn't have to be created over and over again - although think I need to put this int he app scope instead but i am calling it before the app is set up--->
		<cfset variables.botIPArray = local.botIPArray />
	</cfif>

	<!---NOTE: notice the return her so we don't have to go through the rest of the methed--->
	<cfif arrayFindNoCase(variables.botIPArray,arguments.struct.REMOTE_ADDR)>
		<!---<cflog file="cwig_greg" type="information" text="Event Name: '#cgi.HTTP_USER_AGENT#'">--->
		<cfreturn TRUE />
	</cfif>

	<!---We we get this far - it's false--->
	<cfreturn FALSE />
</cffunction>


</cfcomponent>

