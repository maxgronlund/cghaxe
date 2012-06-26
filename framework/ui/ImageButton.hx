import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.display.Bitmap;
import flash.geom.Point;

class ImageButton extends MouseHandler
{
//	private var multiStateImage:MultiStateImage;
	private var bmp:Bitmap;
	
	public function new(bmp:Bitmap)
	{
		super();
		this.bmp = bmp;
		//multiStateImage = new MultiStateImage(bmp, size);
		addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
	}
	
	private function onAddedToStage(e:Event):Void{
		addChild(bmp);
	}

	override private function onMouseDown(e:MouseEvent)
	{	
	  super.onMouseDown(e); 
	  trace('mouse down');
	} 
}