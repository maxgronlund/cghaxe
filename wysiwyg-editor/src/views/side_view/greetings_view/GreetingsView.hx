import flash.geom.Point;
import flash.events.Event;
import flash.events.MouseEvent;

class GreetingsView extends VectorsView, implements IView{
  
  var print_types:Xml;
  private var pos:Int;
  
  private var _overMessage :OverMessage = null;

  public function new(greetingsController:IController){	
    super(greetingsController);
    //vectorsPane           = new GreetingsPane(greetingsController);
	
	vectorsPane = new InsertImageDialogView(greetingsController);
	
    verticalScrollbar     = new VerticalScrollbar(greetingsController, EVENT_ID.GREETING_SCROLL);
    Preset.addEventListener(EVENT_ID.GREETINGS_LOADED, onVectorLoaded);
    Application.addEventListener(EVENT_ID.SET_DEFAULT_TOOL, onLoadDefaultTool);
    addVectorInfo       = new InfoMessageView(GLOBAL.tool_tips_controller, TOOL_TIPS.GREETINGS_ADD,'right','top');
    Pages.addEventListener(EVENT_ID.PAGE_SELECTED, onPageSelected);
	
	Greetings.addEventListener(EVENT_ID.GREETING_PREVIEW, onGreetingsPreview);
	Greetings.addEventListener(EVENT_ID.GREETING_FINISH_PREVIEW, onFinishGreetingPreview);
	
	_overMessage = new OverMessage();
	_overMessage.mouseChildren = false;
	_overMessage.mouseEnabled = false;
  }
  
  override public function init():Void{
                           
    selectButton.init( controller,
              new Point(190,30), 
              new ToolSelectionButton(), 
              new Parameter( EVENT_ID.SHOW_GREETINGS));
    
    addVectorButton.init(controller,
            new Point(150,22), 
            new OneStateButtonBackL(), 
            new Parameter( EVENT_ID.ADD_GREETING_TO_PAGE));
    addVectorButton.fireOnMouseUp(false);
    
    addVectorIButton.init( GLOBAL.tool_tips_controller,
                        new Point(22,22), 
                        new OneStateButtonBackS(), 
                        new Parameter( TOOL_TIPS.GREETINGS_ADD));
    
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
    
    if(cmd == 'Greetings'){
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

    for(greeting in e.getXml().elementsNamed('greeting')){
      var param:IParameter = new Parameter(EVENT_ID.ADD_GREETING_BUTTON);
      param.setXml(greeting);
      vectorsPane.setParam(param);
    }
  }

  override public function setParam(param:IParameter):Void{
    switch( param.getLabel() ){
      case EVENT_ID.GREETING_SELECTED: {
        vectorsPane.setParam(param);
      }
    }
	}
	
	override public function setFloat(id:String, f:Float):Void{
    switch ( id ) {
      case EVENT_ID.GREETING_SCROLL:{
        vectorsPane.y = -(vectorsPane.getFloat('height')-scrollPane.getFloat('mask_height')) * f;
      }
    }
	}
	private function onLoadDefaultTool(e:IKEvent):Void{ 
    selectButton.setText(TRANSLATION.greetings_button);
    addVectorButton.setText(TRANSLATION.add_greeting);
    addVectorButton.updateLabel(); 
    
    addVectorIButton.setText('?');    
    addVectorIButton.updateLabel();
    
    
    
    addVectorInfo.setContent( TOOL_TIPS.greetings_add_title,
                              TOOL_TIPS.greetings_add_body,
                              TOOL_TIPS.greetings_add_link);
    //addVectorIButton.setContent( TOOL_TIPS.greetings_add_title,
    //                             TOOL_TIPS.greetings_add_body,
    //                             TOOL_TIPS.greetings_add_link); 
  }
  
  override public function onAddedToStage(e:Event):Void
  {
	  super.onAddedToStage(e);
		addChild(_overMessage);
		_overMessage.visible = false;
	 }
	 
	 private function onGreetingsPreview(e :IKEvent) :Void
	 {
		 
		 var title:String;
		
		for( url in e.getXml().elementsNamed("title") ) {
		  title = url.firstChild().nodeValue;
		}
		 
		 _overMessage.setContent(title);
		 onGreetingsPreviewMouseMove();
		 _overMessage.visible = true;
		 
		 this.addEventListener(MouseEvent.MOUSE_MOVE, onGreetingsPreviewMouseMove);
	}
	
	private function onGreetingsPreviewMouseMove(e :MouseEvent = null) :Void
	{
		_overMessage.x = this.mouseX - _overMessage.getWidth() - 15;
		_overMessage.y = this.mouseY - 30;
	}
	
	private function onFinishGreetingPreview(e :IKEvent) :Void
	{
		_overMessage.visible = false;
		this.removeEventListener(MouseEvent.MOUSE_MOVE, onGreetingsPreviewMouseMove);
	}
}

