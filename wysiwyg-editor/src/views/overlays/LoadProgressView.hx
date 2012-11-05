import flash.geom.Point;
import flash.events.Event;
import flash.display.BitmapData;
import flash.display.Bitmap;

class LoadProgressView extends View, implements IView
{
  private var rect:Rectangle;
  private var title:FormatedText;
  private var body:FormatedText;
  
  public function new(logosController:IController){	
    super(logosController);
  
    rect        = new Rectangle(450, 150, 0x000000, 0xC8C8C8, Rectangle.DRAW_LINES, Rectangle.USE_FILL);
    title       = new FormatedText('helvetica', '0.0', 16, false);
    body       = new FormatedText('helvetica', '0.0', 12, false);
    Application.addEventListener(EVENT_ID.UPDATE_LOAD_PROGRESS, onUpdateLoadProgress);
    Application.addEventListener(EVENT_ID.CLOSE_LOAD_PROGRESS, onCloseLoadProgress);
    
  }
  override public function init():Void{
    
  }
    
  override public function onAddedToStage(e:Event):Void{
    super.onAddedToStage(e);
    addChild(rect);
    addChild(title);
    title.setLabel('Loading...');
    title.x = 10;
    title.y = 10;
    
    addChild(body);
    body.setLabel('');
    body.x = 10;
    body.y = 30;
  }
  
  private function onUpdateLoadProgress(e:IKEvent):Void{
    body.setLabel(e.getString());
  }
  
  private function onCloseLoadProgress(e:IKEvent):Void{
    this.visible = false;
    
  }
  
}