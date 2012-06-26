package;

import flash.events.Event;

class StringEvent extends KEvent, implements IKEvent
{
	private var str:String;
	
	public function new( label:String, param:IParameter, str:String, bubbles:Bool = false, cancelable:Bool = false ) {
		super( label ,param, bubbles, cancelable);
		this.str = str;
	}
	override public function getString():String{return str;}
	override public function getType():String{return KEvent.STRING;}
}