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
	
	public function setParam(param:IParameter):Void{
		trace("setParam: must be overriden in a subclass");
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
	public function setPoint(id:String, p:Point):Void{
		trace("setPoint: must be overriden in a subclass");
	}
	
	
// getters
	public function getController(id:String):IController{
		trace("getController: must be overriden in a subclass");
		return null;
	}
	public function getPoint(id:String):Point{
		trace("getPoint: must be overriden in a subclass");
		return null;
	}
	public function getString(id:String):String{
		trace("getString: must be overriden in a subclass");
		return null;
	}
	public function getInt(id:String):Int{
		trace("getInt: must be overriden in a subclass");
		return 0;
	}
	public function getBool(id:String, index:UInt):Bool{
		trace("getBool: must be overriden in a subclass");
		return false;
	}
	public function getFloat(id:String):Float{
		trace("getFloat: must be overriden in a subclass");
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