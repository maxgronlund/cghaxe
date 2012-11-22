import flash.geom.Point;
import flash.events.Event;

class SymbolsView extends VectorsView, implements IView{
  var print_types:Xml;

  public function new(symbolsController:IController){	
    super(symbolsController);
    vectorsPane           = new SymbolsPane(symbolsController);
    verticalScrollbar     = new VerticalScrollbar(symbolsController, EVENT_ID.SYMBOL_SCROLL);
    Preset.addEventListener(EVENT_ID.SYMBOLS_LOADED, onVectorLoaded);
    Application.addEventListener(EVENT_ID.SET_DEFAULT_TOOL, onLoadDefaultTool);
    Pages.addEventListener(EVENT_ID.PAGE_SELECTED, onPageSelected);
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
            
    addVectorIButton.init( GLOBAL.tool_tips_controller,
                        new Point(22,22), 
                        new OneStateButtonBackS(), 
                        new Parameter( TOOL_TIPS.SYMBOLS_ADD));
    
    super.init();
  }
  
  private function onPageSelected(e:IKEvent):Void{
    disableTools();
    if(Pages.getString(CONST.PRINT_TYPES) != 'na'){
      print_types = Xml.parse(Pages.getString(CONST.PRINT_TYPES));
      setPrintTypes();
    }
    PositionTools();
  }
  
  private function disableTools():Void{
     back.visible                     = false;
     selectButton.visible             = false;
     addVectorButton.visible          = false;
     addVectorIButton.visible         = false;
     vectorsPane.visible              = false;
     verticalScrollbar.visible        = false; 
     scrollPaneBack.visible           = false; 
  }
  
  private function onEnableTool(cmd:String):Void{

    if(cmd == 'Symbols'){
      back.visible                     = true;
      selectButton.visible             = true;
      addVectorButton.visible          = true;
      addVectorIButton.visible         = true;
      vectorsPane.visible              = true;
      verticalScrollbar.visible        = true;
      scrollPaneBack.visible           = true;
    }
  }
    
  private function setPrintTypes():Void{
  
    //disableTools();
    for(print_types in print_types.elementsNamed('print-types')){
      for(print_type in print_types.elementsNamed('print-type')){
        for(title in print_type.elementsNamed('title')){
          onEnableTool( title.firstChild().nodeValue.toString());
          //trace( title.firstChild().nodeValue.toString());
        }
      }
    }
    //PositionTools();
  }

 private function PositionTools():Void{
    //trace('PositionTools');
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
    addVectorIButton.setText('?');    
    addVectorIButton.updateLabel();
    
    addVectorInfo.setContent( TOOL_TIPS.symbols_add_title,
                              TOOL_TIPS.symbols_add_body,
                              TOOL_TIPS.symbols_add_link);
  }
  
}