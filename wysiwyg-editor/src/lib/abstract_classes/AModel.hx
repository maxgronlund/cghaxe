// abstract class of models
package;


import flash.events.EventDispatcher;
import flash.events.Event;
import flash.geom.Point;
import flash.Vector;

class AModel extends EventDispatcher
{
//	public function setup():Void{
//			trace("setup: must be overriden in a subclass");
//	}
	public function init():Void{
			trace("init: must be overriden in a subclass");
	}
// setters
	public function setParam(param:IParameter):Void{
		trace("setParam: must be overriden in a subclass");
	}
	public function dispatchParameter(param:IParameter):Void{
		trace("dispatchParameter: must be overriden in a subclass");
	}
//	public function setFileUrl(xmlUrl:String, id:String):Void{
//		trace("setFileUrl: must be overriden in a subclass");
//	}
	public function setString(id:String, s:String):Void{
		trace("setString: must be overriden in a subclass");
	}
	public function setFloat(id:String, fFloat):Void{
		trace("setFloat: must be overriden in a subclass");
	}
	public function setInt(id:String, i:Int):Void{
		trace("setInt: must be overriden in a subclass");
	}
	public function setXml(id:String, xml:Xml):Void{
		trace("setXml: must be overriden in a subclass");
	}
	public function setDynamic(id:String, index:UInt ,obj:Dynamic):Void{
		trace("setDynamic: must be overriden in a subclass");
	}
	public function setModel(model:IModel):Void{
		trace("setModel: must be overriden in a subclass");
	}
	public function setPoint(id:String, p:Point):Void{
		trace("setPoint: must be overriden in a subclass");
	}
// getters
  public function getString(s:String):String{
  	trace("getString: must be overriden in a subclass");
  	return null;
  }
  public function getInt(s:String):Int{
  	trace("getInt: must be overriden in a subclass");
  	return 0;
  }
  public function setBool(id:String, b:Bool):Void{
  	trace("setBool: must be overriden in a subclass");
  }
  public function getBool(s:String):Bool{
  	trace("getBool: must be overriden in a subclass");
  	return false;
  }
  public function getFloat(s:String):Float{
  	trace("getFloat: must be overriden in a subclass");
  	return 0;
  }
  public function getXmlString(id:String):String{
  	trace("getXmlString: must be overriden in a subclass");
  	return null;
  }
  
  public function getXml(id:String):Xml{
  	trace("getXml: must be overriden in a subclass");
  	return null;
  }
  public function getDynamic(id:String, index:Int):Dynamic{
  	trace("getDynamic: must be overriden in a subclass");
  	return null;
  }
  public function getPoint(id:String):Point{
  	trace("getPoint: must be overriden in a subclass");
  	return null;
  }
  
  public function getVector(id:String):Vector<Dynamic>{
    trace("getVector: must be overriden in a subclass");
    return null;
  }
  
  public function validateString(id:String, s:String):Bool{
    trace("validateString: must be overriden in a subclass");
    return false;
  }
    
  public function getPrintPrice(units:UInt, printType:String):Float {
    trace("getPrintPrice: must be overriden in a subclass");
    return 0.0;
  }
  
  public function isGreetingUrl(url:String):Bool{
    trace("isGreetingsUrl: must be overriden in a subclass");
    return false;
  }
  
  
// dispatchers	!!! finish up later
	public function dispatchXML( label:String, xml:Xml):Void{
		trace("dispatchXML: must be overriden in a subclass");
	}
	public function calculatePrice():Void{
	  trace("calculatePrice: must be overriden in a subclass");
	}
//	public function dispatchString(label:String, str:String):Void{
//		trace("dispatchString: must be overriden in a subclass");
//	}
//	public function dispatchUICmd(label:String, str:String, param:IParameter):Void{
//		trace("dispatchUICmd: must be overriden in a subclass");
//	}
	
	




}