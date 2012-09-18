import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.display.BitmapData;

class GreetingsColorPicker extends View{
	
  //var bitmapData:BitmapData;
  
  public function new(controller:IController) {

    super(controller);
    backdrop = new GreetingsPickerBack();
  }
  
  override public function onAddedToStage(e:Event) {
    super.onAddedToStage(e);
    addChild(backdrop);
  }
  

  override public function showView(id:String, b:Bool):Void{
    trace(b);
    if(b){
      addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
      stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownOutside);
    } else{
      removeEventListener(MouseEvent.ROLL_OVER, onMouseOver);
      removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
      stage.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDownOutside);

    }
    this.visible = b;
    
  }
  

  
  private function onMouseOver(e:MouseEvent):Void{
    stage.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDownOutside);
    removeEventListener(MouseEvent.ROLL_OVER, onMouseOver);
    addEventListener(MouseEvent.ROLL_OUT, onMouseOut);	
    addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
  }
  
  private function onMouseOut(e:MouseEvent){
    
    removeEventListener(MouseEvent.ROLL_OUT, onMouseOut);
    removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
    addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
    // Why the frack is this broken
    //stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownOutside);
  }
  
  private function onMouseDownOutside(e:MouseEvent) {
    controller.setParam(new Parameter(EVENT_ID.NO_COLOR_SELECTED));
  }
  
  private function onMouseDown(e:MouseEvent) {
    
    var pixelValue:UInt = backdrop.bitmapData.getPixel(Std.int(e.localX), Std.int(e.localY));
    var param:Parameter = new Parameter(EVENT_ID.FONT_COLOR_SELECTED);
    param.setUInt(pixelValue);
    controller.setParam(param);
  }
}