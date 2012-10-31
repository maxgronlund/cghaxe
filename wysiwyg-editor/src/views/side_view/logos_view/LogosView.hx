import flash.geom.Point;
import flash.events.Event;



class LogosView extends PropertyView, implements IView{
  
  //private var openLogosColorPickerButton:TwoStateButton;
  //private var logosColorPicker:LogosColorPicker;
  private var logosScrollPane:AView;
  private var logosPane:AView;
  private var logoScrollbar:VerticalScrollbar;
  private var uploadLogoButton:OneStateTextAndImageButton;
  private var addLogoButton:OneStateTextAndImageButton;
  
  private var imagesScrollPane:AView;
  private var imagesPane:AView;
  private var imagesScrollbar:VerticalScrollbar;
  private var uploadImageButton:OneStateTextAndImageButton;
  private var addImageButton:OneStateTextAndImageButton;
  
  public function new(logosController:IController){	
    super(logosController);
    
    //openLogosColorPickerButton  = new TwoStateButton();
		//logosColorPicker						= new LogosColorPicker(logosController);
		
		
    backdrop              = new LogoViewBack();
    logosScrollPane       = new ScrollPane(logosController);
    logosPane             = new LogosPane(logosController);
    logoScrollbar         = new VerticalScrollbar(logosController, EVENT_ID.LOGO_SCROLL);
    uploadLogoButton      = new OneStateTextAndImageButton();
    addLogoButton         = new OneStateTextAndImageButton();
    uploadLogoButton.setFormat(0, 3, 0xffffff, 'center');
    addLogoButton.setFormat(0, 3, 0xffffff, 'center');
    
    
    imagesScrollPane      = new ScrollPane(logosController);
    imagesScrollbar       = new VerticalScrollbar(logosController, EVENT_ID.IMAGE_SCROLL);
    imagesPane            = new ImagesPane(logosController);
    uploadImageButton     = new OneStateTextAndImageButton();
    addImageButton        = new OneStateTextAndImageButton();
    
    uploadImageButton.setFormat(0, 3, 0xffffff, 'center');
    addImageButton.setFormat(0, 3, 0xffffff, 'center');
    
    Preset.addEventListener(EVENT_ID.LOGOS_LOADED, onLogosLoaded);
    Preset.addEventListener(EVENT_ID.IMAGES_LOADED, onImagesLoaded);
    Application.addEventListener(EVENT_ID.SET_DEFAULT_TOOL, onLoadDefaultTool);

  }
  
  
  override public function init():Void{

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
            new Parameter( EVENT_ID.ADD_IMAGE_TO_PAGE));
    addImageButton.fireOnMouseUp(false);
    
    uploadImageButton.init(controller,
            new Point(150,22), 
            new OneStateButtonBack(), 
            new Parameter( EVENT_ID.UPLOAD_IMAGE));
    uploadImageButton.fireOnMouseUp(false);
    
  }
  
  override public function onAddedToStage(e:Event):Void{
    super.onAddedToStage(e);
    

    // logo selection pane
    addChild(logosScrollPane);
    logosScrollPane.setSize( 174, 200);
    logosScrollPane.x = 9;
    logosScrollPane.y = 54;
    logosScrollPane.addView(logosPane, 0,0);	
    
    addChild(logoScrollbar);
    logoScrollbar.setSize(logosPane.getFloat('height'), logosScrollPane.getFloat('mask_height'));
    logoScrollbar.x = logosScrollPane.getSize().x-1;
    logoScrollbar.y = logosScrollPane.y;
    
    addChild(addLogoButton);
    addLogoButton.x = 20;
    addLogoButton.y = 212;
    
    addChild(uploadLogoButton);
    uploadLogoButton.x = 20;
    uploadLogoButton.y = 238;
    

    // image selection pane
    addChild(imagesScrollPane);
    imagesScrollPane.setSize( 174, 200);
    imagesScrollPane.x = 9;
    imagesScrollPane.y = 54 + 236;
    imagesScrollPane.addView(imagesPane, 0,0);	
    
    addChild(imagesScrollbar);
    imagesScrollbar.setSize(imagesPane.getFloat('height'), imagesScrollPane.getFloat('mask_height'));
    imagesScrollbar.x = imagesScrollPane.getSize().x-1;
    imagesScrollbar.y = imagesScrollPane.y;
    
    addChild(addImageButton);
    addImageButton.x = 20;
    addImageButton.y = 448;
    
    addChild(uploadImageButton);
    uploadImageButton.x = 20;
    uploadImageButton.y = 474;

  }
  
  private function onLogosLoaded(e:KEvent):Void{

    for(logo in e.getXml().elementsNamed('logo')){
      var logoParam:IParameter = new Parameter(EVENT_ID.ADD_LOGO_BUTTON);
      logoParam.setXml(logo);
      logosPane.setParam(logoParam);
    }
  }
  
  private function onImagesLoaded(e:KEvent):Void{

    for(photo in e.getXml().elementsNamed('photo')){

      var imageParam:IParameter = new Parameter(EVENT_ID.ADD_IMAGE_BUTTON);
      imageParam.setXml(photo);
      imagesPane.setParam(imageParam);
    }

  }
  
  private function onLoadDefaultTool(e:IKEvent):Void{
    logoScrollbar.setSize(logosPane.getFloat('height'), logosScrollPane.getFloat('mask_height'));

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
      case EVENT_ID.IMAGE_SELECTED: {
        imagesPane.setParam(param);
      }

      
    }
	}

	
	override public function setFloat(id:String, f:Float):Void{
    switch ( id ) {
      case EVENT_ID.LOGO_SCROLL:
        logosPane.y = -(logosPane.getFloat('height')-logosScrollPane.getFloat('mask_height')) * f;
      case EVENT_ID.IMAGE_SCROLL:
        imagesPane.y = -(imagesPane.getFloat('height')-imagesScrollPane.getFloat('mask_height')) * f;
    }
	}
}