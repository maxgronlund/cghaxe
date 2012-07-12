import flash.geom.Point;
import flash.events.Event;

class VectorsView extends PropertyView, implements IView{
  
  private var vectorsScrollPane:AView;
  private var vectorsPane:AView;
  private var verticalScrollbar:VerticalScrollbar;
  private var addVectorButton:OneStateButton;
  
  public function new(vectorsController:IController){	
    super(vectorsController);
    backdrop            = new PlaceholdersBackBitmap();
    vectorsScrollPane   = new ScrollPane(vectorsController);
    vectorsPane         = new VectorsPane(vectorsController);
    verticalScrollbar   = new VerticalScrollbar(vectorsController, EVENT_ID.VECTOR_SCROLL);
    addVectorButton     = new OneStateButton();
    
    Preset.addEventListener(EVENT_ID.VESTORS_LOADED, onVectorsLoaded);
    Application.addEventListener(EVENT_ID.SET_DEFAULT_TOOL, onLoadDefaultToold);
    
  }
  
  
  override public function init():Void{
//        trace('init');
    selectButton.init( controller,
              new Point(190,30), 
              new GreetingsViewButton(), 
              new Parameter( EVENT_ID.SHOW_VESTORS));
    
    addVectorButton.init(controller,
            new Point(150,22), 
            new AddPageDesignButton(), 
            new Parameter( EVENT_ID.ADD_VECTOR_TO_PAGE));
    
    addVectorButton.fireOnMouseUp(false);
  }
  
  override public function onAddedToStage(e:Event):Void{
//    trace('on added to stage');
    super.onAddedToStage(e);

    // font selection pane
    addChild(vectorsScrollPane);
    vectorsScrollPane.setSize(174,410);
    vectorsScrollPane.x = 9;
    vectorsScrollPane.y = 56;
    vectorsScrollPane.addView(vectorsPane, 0,0);	
    
    addChild(verticalScrollbar);
    verticalScrollbar.setSize(vectorsPane.getFloat('height'), vectorsScrollPane.getFloat('mask_height'));
    verticalScrollbar.x = vectorsScrollPane.getSize().x-2;
    verticalScrollbar.y = vectorsScrollPane.y;
    
    addChild(addVectorButton);
    addVectorButton.x = 20;
    addVectorButton.y = 488;
  }
  
  private function onVectorsLoaded(e:KEvent):Void{
    var vectorsXml:Xml = Xml.parse(StringTools.htmlUnescape(e.getXml().toString()));

    //for(design in vectorsXml.elementsNamed('design')){
    //  var param:IParameter = new Parameter(EVENT_ID.ADD_DESIGN_BUTTON);
    //  param.setXml(design);
    //  vectorsPane.setParam(param);
    //}

  }
  
  private function onLoadDefaultToold(e:IKEvent):Void{
    trace('onLoadDefaultToold');
    trace(vectorsPane.getFloat('height'));
    trace(vectorsScrollPane.getFloat('mask_height'));
    
    verticalScrollbar.setSize(vectorsPane.getFloat('height'), vectorsScrollPane.getFloat('mask_height'));
  }
  
  override public function setParam(param:IParameter):Void{

    //switch( param.getLabel() ){
    //  case EVENT_ID.DESIGN_SELECTED: {
    //    vectorsPane.setParam(param);
    //  }
    //}
	}
	
	override public function setFloat(id:String, f:Float):Void{
    //switch ( id ) {
    //  case EVENT_ID.DESIGN_SCROLL:{
    //    vectorsPane.y = -(vectorsPane.getFloat('height')-vectorsScrollPane.getFloat('mask_height')) * f;
    //  }
    //}
	}
}