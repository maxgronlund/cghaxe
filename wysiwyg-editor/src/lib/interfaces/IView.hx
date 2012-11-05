package;

import flash.events.Event;
//import flash.events.KeyboardEvent;
import flash.geom.Point;
//import flash.display.Sprite;

interface IView
{
	function init():Void;
	function addView(view:AView, posX:Int, posY:Int, id:String = null):Void;
	function onAddedToStage(e:Event):Void;
	function onRemovedFromStage(e:Event):Void;
	function setParam(e:IParameter):Void;
	function showView(id:String, b:Bool):Void;
	function connectController(id:String, controller:IController):Void;
	function update(id:String, index:Int, value:String):Void;
	function setPosX(posX:Int):Void;
	function setPosY(posY:Int):Void;
	function setSize(sizeX:Int, sizeY:Int):Void;
	function getSize():Point;
	function setInt(id:String, i:Int):Void;
	function setUInt(id:String, i:UInt):Void;
	function getInt(id:String):Int;
	function getUInt(id:String):UInt;
	function getFloat(id:String):Float;
	function setFloat(id:String, f:Float):Void;
	function setString(id:String, s:String):Void;
	function getString(id:String):String;
	function setModel(model:IModel):Void;
	function getModel():IModel;
	function getView(i:Int):AView;
	function getPosX():Float;
	function getPosY():Float;
	function enableMouse(b:Bool):Void;
	function setXml(id:String, xml:Xml):Void;
	function updateFoilEffects(offset_offset:Float=1):Void;
	function glimmerFoils():Void;
	function getHeight():Int;
	
	
	function addColumn(title:IModel):Void;
}