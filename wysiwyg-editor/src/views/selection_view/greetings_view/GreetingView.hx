import flash.events.Event;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.geom.Point;
import flash.Vector;
import flash.display.Sprite;

class GreetingView extends View, implements IView
{

  private var greetingsScrollPane:AView;
  private var greetingsPane:AView;
  private var verticalScrollbar:VerticalScrollbar;
  
  public function new(selectionController:IController){	
    super(controller);
    backdrop              = new Bitmap(new BitmapData(SIZE.MAIN_VIEW_WIDTH, SIZE.MAIN_VIEW_HEIGHT,false,0xDEDEDE ));
    greetingsScrollPane   = new ScrollPane(selectionController);
    greetingsPane         = new GreetingsPane(selectionController);
    verticalScrollbar     = new VerticalScrollbar(selectionController, EVENT_ID.DESIGN_SCROLL);
  	
  }
  
  override public function onAddedToStage(e:Event){
    trace('on added to stage');
    super.onAddedToStage(e);
    	
    addChild(backdrop);
    backdrop.alpha = 0.5;
   
  }
  
}

