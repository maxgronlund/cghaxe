import flash.events.Event;
import flash.geom.Point;

class TextView extends PropertyView, implements IView{
	
	private var fontScrollPane:AView;
	private var fontPane:AView;
	private var fontScrollbar:VerticalScrollbar;
//	private var 91:FontStylePopup;
  private var lineSpacePopup:LineSpacePopup;
  private var fontSizePopup:FontSizePopup;
  private var addTextfieldButton:OneStateButton;
  private var textAlign:TextAlign;
  
  public function new(textController:IController){	
    super(textController);
    backdrop							= new TextViewBack();
    fontScrollPane				= new ScrollPane(textController);
    fontPane							= new FontPane(textController);
    fontScrollbar 				= new VerticalScrollbar(textController, EVENT_ID.FONT_SCROLL);
    //fontStylePopup 				= new FontStylePopup(textController);
    lineSpacePopup 				= new LineSpacePopup(textController);
    textAlign 	 					= new TextAlign(textController);
    fontSizePopup 				= new FontSizePopup(textController);
    addTextfieldButton 		= new OneStateButton();
  }
  
  override public function init():Void {
    
    selectButton.init( controller,
        new Point(190,30), 
        new TextViewButton(), 
        new Parameter( EVENT_ID.SHOW_TEXT)); //!!! rename
        
    textAlign.init();

                    
    addTextfieldButton.init(controller,
                    new Point(150,22), 
                    new CreateTextfieldButton(), 
                    new Parameter( EVENT_ID.ADD_PLACEHOLDER));
                    
    addTextfieldButton.fireOnMouseUp(false);
    
  }
  
  override public function onAddedToStage(e:Event):Void{
    
    super.onAddedToStage(e);
    // font selection pane
    addChild(fontScrollPane);
    fontScrollPane.setSize(174,312);
    fontScrollPane.x = 9;
    fontScrollPane.y = 164;
    fontScrollPane.addView(fontPane, 0,0);	
	//	controller.setView('font_pane',fontPane);
    // font scroll bar
    addChild(fontScrollbar);
    fontScrollbar.setSize(fontPane.getFloat('height'), fontScrollPane.getFloat('mask_height'));
    fontScrollbar.x = fontScrollPane.getSize().x-2;
    fontScrollbar.y = fontScrollPane.y;
    
    addChild(textAlign);
    textAlign.x = 8;
    textAlign.y = 94;
    
    addChild(addTextfieldButton);
    addTextfieldButton.x = 20;
    addTextfieldButton.y = 488;
		
//		addChild(fontStylePopup);
//		fontStylePopup.x = 8;
//		fontStylePopup.y = 216;
    addChild(lineSpacePopup);
    lineSpacePopup.x = 8;
    lineSpacePopup.y = 52;
    
    addChild(fontSizePopup);
    fontSizePopup.x = 110;
    fontSizePopup.y = 52;
    
  }
  
  override public function setFloat(id:String, f:Float):Void{
    
    switch ( id ) {
      
      case EVENT_ID.FONT_SCROLL:{
        fontPane.y = -(fontPane.getFloat('height')-fontScrollPane.getFloat('mask_height')) * f;
      }
    }
  }
  
  override public function setParam(param:IParameter):Void{
    
    switch ( param.getLabel() ){
      case EVENT_ID.FONT_SELECTED:{
        //trace('font selected');
        fontPane.setParam(param);   
      }
      case EVENT_ID.LINE_SPACE_SELECTED:{
        lineSpacePopup.deselectItem(param.getInt());
        lineSpacePopup.show(true); 
        lineSpacePopup.setInt('display', param.getInt());
        //trace(param.getInt());
      }
      case EVENT_ID.FONT_SIZE_SELECTED:{
        fontSizePopup.deselectItem(param.getInt());
        fontSizePopup.show(true); 
        fontSizePopup.setInt('display', param.getInt());
      }
      case EVENT_ID.ALIGN_LEFT:{
        textAlign.setParam(param);
      }
      case EVENT_ID.ALIGN_CENTER:{
        textAlign.setParam(param);
      }
      case EVENT_ID.ALIGN_RIGHT:{
        textAlign.setParam(param);
      }
      
      case EVENT_ID.UPDATE_FONT_PANE:{
        onUpdateFontPane(param.getString());
      }
      case EVENT_ID.UPDATE_TEXT_TOOLS:{
        textAlign.setParam(param);
        fontSizePopup.setParam(param);
        lineSpacePopup.setParam(param);
      	fontPane.setParam(param);
      	
      }
    }
  }
  
  private function onUpdateFontPane(s):Void{
    trace('onUpdateFontPane');
    fontPane.setString(EVENT_ID.UPDATE_FONT_PANE, s);
  }
  
  
}