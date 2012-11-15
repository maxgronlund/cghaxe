import flash.geom.Point;
import flash.events.Event;

class SymbolsView extends VectorsView, implements IView{


  public function new(symbolsController:IController){	
    super(symbolsController);
    vectorsPane           = new SymbolsPane(symbolsController);
    verticalScrollbar     = new VerticalScrollbar(symbolsController, EVENT_ID.SYMBOL_SCROLL);
    Preset.addEventListener(EVENT_ID.SYMBOLS_LOADED, onVectorLoaded);
    Application.addEventListener(EVENT_ID.SET_DEFAULT_TOOL, onLoadDefaultTool);
  }
  
  override public function init():Void{
    //trace('init');     
    selectButton.init( controller,
              new Point(190,30), 
              new ToolSelectionButton(), 
              new Parameter( EVENT_ID.SHOW_SYMBOLS));
    
    addVectorButton.init(controller,
            new Point(150,22), 
            new OneStateButtonBackL(), 
            new Parameter( EVENT_ID.ADD_SYMBOL_TO_PAGE));
    
    super.init();
  }
  
  override private function onVectorLoaded(e:KEvent):Void{

    for(symbol in e.getXml().elementsNamed('symbol')){
      var param:IParameter = new Parameter(EVENT_ID.ADD_SYMBOL_BUTTON);
      param.setXml(symbol);
      vectorsPane.setParam(param);
      //trace(symbol.toString());
    }
  }

  override public function setParam(param:IParameter):Void{
    switch( param.getLabel() ){
      case EVENT_ID.SYMBOL_SELECTED: {
        vectorsPane.setParam(param);
      }
    }
  }
  
  
  override public function setFloat(id:String, f:Float):Void{
    switch ( id ) {
      case EVENT_ID.SYMBOL_SCROLL:{
        vectorsPane.y = -(vectorsPane.getFloat('height')-scrollPane.getFloat('mask_height')) * f;
      }
    }
  }
  private function onLoadDefaultTool(e:IKEvent):Void{
    selectButton.setText(TRANSLATION.symbols_button);
    addVectorButton.setText(TRANSLATION.add_symbol);
    addVectorButton.updateLabel();
  }
}