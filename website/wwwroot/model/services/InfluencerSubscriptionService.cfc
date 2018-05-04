component persistent="false" accessors="true" output="false" extends="baseInfluencerService" {

	property name='ObjectType' type="string" default="InfluencerSubscription";
	property name='iteratorVariableName' type="string" default="InfluencerSubscriptions";
	property name='ObjectIDProp' type="string" default="Subscriptionid";
	property name='tablename' type="string" default="custom_influencersubscriptions";
	
	
	public any function init() {
		
		SUPER.init();
		
		if (!arrayLen(variables.list())) {
			insertDefaultSubscriptions(); 
		}

		return this;
	}
	
	public any function get(string id='') {
		var result = '';
		if ( Len( trim( arguments.id )) ) {
			result = variables.factory.getBean(variables.ObjectType).loadBy(subscriptionid=arguments.id);
		} else {
			result = new();
		};
		return result;
	}
	
	
	public any function list() {
		local.list = entityLoad('InfluencerSubscriptions');
		return entityLoad('InfluencerSubscriptions');
	}

	public void function save(required any InfluencerSubscription) {
		var newID = '';
		
		if ( Len(arguments.InfluencerSubscription.getID()) ) {
			lock scope='session' type='exclusive' timeout=10 {
				r[arguments.Influencer.getID()] = arguments.Influencer;
			};
		} else {
			lock scope='session' type='exclusive' timeout=10 {
				newID = getNextID();
				setNextID(getNextID()+1);
			};
			arguments.Influencer.setID(newID);
			lock scope='session' type='exclusive' timeout=10 {
				r[newID] = arguments.Influencer;
			};
		};
	}
	
	
		
		public any function insertDefaultSubscriptions() {
		local.subs = [];
		/*WriteDump(var=variables.factory,top=2,label='goo', abort=true);*/
		local.newSub = variables.factory.getBean(variables.objectType);
		local.newSub.setLevel('Premiere');
		local.newSub.setname('Im a good trial');
		local.newSub.setdescription('Short paid trial');
		local.newSub.setduration('3');
		local.newSub.setcost('1.00');
		arrayAppend(local.subs, local.newSub);
		
		local.newSub = variables.factory.getBean(variables.objectType);
		local.newSub.setLevel('Standard');
		local.newSub.setname('Willing to see it over time');
		local.newSub.setdescription('Long enough to ');
		local.newSub.setduration('6');
		local.newSub.setcost('5.00');
		arrayAppend(local.subs, local.newSub);
		
		local.newSub = variables.factory.getBean(variables.objectType);
		local.newSub.setname('Im all in');
		local.newSub.setLevel('Premiere');
		local.newSub.setdescription('Im all in');
		local.newSub.setduration('12');
		local.newSub.setcost('10.00');
		arrayAppend(local.subs, local.newSub);

		
		for (sub in local.subs) {
			try {
				entitySave(sub);
			} catch (any e) {
				WriteDump(e);abort;
			} 
		}
		
		ormFlush();

	}


}
