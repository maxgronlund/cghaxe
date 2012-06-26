package;

import flash.events.Event;

class AddThumbsEvent extends AEvent, implements IKEvent
{
	private var pageThumbs:Vector<PageThumbModel>;  //!!! wouaw not right only one modell 
	
	public function new( label:String, pageThumbs:Vector, bubbles:Bool = false, cancelable:Bool = false ) {
		super( label ,bubbles, cancelable);
		this.pageThumbs = pageThumbs;
	}
	
	override public function getParam():IParameter
	{
		return param;
	}
	override public function getLabel():String
	{
		return param.getLabel();
	}
	
	override public function getFloat():Float
	{
		return param.getFloat();
	}
	
	override public function getBool():Bool{
		return param.getBool();
	}
	
	override public function getString():String{
		return param.getString();
	}
	
	public function getThumbs():Vector{
		
	}
}