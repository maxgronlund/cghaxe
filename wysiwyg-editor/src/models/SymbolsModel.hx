import flash.events.Event;
import flash.Vector;

class SymbolsModel extends Model, implements IModel {
  
  private var symbolsXml:Xml;

  public function new(){	
    super();
  }
    
 override public function init():Void{	
   super.init();
 }
 
  override public function setParam(param:IParameter):Void{
    switch ( param.getLabel() ) {
	  case EVENT_ID.SHOW_SYMBOLS: {	
		  dispatchEvent(new Event(EVENT_ID.SHOW_SYMBOLS));
	  }
      case EVENT_ID.SYMBOL_SELECTED:{
        symbolsXml = param.getXml();
      }
	  case EVENT_ID.START_DRAG_SYMBOL:{
        symbolsXml = param.getXml();
		dispatchXML(EVENT_ID.START_DRAG_SYMBOL, symbolsXml);
      }
      case EVENT_ID.ADD_SYMBOL_TO_PAGE:{
        if(symbolsXml != null){
          dispatchXML(EVENT_ID.ADD_SYMBOL_TO_PAGE, symbolsXml);
        }
      }
    }
  }

  private function onPassSymbols(e:IKEvent):Void{
    var xml:Xml = Xml.parse(StringTools.htmlUnescape(e.getXml().toString()));
  }

}