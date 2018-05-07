component accessors=true {


	public function init(fw) {
		variables.fw = fw;
		rc.errors = {};
	}


	public void function before(required struct rc) {
		param name="rc.errors" type="struct" default="#structNew()#";
		param name="rc.validationMessages" type="struct" default="#structNew()#";
	}

}
