component {
	
	include '/mediakits_env/requestSettings.cfm';
	include '/mediakits_env/mappings.cfm';
	
	this.name = "mediakitsapiCatches_#hash(GetCurrentTemplatePath())#";
	this.clientmanagement="true";
	this.setClientCookies = "false";
	this.sessionmanagement = "true";
	this.sessiontimeout="#createtimespan(0,1,0,0)#";
	this.applicationtimeout="#createtimespan(5,0,0,0)#";
	this.datasource = "mediakits";
	this.ormenabled = "true";
	this.dbcreate = "update";
	this.scriptProtect = "all";

 
	
	function setupApplication() {

		include '/mediakits_env/applicationSettings.cfm';

		application.securityConfig = CreateObject('component', 'model.beans.securityConfig').init();
		application.su = CreateObject('component', 'model.services.SecurityService').init(application.securityConfig);

	}
	
	function setupSession() {
		
		if (!structkeyExists(session,'surfer')) {
			session.surfer = variables.getBeanFactory().getBean('surfer');
		}

	}
	
	
	function setupRequest() {
		
		include '/mediakits_env/requestSettings.cfm';
		include '/mediakits_env/mappings.cfm';
		
	}
	
	function onError(exception) {
		// use setupRequest to do initialization per request
		WriteDump(var=arguments,top=10,label='in onError', abort=true);
	}
	
	

}
