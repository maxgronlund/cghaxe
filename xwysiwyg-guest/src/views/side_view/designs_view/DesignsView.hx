import flash.geom.Point;
import flash.events.Event;

class DesignsView extends PropertyView, implements IView{
  
  private var designsScrollPane:AView;
  private var designsPane:AView;
  private var verticalScrollbar:VerticalScrollbar;
  private var addDesignButton:OneStateButton;
  
  public function new(designsController:IController){	
    super(designsController);
    backdrop				= new PlaceholdersBackBitmap();
    
    designsScrollPane   = new ScrollPane(designsController);
    designsPane         = new DesignsPane(designsController);
    verticalScrollbar   = new VerticalScrollbar(designsController);
    addDesignButton     = new OneStateButton();
    
    Preset.addEventListener(EVENT_ID.PAGE_DESIGNS_LOADED, onPageDesignsLoaded);
    
  }
  
  override public function init():Void{
//        trace('init');
    selectButton.init( controller,
              new Point(190,30), 
              new DesignsViewButton(), 
              new Parameter( EVENT_ID.SHOW_PAGE_DESIGN));
    
    addDesignButton.init(controller,
            new Point(150,22), 
            new AddPageDesignButton(), 
            new Parameter( EVENT_ID.ADD_DESIGN_TO_PAGE));
    
    addDesignButton.fireOnMouseUp(false);
  }
  
  override public function onAddedToStage(e:Event):Void{
//    trace('on added to stage');
    super.onAddedToStage(e);

    // font selection pane
    addChild(designsScrollPane);
    designsScrollPane.setSize(174,133);
    designsScrollPane.x = 9;
    designsScrollPane.y = 56;
    designsScrollPane.addView(designsPane, 0,0);	
    
    addChild(verticalScrollbar);
    verticalScrollbar.setSize(designsPane.getFloat('height'), designsScrollPane.getFloat('mask_height'));
    verticalScrollbar.x = designsScrollPane.getSize().x-2;
    verticalScrollbar.y = designsScrollPane.y;
    
    addChild(addDesignButton);
    addDesignButton.x = 20;
    addDesignButton.y = 488;
  }
  
  private function onPageDesignsLoaded(e:KEvent):Void{
    trace('onPageDesignsLoaded');
  //  trace(e.getXml().toString());
    
    
    var designsXml:Xml = Xml.parse(StringTools.htmlUnescape(e.getXml().toString()));
    

    for(design in designsXml.elementsNamed('design')){
      var param:IParameter = new Parameter(EVENT_ID.ADD_DESIGN_BUTTON);
      param.setXml(design);
      designsPane.setParam(param);
      
    }

  }
  
  override public function setParam(param:IParameter):Void{

    switch( param.getLabel() ){
      case EVENT_ID.DESIGN_SELECTED: {
        designsPane.setParam(param);
      }
    }
	}
}