package;

import flash.display.Sprite;
//import flash.display.Stage;
import flash.events.Event;
import flash.geom.Point;

class AView extends Sprite, implements IView
{
	public function new(controller:IController):Void{
		super();
	}
	
	public function init():Void{
		trace("init: must be overriden in a subclass");
	}
	
	public function onAddedToStage(e:Event):Void{
		trace("onAddedToStage: must be overriden in a subclass");
	}
	public function onRemovedFromStage(e:Event):Void{
		trace("onRemoved: must be overriden in a subclass");
	}
	public function addView(view:AView, posX:Int, posY:Int, id:String = null):Void{
		trace("addView: must be overriden in a subclass");
	}
	public function setup(xml:Xml, f:Dynamic):Void{
		trace("setup: must be overriden in a subclass");
	}
	
	public function setParam(e:IParameter):Void{
		trace("setParam: must be overriden in a subclass");
	}
	
	public function setModel(model:IModel):Void{
		trace("setModel: must be overriden in a subclass");
	}
	
	public function showView(id:String, b:Bool):Void{
		trace("showView: must be overriden in a subclass");
	}
	
	public function connectController(id:String, controller:IController):Void{
		trace("connectController: must be overriden in a subclass");
	}

	public function update(id:String, index:Int, value:String):Void{
		trace("update: must be overriden in a subclass");
	}
	
	public function setPosX(posX:Int):Void{
		trace("setPosX: must be overriden in a subclass");
	}
	
	public function setPosY(posX:Int):Void{
		trace("setPosX: must be overriden in a subclass");
	}
	
	public function setSize(sizeX:Int, sizeY:Int):Void{
		trace("setSize: must be overriden in a subclass");
	}
	
	public function getFloat(id:String):Float{
		trace("getFloat: must be overriden in a subclass");
		return 0.0;
	}
	public function getSize():Point{
		trace("getSize: must be overriden in a subclass");
		return new Point(0,0);
	}
	
	public function getInt(id:String):Int{
		trace("getInt: must be overriden in a subclass");
		return 0;
	}
	
	public function getUInt(id:String):UInt{
		trace("getUInt: must be overriden in a subclass");
		return 0;
	}
	
	public function getModel():IModel{
		trace("getPoint: must be overriden in a subclass");
		return null;
	}
	
	public 	function setFloat(id:String, f:Float):Void{
		trace("setFloat: must be overriden in a subclass");
	}
	
	public 	function setString(id:String, s:String):Void{
		trace("setString: must be overriden in a subclass");
	}
	
	public 	function getString(id:String):String{
		trace("getString: must be overriden in a subclass");
		return null;
	}

	public function setInt(id:String, i:Int):Void{
		trace("setInt: must be overriden in a subclass");
	}
	
	public function setUInt(id:String, i:UInt):Void{
		trace("setUInt: must be overriden in a subclass");
	}
	
	public function getView(i:Int):AView{
		trace("getView: must be overriden in a subclass");
    return null;
	}
	
	public function getPosX():Float{
		trace("getPosX: must be overriden in a subclass");
    return 0;
	}
	
	public function getPosY():Float{
		trace("getPosY: must be overriden in a subclass");
    return 0;
	}
	public function enableMouse(b:Bool):Void{
		trace("enableMouse: must be overriden in a subclass");

	}
	
	public 	function setXml(id:String, xml:Xml):Void{
		trace("setXml: must be overriden in a subclass");
	}

	
	// !!! mess
	public function addColumn(title:IModel):Void{
	  trace("addColumn: must be overriden in a subclass");
	}
	
	public function updateFoilEffects(offset_offset:Float=1):Void{
	  trace("updateFoilEffects: must be overriden in a subclass");
	}
	
	public function glimmerFoils():Void{
	  trace("updateGlimmerFoils: must be overriden in a subclass");
	}
	
}


