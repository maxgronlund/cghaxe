import flash.geom.Point;
import flash.events.Event;
import flash.Vector;

class DesignsView extends PropertyView, implements IView{
  
  private var designsScrollPane:AView;
  private var designsPane:AView;
  private var verticalScrollbar:VerticalScrollbar;
  private var addDesignButton:OneStateButton;
  
 
  
  
  public function new(designsController:IController){	
    //trace('new');
    super(designsController);
    backdrop            = new PlaceholdersBackBitmap();
    
    designsScrollPane   = new ScrollPane(designsController);
    designsPane         = new DesignsPane(designsController);
    verticalScrollbar   = new VerticalScrollbar(designsController, EVENT_ID.DESIGN_SCROLL);
    addDesignButton     = new OneStateButton();

    //Preset.addEventListener(EVENT_ID.PAGE_DESIGNS_LOADED, onPageDesignsLoaded);
    //Application.addEventListener(EVENT_ID.SET_DEFAULT_TOOL, onLoadDefaultTool);
    
    //Pages.addEventListener(EVENT_ID.BUILD_PAGE, onBuildPage);
    
    //Preset.addEventListener(EVENT_ID.ADD_DESIGN_PAGE_TO_SIDEBAR, onBuildPage);
    
  }
  
  
  override public function init():Void{
    //trace('init');
    selectButton.init( controller,
              new Point(190,30), 
              new DesignsViewButton(), 
              new Parameter( EVENT_ID.SHOW_DESIGNS));
    
    addDesignButton.init(controller,
            new Point(150,22), 
            new AddPageDesignButton(), 
            new Parameter( EVENT_ID.ADD_DESIGN_TO_PAGE));
    
    addDesignButton.fireOnMouseUp(false);
  }
  
  //override public function setInt(id:String, i:Int):Void{
  //  switch ( id )
  //  {
  //    case EVENT_ID.DESIGN_SELECTED:
  //      designsPane.selectButton(i);
  //  }
  //}
  //
  
//  private function onBuildPage(e:IKEvent):Void{
//    
//    //designsPane.setXml(CONST.XML_FILE, e.getXml());
//
//  }
  
  
  override public function onAddedToStage(e:Event):Void{
    //trace('onAddedToStage');
    super.onAddedToStage(e);

    // font selection pane
    addChild(designsScrollPane);
    designsScrollPane.setSize(174,410);
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
    
    
    //Pages.addEventListener(EVENT_ID.ADD_PLACEHOLDER, onPageSelected);
  }
  
//  private function onPageSelected(e:IKEvent):Void{
//    //trace(pages[e.getInt()].toString());
//    designsPane.setInt(EVENT_ID.PAGE_SELECTED, e.getInt());
//   //trace(e.getInt()); 
//  }
  
//  private function onPageDesignsLoaded(e:KEvent):Void{
//    
//    
//    var designsXml:Xml = Xml.parse(StringTools.htmlUnescape(e.getXml().toString()));
//
//    for(design in designsXml.elementsNamed('design')){
//      var param:IParameter = new Parameter(EVENT_ID.ADD_DESIGN_BUTTON);
//      param.setXml(design);
//      designsPane.setParam(param);
//    }
//
//  }
//  
//  private function onLoadDefaultTool(e:IKEvent):Void{
//  
//   // verticalScrollbar.setSize(designsPane.getFloat('height'), designsScrollPane.getFloat('mask_height'));
//  }
  
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
}