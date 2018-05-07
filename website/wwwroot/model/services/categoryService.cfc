component persistent="false" accessors="true" output="false" extends="baseService" {

	property name='beanfactory';
	property name='ObjectType' type="string" default="category";
	property name='tablename' type="string" default="categories";
	property name='ObjectIDProp' type="string" default="categoryid";
	
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
		  optionList = ListAppend(optionList, row.categoryid & '|' & row.name, '^');
		}

		return optionList;
	}
	
	public any function getQuery(required string email='') {
		
		local.results=QueryExecute("SELECT * FROM #variables.tableName# ORDER BY sortOrder");
		/*WriteDump(var=accountExists.recordCount,top=2,label='goo', abort=true);*/
		return local.results;
	}

	public any function insertDefaults() {
		local.defaults = [];
		
		local.newDefault = variables.factory.getBean(variables.objectType);
		local.newDefault.setName('cat1');
		local.newDefault.setKeywords('cat1');
		local.newDefault.setDescription('cat1');
		arrayAppend(local.defaults, local.newDefault);
		
		local.newDefault = variables.factory.getBean(variables.objectType);
		local.newDefault.setName('cat2');
		local.newDefault.setKeywords('cat2');
		local.newDefault.setDescription('cat2');
		arrayAppend(local.defaults, local.newDefault);
		
		local.newDefault = variables.factory.getBean(variables.objectType);
		local.newDefault.setName('cat23');
		local.newDefault.setKeywords('cat23');
		local.newDefault.setDescription('cat23');
		arrayAppend(local.defaults, local.newDefault);
		
		local.newDefault = variables.factory.getBean(variables.objectType);
		local.newDefault.setName('cat3');
		local.newDefault.setKeywords('cat3');
		local.newDefault.setDescription('cat3');
		arrayAppend(local.defaults, local.newDefault);
		
		for (cat in local.defaults) {
			try {
				entitySave(cat);
			} catch (any e) {
				WriteDump(e);abort;
			} 
		}
		
		ormFlush();

	}

}
