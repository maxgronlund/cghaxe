package;

import flash.events.Event;

interface IPlaceholder{
  function getText(): Void;
  function getXml() : String;
  function onUpdatePlaceholder(event:Event):Void;
  function getAnchorPoint():Float;
  function setFocus(b:Bool):Void;
  function getPrintType():String;
  function getFoilColor():String;
  function getStdPmsColor():String;
  function getPms1Color():String;
  function getPms2Color():String;
  function updateFoilEffect(offset:Float):Void;
}
