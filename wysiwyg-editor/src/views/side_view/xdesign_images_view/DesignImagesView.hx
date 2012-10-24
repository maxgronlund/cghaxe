import flash.geom.Point;
import flash.events.Event;

class DesignImagesView extends PropertyView, implements IView{
  
  private var designImagesScrollPane:AView;
  private var designImagesPane:AView;
  private var verticalScrollbar:VerticalScrollbar;
  private var addDesignImageButton:OneStateButton;
  
  public function new(designImagesController:IController){	
    super(designImagesController);
    backdrop                  = new PlaceholdersBackBitmap();
    
    designImagesScrollPane    = new ScrollPane(designImagesController);
    designImagesPane          = new DesignImagesPane(designImagesController);
    verticalScrollbar         = new VerticalScrollbar(designImagesController, EVENT_ID.DESIGN_SCROLL);
    addDesignImageButton           = new OneStateButton();
    
    Preset.addEventListener(EVENT_ID.DESIGN_IMAGES_LOADED, onPageDesignImagesLoaded);
    Designs.addEventListener(EVENT_ID.DESIGN_IMAGES_LOADED, onPageDesignImagesLoaded);
    
    
    
    Application.addEventListener(EVENT_ID.SET_DEFAULT_TOOL, onLoadDefaultTool);
    
  }
  
  
  override public function init():Void{
//        trace('init');
    selectButton.init( controller,
              new Point(190,30), 
              new DesignImagesViewButton(), 
              new Parameter( EVENT_ID.SHOW_DESIGN_IMAGES));
    
    addDesignImageButton.init(controller,
            new Point(150,22), 
            new AddPageDesignButton(), 
            new Parameter( EVENT_ID.ADD_DESIGN_IMAGE_TO_PAGE));
    
    addDesignImageButton.fireOnMouseUp(false);
  }
  
  override public function onAddedToStage(e:Event):Void{
//    trace('on added to stage');
    super.onAddedToStage(e);

    // font selection pane
    addChild(designImagesScrollPane);
    designImagesScrollPane.setSize(174,410);
    designImagesScrollPane.x = 9;
    designImagesScrollPane.y = 56;
    designImagesScrollPane.addView(designImagesPane, 0,0);	
    
    addChild(verticalScrollbar);
    verticalScrollbar.setSize(designImagesPane.getFloat('height'), designImagesScrollPane.getFloat('mask_height'));
    verticalScrollbar.x = designImagesScrollPane.getSize().x-2;
    verticalScrollbar.y = designImagesScrollPane.y;
    
    addChild(addDesignImageButton);
    addDesignImageButton.x = 20;
    addDesignImageButton.y = 488;
  }
  
  private function onPageDesignImagesLoaded(e:KEvent):Void{

    var xml:Xml = Xml.parse(StringTools.htmlUnescape(e.getXml().toString()));
    
    //trace(xml.toString());
    
    for(design_images in xml.elementsNamed('design-images')){
      for(design_image in design_images.elementsNamed('design-image')){
        //trace(design_image.toString());
        var param:IParameter = new Parameter(EVENT_ID.ADD_DESIGN_IMAGE_BUTTON);
        param.setXml(design_image);
        designImagesPane.setParam(param);
      }
    }
    
    
    //var param:IParameter = new Parameter(EVENT_ID.ADD_DESIGN_IMAGE_BUTTON);
    //param.setXml(xml);
    //designImagesPane.setParam(param);
  }
  
  private function onLoadDefaultTool(e:IKEvent):Void{
    //trace('onLoadDefaultTool');
    //trace(designImagesPane.getFloat('height'));
    //trace(designImagesScrollPane.getFloat('mask_height'));
    //
    //verticalScrollbar.setSize(designImagesPane.getFloat('height'), designImagesScrollPane.getFloat('mask_height'));
  }
  
  override public function setParam(param:IParameter):Void{

    switch( param.getLabel() ){
      case EVENT_ID.DESIGN_IMAGE_SELECTED: {
        designImagesPane.setParam(param);
      }
    }
	}
	
	override public function setFloat(id:String, f:Float):Void{
    //switch ( id ) {
    //  case EVENT_ID.DESIGN_IMAGE_SCROLL:{
    //    designImagesPane.y = -(designImagesPane.getFloat('height')-designImagesScrollPane.getFloat('mask_height')) * f;
    //  }
    //}
	}
}