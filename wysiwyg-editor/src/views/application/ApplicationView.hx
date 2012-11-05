import flash.events.Event;
import flash.display.BitmapData;
import flash.display.Bitmap;

class ApplicationView extends View, implements IView
{


  public function new(controller:IController){	
  	super(controller);		
  	//bmpData 	= new BitmapData(1,1,false,0xf0f0f0 );
  	//backdrop	= new Bitmap(bmpData);	
  }
  
  override public function onAddedToStage(e:Event){
    super.onAddedToStage(e);	
    
    //addChild(backdrop);
    //backdrop.height = stage.stageHeight;
    //backdrop.width = stage.stageWidth;
  }
}

