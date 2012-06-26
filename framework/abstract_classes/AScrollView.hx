package;

import flash.display.Sprite;
import flash.display.Stage;
import flash.events.Event;
import flash.events.KeyboardEvent;

class AScrollView extends AView, implements IView
{
	public function new(controller:IController):Void{
		super(controller);
	}
	
	override public function init():Void{
		trace("init: must be overriden in a subclass");
	}
	
	public function onSiblingSelected(e:XmlEvent):Void{
		trace("onSiblingSelected: must be overriden in a subclass");

	}
	
	public function setSize(sizeX:Int, sizeY:Int):Void{
		trace("setSize: must be overriden in a subclass");
	}
	
	public function scrollTo(posX:Float, posY:Float){
		trace("scrollTo: must be overriden in a subclass");
	}
}


