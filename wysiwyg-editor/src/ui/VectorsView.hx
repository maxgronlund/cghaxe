import flash.geom.Point;
import flash.events.Event;

class VectorsView extends PropertyView, implements IView{

  private var back:Rectangle;
  private var scrollPaneBack:Rectangle;
  private var scrollPane:AView;
  private var vectorsPane:AView;
  private var verticalScrollbar:VerticalScrollbar;
  private var addVectorButton:OneStateTextAndImageButton;
  private var addVectorIButton:OneStateTextAndImageButton;
  private var addVectorInfo:InfoMessageView;
  
  public function new(greetingsController:IController){	
    super(greetingsController);
    back                = new Rectangle(190, 226, 0x000000, 0xDEDEDE, Rectangle.DONT_DRAW_LINES, Rectangle.USE_FILL);
		scrollPaneBack      = new Rectangle(174, 160, 0xC3C3C3, 0xF4F4F4, Rectangle.DRAW_LINES, Rectangle.USE_FILL);
    //backdrop              = new PlaceholdersBackBitmap();
    scrollPane          = new ScrollPane(greetingsController);
    vectorsPane         = new GreetingsPane(greetingsController);
    verticalScrollbar   = new VerticalScrollbar(greetingsController, EVENT_ID.GREETING_SCROLL);
    addVectorButton     = new OneStateTextAndImageButton();
    addVectorButton.setFormat(0, 3, 0x333333, 'center');
    
    addVectorIButton       = new OneStateTextAndImageButton();
    addVectorIButton.setFormat(0, 3, 0x333333, 'center');
    Application.addEventListener(EVENT_ID.ADD_SCROLL_BARS, onAddScrollBars);
    addVectorInfo       = new InfoMessageView(GLOBAL.tool_tips_controller, 
                                                 TOOL_TIPS.SYMBOLS_ADD,
                                                 'right', 
                                                 'top');
  }
  
  
  override public function init():Void{
    
    addVectorButton.fireOnMouseUp(false);
    
  }
  
  override public function onAddedToStage(e:Event):Void{
    super.onAddedToStage(e);
    addChild(back);
    back.y              = 30;
    
    addChild(scrollPaneBack);
    scrollPaneBack.x    = 8;
    scrollPaneBack.y    = 43;

    addChild(scrollPane);
    scrollPane.setSize( 174, 159);
    scrollPane.x        = 9;
    scrollPane.y        = 44;
    scrollPane.addView(vectorsPane, 0,0);	
    

    addChild(addVectorButton);
    addVectorButton.x   = 9;
    addVectorButton.y   = 218;
    
    addChild(addVectorIButton);
    addVectorIButton.x   = 154 +9;
    addVectorIButton.y   = 218;
    
    addVectorInfo.x = addVectorIButton.x;
  	addVectorInfo.y = addVectorIButton.y;
    addChild(addVectorInfo);

    
  }
  
  private function onVectorLoaded(e:KEvent):Void{

    for(greeting in e.getXml().elementsNamed('greeting')){
      var param:IParameter = new Parameter(EVENT_ID.ADD_GREETING_BUTTON);
      param.setXml(greeting);
      vectorsPane.setParam(param);
    }
  }
  
  private function onAddScrollBars(e:IKEvent):Void{
    
    if(vectorsPane.getFloat('height') > scrollPane.getFloat('mask_height')){
      addChild(verticalScrollbar);
      verticalScrollbar.setSize(vectorsPane.getFloat('height'), scrollPane.getFloat('mask_height'));
      verticalScrollbar.x = scrollPane.getSize().x-2;
      verticalScrollbar.y = scrollPane.y;
    } 
  }

	
	override public function setFloat(id:String, f:Float):Void{
    switch ( id ) {
      case EVENT_ID.GREETING_SCROLL:{
        vectorsPane.y = -(vectorsPane.getFloat('height')-scrollPane.getFloat('mask_height')) * f;
      }
    }
	}
	override public function getHeight():Int{
		return 256;
	}
}