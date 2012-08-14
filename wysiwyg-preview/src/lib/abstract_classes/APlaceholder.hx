package;



import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.display.Bitmap;

class APlaceholder extends MouseHandler{

  
  public function new(parrent:PageView, id:Int, model:IModel, text:String){	
    super();

  }
  
  public function calculateAnchorPoint(): Float {
    trace("calculateAnchorPoint: must be overriden in a subclass");
    return 0.0;
  }
  
  public function getAnchorPoint(): Float {
    trace("getAnchorPoint: must be overriden in a subclass");
    return 0.0;
  }
  
  public function getText(): Void {
    trace("getText: must be overriden in a subclass");

  }
  
  public function getXml() : String {
    trace("getXml: must be overriden in a subclass");

    return '';
  }
  
  public function onUpdatePlaceholder(event:Event):Void{
    trace("onUpdatePlaceholder: must be overriden in a subclass");
  }
  
  public function setFocus(b:Bool):Void{
    trace("setFocus: must be overriden in a subclass");
  }
  
  public function getPlaceholderType():String{
    trace("getPlaceholderType: must be overriden in a subclass");
    return 'na';
  }
  
  public function getTextField():TextField{
    trace("getTextField: must be overriden in a subclass");
    return null;
  }
  
  public function getBitmapMask():Bitmap {
    trace("getBitmapMask: must be overriden in a subclass");
    return null;
  }
  
  public function alert(b:Bool):Void
  {
     trace("alert: must be overriden in a subclass");
  }
  

}