package;

import flash.events.Event;

class DynamicEvent extends KEvent, implements IKEvent
{
	private var obj:Dynamic;
	
	public function new( label:String, param:IParameter, obj:Dynamic, bubbles:Bool = false, cancelable:Bool = false ) {
		super( label ,param, bubbles, cancelable);
		this.obj = obj;
	}
	override public function getDynamic():Dynamic{return obj;}
	override public function getType():String{return KEvent.DYNAMIC;}
}