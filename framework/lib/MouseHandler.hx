import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.events.Event;


class MouseHandler extends Sprite
{
  public function new(){
    super();
		addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
    addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
		addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
  }

	private function onRemoved(e:Event):Void{
    removeEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
    enableMouse(false);
	}

  public function resetMouse():Void{

    removeEventListener(MouseEvent.ROLL_OVER, onMouseOver);
    removeEventListener(MouseEvent.ROLL_OUT, onMouseOut);
    removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
    removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
    stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
    
    addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
    addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
    
  }

  public function enableMouse(b:Bool):Void{
    if(b){
      addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
      addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
    }
    else{
      removeEventListener(MouseEvent.ROLL_OVER, onMouseOver);
      removeEventListener(MouseEvent.ROLL_OUT, onMouseOut);
      removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
      removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
      stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
    }
  }
  
  private function onMouseOver(e:MouseEvent):Void{
    removeEventListener(MouseEvent.ROLL_OVER, onMouseOver);
    addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
    addEventListener(MouseEvent.ROLL_OUT, onMouseOut);	
  }
  
  private function onMouseOut(e:MouseEvent){
    removeEventListener(MouseEvent.ROLL_OUT, onMouseOut);
    addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
    addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
  }

  private function onMouseDown(e:MouseEvent){	
    removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
    stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
    stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
  }
  
  private function onMouseUp(e:MouseEvent){	
    stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
    stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
  }
  
  private function onMouseMove(e:MouseEvent){}
	


}