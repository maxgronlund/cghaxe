/* Scroll pane 
* holds a sub view capable of resising
* if the viw is larger than the scroll pane scroll handles are provided
*/

import flash.events.Event;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.display.Shape;
import flash.geom.Point;


class ScrollPane extends View
{
	private var contentPane:AView;

	
	public function new(controller:IController)
	{
		super(controller);

	}
	
	override public function onAddedToStage(e:Event):Void{
		super.onAddedToStage(e);
		applyMask();
		
	}
	
	override function setSize(maskSizeX:Int, maskSizeY:Int):Void{

		mask.width = maskSizeX;
		mask.height = maskSizeY;

	}
	
	private function applyMask():Void
	{
		var mask:Shape  = new Shape();
		mask.graphics.beginFill ( 0x9900FF );
		mask.graphics.drawRect ( 0, 0, 10,10);
		mask.graphics.endFill();
		addChild(mask);
		mask.visible = false;
		// apply mask
		this.mask = mask;
	}
	
	override public function getSize():Point{
		return new Point(mask.width, mask.height);
	}
	
	override public function getFloat(id:String):Float{
		switch ( id ){
			case 'mask_height':
				if (mask == null) return 0;
				return mask.height;
		}
		return 0;
	}
}