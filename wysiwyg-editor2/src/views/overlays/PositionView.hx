import flash.geom.Point;
import flash.events.Event;


class PositionView extends View, implements IView
{
  private var rect:Rectangle;
  private var posX:FormatedText;
  private var posY:FormatedText;
  private var pagePosX:FormatedText;
  private var pagePosY:FormatedText;

  
  public function new(controller:IController){	
    super(controller);
  
    rect            = new Rectangle(120, 22, 0x000000, 0xC8C8C8, Rectangle.DRAW_LINES, Rectangle.USE_FILL);
    posX            = new FormatedText('helvetica', '0.0', 11, false);
    posY            = new FormatedText('helvetica', '0.0', 11, false);
    pagePosX        = new FormatedText('helvetica', '0.0', 11, false);
    pagePosY        = new FormatedText('helvetica', '0.0', 11, false);
    Application.addEventListener(EVENT_ID.UPDATE_STAGE_POSITION,  onUpdateDesktopPositionInfo );
    Application.addEventListener(EVENT_ID.UPDATE_PAGE_POSITION,  onUpdatePagePositionInfo );
    //Application.addEventListener(EVENT_ID.CLOSE_LOAD_PROGRESS, onCloseLoadPosition);

    
  }
  override public function init():Void{
    
  }
    
  override public function onAddedToStage(e:Event):Void{
    super.onAddedToStage(e);
    trace('on added to stage');
    addChild(rect);
    
    addChild(posX);
    posX.x = 2;
    posX.y = 4;
    posX.setLabel('000');
    
    addChild(posY);
    posY.setLabel('000');
    posY.x = 24;
    posY.y = 4;
    
    addChild(pagePosX);
    pagePosX.x = 64;
    pagePosX.y = 4;
    pagePosX.setLabel('000');
    
    addChild(pagePosY);
    pagePosY.setLabel('000');
    pagePosY.x = 88;
    pagePosY.y = 4;
  }
  
  private function onUpdateDesktopPositionInfo(e:IKEvent):Void{

    posX.setLabel( Std.string(e.getPoint().x) );
    posY.setLabel( Std.string(e.getPoint().y)  );
    //trace(countInfo);   <<---------- here for tracing in the console
  }
  
  private function onUpdatePagePositionInfo(e:IKEvent):Void{

    pagePosX.setLabel( Std.string(e.getPoint().x) );
    pagePosY.setLabel( Std.string(e.getPoint().y)  );
    //trace(countInfo);   <<---------- here for tracing in the console
  }
  
  private function onCloseLoadPosition(e:IKEvent):Void{

    //this.visible = false;
    
  }
  
}