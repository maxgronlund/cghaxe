import flash.events.EventDispatcher;
import flash.events.Event;




//import ParameterEvent;



class AController extends EventDispatcher
{	


	public function new(){	
		super();	
	}
	//*************************************************
	// Abstract methods
	//*************************************************
	
	public function init():Void{	
		trace("init: must be overriden in a subclass");
	}
	
	public function setParam(param:IParameter):Void{
		trace("setParam: must be overriden in a subclass");
	}
	
	public function getController(c:String):IController{
		trace("getController: must be overriden in a subclass");
		return null;
	}

	public function setView(id:String,view:IView):Void{
		trace("setView: must be overriden in a subclass");
	}	
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
	public function setDynamic(id:String, index:UInt, obj:Dynamic):Void{
		trace("setDynamic: must be overriden in a subclass");
	}
// getters
	public function getString(s:String):String{
		trace("setFileUrl: must be overriden in a subclass");
		return null;
	}
	public function getInt(s:String):Int{
		trace("setFileUrl: must be overriden in a subclass");
		return 0;
	}
	public function getBool(s:String, index:UInt):Bool{
		trace("getBool: must be overriden in a subclass");
		return false;
	}
	public function getFloat(s:String):Float{
		trace("setFileUrl: must be overriden in a subclass");
		return 0;
	}
	public function getXml(id:String):Xml{
		trace("getXml: must be overriden in a subclass");
		return null;
	}
	public function getDynamic(id:String, index:UInt):Dynamic{
		trace("getDynamic: must be overriden in a subclass");
		return null;
	}
	

}