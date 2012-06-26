// abstract class of models
package;


import flash.events.EventDispatcher;
import flash.events.Event;

class ALoader extends EventDispatcher
{

	
	
	//*************************************************
	// Abstract methods
	//*************************************************
	
	public function load(url:String, eventId:String):Void{
		trace("load: must be overriden in a subclass");
	} 
	public function onLoaded(e:Event):Void{
		trace("onLoaded: must be overriden in a subclass");
	}
	
	public function onError(e:Event):Void{
		trace("onError: must be overriden in a subclass");
	}
	
}