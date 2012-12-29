import flash.events.Event;
import flash.events.TextEvent;
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.text.TextFieldType;
import flash.text.TextFormatAlign;
import flash.net.URLRequest;

class FormatedText extends Sprite
{
  private var textField:TextField;
  private var text:String;
  private var format:TextFormat;
  private var fontSize:Int;
  private var ediable:Bool;
  private var color:UInt;
  private var link:String;
  private var sizeX:Int;
  
  public function new(font:String, text:String, fontSize:Int, ediable:Bool, color:UInt = 0x111111, sizeX = -1){
    super();
    this.text         = text;
    this.fontSize	    = fontSize;
    this.ediable      = ediable;
    this.color        = color;
    this.sizeX        = sizeX;
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
	  
	  if (textField != null)
    textField.text                  = str;
  }
  
  public function appendText(str:String):Void {
    textField.text                  = str;
  }
  
  private function configureLabel():Void {
    textField = new TextField();
    
    if(sizeX != -1){
      textField.wordWrap            = true; 
      textField.width               = sizeX;
    }                               
    
    
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
  
  
  public function getWidth():Float {
	 
	  if (textField == null) return 0;
    return textField.width;
  }
  
  public function getTextWidth():Float {
	 
	  if (textField == null) return 0;
    return textField.textWidth;
  }
  
  public function getHeight():Float{
    return textField.height;
  }
  
  public function setFocus(b:Bool):Void{
    textField.border 	= b;
    textField.mouseEnabled = b;
  }
  
  public function setColor(color:Int):Void{
    if(textField != null)
      textField.textColor = color;
  }
  
  public function setLink(str:String):Void {
    this.link = str;
    if(str != '-'){
      textField.htmlText = '<A href="event:' + str + '">' + 'Click here' + '</A>'; //urlLink is a string variable containing the url address
      textField.addEventListener(TextEvent.LINK, linkEvent);
    }
    
  }
  /*
  txtUrl.htmlText = '<A href="event:' + urlLink + '">' + urlLink + '</A>'; //urlLink is a string variable containing the url address
*/
  public function linkEvent(event:TextEvent):Void {   
      trace(event.text);
      //var link:URLRequest = new URLRequest(event.text);
      //navigateToURL(link, "_blank");
      flash.Lib.getURL(new flash.net.URLRequest(link));
  }
  
  
}