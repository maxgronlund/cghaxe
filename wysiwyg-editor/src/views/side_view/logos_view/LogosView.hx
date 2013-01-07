import flash.geom.Point;
import flash.events.Event;
import flash.text.TextField;
import flash.Vector;



class LogosView extends PropertyView, implements IView{
  
  //private var openLogosColorPickerButton:TwoStateButton;
  //private var logosColorPicker:LogosColorPicker;
  private var logosScrollPane:AView;
  private var logosPane:AView;
  private var logoScrollbar:VerticalScrollbar;
  private var uploadLogoButton:OneStateTextAndImageButton;
  private var uploadLogoIButton:OneStateTextAndImageButton;
  private var back:Rectangle;
  private var logosBack:Rectangle;
  private var photosBack:Rectangle;
  
  private var addLogoInfo:InfoMessageView;
  private var uploadLogoInfo:InfoMessageView;
  
  private var photosScrollPane:AView;
  private var photosPane:AView;
  private var photosScrollbar:VerticalScrollbar;
  private var uploadImageButton:OneStateTextAndImageButton;
  
  private var imagesTextField:FormatedText;
  private var logosTextField:FormatedText;
  
  private var allLoadingLogosVectors:Vector<Xml>;
  private var currentVectorLogosLoading:UInt;
  private var verticalScrollbarLogosAdded:Bool;
  
  private var allLoadingPhotosVectors:Vector<Xml>;
  private var currentVectorPhotosLoading:UInt;
  private var verticalScrollbarPhotosAdded:Bool;
  
  public function new(logosController:IController){	
    super(logosController);
    
    //openLogosColorPickerButton  = new TwoStateButton();
		//logosColorPicker						= new LogosColorPicker(logosController);
		
	back        = new Rectangle(190, 442, 0x000000, 0xDEDEDE, Rectangle.DONT_DRAW_LINES, Rectangle.USE_FILL);
	logosBack   = new Rectangle(174, 160, 0xC3C3C3, 0xF4F4F4, Rectangle.DRAW_LINES, Rectangle.USE_FILL);
	photosBack  = new Rectangle(174, 160, 0xC3C3C3, 0xF4F4F4, Rectangle.DRAW_LINES, Rectangle.USE_FILL);
		
    logosScrollPane       = new ScrollPane(logosController);
    logosPane             = new SymbolImageDialog(logosController);
    logoScrollbar         = new VerticalScrollbar(logosController, EVENT_ID.LOGO_SCROLL);
    uploadLogoButton      = new OneStateTextAndImageButton();
    
	imagesTextField 	= new FormatedText('helvetica', 'text', 12, false);
	logosTextField 	= new FormatedText('helvetica', 'text', 12, false);
	
    uploadLogoIButton     = new OneStateTextAndImageButton();
    uploadLogoIButton.setFormat(0, 3, 0x333333, 'center');
    
    uploadLogoButton.setFormat(0, 3, 0x333333, 'center');
   
    photosScrollPane      = new ScrollPane(logosController);
    photosScrollbar       = new VerticalScrollbar(logosController, EVENT_ID.PHOTO_SCROLL);
    photosPane            = new SymbolImageDialog(logosController);
    uploadImageButton     = new OneStateTextAndImageButton();
   
    uploadImageButton.setFormat(0, 3, 0x333333, 'center');
    
    
    
    addLogoInfo       = new InfoMessageView(GLOBAL.tool_tips_controller, TOOL_TIPS.MY_UPLOADS_ADD,'right','top');                
    uploadLogoInfo    = new InfoMessageView(GLOBAL.tool_tips_controller, TOOL_TIPS.MY_UPLOADS_UPLOAD,'right','top');
    Preset.addEventListener(EVENT_ID.LOGOS_LOADED, onLogosLoaded);
    Preset.addEventListener(EVENT_ID.PHOTOS_LOADED, onPhotosLoaded);
    Application.addEventListener(EVENT_ID.SET_DEFAULT_TOOL, onLoadDefaultTool);

	
	verticalScrollbarLogosAdded = false;
	verticalScrollbarPhotosAdded = false;
	
	allLoadingPhotosVectors = new Vector<Xml>();
	allLoadingLogosVectors = new Vector<Xml>();
	
	currentVectorPhotosLoading = 0;
	currentVectorLogosLoading = 0;
	
    Logos.addEventListener(EVENT_ID.SHOW_MY_UPLOADS, onShowMyUploads);
  }
  
  
  override public function init():Void{

    selectButton.init( controller,
              new Point(190,30), 
              new ToolSelectionButton(), 
              new Parameter( EVENT_ID.SHOW_MY_UPLOADS));
    
        
    uploadLogoButton.init( controller, 
            new Point(150,22),  
            new OneStateButtonBackL(), 
            new Parameter( EVENT_ID.UPLOAD_LOGO) );
    uploadLogoButton.fireOnMouseUp(false);
    
    uploadLogoIButton.init( GLOBAL.tool_tips_controller,
                        new Point(22,22), 
                        new OneStateButtonBackS(), 
                        new Parameter( TOOL_TIPS.MY_UPLOADS_UPLOAD));

    uploadImageButton.init(controller,
            new Point(150,22), 
            new OneStateButtonBackL(), 
            new Parameter( EVENT_ID.UPLOAD_PHOTO));
    uploadImageButton.fireOnMouseUp(false);
    
    
  }
  
  override public function onAddedToStage(e:Event):Void{
    
    super.onAddedToStage(e);

    addChild(back);
    back.y = 30;
    
	addChild(logosTextField);
	logosTextField.x = 8;
	logosTextField.y = 34;
	
    addChild(logosBack);
    logosBack.x = 8;
    logosBack.y = 55;
    // logo selection pane
    addChild(logosScrollPane);
    logosScrollPane.setSize( 174, 159);
    logosScrollPane.x = 9;
    logosScrollPane.y = 56;
    logosScrollPane.addView(logosPane, 0,0);	
   
    addChild(uploadLogoButton);
    uploadLogoButton.x = 9;
    uploadLogoButton.y = 220;
    
    addChild(uploadLogoIButton);
    uploadLogoIButton.x = 9+154;
    uploadLogoIButton.y = 220;
    
    //fixedSizeInfo.x = uploadLogoIButton.x;
  	//fixedSizeInfo.y = uploadLogoIButton.y;
    //addChild(fixedSizeInfo);
    
   
    

    

    // image selection pane
	addChild(photosBack);
	photosBack.x = 9;
	photosBack.y = 54 + 213;
	
	addChild(imagesTextField);
	imagesTextField.x = 8;
	imagesTextField.y = 246;
	
	
    addChild(photosScrollPane);
    photosScrollPane.setSize( 174, 159);
    photosScrollPane.x = 9;
    photosScrollPane.y = 54 + 213;
    photosScrollPane.addView(photosPane, 0,0);	
    
   
    addChild(uploadImageButton);
    uploadImageButton.x = 20;
    uploadImageButton.y = 436;

	addChild(addLogoInfo);
    
    uploadLogoInfo.x = uploadLogoIButton.x;
  	uploadLogoInfo.y = uploadLogoIButton.y;
    addChild(uploadLogoInfo);
			
	photosPane.addEventListener(EVENT_ID.LOAD_NEXT_IMAGE, loadPhotosVector);
	logosPane.addEventListener(EVENT_ID.LOAD_NEXT_IMAGE, loadLogosVector);
	
  }
  
  private function onLogosLoaded(e:KEvent):Void{

    /*for(logo in e.getXml().elementsNamed('logo')){
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
    }*/
	
	for (vector in e.getXml().elementsNamed('logo')) {
		allLoadingLogosVectors.push(vector);
	}
  }
  
  private function onPhotosLoaded(e:KEvent):Void{
    
    /*for(photo in e.getXml().elementsNamed('photo')){

      var imageParam:IParameter = new Parameter(EVENT_ID.ADD_IMAGE_BUTTON);
      imageParam.setXml(photo);
      photosPane.setParam(imageParam);
    }*/
	
	for (vector in e.getXml().elementsNamed('photo')) {
		allLoadingPhotosVectors.push(vector);
	}
  }
  
  private function onShowMyUploads(e:Event):Void {
	  var param1:IParameter = new Parameter(EVENT_ID.ADD_LOGO_BUTTON);
	  loadFirstLogosVector(param1);
	  
	   var param2:IParameter = new Parameter(EVENT_ID.ADD_IMAGE_BUTTON);
	  loadFirstPhotosVector(param2);
  }
  
  
  public function loadFirstLogosVector(param:IParameter):Void {
	 if (currentVectorLogosLoading == 0) {
		  var event:KEvent = new KEvent(EVENT_ID.LOAD_NEXT_IMAGE, param);
		  loadLogosVector(event);
	  }
  }
  
  public function loadFirstPhotosVector(param:IParameter):Void {
	 if (currentVectorPhotosLoading == 0) {
		  var event:KEvent = new KEvent(EVENT_ID.LOAD_NEXT_IMAGE, param);
		  loadPhotosVector(event);
	  }
  }
    
  
  public function loadPhotosVector(e:KEvent):Void {
	 if (currentVectorPhotosLoading < allLoadingPhotosVectors.length) {
		  var vectorXml:Xml = allLoadingPhotosVectors[currentVectorPhotosLoading];
		  var str:String = vectorXml.toString();	
		  
		  var param:IParameter = new Parameter(EVENT_ID.ADD_IMAGE_BUTTON);
		  param.setXml(vectorXml);
		  photosPane.setParam(param);
		  
		  
		  currentVectorPhotosLoading++;
		  
		  refreshPhotosScrollBars();
	 } else {
		 refreshPhotosScrollBars();
	 }
  }
  
  public function loadLogosVector(e:KEvent):Void {
	 if (currentVectorLogosLoading < allLoadingLogosVectors.length) {
		  var vectorXml:Xml = allLoadingLogosVectors[currentVectorLogosLoading];
		  var str:String = vectorXml.toString();	
		  
		  var param:IParameter = new Parameter(EVENT_ID.ADD_LOGO_BUTTON);
		  param.setXml(vectorXml);
		  logosPane.setParam(param);
		  
		  
		  currentVectorLogosLoading++;
		  
		  refreshLogosScrollBars();
	 } else {
		 refreshLogosScrollBars();
	 }
  }
  
  
  private function refreshPhotosScrollBars():Void {
	 
	  if (verticalScrollbarPhotosAdded) {
		  photosScrollbar.setSize(photosPane.getFloat('logo_height'), photosScrollPane.getFloat('mask_height'));
		  photosScrollbar.x = photosScrollPane.getSize().x-2;
		  photosScrollbar.y = photosScrollPane.y;
	  }	
	  else {
		if(photosPane.getFloat('logo_height') > photosScrollPane.getFloat('mask_height')){
			  addChild(photosScrollbar);
			  verticalScrollbarPhotosAdded = true;
			  photosScrollbar.setSize(photosPane.getFloat('logo_height'), photosScrollPane.getFloat('mask_height'));
			  photosScrollbar.x = photosScrollPane.getSize().x-2;
			  photosScrollbar.y = photosScrollPane.y;
			}
		}
		
  }
  
  private function refreshLogosScrollBars():Void {
	  if (verticalScrollbarLogosAdded) {
		  logoScrollbar.setSize(logosPane.getFloat('logo_height'), logosScrollPane.getFloat('mask_height'));
		  logoScrollbar.x = logosScrollPane.getSize().x-2;
		  logoScrollbar.y = logosScrollPane.y;
		}	
	  else {
		if(logosPane.getFloat('logo_height') > logosScrollPane.getFloat('mask_height')){
			  addChild(logoScrollbar);
			  verticalScrollbarLogosAdded = true;
			  logoScrollbar.setSize(logosPane.getFloat('logo_height'), logosScrollPane.getFloat('mask_height'));
			  logoScrollbar.x = logosScrollPane.getSize().x-2;
			  logoScrollbar.y = logosScrollPane.y;
			}
		}
  }
  
  private function onLoadDefaultTool(e:IKEvent):Void{
    logoScrollbar.setSize(logosPane.getFloat('height'), logosScrollPane.getFloat('mask_height'));

    uploadLogoButton.setText(TRANSLATION.upload_logo); 
    uploadLogoButton.updateLabel();  
    
    uploadLogoIButton.setText('?');    
    uploadLogoIButton.updateLabel();
        
    selectButton.setText(TRANSLATION.my_uploads_button); 
    
    uploadLogoInfo.setContent( TOOL_TIPS.my_uploads_upload_title ,
                              TOOL_TIPS.my_uploads_upload_body ,
                              TOOL_TIPS.my_uploads_upload_link); 
         
    uploadImageButton.setText(TRANSLATION.upload_image); 
    uploadImageButton.updateLabel();     
    
	logosTextField.setLabel(TRANSLATION.logo_title);
	imagesTextField.setLabel(TRANSLATION.image_title);
  }
  
  override public function setParam(param:IParameter):Void{

    switch( param.getLabel() ){
		  case EVENT_ID.LOGO_SELECTED: {
			logosPane.setParam(param);
		  }
		  
		  case EVENT_ID.PHOTO_SELECTED: 
			photosPane.setParam(param);

		}
	}

	
	override public function setFloat(id:String, f:Float):Void{
    switch ( id ) {
      case EVENT_ID.LOGO_SCROLL:
        logosPane.y = -(logosPane.getFloat('logo_height')-logosScrollPane.getFloat('mask_height')) * f;
      
      case EVENT_ID.PHOTO_SCROLL:
        photosPane.y = -(photosPane.getFloat('logo_height')-photosScrollPane.getFloat('mask_height')) * f;
      
    }
  }
  
  override public function getHeight():Int{
    var r = 0;
    if(back.visible)
		  r =  Std.int(back.height)+30;
    return r;
  }
}