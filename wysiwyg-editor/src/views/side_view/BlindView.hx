import flash.Lib;
import flash.events.Event;
import flash.display.BitmapData;
import flash.display.Bitmap;

class BlindView extends View
{
	public function new(controller:IController){	
    super(controller);
    bmpData 		= new BitmapData(SIZE.SIDEBAR_VIEW_WIDTH,SIZE.PROPERTY_INSPECTOR_HEIGHT,false,COLOR.SIDE_VIEW );
    backdrop		= new Bitmap(bmpData);
	}
	
	override public function onAddedToStage(e:Event){
		super.onAddedToStage(e);	
		backdrop.height = Lib.current.stage.stageHeight;
		addChild(backdrop);
	}
	
	override public function init():Void{
	  
	}
	
	override public function update(s:String, i:Int, t:String):Void{}
}