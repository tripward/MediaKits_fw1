component persistent="false" accessors="true" output="false" extends="baseService" {

	property name='beanfactory';
	property name='ObjectType' type="string" default="InfluencerAccount";
	property name='tableName' type="string" default="InfluencerAccounts";
	property name='ObjectIDProp' type="string" default="influenceraccountid";
	property name='tablename' type="string" default="InfluencerAccounts";

	public any function init() {
		SUPER.init();
		return this;
	}
	
	public any function new() {
		return SUPER.new();
	}
	
	public any function doesAccountExist(required string email='') {

		var accountExists.recordCount = 0;
		
		accountExists=QueryExecute(("SELECT email FROM #variables.tableName# WHERE email = :email"),{email=arguments.email},
		{datasource="#variables.datasource#"});
		/*WriteDump(var=accountExists.recordCount,top=2,label='goo', abort=true);*/
		return accountExists.recordCount;
	}
	
	public any function getQueryByAttributes(required struct searchCriteria) {


		
		accountExists=QueryExecute(("SELECT influenceraccountid,firstname,lastname,email FROM #variables.tableName# WHERE email = :email"),{email=arguments.email},
		{datasource="#variables.datasource#"});
		/*WriteDump(var=accountExists.recordCount,top=2,label='goo', abort=true);*/
		return accountExists.recordCount;
	}
	
	public any function getSurferProperties(required string username) {

		local.surferprops=QueryExecute(("SELECT influenceraccountid,firstname,lastname,email FROM #variables.tableName# WHERE email = :email"),{email=arguments.username});
		return local.surferprops;
	}
	
	public any function getByLoginCreds(required string username='', required string password='' ) {

		try {
			local.account = QueryExecute("SELECT influencerAccountID
			FROM influencerAccounts
			WHERE email = ( :username)",        
			 {username={value='#arguments.username#', CFSQLType='cf_sql_char'}});        
		} catch (any e) {        
			WriteDump(var=e,top=3,label='error catch getByLoginCreds', abort=true);        
		} 
		/*WriteDump(var=local.account,top=2,label='goo', abort=true);*/
		return local.account;
	}
	
	public any function getAccountIDLoginCreds(required string username='', required string password='' ) {
		var local.accountIDQry = '';
		
		/*local.accountID = QueryExecute(("SELECT influenceraccountid FROM #variables.tableName# WHERE email = :email AND password = :password"),{email=arguments.username,password=arguments.password},*/
		local.accountQuery = QueryExecute(("SELECT COUNT(influenceraccountid) FROM #variables.tableName# WHERE email = :email"),{email=arguments.username},
		{datasource="#variables.datasource#"});
		
		if (local.accountQuery.recordCount) {
			local.accountID = local.accountQuery.influenceraccountid;
		}
		WriteDump(var=local.accountIDQry,top=2,label='goo', abort=true);

		return local.accountID;
	}
	
	public any function getByUsername(required string email='') {
		var result = '';
		if ( Len( trim( arguments.email )) ) {
			result = variables.getBean(variables.ObjectType).loadBy(email=arguments.email);
		} else {
			result = new();
		};
		return result;
	}


}
