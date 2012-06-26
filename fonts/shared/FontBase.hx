package;
import flash.events.Event;
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFieldType;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormatAlign;

import flash.Lib;
import flash.display.MovieClip;
//import flash.events.Event;

class FontBase extends MovieClip
{
//	private var formatedText:FormatedText;
  private var textField:TextField;
  private var textFormat:TextFormat;
  
  
  
  public function new()
  {
    var consoleSender:ConsoleSender = new ConsoleSender();
    
    super();
    Lib.current.font  = this;	
    //trace('new');
    
  }

  public function init(size:Int, color:UInt, align:String, text:String, leading:Int, letterSpacing:Int):Void{
    
    var font:Font     = new MyFont();
    
    textFormat 			                = new TextFormat();
    textFormat.font                 = font.fontName;
    textFormat.size                 = size;
    textFormat.color                = color;
    textFormat.leading              = leading;
    textFormat.letterSpacing        = letterSpacing;
    setTextFormatAlign(align);
    
                                    
    textField                       = new TextField();
    textField.useRichTextClipboard  = true;
    textField.defaultTextFormat     = textFormat;
    textField.type                  = TextFieldType.INPUT;
    setFieldAlign(align);                
    textField.embedFonts	          =	true;
    textField.multiline		          =	true;
    textField.selectable            = false;
    //textField.wordWrap		          = false;
    //textField.border		          	= false;
    textField.borderColor	          = 5789784;
    textField.text				          = text;
    Lib.current.addChild(textField);
    textField.scaleX = 150/71;
    textField.scaleY = 150/71;


  }
  public function getText(): String{
    return textField.text;
  }
  
  public function setFocus( b:Bool ): Void{
  	textField.border 	= b;
  }
  
  public function selectable(b:Bool):Void{
    textField.selectable    = b;
    textField.doubleClickEnabled = b;
    textField.mouseEnabled = b;
  }
  

  
  private function setTextFormatAlign( align:String ): Void {
    
    switch (align)
    {
      case 'left':
        textFormat.align    = TextFormatAlign.LEFT;
      case 'center':        
        textFormat.align    = TextFormatAlign.CENTER;
      case 'right':         
        textFormat.align    = TextFormatAlign.RIGHT;
    }
  }
  
  private function setFieldAlign( align:String ): Void {
    
    switch (align)
    {
      case 'left':
        textField.autoSize = TextFieldAutoSize.LEFT;
      case 'center':
        textField.autoSize = TextFieldAutoSize.CENTER;
      case 'right':
        textField.autoSize = TextFieldAutoSize.RIGHT;
    }
  }

  public function getXml():String{
    
    var escapedText:String = StringTools.htmlEscape(getText());
    
  	var str:String = '\t\t\t<text>'   + escapedText+ '</text>\n';
              str += '\t\t\t<html>'   + textField.htmlText + '</html>\n';
    
    return str;
  }
  
  public function getWidth():Float{
    return textField.width;
  }
  
}

