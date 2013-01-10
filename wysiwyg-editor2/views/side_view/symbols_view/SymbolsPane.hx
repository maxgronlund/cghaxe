import flash.events.Event;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.geom.Point;
import flash.Vector;

class SymbolsPane extends VectorsPane, implements IView{

  public function new(vectorsController:IController){	
    super(vectorsController);
  }
  
  override public function setParam(param:IParameter):Void{
    
    switch ( param.getLabel() ){
      case EVENT_ID.ADD_SYMBOL_BUTTON:{
        param.setLabel(EVENT_ID.SYMBOL_SELECTED);
        addButton(param);
      }
      case EVENT_ID.SYMBOL_SELECTED:{
        selectButton( param.getInt());
      }
    }
  }
  

}