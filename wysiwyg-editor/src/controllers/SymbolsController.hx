class SymbolsController extends Controller, implements IController{

  public function new(){	
  	super();
  }

  override public function setParam(param:IParameter):Void{
    switch ( param.getLabel() ){
      case EVENT_ID.SHOW_SYMBOLS:{
        GLOBAL.side_view.showView(EVENT_ID.SHOW_SYMBOLS, param.getBool());
      }
      case EVENT_ID.SYMBOL_SELECTED:{
        GLOBAL.symbols_view.setParam(param);
        Symbols.setParam(param);
      }
      case EVENT_ID.ADD_SYMBOL_TO_PAGE:{Symbols.setParam(param);}
      case EVENT_ID.SYMBOL_SCROLL:{GLOBAL.symbols_view.setFloat(EVENT_ID.SYMBOL_SCROLL, param.getFloat());}

    }	
  }
  
  private function onScroll(param:IParameter):Void{
    switch ( param.getLabel() ){
      case EVENT_ID.SYMBOL_SCROLL:{
        GLOBAL.symbols_view.setFloat(EVENT_ID.SYMBOL_SCROLL, param.getFloat());
      }
    }	
	}
}