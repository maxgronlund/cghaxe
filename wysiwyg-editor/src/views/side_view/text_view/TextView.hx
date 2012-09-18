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
  private var garamondButton:TwoStateButton;
  
  public function new(textController:IController){	
    super(textController);
    backdrop              = new TextViewBack();
    fontScrollPane        = new ScrollPane(textController);
    fontPane    	        = new FontPane(textController);
    fontScrollbar         = new VerticalScrollbar(textController, EVENT_ID.FONT_SCROLL);
    lineSpacePopup        = new LineSpacePopup(textController);
    textAlign             = new TextAlign(textController);
    fontSizePopup         = new FontSizePopup(textController);
    addTextfieldButton    = new OneStateButton();
    garamondButton        = new TwoStateButton();
  }
  
  override public function init():Void {
    
    selectButton.init( controller,
        new Point(190,30), 
        new TextViewButton(), 
        new Parameter( EVENT_ID.SHOW_TEXT)); //!!! rename
        
    textAlign.init();
                            
    
    garamondButton.init( controller,
            new Point(150,30), 
            new GarmondPrintButton(), 
            new Parameter( EVENT_ID.USE_GARAMOND));
            
    //Application.addEventListener( EVENT_ID.USE_GARAMOND, onUseGaramond);
    
    addTextfieldButton.init(controller,
                        new Point(150,22), 
                        new CreateTextfieldButton(), 
                        new Parameter( EVENT_ID.ADD_PLACEHOLDER));

    addTextfieldButton.fireOnMouseUp(false);
    GLOBAL.Application.addEventListener(EVENT_ID.UPDATE_SIDE_VIEWS, onUpdateSideView);
  }
  
  
  private function onUpdateSideView(e:IKEvent):Void{
    
    var b:Bool = e.getString() == 'garamond_place_holder';
    garamond(b);
    garamondButton.setOn(b);
   //   garamond(true);
   //   garamondButton.setOn(true);
   // }else{
   //   garamond(false);
   //   garamondButton.setOn(false);
   // }
   // //garamondButton.setOn(e.getString() == 'garamond_place_holder');
    
    
	}
  
  override public function onAddedToStage(e:Event):Void{
    
    super.onAddedToStage(e);
    
    addChild(addTextfieldButton);
    addTextfieldButton.x = 20;
    addTextfieldButton.y = 488;
  	addTextfieldButton.fireOnMouseUp(false);
    
    addChild(garamondButton);
  	garamondButton.x = 20;
  	garamondButton.y = 40;
  	
  	
    // font selection pane
    addChild(fontScrollPane);
    fontScrollPane.setSize(174,272);
    fontScrollPane.x = 9;
    fontScrollPane.y = 204;
    fontScrollPane.addView(fontPane, 0,0);	

    // font scroll bar
    addChild(fontScrollbar);
    fontScrollbar.setSize(fontPane.getFloat('height'), fontScrollPane.getFloat('mask_height'));
    fontScrollbar.x = fontScrollPane.getSize().x-2;
    fontScrollbar.y = fontScrollPane.y;
    
    addChild(textAlign);
    textAlign.x = 8;
    textAlign.y = 134;
    
    addChild(lineSpacePopup);
    lineSpacePopup.x = 8;
    lineSpacePopup.y = 92;
    
    addChild(fontSizePopup);
    fontSizePopup.x = 110;
    fontSizePopup.y = 92;

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
      case EVENT_ID.ALIGN_LEFT:{ textAlign.setParam(param); }
      case EVENT_ID.ALIGN_CENTER:{ textAlign.setParam(param); }
      case EVENT_ID.ALIGN_RIGHT:{ textAlign.setParam(param); }
      case EVENT_ID.USE_GARAMOND:{  garamond(param.getBool()); }
    }
  }
  
  private function garamond(b:Bool):Void{
    fontSizePopup.visible     = !b;
    lineSpacePopup.visible    = !b;
    fontPane.visible          = !b;
    fontScrollbar.visible     = !b;
    lineSpacePopup.setString('use garamond', b ?'on':'off');
    if(b){
      fontSizePopup.setString('use garamond', 'foo');
      fontPane.setString('use garamond', 'foo');
    }
  }
  
  //private function onUpdateFontPane(s):Void{
  //  trace('setParam');
  //  fontPane.setString(EVENT_ID.UPDATE_FONT_PANE, s);
  //}
  
  
}