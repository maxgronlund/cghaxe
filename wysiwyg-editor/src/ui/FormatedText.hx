import flash.events.Event;
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.text.TextFieldType;
import flash.text.TextFormatAlign;

class FormatedText extends Sprite
{
  private var textField:TextField;
  private var text:String;
  private var format:TextFormat;
  private var fontSize:Int;
  private var ediable:Bool;
  private var color:UInt;
  
  public function new(font:String, text:String, fontSize:Int, ediable:Bool, color:UInt = 0x111111){
    super();
    this.text         = text;
    this.fontSize	    = fontSize;
    this.ediable      = ediable;
    this.color        = color;
    format            = new TextFormat();
    format.font       = font;
    addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    
  }
  
  private function onAddedToStage( e:Event ): Void{
    removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    configureLabel();
    setLabel(text);
  }
  public function setLabel(str:String):Void {
    textField.text                  = str;
  }
  
  public function appendText(str:String):Void {
    textField.text                  = str;
  }
  
  private function configureLabel():Void {
    textField = new TextField();
    textField.useRichTextClipboard  = ediable;
    textField.selectable            = ediable;	 
    textField.border 		            = false;
    textField.borderColor           = 0x999999;
    textField.autoSize 	            = TextFieldAutoSize.LEFT;
    textField.multiline             = true;
    textField.background            = false;                   
    format.color                    = color;
    format.size                     = fontSize;
    format.underline                = false;
    textField.defaultTextFormat     = format;
    addChild(textField);  
  }
  
  public function getText():String{
    return textField.text;
  }
  
  public function getWidth():Float{
    return textField.width;
  }
  
  public function setFocus(b:Bool):Void{
    textField.border 	= b;
    textField.mouseEnabled = b;
  }
  
  public function setColor(color:Int):Void{
    if(textField != null)
      textField.textColor = color;

  }
  
}