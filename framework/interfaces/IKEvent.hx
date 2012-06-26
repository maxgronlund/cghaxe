import flash.text.TextFormat;
import flash.geom.Point;

interface IKEvent
{
	function getParam():IParameter;
	function getLabel():String;
	function getFloat():Float;
	function getInt():Int;
	function getBool():Bool;
	function getXml():Xml;
	function getString():String;
	function getDynamic():Dynamic;
	function getType():String;
	function getFontPackage():FontPackage;
	function getPoint():Point;
}
