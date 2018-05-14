component extends="framework.one" {
	
	include '/mediakits_env/requestSettings.cfm';
	include '/mediakits_env/mappings.cfm';
	
	this.name = "mediakits_#hash(GetCurrentTemplatePath())#";
	this.clientmanagement="true";
	this.setClientCookies = "false";
	this.sessionmanagement = "true";
	this.sessiontimeout="#createtimespan(0,1,0,0)#";
	this.applicationtimeout="#createtimespan(5,0,0,0)#";
	this.datasource = "mediakits";
	this.ormenabled = "true";
	this.dbcreate = "update";
	this.scriptProtect = "all";

 try {
	this.ormsettings = {
		cfclocation="model.beans",
		dbcreate="update",
		dialect = 'MySQL',
		logsql="true",
		eventHandling="true",
		flushatrequestend="false"};

		
			variables.framework = {
				// the name of the URL variable:
				action = 'action',
				// whether or not to use subsystems:
				usingSubsystems = false,
				// default subsystem name (if usingSubsystems == true):
				defaultSubsystem = 'home',
				// default section name:
				defaultSection = 'main',
				// default item name:
				defaultItem = 'default',
				// if using subsystems, the delimiter between the subsystem and the action:
				subsystemDelimiter = ':',
				// if using subsystems, the name of the subsystem containing the global layouts:
				siteWideLayoutSubsystem = 'common',
				// the default when no action is specified:
				//home = defaultSubsystem & ':' & defaultSection & '.' & defaultItem,
				// the default error action when an exception is thrown:
				//error = defaultSubsystem & ':' & defaultSection & '.error',
				// the URL variable to reload the controller/service cache:
				reload = 'reload',
				// the value of the reload variable that authorizes the reload:
				password = 'true',
				// debugging flag to force reload of cache on each request:
				reloadApplicationOnEveryRequest = true,
				// whether to force generation of SES URLs:
				generateSES = FALSE,
				// whether to omit /index.cfm in SES URLs:
				SESOmitIndex = FALSE,
				// location used to find layouts / views:
				base = "",
				// either CGI.SCRIPT_NAME or a specified base URL path:
				baseURL = 'useCgiScriptName',
				// location used to find controllers / services:
				// cfcbase = essentially base with / replaced by .
				// list of file extensions that FW/1 should not handle:
				unhandledExtensions = 'cfc',
				// list of (partial) paths that FW/1 should not handle:
				unhandledPaths = '/apiCatches',
				/*unhandledPaths = '/flex2gateway,/apiCatches/',*/
				// flash scope magic key and how many concurrent requests are supported:
				preserveKeyURLKey = 'fw1pk',
				maxNumContextsPreserved = 10,
				// set this to true to cache the results of fileExists for performance:
				cacheFileExists = false,
				// change this if you need multiple FW/1 applications in a single CFML application:
				applicationKey = 'framework.one',
		        // change this if you want a different dependency injection engine:
		        diEngine = 'di1',
		        // change this if you want different locations to be scanned by the D/I engine:
		        diLocations = 'model,controllers',
		        // optional configuration for your dependency injection engine:
		        diConfig = { },
		        // routes (for fancier SES URLs) - see the documentation for details:
		        routes = [ ],
		        routesCaseSensitive = true
				};
			
			
			} catch (any e) {
						WriteDump(e);abort;
						
						
				
			} 
	
	
	function setupApplication() {

		include '/mediakits_env/applicationSettings.cfm';
		/*WriteDump(var=this.getBeanFactory().getBean('awards'),top=2,label='goo', abort=true);*/
		/*WriteDump(var=this.getBeanFactory().getBean('securityConfig'),top=2,label='goo', abort=true);*/
		/*<cfdump var="#application['framework.one'].factory#" label="cgi" abort="true" top="3" />*/
		application.securityConfig = this.getBeanFactory().getBean('securityConfig');
		/*WriteDump(var=application.securityConfig,top=2,label='goo', abort=true);*/
		
		application.su = CreateObject('component', 'model.services.SecurityService').init(application.securityConfig);
		
/*<cfdump var="#application.securityConfig#" label="cgi" abort="true" top="3" />*/
/*<!---<cfset application.securityConfig.antispamyPath = ExpandPath('/') & "security\antiSpamyslashdot.xml" />--->*/



		
		/*WriteDump(var=application.securityConfig,top=2,label='goo', abort=true);*/
		/*application.su = CreateObject('component', 'model.services.SecurityService').init(application.securityConfig);*/
	}
	
	function setupSession() {
		
		if (!structkeyExists(session,'surfer')) {
			session.surfer = variables.getBeanFactory().getBean('surfer');
		}
/*WriteDump(var=session,top=2,label='goo', abort=true);*/
	}
	
	
	function setupRequest() {
		
		include '/mediakits_env/requestSettings.cfm';
		include '/mediakits_env/mappings.cfm';
		
		// use setupRequest to do initialization per request
		request.context.startTime = getTickCount();
		
			if (structKeyExists(url,'reload')) {
				ormReload();
			}

	}
	
	function onError(exception) {
		// use setupRequest to do initialization per request
		WriteDump(var=arguments,top=10,label='in onError', abort=true);
	}
	
	

}
