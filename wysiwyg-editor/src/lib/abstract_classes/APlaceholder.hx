package;

import flash.display.Sprite;

import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.display.Bitmap;

class APlaceholder extends Sprite{

  
  public function new(parrent:PageView, id:Int, model:IModel, text:String, resizable:Bool = false){	
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
  
  public function updateColor( color:Int):Void{
    trace("updateColor: must be overriden in a subclass");
  }
  
  public function setFocus(b:Bool):Void{
    trace("setFocus: must be overriden in a subclass");
  }
  
  public function getPlaceholderType():String{
    trace("getPlaceholderType: must be overriden in a subclass");
    return 'na';
  }
    
  public function getStdPmsColor():String{
    trace("getStdPmsColor: must be overriden in a subclass");
    return 'na';
  }
  
  public function getPms1Color():String{
    trace("getPms1Color: must be overriden in a subclass");
    return 'na';
  }
  
  public function getPms2Color():String{
    trace("getPms2Color: must be overriden in a subclass");
    return 'na';
  }
  
  public function getFoilColor():String{
    trace("getFoilColor: must be overriden in a subclass");
    return 'na';
  }
  
  public function getPrintType():String{
    trace("getPrintType: must be overriden in a subclass");
    return 'na';
  }
  
  public function getPrintColor():String{
    trace("getPrintColor: must be overriden in a subclass");
    return 'na';
  }
  
  public function getTextField():TextField{
    trace("getTextField: must be overriden in a subclass");
    return null;
  }
  
  public function getTextFieldText():String{
    //trace("getTextFieldText: must be overriden in a subclass");
    return "na";
  }
  
  public function getBitmapMask():Bitmap {
    trace("getBitmapMask: must be overriden in a subclass");
    return null;
  }
  
  public function alert(b:Bool):Void{
     trace("alert: must be overriden in a subclass");
  }
  
  public function updateFoilEffect(offset:Float):Void{
    trace("updateFoilEffect: must be overriden in a subclass");
  }
  
  public function isGaramond():String{
    trace("updateFoilEffect: must be overriden in a subclass");
    return 'false';
  }
  
  public function setSize(width:Float, height:Float):Void{
    trace("setSize: must be overriden in a subclass");

  }
  
  //public function canResize(b:Bool):Void{
  //  trace("canResize: must be overriden in a subclass");
  //}
}
