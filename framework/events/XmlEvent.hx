package;

import flash.events.Event;

class XmlEvent extends KEvent, implements IKEvent
{


	private var xml:Xml;

	
	public function new( label:String, param:IParameter, bubbles:Bool = false, cancelable:Bool = false ) {
		super( label , param, bubbles, cancelable);
		this.xml = param.getXml();
	}

	override public function getType():String{return KEvent.XML;}

	
}