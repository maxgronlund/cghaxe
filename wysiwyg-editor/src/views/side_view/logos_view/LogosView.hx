import flash.geom.Point;
import flash.events.Event;



class LogosView extends PropertyView, implements IView{
  
  //private var openLogosColorPickerButton:TwoStateButton;
  //private var logosColorPicker:LogosColorPicker;
  private var logosScrollPane:AView;
  private var logosPane:AView;
  private var verticalScrollbar:VerticalScrollbar;
  private var addLogoButton:OneStateButton;
  
  public function new(logosController:IController){	
    super(logosController);
    
    //openLogosColorPickerButton  = new TwoStateButton();
		//logosColorPicker						= new LogosColorPicker(logosController);
		
		
    backdrop              = new PlaceholdersBackBitmap();
    logosScrollPane       = new ScrollPane(logosController);
    logosPane             = new LogosPane(logosController);
    verticalScrollbar     = new VerticalScrollbar(logosController, EVENT_ID.LOGO_SCROLL);
    addLogoButton         = new OneStateButton();
    
    Preset.addEventListener(EVENT_ID.LOGOS_LOADED, onLogosLoaded);
    Application.addEventListener(EVENT_ID.SET_DEFAULT_TOOL, onLoadDefaultToold);
//    logosColorPicker.visible 	= false;
  }
  
  
  override public function init():Void{
       
    selectButton.init( controller,
              new Point(190,30), 
              new LogoViewButton(), 
              new Parameter( EVENT_ID.SHOW_LOGOS));
    
    addLogoButton.init(controller,
            new Point(150,22), 
            new AddLogoButton(), 
            new Parameter( EVENT_ID.ADD_LOGO_TO_PAGE));
    
    addLogoButton.fireOnMouseUp(false);
    
  }
  
  override public function onAddedToStage(e:Event):Void{
    super.onAddedToStage(e);

    
    // font selection pane
    addChild(logosScrollPane);
    logosScrollPane.setSize( 174, 430);
    logosScrollPane.x = 9;
    logosScrollPane.y = 44;
    logosScrollPane.addView(logosPane, 0,0);	
    
    addChild(verticalScrollbar);
    verticalScrollbar.setSize(logosPane.getFloat('height'), logosScrollPane.getFloat('mask_height'));
    verticalScrollbar.x = logosScrollPane.getSize().x-2;
    verticalScrollbar.y = logosScrollPane.y;
    
    addChild(addLogoButton);
    addLogoButton.x = 20;
    addLogoButton.y = 488;
  }
  
  private function onLogosLoaded(e:KEvent):Void{
    //var logosXml:Xml = Xml.parse(StringTools.htmlUnescape(e.getXml().toString()));
    
    for(logo in e.getXml().elementsNamed('logo')){
      //trace(logo.toString());
      var param:IParameter = new Parameter(EVENT_ID.ADD_LOGO_BUTTON);
      param.setXml(logo);
      logosPane.setParam(param);
    }

  }
  
  private function onLoadDefaultToold(e:IKEvent):Void{
    verticalScrollbar.setSize(logosPane.getFloat('height'), logosScrollPane.getFloat('mask_height'));
  }
  
  override public function setParam(param:IParameter):Void{

    switch( param.getLabel() ){
      case EVENT_ID.LOGO_SELECTED: {
        logosPane.setParam(param);
      }

      
    }
	}

	
	override public function setFloat(id:String, f:Float):Void{
    switch ( id ) {
      case EVENT_ID.LOGO_SCROLL:{
        logosPane.y = -(logosPane.getFloat('height')-logosScrollPane.getFloat('mask_height')) * f;
      }
    }
	}
}