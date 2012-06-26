package;

class xModel extends AModel
{
//	override public function setAuthenticity(authenticity:String):Void{
//		this.authenticity = authenticity;
//	}
//	
//	override public function setSession(session:String):Void{
//		this.session = session;
//	}
	
	override public function setParam(param:IParameter):Void{
		switch(param.getType()){
			case PARAM_TYPE.XML:
				dispatchEvent(new XmlEvent(param.getLabel(), param));
			case PARAM_TYPE.STRING:
				dispatchEvent(new StringEvent(param.getLabel(),param, param.getString()));
			case PARAM_TYPE.UPDATE:
				dispatchEvent(new StringEvent(param.getLabel(),param, param.getString()));
			default:
			  dispatchEvent(new KEvent(param.getLabel(),param));
		}
	}
	
	override public function dispatchXML( label:String, xml:Xml):Void{
		var param:IParameter = new Parameter(label, PARAM_TYPE.XML);
		param.setXml(xml);
		dispatchEvent(new XmlEvent(label, param));
	}
	
	override public function dispatchParameter(param:IParameter):Void{
		switch(param.getType()){
			case PARAM_TYPE.XML:
				dispatchEvent(new XmlEvent(param.getLabel(), param));
			case PARAM_TYPE.STRING:
				dispatchEvent(new StringEvent(param.getLabel(),param, param.getString()));
			case PARAM_TYPE.UPDATE:
				dispatchEvent(new StringEvent(param.getLabel(),param, param.getString()));
			case PARAM_TYPE.DYNAMIC:
				dispatchEvent(new DynamicEvent(param.getLabel(),param, param.getDynamic()));
			case PARAM_TYPE.FONT:
				dispatchEvent(new DynamicEvent(param.getLabel(),param, param.getDynamic()));
			default:
			  dispatchEvent(new KEvent(param.getLabel(),param));
		}
	}
}