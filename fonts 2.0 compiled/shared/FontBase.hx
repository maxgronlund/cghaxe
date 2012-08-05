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
    //trace('new');
    outline = new Vector<Shape>();
    
    createAlertBox();
    createBackdrop();
    createOutline();
    
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
  
  private function createOutline():Void{
    
    // left
    createLine(new Point(-10,0), new Point(0,0));
    createLine(new Point(-10,0), new Point(0,0));
    createLine(new Point(-10,0), new Point(0,0));
                                               
    // bottom side                             
    createLine(new Point(0,0), new Point(0,10) );
    createLine(new Point(0,0), new Point(0,10) );
    createLine(new Point(0,0), new Point(0,10) );
                                               
    // right side                              
    createLine(new Point(0,0), new Point(10,0) );
    createLine(new Point(0,0), new Point(10,0) );
    createLine(new Point(0,0), new Point(10,0) );
                                               
    // top side                                
    createLine(new Point(0,0), new Point(0,-10));
    createLine(new Point(0,0), new Point(0,-10));
    createLine(new Point(0,0), new Point(0,-10));
    
  }
  
  private function createLine(start:Point, end:Point):Void{
    var line:Shape = new Shape();
    line.graphics.lineStyle(1, 0x000000, 1);
    line.graphics.moveTo(start.x , start.y); 
    line.graphics.lineTo(end.x, end.y);
    Lib.current.addChild(line);
    outline.push(line);
  }
  
  public function textInputCapture(event:Event):Void { 
    resizeBackdrop();
    placeholderView.hitTest();
  }
  
  private function createAlertBox():Void{
    
    alertBox = new Sprite();
    Lib.current.addChild(alertBox);
    alertBox.graphics.lineStyle(1/scale,0xff0000);
    alertBox.graphics.beginFill(0xff8888);
    alertBox.graphics.drawRect(0,0,100,100);
    alertBox.graphics.endFill();
    alertBox.visible = false;
    
  }
  
  private function createBackdrop():Void{

    backdrop = new Sprite();
    Lib.current.addChild(backdrop);
    backdrop.graphics.lineStyle(1/scale,0x888888);
    backdrop.graphics.beginFill(0xffffff);
    backdrop.graphics.drawRect(0,0,100,100);
    backdrop.graphics.endFill();
  }

  private function resizeBackdrop():Void{
    resizeAlertBox();
    resizeBack();
    drawCuttingMarks();
  }
  
  private function resizeBack():Void{
    backdrop.width        = 16+textField.width-(scale*combindeMargins);
    backdrop.height       = textField.height;
    backdrop.x            = textField.x + combindeMargins;
  }
  
  private function resizeAlertBox():Void{
    alertBox.width        = 16+textField.width-(scale*combindeMargins);
    alertBox.height       = textField.height;
    alertBox.x            = textField.x + combindeMargins;
  }
  
  private function drawCuttingMarks():Void{
    // left 
    drawVertical( 0, backdrop.x, outline);
    // bottom
    drawHorizontal( 3, textField.height,outline);
    // right
    drawVertical( 6, backdrop.x+backdrop.width,outline );
    // top
    drawHorizontal( 9, 0,outline);
  }
  
  private function drawHorizontal(offset:UInt, posY:Float,lines:Vector<Shape>):Void{
    
    lines[offset].x    = backdrop.x;
    lines[offset+1].x  = backdrop.x + (backdrop.width/2);
    lines[offset+2].x  = backdrop.x + backdrop.width;
    
    lines[offset].y    = posY;
    lines[offset+1].y  = posY;
    lines[offset+2].y  = posY;
  }
  
  private function drawVertical(offset:UInt, posX:Float,lines:Vector<Shape>):Void{
     
     lines[offset].x    = posX;
     lines[offset+1].x  = posX;
     lines[offset+2].x  = posX;
 
     lines[offset].y    = 0;
     lines[offset+1].y  = backdrop.height/2;
     lines[offset+2].y  = backdrop.height;
  }
  
  public function setText(text:String):Void{
    textField.text = text;
  }
  
  public function getText(): String{
    return textField.text;
  }
  
  public function setFocus( b:Bool ): Void{
    
    backdrop.visible = b;
    resizeBackdrop();
    for( i in 0...outline.length){
      outline[i].visible = b;
    }
  }
  
  public function selectable(b:Bool):Void{
    //trace(b);
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
    //trace('getXml');
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
    alertBox.visible = b;
  }
}



