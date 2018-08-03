dsfbsfgbfbgdfgbfdgbswitch(rc.mediakitTemplate) {        
			case "1":        
				 /*variables.fw.redirect(path='/infuencer-profile/generate-media-kit/?influenceraccountid=#rc.newAccount.getID()#', action='',preserve='ALL',queryString='');*/
				         
				 variables.fw.redirect(path='/infuencer-profile/generate-media-kit/?mediakitsFunctionsaction=generateMediaKit:main.mediakit_template_1',preserve='ALL',queryString='');
				break;        
			case "2":        
				 WriteOutput("I like Oranges");        
				break;        
			default:        
				WriteOutput("I like fruit");        
		}