import flash.geom.Point;
import flash.events.Event;
import flash.events.FocusEvent;
import flash.events.TextEvent;
import flash.events.MouseEvent;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Shape;
import flash.geom.ColorTransform; 
import flash.events.KeyboardEvent;

class CustomPmsColorPicker extends View{
  
  private var pms_id:String;
  private var color:String;
  private var rgbColor:Int;
  private var colorInput:PMSColorTextField;
  //private var color_field:Shape;
  private var param:IParameter;
  private var pmsParam:IParameter;
  private var pickerBmpData:BitmapData;
  private var pickerBackdrop:Bitmap;
  
  
  public function new(controller:IController){
    super(controller);
    pms_id = EVENT_ID.PMS1_COLOR_SELECTED;
    colorInput = new PMSColorTextField();
    colorInput.setText("BLUE");
    colorInput.textField.addEventListener(KeyboardEvent.KEY_UP, onTextChange);
		colorInput.textField.addEventListener(FocusEvent.FOCUS_OUT, onTextFocusOut);
		colorInput.textField.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
   }

   override public function init():Void{
     backdrop           = new CustomPMSPickerBitmap();
     pickerBmpData      = new BitmapData(33,30,false,0x000000 );
     pickerBackdrop     = new Bitmap(pickerBmpData);
     
     //colorInput.setText(GLOBAL.pms1ColorString);
      //setInt('color', rgbColor);
     colorInput.setText('000000');
     rgbColor           = 0;
   }
   
   override public function onAddedToStage(e:Event){
     super.onAddedToStage(e);	
     addChild(backdrop);
     addChild(pickerBackdrop);
     pickerBackdrop.x = 1;
     pickerBackdrop.y = 1;
     addChild(colorInput);
     colorInput.x  = 40;
     colorInput.y  = 7;
     addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
   }
   
   private function onKeyDown(event:KeyboardEvent): Void{
     //trace(event.charCode);
     // if the key is ENTER
     if(event.charCode == 13){
       updateColor();
     }
   }
   
   private function onTextChange(e:Event){
     //trace("onTextChange");
     updateColor();
   }
   
   private function onTextFocusOut(e:Event){
    updateColor();
   }
   
   private function updateColor():Void{
     // called from the text field
     
     pmsParam.setString(colorInput.getText());
     controller.setParam(pmsParam);
   }
   
   private function setPmsColor():Void{
     
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
     
     var pixelValue:UInt = pickerBackdrop.bitmapData.getPixel(Std.int(e.localX), Std.int(e.localY));
     param.setInt(pixelValue);
     controller.setParam(param);
   }

   private function onMouseUp(e:MouseEvent){	
     stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
 		 addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
   }
   
   override public function setString(id:String, s:String):Void{
     switch ( id ){
       case 'id':{
         param = new Parameter(s);
         //Application.addEventListener( s, onColorChanged);
       }
       case 'pms_value':{
         pmsParam = new Parameter(s);
         Application.addEventListener( s, onColorChanged);
       }
       case 'pms code':{
         colorInput.setText(s);
         updateColor();
       }
     }
   }
   
   private function onColorChanged(e:IKEvent):Void{
     setInt( 'color', e.getInt() );
   }
   

   
   override public function setInt(id:String, i:Int):Void{
     switch ( id ){
       case 'color':{
         //trace(i);
         rgbColor = i;
         removeChild(pickerBackdrop);
         pickerBackdrop = null;
         pickerBmpData  = null;

         pickerBmpData    = new BitmapData(33,30,false,i );
         pickerBackdrop   = new Bitmap(pickerBmpData);
         
         addChild(pickerBackdrop);
         pickerBackdrop.x = 1;
         pickerBackdrop.y = 1;
     
        //color_field.transform.colorTransform = myColorTransform;
       }
     }
  }
}


