<cfcomponent extends="framework.one" output="false">

                <cfinclude template="/cbchsdms_environment/requestSettings.cfm" />
                <cfinclude template="/cbchsdms_environment/envMappings.cfm" />

                <cfset this.name = "cbchsdms_#hash(GetCurrentTemplatePath())#" />
                <!---<cfset this.clientmanagement="true" />--->
                <cfset this.setClientCookies = "false" />
                <cfset this.sessionmanagement = "true" />
                <cfset this.sessiontimeout="#createtimespan(0,1,0,0)#" />
                <cfset this.applicationtimeout="#createtimespan(5,0,0,0)#" />
                <cfset this.datasource = "childwelfare_gateway-ims" />
                <cfset this.ormenabled = "true" />
                <cfset this.dbcreate = "update" />

                <cfset this.scriptProtect = "all" />

                <cfset this.mlsDatasource = "mls" />
                
                <cfscript>
                                this.ormsettings = {
                                cfclocation="model",
                                dbcreate="update",
                                //dialect = '',
                                logsql="true",
                                eventHandling="true",
                                //eventhandler="root.model.beans.eventhandler",
                                flushatrequestend="false"};

                </cfscript>

                <!---This is shortened version of the fw1 defaults that I change at least semi frequently
                the full list is below the snippent for reference--->
                <cfset variables.framework = {
                                action = 'action',
                                reload = 'reload',
                                reloadApplicationOnEveryRequest = request.reloadAppOnEachRequest,
                                suppressImplicitService = true,
                                usingSubsystems = true,
                                defaultSubsystem = 'home',
                                error = 'main.error',
                                siteWideLayoutSubsystem = 'home',
                                unhandledErrorCaught = true,
                                unhandledPaths = '/devtools/,/surveyDateAdmin/annual_Dates_Times/,/surveyDateAdmin/,/CWLibrarian/,/imsUpdate/,/legacy/,/LyrisMigration/,/docbox/,/testbox/',
                                maxNumContextsPreserved = 1,
                                generateSES = false,
                                trace = #request.isShowTrace#,
                                diEngine  = "di1", 
                                diLocations = "/systemAccountMaintenance/model,/home/model,/cbchsdmsum/services/,/com/services,/sgm/services,/rssAdmin/model,/compendium/model,/surveyAdmin/model,/CWLibrarian/model,/conferenceCalendar/model,/stateStatutes/model,/stateSubsidies/model,/imsUpdate/model"
                                } />


                <cffunction name="setupApplication">
                                <!---<cfset super.setupApplication() />--->
                                
                                <cfinclude template="/cbchsdms_environment/applicationSettings.cfm" />

                                <cfset application.datasource = "childwelfare_gateway-ims" />
                                  <cfset application.comDatasource = "childwelfare_uberorgs_ora" />
                                  <cfset application.rssfeedDatasource = "childwelfare_rss" />
                                  <cfset application.surveyDSN = "childwelfare_assessment-survey" />
                                  <cfset application.compendiumDSN = "childwelfare_compendium" />
                                
                                <cfset application.myLibDatasource = "childwelfare_myLibrarian"> <!---request.dsn --->
                                <cfset application.libDatasource = "childwelfare_library"> <!---request.dsn_basis --->
                                <!---<cfset application.main_dsn = "childwelfare_gateway-ims"> from cwlib folder --->
                                <!--- <cfset application.eDirectoryDatasource = "childwelfare_edirectory" /> --->
                                
                                <!---Look at the developer read me for all you can do with this--->
                                <cfset application.states = createObject("component","sgm.services.states").init() />
                                <!---<cfset application.userManagementUtils = createObject("component","sgm.services.usermanagement_Utils").init() />--->
                                <cfset application.CommonUserManagement = createObject("component","home.model.services.usermanagementoldHome").init() />

                                  <cfset application.Utils = createObject("component","home.model.services.Utils").init() />
                                <cfset application.ReportUtils = createObject("component","home.model.services.ReportUtils").init() />
                                <cfset application.SecurityUtils = createObject("component","home.model.services.SecurityUtils").init() />

                                

                                <cfset application.mlsDatasource = "cbmls" />
                </cffunction>

<!---       <cfscript>
                                function setupSubsystem(subsystem) {};
                </cfscript>--->

                <cffunction name="isSecureSite" returntype="boolean" output="no">
                                <cfscript>
                                if(cgi.server_port_secure){
                                                return true;
                                }
                                return false;
                                </cfscript>
                </cffunction>

                <cffunction name="getRootUrl" returntype="string" output="no">
                                <cfscript>
                                if(isSecureSite()){
                                                rtnStr="https://";
                                }
                                else{
                                                rtnStr="http://";
                                };

                                rtnStr & cgi.HTTP_HOST & "/";

                                return rtnStr;
                                </cfscript>
                </cffunction>


<!---
                public function setupSession() {
                                  controller('security.session');
                }
--->
                <cffunction name="setupSession" returnType="void" output="false">

                                <!--- HANDLE SESSION MANAGEMENT MANUALLY WITH TRUE PER-SESSION COOKIES --->

                                                <CFIF structKeyExists(SESSION,'sessionID') and !StructKeyExists(cookie, "jsessionid")>                  <!--- cookie.jsessionid exists --->                              
                                                                <CFCOOKIE NAME="jsessionID" VALUE="#SESSION.sessionID#" httponly="yes" secure="#cgi.server_port_secure#"> 
                                                </CFIF>

                                <!---still not sure the best place to set a seesion variable--->
                                <cfif !structKeyExists(session,"loginCounter")>
                                                <cfset session.loginCounter = 0 />
                                </cfif>

                                <!---still not sure the best place to set a seesion variable--->
                                <cfif !structKeyExists(session,"user")>
                                                <cfset session.user = createObject("component","model.cbchsdmsum.cbchsum_users").init() />
                                </cfif>
                </cffunction>
                
                
                

                <!---
                                public function setupRequest() {
                                                  if(structKeyExists(url, "init")) { // use index.cfm?init to reload ORM
                                                                                setupApplication();
                                                                                ormReload();
                                                                                location(url="index.cfm",addToken=false);
                                                  }
                                                  controller("security.authorize");
                                }
                --->
                <cffunction name="setupRequest">
                                <!--- use setupRequest to do initialization per request --->
                                <!---<cfset request.context.startTickTime = getTickCount() />--->
                                <!--- <cfdump var="#request#" label="cgi" abort="true" /> --->
                                <!---<cfif structKeyExists(url,'reload')>--->
                                
                                <cfset application.howFarBackToGetSurveyDates = "#datePart('m', now())#/#datePart('d', now())#/#datePart('yyyy', now()) - 1#" />
                                
                                <cfinclude template="/cbchsdms_environment/requestSettings.cfm" />
                                <cfinclude template="/cbchsdms_environment/envMappings.cfm" />
                                
                                <cfif request.reloadAppOnEachRequest OR structKeyExists(url,'reloadapp')>
                                                <cfset setupApplication() />
                                </cfif>
                                
                                <cfif structKeyExists(url,'init')>
                                                <cfset ormReload() />
                                                <cfset setupApplication() />
                                                <cfset structClear(session) />
                                                <cfset setupSession() />
                                                <cfset applicationStop() />
                                                <cflocation url="/">
                                                <cfabort />
                                </cfif>
                                

                                <cfset rc.title = "" />

                                <cfinclude template="/xss.cfm" />
                                
                                <cfinclude template="/hpp.cfm" />
                                <cfinclude template="/csrfCheck.cfm" />

                                <!--- must know subsystem to throw a subsystem specific error, cannot be done at app startup --->
                                <cfset variables.framework.error = getSubsystem() & ':main.error' />

                </cffunction>
                
                
                
                

                <cffunction name="onMissingView">
<!---<cfdump var="#cgi#" label="in onmissing view" abort="true" top="1" />--->
                                <cfsavecontent variable="local.myReturn">

                                                <h2>The view you selected does not exist</h2>

                                                <div>Common Reasons this could happen</div>
                                                <ul>
                                                                <li>Um, you didn't create a view .cfm</li>
                                                                <li>You misspelled something in the action variable subsystem:main.page</li>
                                                </ul>

                                                </cfsavecontent>

                                <cfreturn local.myReturn/ >
                </cffunction>

                <cffunction name="onError">
                                <cfargument name="Exception" required=true/>
                                <cfargument type="String" name="EventName" required=true/>
                                
                                <cfif request.isShowErrorDebugging>
                                                <cfscript>
                                                                local['error'] = arguments.Exception;
                                                                                
                                                                // Styles...
                                                                local['summaryItemContainerCss'] = "font-family: verdana,san-serif;"
                                                                                                                                                                & "margin-bottom: 10px;";
                                                                local['summaryItemLabelCss'] = "font-size: 50%;"
                                                                                                                                                                & "color: darkgrey;";
                                                </cfscript>
                                                <cfoutput>
                                                                <div style="#summaryItemContainerCss#">
                                                                                <div style="#summaryItemLabelCss#">
                                                                                                MESSAGE / DETAIL:
                                                                                </div>
                                                                                <cfif structKeyExists(error, "message")>
                                                                                                <div style="margin-bottom:0.5em;">
                                                                                                                <div title="Message from error root">#error.message#</div>
                                                                                                                <cfif structKeyExists(error, "detail") AND len(error.detail) >
                                                                                                                                <div title="Detail from error struct root">#error.detail#</div>
                                                                                                                </cfif>
                                                                                                </div>
                                                                                                <cfif structKeyExists(error, "rootCause")>
                                                                                                                <cfif structKeyExists(error.rootCause, "message")>
                                                                                                                                <div title="Message from RootCause"><b>#error.rootCause.message#</b></div>
                                                                                                                </cfif>
                                                                                                                <cfif structKeyExists(error.rootCause, "detail") AND len(error.rootCause.detail) >
                                                                                                                                <div title="Detail from RootCause">#error.rootCause.detail#</div>
                                                                                                                </cfif>
                                                                                                </cfif>
                                                                                <cfelse>
                                                                                                [Message not found]
                                                                                </cfif>
                                                                </div>
                                                                
                                                                <cfif structKeyExists(error, "diagnostics")>
                                                                                <div style="#summaryItemContainerCss#">
                                                                                                <div style="#summaryItemLabelCss#">
                                                                                                                DIAGNOSTICS:
                                                                                                </div>
                                                                                                #error.diagnostics#
                                                                                </div>
                                                                </cfif>
                                                                <br>
                                                                
                                                                <cfscript>
                                                                                // The TAG CONTEXT array can be in three places. Here, we'll set the node/struct
                                                                                //  that has the one we want to display...
                                                                                local['errorContextNode'] = "";
                                                                                local['errorContextName'] = "";
                                                                                if (structKeyExists(error, "rootCause") AND structKeyExists(error.rootCause, "tagContext")) {
                                                                                                local['errorContextNode'] = error.rootCause;
                                                                                                local['errorContextName'] = "RootCause";
                                                                                } else if (structKeyExists(error, "tagContext")) {
                                                                                                local['errorContextNode'] = error;
                                                                                                local['errorContextName'] = "Error Root";
                                                                                }
                                                                </cfscript>
                                                                <cfif local.errorContextNode neq "" >
                                                                                <div style="font-weight:bold; font-size: 105%; font-family:verdana,san-serif; margin-bottom:0.5em;">Tag Context (#local.errorContextName#)</div>
                                                                                <cfloop array="#local.errorContextNode.tagContext#" index="local.arrElem">
                                                                                                <cfscript>
                                                                                                                local['thisPath'] = ((structKeyExists(local.arrElem, "template")) ? local.arrElem.template : '');
                                                                                                                local['thisLineNum'] = ((structKeyExists(local.arrElem, "line")) ? local.arrElem.line : '');
                                                                                                                local['fileDir'] = listDeleteAt(local.thisPath, listLen(local.thisPath, "\"), "\");
                                                                                                                local['fileName'] = listLast(local.thisPath, "\");
                                                                                                                local['functionName'] = "";
                                                                                                                if (structKeyExists(local.arrElem, "raw_trace") ) {
                                                                                                                                local.arrayOfMatches = reMatch("func[^\.]+\.", local.arrElem.raw_trace);
                                                                                                                                if (arrayLen(local.arrayOfMatches)) {
                                                                                                                                                local['functionName'] = lcase(mid(local.arrayOfMatches[1], 5, len(local.arrayOfMatches[1])-5)) & "()";
                                                                                                                                }
                                                                                                                }
                                                                                                </cfscript>
                                                                                                <div style="#summaryItemContainerCss#">
                                                                                                                <cfif listLen(local.thisPath, "\") gt 1 >
                                                                                                                                #encodeForHTML(local.fileDir)#\<b>#encodeForHTML(local.fileName)#</b>
                                                                                                                <cfelse>
                                                                                                                                #encodeForHTML(local.thisPath)# <!--- Sometimes this = "<generated>" apparently. --->
                                                                                                                </cfif>
                                                                                                                &nbsp; &nbsp;
                                                                                                                Line: #local.thisLineNum#
                                                                                                                &nbsp; &nbsp;
                                                                                                                #local.functionName#
                                                                                                </div>
                                                                                </cfloop>
                                                                                <br>
                                                                </cfif>
                                                                
                                                                
                                                                
                                                                
                                                                <br>
                                                </cfoutput>

                                                <cfdump var="#arguments#" label="in onerror" abort="true"  />
                                </cfif>
                                
                                <!--- Log all errors. --->
                                <cflog file="#This.Name#" type="error" text="Event Name: #Arguments.Eventname#" />
                                <cflog file="#This.Name#" type="error" text="Message: #Arguments.Exception.message#" />
                                
                                <cflocation url="/index.cfm?action=home:main.error" addtoken="FALSE" />

                                <!---<cflog file="#This.Name#" type="error"
                                text="Root Cause Message: #Arguments.Exception.rootcause.message#">--->
                                <!--- Display an error message if there is a page context. --->

                                <!---<cfmail from="info@childwelfae.gov" subject="CBCHS DMS Error" to="trip.ward@icfi.com" >
                                                                <cfdump var="#arguments#" label="cgi" abort="false" />
                                                </cfmail>--->

                                <!---<cfif
                                                NOT (Arguments.EventName IS "onSessionEnd") OR
                                                (Arguments.EventName IS "onApplicationEnd")>
                                                <cfoutput>
                                                <h2>Opps.</h2>
                                                <p>Please provide the following information to technical support:</p>
                                                <!---<p>Event: #Arguments.EventName#</p>--->
                                                <!---<cfdump var=#Arguments.Exception.cause.message#>---></p>
                                                <!---<cfdump var=#listLast(Arguments.Exception.tagContext[1].template,"\")#> on line #Arguments.Exception.tagContext[1].line# column #Arguments.Exception.tagContext[1].column#</p>--->
                                                <!---<cfif request.isShowErrorDebugging>--->
                                                                <cfdump var="#Arguments.Exception#" label="Arguments.Exception" abort="true" />
                                                <!---</cfif>--->
                                                </cfoutput>
                                </cfif>--->
                                
                </cffunction>

</cfcomponent>

