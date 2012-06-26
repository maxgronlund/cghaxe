package;


import flash.events.IEventDispatcher;
import flash.geom.Point;


interface IController implements IEventDispatcher
{
  function init():Void;
	function setParam(param:IParameter):Void;
	function getController(c:String):IController;
	function setView(id:String, view:IView):Void;
	
	
	function setString(id:String, s:String):Void;
	function setFloat(id:String, f:Float):Void;
	function setInt(id:String, i:Int):Void;
	function setXml(id:String, xml:Xml):Void;
	function setDynamic(id:String, index:UInt, obj:Dynamic):Void;
	function setPoint(id:String. p:Point):Void;
// getters	
	function getString(s:String):String;
	function getFloat(s:String):Float;
	function getInt(s:String):Int;
	function getBool(s:String, index:UInt):Bool;
	function getXml(id:String):Xml;
	function getDynamic(id:String, index:UInt):Dynamic;
	function getPoint(id:String):Point;

		


}
