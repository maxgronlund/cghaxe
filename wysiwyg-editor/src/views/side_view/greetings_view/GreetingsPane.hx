import flash.events.Event;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.geom.Point;
import flash.Vector;

class GreetingsPane extends VectorsPane, implements IView{
  

  public function new(greetingsController:IController){	
    super(greetingsController);
  }
  
  override public function setParam(param:IParameter):Void{
    
    switch ( param.getLabel() ){
      case EVENT_ID.ADD_GREETING_BUTTON:{
        param.setLabel(EVENT_ID.GREETING_SELECTED);
        addButton(param);
      }
      case EVENT_ID.GREETING_SELECTED:{
        selectButton( param.getInt());
      }
    }
  }
  
}