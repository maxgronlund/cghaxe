package;

import flash.display.Shape;
import flash.Vector;
import flash.geom.Point;
import flash.display.Sprite;
import flash.Lib;



class Backdrop extends Sprite{

  private var scale:Float;
  private var combindeMargins:Float;
  private var backdrop:Sprite;
  private var lines:Vector<Shape>;

  
  public function new(){
    var consoleSender:ConsoleSender = new ConsoleSender();
    super();
    lines = new Vector<Shape>();
    createLines();
  }

  public function init( size:Int, 
                        color:UInt,
                        align:String, 
                        text:String, 
                        leading:Int, 
                        letterSpacing:Int):Void
  {
    updateBackdrop(0x888888);
    
    backdrop.width                  = textField.width-(scale* combindeMargins);
    backdrop.height                 = textField.height;
    backdrop.alpha                  = 0.5;

    setFocus(false);
    textField.addEventListener(Event.CHANGE, textInputCapture);
  }
   
  public function highlightBorders(b:Bool):Void{
    //trace(b);
    //!b ? backdrop.graphics.lineStyle(1/scale,0xFF0000): backdrop.graphics.lineStyle(1/scale,0x888888);
  }
  
  private function createLines():Void{
    // left
    createLine(new Point(-10,0), new Point(0,0));
    createLine(new Point(-10,0), new Point(0,0));
    createLine(new Point(-10,0), new Point(0,0));
                                    
    // bottom side                  
    createLine(new Point(0,0), new Point(0,10));
    createLine(new Point(0,0), new Point(0,10));
    createLine(new Point(0,0), new Point(0,10));
                                                
    // right side                               
    createLine(new Point(0,0), new Point(10,0));
    createLine(new Point(0,0), new Point(10,0));
    createLine(new Point(0,0), new Point(10,0));
                                    
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
    lines.push(line);
  }
  
  public function textInputCapture(event:Event):Void { 
    resizeBackdrop();
  }
  
  private function updateBackdrop(c:UInt):Void{
    if(backdrop != null){
      Lib.current.removeChild(backdrop);
      backdrop = null;
    }
      
    scale = 150/72;
    backdrop = new Sprite();
    Lib.current.addChild(backdrop);
    backdrop.graphics.lineStyle(1/scale,c);
    backdrop.graphics.beginFill(0xffffff);
    backdrop.graphics.drawRect(0,0,100,100);
    backdrop.graphics.endFill();
    backdrop.x = 100 * scale;
  }

  private function resizeBackdrop():Void{

    backdrop.width        = 16+textField.width-(scale*combindeMargins);
    backdrop.height       = textField.height;
    backdrop.x            = textField.x + combindeMargins;
    drawCuttingMarks();
  }
  
  private function drawCuttingMarks():Void{
    // left 
    drawVertical( 0, backdrop.x);
    // bottom
    drawHorizontal( 3, textField.height);
    // right
    drawVertical( 6, backdrop.x+backdrop.width );
    // top
    drawHorizontal( 9, 0);
  }
  
  private function drawHorizontal(offset:UInt, posY:Float):Void{
    
    lines[offset].x    = backdrop.x;
    lines[offset+1].x  = backdrop.x + (backdrop.width/2);
    lines[offset+2].x  = backdrop.x + backdrop.width;
    
    lines[offset].y    = posY;
    lines[offset+1].y  = posY;
    lines[offset+2].y  = posY;
  }
  
  private function drawVertical(offset:UInt, posX:Float):Void{
     
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
    
    //b = actAsATag ? actAsATag:b;
    backdrop.visible = b;
    resizeBackdrop();
    for( i in 0...lines.length){
      lines[i].visible = b;
    }

  }
  
  public function selectable(b:Bool):Void{
    
    //b = actAsATag ? !actAsATag:b;
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
  
  public function allert(b:Bool):Void{
    
    updateBackdrop(0xff0000);
    resizeBackdrop();
    
    //Lib.current.setChildIndex(textField, Lib.current.numChildren - 1);
    //backdrop.graphics.lineStyle(1/scale,0x880000);
    //var myColorTransform = new ColorTransform();
    //myColorTransform.color = b ? 0xFF0000:0x888888;
    //backdrop.transform.colorTransform = myColorTransform;
    //for( i in 0...lines.length){
    //  lines[i].transform.colorTransform = myColorTransform;
    //}
    

  }
}



