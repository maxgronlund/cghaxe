import flash.events.Event;
import flash.display.Bitmap;
import flash.geom.Point;
import flash.display.Shape;
import flash.Vector;
import flash.display.Sprite;
import flash.display.LineScaleMode;


class ResizeHandle extends Sprite
{
  
  //private var rectangle:Rectangle;
  private var lines:Vector<Shape>;
  private var color:Int;
  private var backdrop:Sprite;
  private var scale:Float;
  
  //private var arrows:Bitmap;
  
  public function new(width:Int=0, height:Int=0, color:Int = 0x000000){
    super();
    addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    this.color    = 0x000000;
    scale         = GLOBAL.from_72_to_150_dpi;

  }

  private function onAddedToStage(e:Event):Void{	
    
  	removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
  	addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
    lines = new Vector<Shape>();
    createBackdrop();
  	drawArrows();
  }
  
  private function createBackdrop():Void{
    backdrop = new Sprite();
    addChild(backdrop);
    backdrop.graphics.lineStyle(1/scale,0x000000);
    backdrop.graphics.beginFill(0x888888);
    backdrop.graphics.drawRect(0,0,32,32);
    backdrop.graphics.endFill();
    backdrop.alpha = 0.9;
  }
  
  private function onRemovedFromStage(e:Event):Void{
  	removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
  }
  
  private function drawArrows():Void{
    
    var sizeX = 30;
    var sizeY = 30;
    createLine(new Point(6,6),          new Point(16, 6));
    createLine(new Point(6,6),          new Point(6, 16));
    
    createLine(new Point(24,24),          new Point(24, 14));
    createLine(new Point(24,24),            new Point(14, 24));
    
    createLine(new Point(6,6),            new Point(24,24));
    //createLine(new Point(sizeX,0),      new Point(sizeX,sizeY));
    //createLine(new Point(sizeX,sizeY),  new Point(0,sizeY));
    //createLine(new Point(0,sizeY),      new Point(0,0));
    
  }
  
  private function createLine(start:Point, end:Point):Void{
    var line:Shape = new Shape();
    line.graphics.lineStyle(1, color, 1);
    line.graphics.moveTo(start.x , start.y); 
    line.graphics.lineTo(end.x, end.y);
    addChild(line);
    lines.push(line);
  }



  private function setState(state:Int):Void {
  
  }
  
  public function setSize(sizeX:Float, sizeY:Float):Void{
//    rectangle.setSize(sizeX, sizeY);
  }
}