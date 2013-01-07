import flash.geom.Point;
import flash.events.Event;

class SymbolsView extends VectorsView, implements IView{
  var print_types:Xml;

  public function new(symbolsController:IController){	
    super(symbolsController);
    //vectorsPane           = new SymbolsPane(symbolsController);
	
	back                = new Rectangle(190, 326, 0x000000, 0xDEDEDE, Rectangle.DONT_DRAW_LINES, Rectangle.USE_FILL);
	scrollPaneBack      = new Rectangle(174, 160, 0xC3C3C3, 0xF4F4F4, Rectangle.DRAW_LINES, Rectangle.USE_FILL);

	
	vectorsPane = new SymbolImageDialog(symbolsController);
	
    verticalScrollbar     = new VerticalScrollbar(symbolsController, EVENT_ID.SYMBOL_SCROLL);
    Preset.addEventListener(EVENT_ID.SYMBOLS_LOADED, onVectorLoaded);
    Application.addEventListener(EVENT_ID.SET_DEFAULT_TOOL, onLoadDefaultTool);
    Pages.addEventListener(EVENT_ID.PAGE_SELECTED, onPageSelected);
	
	Symbols.addEventListener(EVENT_ID.SHOW_SYMBOLS, onShowSymbols);
  }
  
  override public function init():Void{
    //trace('init');     
    
	selectButton.init( controller,
              new Point(190,30), 
              new ToolSelectionButton(), 
              new Parameter( EVENT_ID.SHOW_SYMBOLS));
	
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
     vectorsPane.visible              = false;
     verticalScrollbar.visible        = false; 
     scrollPaneBack.visible           = false; 
  }
  
  private function onEnableTool(cmd:String):Void{

    if(cmd == 'Symbols'){
      back.visible                     = true;
	  selectButton.visible             = true;
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
    
    
  
  private function onVectorLoaded(e:KEvent):Void{

	createVectorsArray('symbol',e.getParam().getXml());
		
  }
  
  private function onShowSymbols(e:Event):Void
  {
	  var param:IParameter = new Parameter(EVENT_ID.ADD_SYMBOL_BUTTON);
	  loadFirstVector(param);
	  
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
  }
  
  override public function onAddedToStage(e:Event):Void 
  {
	super.onAddedToStage(e);
  
    scrollPane.setSize( 174, 299);
	scrollPaneBack.setSize(174, 300);
  } 
}