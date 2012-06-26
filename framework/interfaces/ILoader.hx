package;

import flash.events.Event;
import flash.events.IEventDispatcher;

interface ILoader  implements IEventDispatcher
{
	function load(url:String, eventId:String):Void; 
	function onLoaded(e:Event):Void;
	function onError(e:Event):Void;
}
