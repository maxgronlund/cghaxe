import flash.geom.Point;
import flash.events.Event;

class VectorsView extends PropertyView, implements IView{

  private var scrollPane:AView;
  private var vectorsPane:AView;
  private var verticalScrollbar:VerticalScrollbar;
  private var addVectorButton:OneStateButton;
  
  public function new(greetingsController:IController){	
    super(greetingsController);

    backdrop              = new PlaceholdersBackBitmap();
    scrollPane            = new ScrollPane(greetingsController);
    vectorsPane         = new GreetingsPane(greetingsController);
    verticalScrollbar     = new VerticalScrollbar(greetingsController, EVENT_ID.GREETING_SCROLL);
    addVectorButton       = new OneStateButton();
    
    //Preset.addEventListener(EVENT_ID.GREETINGS_LOADED, onVectorLoaded);
    Application.addEventListener(EVENT_ID.SET_DEFAULT_TOOL, onLoadDefaultTool);
  }
  
  
  override public function init():Void{
    addVectorButton.fireOnMouseUp(false);
  }
  
  override public function onAddedToStage(e:Event):Void{
    super.onAddedToStage(e);

    addChild(scrollPane);
    scrollPane.setSize( 174, 430);
    scrollPane.x = 9;
    scrollPane.y = 44;
    scrollPane.addView(vectorsPane, 0,0);	
    
    addChild(verticalScrollbar);
    verticalScrollbar.setSize(vectorsPane.getFloat('height'), scrollPane.getFloat('mask_height'));
    verticalScrollbar.x = scrollPane.getSize().x-2;
    verticalScrollbar.y = scrollPane.y;
    
    addChild(addVectorButton);
    addVectorButton.x = 20;
    addVectorButton.y = 488;
  }
  
  private function onVectorLoaded(e:KEvent):Void{

    for(greeting in e.getXml().elementsNamed('greeting')){
      var param:IParameter = new Parameter(EVENT_ID.ADD_GREETING_BUTTON);
      param.setXml(greeting);
      vectorsPane.setParam(param);
    }
  }
  
  private function onLoadDefaultTool(e:IKEvent):Void{
    verticalScrollbar.setSize(vectorsPane.getFloat('height'), scrollPane.getFloat('mask_height'));
  }
  
//  override public function setParam(param:IParameter):Void{
//
//    switch( param.getLabel() ){
//      case EVENT_ID.GREETING_SELECTED: {
//        vectorsPane.setParam(param);
//      }
//    }
//	}
	
	override public function setFloat(id:String, f:Float):Void{
    switch ( id ) {
      case EVENT_ID.GREETING_SCROLL:{
        vectorsPane.y = -(vectorsPane.getFloat('height')-scrollPane.getFloat('mask_height')) * f;
      }
    }
	}
}