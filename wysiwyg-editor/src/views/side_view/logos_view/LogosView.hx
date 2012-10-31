import flash.geom.Point;
import flash.events.Event;



class LogosView extends PropertyView, implements IView{
  
  //private var openLogosColorPickerButton:TwoStateButton;
  //private var logosColorPicker:LogosColorPicker;
  private var logosScrollPane:AView;
  private var logosPane:AView;
  private var verticalScrollbar:VerticalScrollbar;
  private var uploadLogoButton:OneStateTextAndImageButton;
  private var addLogoButton:OneStateTextAndImageButton;
  
  
  
  
  
  private var uploadImageButton:OneStateTextAndImageButton;
  private var addImageButton:OneStateTextAndImageButton;
  
  public function new(logosController:IController){	
    super(logosController);
    
    //openLogosColorPickerButton  = new TwoStateButton();
		//logosColorPicker						= new LogosColorPicker(logosController);
		
		
    backdrop              = new LogoViewBack();
    logosScrollPane       = new ScrollPane(logosController);
    logosPane             = new LogosPane(logosController);
    verticalScrollbar     = new VerticalScrollbar(logosController, EVENT_ID.LOGO_SCROLL);
    uploadLogoButton      = new OneStateTextAndImageButton();
    addLogoButton         = new OneStateTextAndImageButton();
    uploadImageButton     = new OneStateTextAndImageButton();
    addImageButton        = new OneStateTextAndImageButton();
    
    uploadLogoButton.setFormat(0, 3, 0xffffff, 'center');
    addLogoButton.setFormat(0, 3, 0xffffff, 'center');
    uploadImageButton.setFormat(0, 3, 0xffffff, 'center');
    addImageButton.setFormat(0, 3, 0xffffff, 'center');
    
    Preset.addEventListener(EVENT_ID.LOGOS_LOADED, onLogosLoaded);
    Application.addEventListener(EVENT_ID.SET_DEFAULT_TOOL, onLoadDefaultTool);
//    logosColorPicker.visible 	= false;
  }
  
  
  override public function init():Void{
      trace('init');
    selectButton.init( controller,
              new Point(190,30), 
              new LogoViewButton(), 
              new Parameter( EVENT_ID.SHOW_LOGOS));
    
    addLogoButton.init(controller,
            new Point(150,22), 
            new OneStateButtonBack(), 
            new Parameter( EVENT_ID.ADD_LOGO_TO_PAGE));
    
    addLogoButton.fireOnMouseUp(false);
    
    
    uploadLogoButton.init( controller, 
            new Point(150,22),  
            new OneStateButtonBack(), 
            new Parameter( EVENT_ID.UPLOAD_LOGO) );
            

    
    uploadLogoButton.fireOnMouseUp(false);
    
    
    addImageButton.init(controller,
            new Point(150,22), 
            new OneStateButtonBack(), 
            new Parameter( EVENT_ID.UPLOAD_IMAGE));

    addImageButton.fireOnMouseUp(false);
    
    uploadImageButton.init(controller,
            new Point(150,22), 
            new OneStateButtonBack(), 
            new Parameter( EVENT_ID.UPLOAD_IMAGE));

    uploadImageButton.fireOnMouseUp(false);
    
  }
  
  override public function onAddedToStage(e:Event):Void{
    super.onAddedToStage(e);
    
    

    
    // font selection pane
    addChild(logosScrollPane);
    logosScrollPane.setSize( 174, 200);
    logosScrollPane.x = 9;
    logosScrollPane.y = 54;
    logosScrollPane.addView(logosPane, 0,0);	
    
    addChild(verticalScrollbar);
    verticalScrollbar.setSize(logosPane.getFloat('height'), logosScrollPane.getFloat('mask_height'));
    verticalScrollbar.x = logosScrollPane.getSize().x-2;
    verticalScrollbar.y = logosScrollPane.y;
    
    addChild(addLogoButton);
    addLogoButton.x = 20;
    addLogoButton.y = 212;
    
    
    addChild(uploadLogoButton);
    uploadLogoButton.x = 20;
    uploadLogoButton.y = 238;
    
    
    addChild(addImageButton);
    addImageButton.x = 20;
    addImageButton.y = 462;
    
    addChild(uploadImageButton);
    uploadImageButton.x = 20;
    uploadImageButton.y = 488;
    
    /*
    trace(TRANSLATION.add_ons_button);
    trace(TRANSLATION.name);*/
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
  
  private function onLoadDefaultTool(e:IKEvent):Void{
    verticalScrollbar.setSize(logosPane.getFloat('height'), logosScrollPane.getFloat('mask_height'));


    
    
    uploadLogoButton.setText(TRANSLATION.upload_logo); 
    uploadLogoButton.updateLabel();      
    addLogoButton.setText(TRANSLATION.add_logo);    
    addLogoButton.updateLabel();         
    uploadImageButton.setText(TRANSLATION.upload_image); 
    uploadImageButton.updateLabel();     
    addImageButton.setText(TRANSLATION.add_image); 
    addImageButton.updateLabel();        
    
    
    
    
    
    
    
    
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