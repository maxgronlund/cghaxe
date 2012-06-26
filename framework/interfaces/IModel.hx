import flash.events.IEventDispatcher;
import flash.events.Event;
import flash.geom.Point;

interface IModel implements IEventDispatcher
{
//	function setup():Void;
  function init():Void;
// setters
	function setParam(param:IParameter):Void;
	function dispatchParameter(param:IParameter):Void;
//	function setFileUrl(s:String, id:String):Void;
	function setString(id:String, s:String):Void;
	function setFloat(id:String, f:Float):Void;
	function setInt(id:String, i:Int):Void;
	function setBool(id:String, b:Bool):Void;
	function setXml( id:String, xml:Xml):Void;
	function setDynamic(id:String, index:UInt ,obj:Dynamic):Void;
	function setPoint(id:String, p:Point):Void;

// getters	
	function getString(s:String):String;
	function getFloat(s:String):Float;
	function getInt(s:String):Int;
	function getBool(s:String):Bool;
	function getXml(id:String):String;
	function getDynamic(id:String, index:Int):Dynamic;
	function getPoint(id:String):Point;
	function dispatchXML(label:String, xml:Xml):Void;
}
