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
import flash.events.Event;
import flash.events.MouseEvent;
import flash.display.Sprite;
import flash.Lib;
import flash.display.MovieClip;

class TextSelectBox extends SelectBox
{
 

  public function new(pageView:Dynamic, placeHolderView:Dynamic){
    super(pageView,placeHolderView);
  }
  
  override private function onMouseDown(e:MouseEvent){
    //super.onMouseDown(e);
    //removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
    //stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
    //stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
    //
    //if(MouseTrap.capture()){
    //  if(backdrop.alpha == transparency){
    //    placeHolderView.setTextOnTop(true);
    //  }else {
    //    pageView.setPlaceholderInFocus(placeHolderView);
    //  }
    //  pageView.enableMove(e);
    //  placeHolderView.updateGlobals();
    //}
  }
}