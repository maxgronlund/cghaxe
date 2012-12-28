import flash.geom.Point;
import flash.events.Event;



class LogosView extends PropertyView, implements IView{
  
  //private var openLogosColorPickerButton:TwoStateButton;
  //private var logosColorPicker:LogosColorPicker;
  private var logosScrollPane:AView;
  private var logosPane:AView;
  private var logoScrollbar:VerticalScrollbar;
  private var uploadLogoButton:OneStateTextAndImageButton;
  private var uploadLogoIButton:OneStateTextAndImageButton;
  private var addLogoButton:OneStateTextAndImageButton;
  private var addLogoIButton:OneStateTextAndImageButton;
  private var back:Rectangle;
  private var logosBack:Rectangle;
  
  private var addLogoInfo:InfoMessageView;
  private var uploadLogoInfo:InfoMessageView;
  /*
  private var photosScrollPane:AView;
  private var photosPane:AView;
  private var photosScrollbar:VerticalScrollbar;
  private var uploadImageButton:OneStateTextAndImageButton;
  private var addImageButton:OneStateTextAndImageButton;
  */
  public function new(logosController:IController){	
    super(logosController);
    
    //openLogosColorPickerButton  = new TwoStateButton();
		//logosColorPicker						= new LogosColorPicker(logosController);
		back        = new Rectangle(190, 246, 0x000000, 0xDEDEDE, Rectangle.DONT_DRAW_LINES, Rectangle.USE_FILL);
		logosBack   = new Rectangle(174, 160, 0xC3C3C3, 0xF4F4F4, Rectangle.DRAW_LINES, Rectangle.USE_FILL);
		//backdrop = null;
    //backdrop              = new LogoViewBack();
    logosScrollPane       = new ScrollPane(logosController);
    logosPane             = new LogosPane(logosController);
    logoScrollbar         = new VerticalScrollbar(logosController, EVENT_ID.LOGO_SCROLL);
    uploadLogoButton      = new OneStateTextAndImageButton();
    addLogoButton         = new OneStateTextAndImageButton();
    
    uploadLogoIButton     = new OneStateTextAndImageButton();
    uploadLogoIButton.setFormat(0, 3, 0x333333, 'center');
    
    uploadLogoButton.setFormat(0, 3, 0x333333, 'center');
    addLogoButton.setFormat(0, 3, 0x333333, 'center');
    
    addLogoIButton       = new OneStateTextAndImageButton();
    addLogoIButton.setFormat(0, 3, 0x333333, 'center');
    /*
    photosScrollPane      = new ScrollPane(logosController);
    photosScrollbar       = new VerticalScrollbar(logosController, EVENT_ID.PHOTO_SCROLL);
    photosPane            = new PhotosPane(logosController);
    uploadImageButton     = new OneStateTextAndImageButton();
    addImageButton        = new OneStateTextAndImageButton();
    
    uploadImageButton.setFormat(0, 3, 0xffffff, 'center');
    addImageButton.setFormat(0, 3, 0xffffff, 'center');
    
    
    */
    
    addLogoInfo       = new InfoMessageView(GLOBAL.tool_tips_controller, TOOL_TIPS.MY_UPLOADS_ADD,'right','top');                
    uploadLogoInfo    = new InfoMessageView(GLOBAL.tool_tips_controller, TOOL_TIPS.MY_UPLOADS_UPLOAD,'right','top');
    Preset.addEventListener(EVENT_ID.LOGOS_LOADED, onLogosLoaded);
    Preset.addEventListener(EVENT_ID.PHOTOS_LOADED, onPhotosLoaded);
    Application.addEventListener(EVENT_ID.SET_DEFAULT_TOOL, onLoadDefaultTool);

  }
  
  
  override public function init():Void{

    selectButton.init( controller,
              new Point(190,30), 
              new ToolSelectionButton(), 
              new Parameter( EVENT_ID.SHOW_MY_UPLOADS));
    
    addLogoButton.init(controller,
            new Point(150,22), 
            new OneStateButtonBackL(), 
            new Parameter( EVENT_ID.ADD_LOGO_TO_PAGE));
    addLogoButton.fireOnMouseUp(false);
    
    
    
    addLogoIButton.init( GLOBAL.tool_tips_controller,
                        new Point(22,22), 
                        new OneStateButtonBackS(), 
                        new Parameter( TOOL_TIPS.MY_UPLOADS_ADD));
                        
                        
                        
    
    uploadLogoButton.init( controller, 
            new Point(150,22),  
            new OneStateButtonBackL(), 
            new Parameter( EVENT_ID.UPLOAD_LOGO) );
    uploadLogoButton.fireOnMouseUp(false);
    
    uploadLogoIButton.init( GLOBAL.tool_tips_controller,
                        new Point(22,22), 
                        new OneStateButtonBackS(), 
                        new Parameter( TOOL_TIPS.MY_UPLOADS_UPLOAD));
    
    
    /*
    addImageButton.init(controller,
            new Point(150,22), 
            new OneStateButtonBackL(), 
            new Parameter( EVENT_ID.ADD_PHOTO_TO_PAGE));
    addImageButton.fireOnMouseUp(false);
    
    uploadImageButton.init(controller,
            new Point(150,22), 
            new OneStateButtonBackL(), 
            new Parameter( EVENT_ID.UPLOAD_PHOTO));
    uploadImageButton.fireOnMouseUp(false);
    */
    
  }
  
  override public function onAddedToStage(e:Event):Void{
    
    super.onAddedToStage(e);

    addChild(back);
    back.y = 30;
    
    addChild(logosBack);
    logosBack.x = 8;
    logosBack.y = 43;
    // logo selection pane
    addChild(logosScrollPane);
    logosScrollPane.setSize( 174, 159);
    logosScrollPane.x = 9;
    logosScrollPane.y = 44;
    logosScrollPane.addView(logosPane, 0,0);	
    
    addChild(logoScrollbar);
    logoScrollbar.setSize(logosPane.getFloat('height'), logosScrollPane.getFloat('mask_height'));
    logoScrollbar.x = logosScrollPane.getSize().x-1;
    logoScrollbar.y = logosScrollPane.y;
    
    addChild(addLogoButton);
    addLogoButton.x = 9;
    addLogoButton.y = 214;
    
    addChild(addLogoIButton);
    addLogoIButton.x = 9+154;
    addLogoIButton.y = 214;
    
    
    
    
    addChild(uploadLogoButton);
    uploadLogoButton.x = 9;
    uploadLogoButton.y = 246;
    
    addChild(uploadLogoIButton);
    uploadLogoIButton.x = 9+154;
    uploadLogoIButton.y = 246;
    
    //fixedSizeInfo.x = uploadLogoIButton.x;
  	//fixedSizeInfo.y = uploadLogoIButton.y;
    //addChild(fixedSizeInfo);
    
    addLogoInfo.x = addLogoIButton.x;
  	addLogoInfo.y = addLogoIButton.y;
    addChild(addLogoInfo);
    
    uploadLogoInfo.x = uploadLogoIButton.x;
  	uploadLogoInfo.y = uploadLogoIButton.y;
    addChild(uploadLogoInfo);

    
/*
    // image selection pane
    addChild(photosScrollPane);
    photosScrollPane.setSize( 174, 150);
    photosScrollPane.x = 9;
    photosScrollPane.y = 54 + 236;
    photosScrollPane.addView(photosPane, 0,0);	
    
    addChild(photosScrollbar);
    photosScrollbar.setSize(photosPane.getFloat('height'), photosScrollPane.getFloat('mask_height'));
    photosScrollbar.x = photosScrollPane.getSize().x-1;
    photosScrollbar.y = photosScrollPane.y;
    
    addChild(addImageButton);
    addImageButton.x = 20;
    addImageButton.y = 448;
    
    addChild(uploadImageButton);
    uploadImageButton.x = 20;
    uploadImageButton.y = 474;
*/

  }
  
  private function onLogosLoaded(e:KEvent):Void{

//    trace(e.getXml().toString());

    for(logo in e.getXml().elementsNamed('logo')){
      var logoParam:IParameter = new Parameter(EVENT_ID.ADD_LOGO_BUTTON);
      for(title in logo.elementsNamed('title')){
        logoParam.setString(title.firstChild().nodeValue.toString());
      }
      for(url in logo.elementsNamed('url')){
        //logoParam.setString(title.firstChild().nodeValue.toString());
        logoParam.setXml(url);
      }
      //logoParam.setXml(logo);
      logosPane.setParam(logoParam);
    }
  }
  
  private function onPhotosLoaded(e:KEvent):Void{
    /*
    for(photo in e.getXml().elementsNamed('photo')){

      var imageParam:IParameter = new Parameter(EVENT_ID.ADD_IMAGE_BUTTON);
      imageParam.setXml(photo);
      photosPane.setParam(imageParam);
    }
    */

  }
  
  private function onLoadDefaultTool(e:IKEvent):Void{
    logoScrollbar.setSize(logosPane.getFloat('height'), logosScrollPane.getFloat('mask_height'));

    uploadLogoButton.setText(TRANSLATION.upload_logo); 
    uploadLogoButton.updateLabel();  
    
    uploadLogoIButton.setText('?');    
    uploadLogoIButton.updateLabel();
        
    addLogoButton.setText(TRANSLATION.add_logo);    
    addLogoButton.updateLabel();  
    
    addLogoIButton.setText('?');    
    addLogoIButton.updateLabel();
    
    selectButton.setText(TRANSLATION.my_uploads_button); 
    
    addLogoInfo.setContent( TOOL_TIPS.my_uploads_add_title,
                            TOOL_TIPS.my_uploads_add_body ,
                            TOOL_TIPS.my_uploads_add_link);
                              
    uploadLogoInfo.setContent( TOOL_TIPS.my_uploads_upload_title ,
                              TOOL_TIPS.my_uploads_upload_body ,
                              TOOL_TIPS.my_uploads_upload_link); 
    /*     
    uploadImageButton.setText(TRANSLATION.upload_image); 
    uploadImageButton.updateLabel();     
    addImageButton.setText(TRANSLATION.add_image); 
    addImageButton.updateLabel();     
    */   

  }
  
  override public function setParam(param:IParameter):Void{

    switch( param.getLabel() ){
      case EVENT_ID.LOGO_SELECTED: {
        logosPane.setParam(param);
      }
      /*
      case EVENT_ID.PHOTO_SELECTED: 
        photosPane.setParam(param);
      */

      
    }
	}

	
	override public function setFloat(id:String, f:Float):Void{
    switch ( id ) {
      case EVENT_ID.LOGO_SCROLL:
        logosPane.y = -(logosPane.getFloat('height')-logosScrollPane.getFloat('mask_height')) * f;
      /*  
      case EVENT_ID.PHOTO_SCROLL:
        photosPane.y = -(photosPane.getFloat('height')-photosScrollPane.getFloat('mask_height')) * f;
      */
    }
  }
  
  override public function getHeight():Int{
    return 276;
  }
}