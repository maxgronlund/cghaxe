import flash.events.Event;
import flash.events.MouseEvent;
import flash.display.Bitmap;
import flash.geom.Point;
import flash.display.Shape;
import flash.Vector;
import flash.display.Sprite;


class Rectangle extends Sprite
{
  private var lines:Vector<Shape>;
  
  public function new(){
    super();
    addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
  }
  
  
  
  
  
  private function onAddedToStage(e:Event):Void{	
  	removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
  	addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);

  }
  private function onRemovedFromStage(e:Event):Void{
  	removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
  }
  
  public function setSize(sizeX:Float, sizeY:Float):Void{
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
  
  private function createLines(sizeX:Int, sizeY:Int):Void{                               
    createLine(new Point(0,0),    new Point(sizeX, 0));
    createLine(new Point(sizeX,0),   new Point(sizeX,sizeY));
    createLine(new Point(sizeX,sizeY),  new Point(0,sizeY));
    createLine(new Point(0,sizeY),   new Point(0,0));

  }
  
  private function createLine(start:Point, end:Point):Void{
    var line:Shape = new Shape();
    line.graphics.lineStyle(1, 0x000000, 1);
    line.graphics.moveTo(start.x , start.y); 
    line.graphics.lineTo(end.x, end.y);
    addChild(line);
    lines.push(line);
  }
  
  
  
  
  //override private function onMouseOut(e:MouseEvent){	
  //  super.onMouseOut(e);
  //}
  //
  //
  //override private function onMouseOver(e:MouseEvent){	
  //  trace('onMouseOver');
  //  super.onMouseOver(e); 
  //}
  //
  //override private function onMouseDown(e:MouseEvent){	
  //  super.onMouseDown(e); 
  //  
  //}
  //
  //override private function onMouseUp(e:MouseEvent){	
  //  super.onMouseUp(e); 
  //  
  //}
  //
  //private function setState(state:Int):Void {
  //
  //}
  
  
}