package;

import flash.events.Event;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.display.Shape;

//import flash.Vector;

class ScrollPaneContainerView extends View
{
	public var scrollPane:AView;
	
	public function new(controller:IController)
	{
		super(controller);
		scrollPane = new View(controller);
	}
	
	public function applyMask():Void
	{
		var mask:Shape  = new Shape();
		mask.graphics.beginFill ( 0x9900FF );
		mask.graphics.drawRect ( 0, 0, backdrop.width,backdrop.height);
		mask.graphics.endFill();
		addChild(mask);
		mask.visible = false;
		// apply mask
		this.mask = mask;
	}
//	override public function onAddedToStage(e:Event){
//		super.onAddedToStage(e);
//	}
	



}