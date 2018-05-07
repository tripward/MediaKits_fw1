component persistent="false" accessors="true" output="false" extends="baseService" {

	property name='beanfactory';
	property name='ObjectType' type="string" default="demographic";
	property name='tableName' type="string" default="demographics";
	property name='ObjectIDProp' type="string" default="demographicid";
	
	public any function init() {
		SUPER.init();
		
		if (!arrayLen(variables.list())) {
			insertDefaults(); 
		}
		
		return this;
	}
	
	public any function getOptionList() {
		
		var optionList = '';

		for(row IN variables.getQuery()){
		  optionList = ListAppend(optionList, row.demographicid & '|' & row.name, '^');
		}

		return optionList;
	}
	
	public any function getQuery(required string email='') {
		
		local.results=QueryExecute("SELECT * FROM #variables.tableName# ORDER BY sortOrder");
		/*WriteDump(var=accountExists.recordCount,top=2,label='goo', abort=true);*/
		return local.results;
	}
	
	

	
	
	public any function insertDefaults() {
		local.demos = [];
		
		local.demo = variables.factory.getBean(variables.objectType);
		local.demo.setName('Male 18-25');
		local.demo.setKeywords('dumb broke');
		local.demo.setDescription('dumb and broke and easily taken advantage of');
		local.demo.setSortOrder(1);
		arrayAppend(local.demos, local.demo);
		
		local.demo = variables.factory.getBean(variables.objectType);
		local.demo.setName('Male 26-39');
		local.demo.setKeywords('disposiable income');
		local.demo.setDescription('not dumb, but still not smart, still easy');
		local.demo.setSortOrder(2);
		arrayAppend(local.demos, local.demo);
		
		local.demo = variables.factory.getBean(variables.objectType);
		local.demo.setName('Male 40-59');
		local.demo.setKeywords('saving for retirement');
		local.demo.setDescription('already married, but looking');
		arrayAppend(local.demos, local.demo);
		
		local.demo = variables.factory.getBean(variables.objectType);
		local.demo.setName('Male 60+');
		local.demo.setKeywords('retired');
		local.demo.setDescription('Bingo anyone?');
		local.demo.setSortOrder(3);
		arrayAppend(local.demos, local.demo);
		
		for (demo in local.demos) {
			try {
				entitySave(demo);
			} catch (any e) {
				WriteDump(e);abort;
			} 
		}
		
		ormFlush();

	}

}
