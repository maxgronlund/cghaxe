import flash.geom.Point;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.display.Bitmap;
import flash.display.BitmapData;

class FoilColorPicker extends View{
  
  public function new(controller:IController){
    super(controller);
  }

  override public function init():Void{
    backdrop     = new FoilPickerBitmap();
  }
 
  override public function onAddedToStage(e:Event){
  	super.onAddedToStage(e);	
  	addChild(backdrop);
   addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
  }
  
  private function onMouseOver(e:MouseEvent):Void{
    removeEventListener(MouseEvent.ROLL_OVER, onMouseOver);
    addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
    addEventListener(MouseEvent.ROLL_OUT, onMouseOut);	
  }
  
  private function onMouseOut(e:MouseEvent){
    removeEventListener(MouseEvent.ROLL_OUT, onMouseOut);
    addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
    addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
  }

  private function onMouseDown(e:MouseEvent){	
    var posY:Float = e.stageY-this.y;
    var color:String;
    
    if(posY < 32)
      color = row1(e.stageX);
    else
      color = row2(e.stageX);

    removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
    stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
    
    var param:Parameter = new Parameter(EVENT_ID.FOIL_COLOR_SELECTED);
    param.setString(color);
    controller.setParam(param);
  }
   
  private function row1(posX:Float):String{
    
    if(posX < 834){return 'Yellow';}
    else if(posX < 869){ return 'silver';}
    else{return 'gold';}
 
  }
  private function row2(posX:Float):String{
    
    if(posX < 834){return 'red';}
    else if(posX < 869){ return 'green';}
    else{return 'blue';}
  }

   private function onMouseUp(e:MouseEvent){	
     stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
 		 addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
   }
}


