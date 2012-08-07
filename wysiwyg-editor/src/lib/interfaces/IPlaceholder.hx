package;

import flash.events.Event;

interface IPlaceholder{
  function getText(): Void;
  function getXml() : String;
  function onUpdatePlaceholder(event:Event):Void;
  function getAnchorPoint():Float;
  function setFocus(b:Bool):Void;

}
