import flash.geom.Point;
import flash.events.Event;
import flash.events.FocusEvent;
import flash.events.MouseEvent;
import flash.display.Bitmap;
import flash.display.BitmapData;

class CustomPmsColorPicker extends View{
  
  private var pms_id:String;
  private var colorInput:PMSColorTextField;
  
  public function new(controller:IController){
    super(controller);
    pms_id = EVENT_ID.PMS1_COLOR_SELECTED;
    colorInput = new PMSColorTextField();
    colorInput.setText("BLUE");
    //var text = colorInput.getText();
    colorInput.textField.addEventListener(Event.CHANGE, onTextChange);
		colorInput.textField.addEventListener(FocusEvent.FOCUS_OUT, onTextFocusOut);
   }

   override public function init():Void{
     backdrop           = new CustomPMSPickerBitmap();
   }
   
   public function onTextChange(e:Event){
   	//updateColor();
   }
   
   public function onTextFocusOut(e:Event){
    updateColor();
   }
   
   private function updateColor():Void{
     trace("UPDATE PMS COLOR");
   }
    
   override public function onAddedToStage(e:Event){
   	super.onAddedToStage(e);	
   	addChild(backdrop);
   	addChild(colorInput);
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
     removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
     stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
     
     var pixelValue:UInt = backdrop.bitmapData.getPixel(Std.int(e.localX), Std.int(e.localY));
     var param:Parameter = new Parameter(EVENT_ID.PMS1_COLOR_SELECTED);
     param.setUInt(pixelValue);
     controller.setParam(param);
   }

   private function onMouseUp(e:MouseEvent){	
     stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
 		 addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
   }
   
   override public function setString(id:String, s:String):Void{
     switch ( id )
     {
      case 'set_pms':
        pms_id = s;
     }
   }
}


