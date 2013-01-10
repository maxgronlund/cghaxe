import flash.geom.Point;
import flash.events.Event;
import flash.Vector;

class DesignsView extends PropertyView, implements IView{
  
  private var back:Rectangle;
  private var scrollPaneBack:Rectangle;
  private var designsScrollPane:AView;
  private var designsPane:AView;
  private var verticalScrollbar:VerticalScrollbar;
  private var addDesignButton:OneStateButton;
  
 
  
  
  public function new(designsController:IController){	
    //trace('new');
    super(designsController);
    //backdrop            = new PlaceholdersBackBitmap();
    back                = new Rectangle(190, 226, 0x000000, 0xDEDEDE, Rectangle.DONT_DRAW_LINES, Rectangle.USE_FILL);
		scrollPaneBack      = new Rectangle(174, 160, 0xC3C3C3, 0xF4F4F4, Rectangle.DRAW_LINES, Rectangle.USE_FILL);
    
    designsScrollPane   = new ScrollPane(designsController);
    designsPane         = new DesignsPane(designsController);
    verticalScrollbar   = new VerticalScrollbar(designsController, EVENT_ID.DESIGN_SCROLL);
    addDesignButton     = new OneStateButton();
    Application.addEventListener(EVENT_ID.ADD_SCROLL_BARS, onAddScrollBars);
    Application.addEventListener(EVENT_ID.SET_DEFAULT_TOOL, onLoadDefaultTool);
    
  }
  
  
  override public function init():Void{
    //trace('init');
    selectButton.init( controller,
              new Point(190,30), 
              new ToolSelectionButton(), 
              new Parameter( EVENT_ID.SHOW_DESIGNS));
    
    addDesignButton.init(controller,
            new Point(150,22), 
            new AddPageDesignButton(), 
            new Parameter( EVENT_ID.ADD_DESIGN_TO_PAGE));
    
    addDesignButton.fireOnMouseUp(false);
  }
  
  
  override public function onAddedToStage(e:Event):Void{

    super.onAddedToStage(e);
    
    addChild(back);
    back.y              = 30;
    
    addChild(scrollPaneBack);
    scrollPaneBack.x    = 8;
    scrollPaneBack.y    = 43;
    

    // font selection pane
    addChild(designsScrollPane);
    designsScrollPane.setSize(174,159);
    designsScrollPane.x = 9;
    designsScrollPane.y = 44;
    designsScrollPane.addView(designsPane, 0,0);	

    
    addChild(addDesignButton);
    addDesignButton.x = 20;
    addDesignButton.y = 218;

  }
  private function onAddScrollBars(e:IKEvent):Void{
    
    if(designsPane.getFloat('height') > designsScrollPane.getFloat('mask_height')){
      addChild(verticalScrollbar);
      verticalScrollbar.setSize(designsPane.getFloat('height'), designsScrollPane.getFloat('mask_height'));
      verticalScrollbar.x = designsScrollPane.getSize().x-2;
      verticalScrollbar.y = designsScrollPane.y;
    } 
  }
  override public function getHeight():Int{
  	return 256;
  }
  
  override public function setParam(param:IParameter):Void{
  
    //switch( param.getLabel() ){
    //  case EVENT_ID.DESIGN_SELECTED: {
    //    designsPane.setParam(param);
    //  }
    //}
  }
  
  override public function setFloat(id:String, f:Float):Void{
    switch ( id ) {
      case EVENT_ID.DESIGN_SCROLL:{
        designsPane.y = -(designsPane.getFloat('height')-designsScrollPane.getFloat('mask_height')) * f;
      }
    }
	}

  private function onLoadDefaultTool(e:IKEvent):Void{
    selectButton.setText(TRANSLATION.designs_button);
  }

}

