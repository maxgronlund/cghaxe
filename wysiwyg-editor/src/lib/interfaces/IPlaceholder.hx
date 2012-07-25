package;

import flash.events.Event;

interface IPlaceholder{
  function getText(): Void;
  function getXml() : String;
  function onUpdatePlaceholder(event:Event):Void;
  function getAnchorPoint():Float;
  public function setFocus(b:Bool):Void;
}
