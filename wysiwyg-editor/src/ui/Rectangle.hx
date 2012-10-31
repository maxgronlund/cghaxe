import flash.events.Event;
import flash.events.MouseEvent;
import flash.display.Bitmap;
import flash.geom.Point;
import flash.display.Shape;
import flash.Vector;
import flash.display.Sprite;
import flash.display.BitmapData;
import flash.display.Bitmap;



class Rectangle extends Sprite
{
  public static inline var USE_FILL   = true;
  public static inline var DRAW_LINES   = true;
  public static inline var DONT_USE_FILL   = false;
  public static inline var DONT_DRAW_LINES   = false;
  
  private var lines:Vector<Shape>;
  private var color:Int;
  private var useFill:Bool;
  private var drawLines:Bool;
  private var bmpData:BitmapData;
	private var backdrop:Bitmap;
  
  private var sizeX:Float;
  private var sizeY:Float;
  
  public function new(sizeX:Float=0, sizeY:Float=0, color:Int = 0x000000, fillColor:Int = 0x888888, drawLines = true, useFill:Bool = false){
    super();
    this.sizeX = sizeX; 
    this.sizeY = sizeY;
    this.color      = color;
    this.useFill    = useFill;
    if(useFill){
      bmpData 		= new BitmapData(10,10,false, fillColor );
  		backdrop		= new Bitmap(bmpData);
    }
    this.drawLines  = drawLines;
    addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
  }
  
  private function onAddedToStage(e:Event):Void{	
  	removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
  	addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
  	
  	addChild(backdrop);
  	setSize(sizeX, sizeY);

  }
  private function onRemovedFromStage(e:Event):Void{
  	removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
  }
  
  public function setSize(sizeX:Float, sizeY:Float):Void{
    if(drawLines){
      if(lines != null){
        for( i in 0...lines.length){
          removeChild(lines[i]);
          lines[i] = null;
        }
        lines = null;
      }
      lines = new Vector<Shape>();
      createLines(Std.int(sizeX),Std.int(sizeY));
    }
    if(useFill){
      this.sizeX = sizeX;
      this.sizeY = sizeY;
      backdrop.width = sizeX;
      backdrop.height = sizeY;
    }
    
    
  }
  
  private function createLines(sizeX:Int, sizeY:Int):Void{                               
    createLine(new Point(0,0),          new Point(sizeX, 0));
    createLine(new Point(sizeX,0),      new Point(sizeX,sizeY));
    createLine(new Point(sizeX,sizeY),  new Point(0,sizeY));
    createLine(new Point(0,sizeY),      new Point(0,0));

  }
  
  private function createLine(start:Point, end:Point):Void{
    var line:Shape = new Shape();
    line.graphics.lineStyle(1, color, 1);
    line.graphics.moveTo(start.x , start.y); 
    line.graphics.lineTo(end.x, end.y);
    addChild(line);
    lines.push(line);
  }  

  
}