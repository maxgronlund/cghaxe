import flash.geom.Point;
import flash.text.TextFormat;
import flash.geom.Point;

interface IParameter 
{
// setters
	function setLabel(label:String):Void;
	function setFloat(f:Float):Void;
	function setInt(i:Int):Void;
	function setUInt(ui:UInt):Void;
	function setBool(b:Bool):Void;
	function setString(str:String):Void;
	function setDynamic(obj:Dynamic):Void;
	function setXml(xml:Xml):Void;
	function setModel(model:IModel):Void;
	function setPoint(point:Point):Void;
	function setFontPackage(fontPackage:FontPackage):Void;


	
// getters
	function getLabel():String;
	function getFloat():Float;
	function getInt():Int;
	function getUInt():UInt;	
	function getBool():Bool;
	function getString():String;
	function getDynamic():Dynamic;	
	function getXml():Xml;
//	function getType():String;
	function getModel():IModel;
	function getPoint():Point;
	function getFontPackage():FontPackage;

}
