package;
import flash.events.Event;
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFieldType;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormatAlign;
import flash.events.KeyboardEvent;
import flash.display.Shape;
import flash.Vector;
import flash.geom.Point;
import flash.geom.ColorTransform;

import flash.display.Sprite;
//import flash.display.BitmapData;
//import flash.display.Bitmap;

import flash.Lib;
import flash.display.MovieClip;


class FontBase extends MovieClip
{

  private var textField:TextField;
  private var textFormat:TextFormat;
  private var scale:Float;
  private var combindeMargins:Float;
  private var backdrop:Sprite;
  private var alertBox:Sprite;
  private var outline:Vector<Shape>;
  private var placeholderView:Dynamic;
  

  
  public function new()
  {
    var consoleSender:ConsoleSender = new ConsoleSender();
    
    super();
    Lib.current.font  = this;	
    scale = 150/72;
    
  }
  
  public function getCombindeMargins():Float {
    return 150.0;
  }

  public function init( size:Int, 
                        color:UInt,
                        align:String, 
                        text:String, 
                        leading:Int, 
                        letterSpacing:Int,
                        placeholderView:Dynamic):Void
  {
    this.placeholderView = placeholderView;
    
    
    var font:Font                   = new MyFont();
    textFormat 			                = new TextFormat();
    textFormat.font                 = font.fontName;
    textFormat.size                 = size;
    textFormat.color                = color;
    textFormat.leading              = leading;
    textFormat.letterSpacing        = letterSpacing*scale;
    textFormat.leftMargin           = 75;
    textFormat.rightMargin          = 75;
    combindeMargins                 = textFormat.leftMargin + textFormat.rightMargin;
    setTextFormatAlign(align);
           
    textField                       = new TextField();
    textField.useRichTextClipboard  = true;
    textField.defaultTextFormat     = textFormat;
    textField.type                  = TextFieldType.INPUT;
    
    //textField.border               = true;
    
    setFieldAlign(align);                
    textField.embedFonts	          =	true;
    textField.multiline		          =	true;
    textField.selectable            = false;

    textField.text				          = text;
    Lib.current.addChild(textField);
    
    
    
    textField.scaleX                = scale;
    textField.scaleY                = scale;
    
    textField.x                     = 0; 
    backdrop.width                  = textField.width-(scale* combindeMargins);
    backdrop.height                 = textField.height;
    backdrop.alpha                  = 0.5;
    setFocus(false);
    textField.addEventListener(Event.CHANGE, textInputCapture);

      
  }
  
  public function textInputCapture(event:Event):Void { 
    //resizeBackdrop();
    placeholderView.textInputCapture();
  }
  
  public function setText(text:String):Void{
    textField.text = text;
  }
  
  public function getText(): String{
    return textField.text;
  }
  
  public function setFocus( b:Bool ): Void{
    //backdrop.visible = b;
    //resizeBackdrop();
    
  }
  
  public function selectable(b:Bool):Void{
    textField.selectable    = b;
    textField.doubleClickEnabled = b;
    textField.mouseEnabled = b;
  }

  private function setTextFormatAlign( align:String ): Void {
    switch (align){
      case 'left': textFormat.align       = TextFormatAlign.LEFT;
      case 'center': textFormat.align     = TextFormatAlign.CENTER;
      case 'right': textFormat.align      = TextFormatAlign.RIGHT;
    }
  }
  
  private function setFieldAlign( align:String ): Void {
    
    switch (align){
      case 'left': textField.autoSize     = TextFieldAutoSize.LEFT;
      case 'center': textField.autoSize   = TextFieldAutoSize.CENTER; 
      case 'right': textField.autoSize    = TextFieldAutoSize.RIGHT;
    }
  }

  public function getXml():String{
    var escapedText:String = StringTools.htmlEscape(getText());
  	var str:String = '\t\t\t<text>'   + escapedText+ '</text>\n';
              str += '\t\t\t<html>'   + textField.htmlText + '</html>\n';
    
    return str;
  }
  
  public function getWidth():Float{
    return textField.width*(72/150);
  }
 
  public function getTextField():TextField{
    return textField;
  }
  
  public function alert(b:Bool):Void{
    //Depricated
    //alertBox.visible = b;
  }
}



