import flash.geom.Point;
import flash.events.Event;
import flash.display.BitmapData;
import flash.display.Bitmap;

class InsertImageDialogView extends View, implements IView
{
  private var rect:Rectangle;
  private var title:FormatedText;
  
  public function new(logosController:IController){	
    super(logosController);
  
    rect        = new Rectangle(560, 440, 0x000000, 0xC8C8C8, Rectangle.DRAW_LINES, Rectangle.USE_FILL);
    title       = new FormatedText('helvetica', '0.0', 16, false);

  }
  override public function init():Void{
    
  }
    
  override public function onAddedToStage(e:Event):Void{
    super.onAddedToStage(e);
    addChild(rect);
    addChild(title);
    title.setLabel('Image Options');
    title.x = 20;
    title.y = 20;
  }
}