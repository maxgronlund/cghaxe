import flash.display.MovieClip;
import flash.display.Bitmap;
import flash.events.MouseEvent;

class Checkbox extends MovieClip {
  private var checked_image:Bitmap;
  private var unchecked_image:Bitmap;
  private var checked:Bool;
  private var actOn:Dynamic;
  
  public function new(checked, actOn){
    super();
    checked_image = new CheckboxChecked();
    unchecked_image = new CheckboxUnchecked();
    this.checked=false;
    addChild(unchecked_image);
    
    this.actOn = actOn;    
    this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
    
    setChecked(checked);
  }
  
  public function isChecked():Bool{
    return checked;
  }
  
  private function onMouseDown(e:MouseEvent){
    flip();
    actOn.setChecked(checked);
  }
  
  public function setChecked(b:Bool){
    if(checked != b){
      if(b){
        removeChild(unchecked_image);
        addChild(checked_image);
      } else {
        addChild(unchecked_image);
        removeChild(checked_image);
      }
      checked = b;
    }
  }
  
  public function flip(){
    setChecked(!checked);
  }
}