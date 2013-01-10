import flash.events.Event;
import flash.events.MouseEvent;
import flash.display.Bitmap;
import flash.geom.Point;
import flash.display.Shape;
import flash.Vector;



class CornerHandle extends MouseHandler
{
  private var rectangle:Rectangle;
  
  public function new(){
    super();
    addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    rectangle = new Rectangle();
  }

  private function onAddedToStage(e:Event):Void{	
    
  	removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
  	addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
  	addChild(rectangle);
  	rectangle.setSize(16,16);
  }
  private function onRemovedFromStage(e:Event):Void{
  	removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
  }
  
  
  override private function onMouseOut(e:MouseEvent){	
    super.onMouseOut(e);
  }
  
  
  override private function onMouseOver(e:MouseEvent){	
    trace('onMouseOver');
    super.onMouseOver(e); 
  }
  
  override private function onMouseDown(e:MouseEvent){	
    super.onMouseDown(e); 
    
  }
  
  override private function onMouseUp(e:MouseEvent){	
    super.onMouseUp(e); 
    
  }

  private function setState(state:Int):Void {
  
  }
  
  public function setSize(sizeX:Float, sizeY:Float):Void{
    rectangle.setSize(sizeX, sizeY);
  }
}