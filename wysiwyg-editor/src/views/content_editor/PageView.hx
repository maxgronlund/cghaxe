/* Shows an image of a page
* can be transparent
* holds placeholders
* the page handles placeholder focus
*/

import flash.events.Event;
import flash.events.MouseEvent;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.geom.Point;
import flash.net.URLRequest;
import flash.display.Loader;
import flash.display.Sprite;
import flash.display.MovieClip;
import flash.Vector;
import flash.Lib;
import flash.filters.DropShadowFilter;
import flash.text.TextField;



class PageView extends View{
  
  private var imageLoader:Loader;
  private var maskLoader:Loader;
  private var model:IModel;
  private var guideMask:Bitmap;
  private var hideMask:Bitmap;
  private var loaded_bitmap:Bitmap;
  private var bitmap_data:BitmapData;
  //private var placeholder:Placeholder;
  private var inFocus:APlaceholder;
  
  private var placeholders:Vector<APlaceholder>; 
//  private var designImagePlaceholders:Vector<APlaceholder>;
  private var hitPoint:Point;
  private var startPoint:Point;
  private var placeholderHasMouse:Bool;
  private var pagePresetXML:Xml;
  private var hideMaskPresent:Bool;
  
  private var frontShotSizeX:Float;
  private var frontShotSizeY:Float;

  
  public function new(controller:IController){	

    super(controller);
    
    imageLoader	                  = new Loader();
    maskLoader	                  = new Loader();
    placeholders              = new Vector<APlaceholder>();
//    designImagePlaceholders       = new Vector<APlaceholder>();
    hitPoint                      = new Point(0,0);
    startPoint                    = new Point(0,0);
    placeholderHasMouse           = false;
    hideMaskPresent               = false;

  }
  
  override public function onAddedToStage(e:Event): Void{

    super.onAddedToStage(e);
    Application.addEventListener(EVENT_ID.DESELECT_PLACEHOLDERS, onDeselectPlaceholders);
    Designs.addEventListener(EVENT_ID.ADD_TEXT_SUGGESTION, onAddTextSuggestion);
    //DesignImages.addEventListener(EVENT_ID.ADD_DESIGN_IMAGE_TO_PAGE, onAddDesignImage);

    
  }
  
  //private function onAddDesignImage(e:IKEvent):Void{
  //  trace('onAddDesignImage');
  //}
  
  override public function setModel(model:IModel):Void{
    
//    trace('model set');
    this.model = model;
    model.addEventListener(EVENT_ID.LOAD_FRONT_SHOT, onLoadFrontShot);
    	
    model.addEventListener(EVENT_ID.ADD_PLACEHOLDER, onAddPlaceholder);
    model.addEventListener(EVENT_ID.GET_STRING, onGetString);           // !!! rename this nonsens
    model.addEventListener(EVENT_ID.RELEASE_FOCUS, onReleasePageFocus);
    model.addEventListener(EVENT_ID.TRASH_PLACEHOLDER, onDestroyPlaceholder);
    model.addEventListener(EVENT_ID.PAGE_XML_LOADED, onPresetXml);
    
    Designs.addEventListener(EVENT_ID.LOAD_FRONT_SHOT, onLoadFrontShot);
    //Designs.addEventListener(EVENT_ID.PAGE_XML_LOADED, onPresetXml); 
  }
  
  override public function setParam(param:IParameter):Void{
    switch ( param.getLabel() ){
      case EVENT_ID.ADD_DESIGN_TO_PAGE:{
        addDesignToPage(param);
      }
      case EVENT_ID.ADD_DESIGN_IMAGE_TO_PAGE:{
        addDesignImageToPage(param);
      }
    }
  }
  
  private function addDesignToPage(param:IParameter):Void{

    onRemovePlaceholders();
    var xml:Xml = Xml.parse(StringTools.htmlUnescape(param.getXml().toString()));
    for( design  in xml.elementsNamed("design") ) {
      for( xml_file  in design.elementsNamed("xml-file") ) {
        pagePresetXML = xml_file;
        loadPagePresetXML();
      }
    }
  }
  
  private function addDesignImageToPage(param:IParameter):Void{
    //trace(param.getXml().toString());
    
    
    //placeholder.x = posX;
  	//placeholder.y = posY;
    //placeholders.push(placeholder);
    //addChild(placeholder);
    
    //addDesignImagePlaceholder(10,10, imageUrl);
    
    
     //trace(param.getXml().toString());
    
     //for( design_image in param.getXml().elementsNamed("swf-file") ){
     //  trace(design_image.toString());
     //  addDesignImagePlaceholder(10,10,design_image.firstChild().nodeValue);
     //}
     for( image in param.getXml().elementsNamed("image") ){
       //trace(image.toString());
       //for( preview in image.elementsNamed("preview") ){
       //  for( url in preview.elementsNamed("url") ){
       //    addDesignImagePlaceholder(10,10,url.firstChild().nodeValue);
       //  }
       //}
       for( url in image.elementsNamed("url") ){
          addDesignImagePlaceholder(10,10,url.firstChild().nodeValue);
        }
     }

  }
  
 
  private function addDesignImagePlaceholder(posX:Float, posY:Float, imageUrl:String):Void{
    trace(imageUrl);
    setPlaceholderInFocus(null);
    
    var placeholder:APlaceholder		= new DesignImagePlaceholderView(this, placeholders.length, model, imageUrl);
  
    placeholder.x = posX;
  	placeholder.y = posY;
    placeholders.push(placeholder);
    addChild(placeholder);
  
  }


  private function onPresetXml(e:IKEvent):Void{
    
    pagePresetXML = Xml.parse(StringTools.htmlUnescape(e.getXml().toString()));
  }
  
  private function loadPagePresetXML():Void{

    for( page  in pagePresetXML.elementsNamed("page") ) {
      for( placeholder in page.elementsNamed("placeholder") ) {
          parsePlaceholder(placeholder);
      }
    }
  }

  
  private function parsePlaceholder(xml:Xml):Void{
    var posX:Float;
    var posY:Float;
    for( pos_x in xml.elementsNamed("pos-x") ) 
      posX =  Std.parseFloat(pos_x.firstChild().nodeValue);
    
    for( pos_y in xml.elementsNamed("pos-y") ) 
      posY =  Std.parseFloat(pos_y.firstChild().nodeValue);
      
    for( anchor_point in xml.elementsNamed("anchor-point") ) 
      GLOBAL.Font.anchorPoint =  Std.parseFloat(anchor_point.firstChild().nodeValue);

    for( font_file_name in xml.elementsNamed("font-file-name") ) 
      GLOBAL.Font.fileName =  font_file_name.firstChild().nodeValue.toString();

    for( font_color in xml.elementsNamed("font-color") ) 
      GLOBAL.Font.fontColor =  Std.parseInt(font_color.firstChild().nodeValue);

    for( line_space in xml.elementsNamed("line-space") ) 
      GLOBAL.Font.leading =  Std.parseInt(line_space.firstChild().nodeValue);

    for( font_size in xml.elementsNamed("font-size") ) 
      GLOBAL.Font.fontSize =  Std.parseInt(font_size.firstChild().nodeValue);

    for( font_align in xml.elementsNamed("font-align") ) 
      GLOBAL.Font.fontAlign =  font_align.firstChild().nodeValue.toString();
    
    for( text in xml.elementsNamed("text") ) 
      TEXT_SUGGESTION.text =  text.firstChild().nodeValue.toString();

    addTextPlaceholder(posX,posY);
    
  }
  
  private function onDeselectPlaceholders(e:IKEvent):Void {
    //trace('boom');
    setPlaceholderInFocus(null);
  }
  
  private function onAddTextSuggestion(e:IKEvent):Void {
    addTextPlaceholder(10,10);

  }
  
  //private function onMoveTool(e:IKEvent):Void {
  //  if(inFocus != null)
  //    inFocus.handleKeyboard();
  //}
  
  private function onDestroyPlaceholder(e:IKEvent){
    removeChild(inFocus);
    var index:UInt = 0;
    for(i in 0...placeholders.length){
      if(placeholders[i] == inFocus) index = i;
    }
    placeholders.splice(index,1);
    
    inFocus = null;
  }
  
  private function onRemovePlaceholders(){
    for(i in 0...placeholders.length){
      removeChild(placeholders[i]);
    }
    inFocus         = null;
    placeholders    = null;
    placeholders    = new Vector<APlaceholder>();
  }
  
  private function onAddPlaceholder(e:KEvent):Void {
    //TEXT_SUGGESTION.text = 'Type here';
  	addTextPlaceholder(100,100);
  }
  
  private function addTextPlaceholder(posX:Float, posY:Float):Void{
    
    setPlaceholderInFocus(null);
    var placeholder:APlaceholder		= new TextPlaceholderView(this, placeholders.length, model, TEXT_SUGGESTION.text);
    placeholder.x = posX;
  	placeholder.y = posY;
    placeholders.push(placeholder);
    addChild(placeholder);
    
  }

  
  private function onReleasePageFocus(e:KEvent):Void {
    setPlaceholderInFocus(null);
  }
  
  public function setPlaceholderInFocus(placeholder:APlaceholder):Void{

    if(inFocus != null){
      // clean up
      inFocus.setFocus(false);
      model.removeEventListener(EVENT_ID.UPDATE_PLACEHOLDER, inFocus.onUpdatePlaceholder);
    } 
    if(placeholder != null) {
      // set focus
      inFocus = placeholder;
      inFocus.setFocus(true);
      model.addEventListener(EVENT_ID.UPDATE_PLACEHOLDER, inFocus.onUpdatePlaceholder);
    }
  }
  
  public function enableMove(e:MouseEvent):Void{
    
//    trace('enable move');
    stage.addEventListener(MouseEvent.MOUSE_MOVE, movePlaceholder);
    startPoint.x = inFocus.x;
    startPoint.y = inFocus.y;
    hitPoint.x = e.stageX * GLOBAL.Zoom.toMouse();
    hitPoint.y = e.stageY * GLOBAL.Zoom.toMouse();
    
    
  }
  

    
  public function disableMove():Void{
    
    if(inFocus.getPlaceholderType() == 'textPlaceholder'){

      var textField:TextField = inFocus.getTextField();
      
      if(model.getString('mask_url') != '/assets/fallback/hide_mask.png'){
        trace('test for hit');
       if(GLOBAL.hitTest.textFieldHitBitmap(textField, guideMask)) {
         trace("Hit!");
       }
      }
      //if(hidemask != null){
      //  if(GLOBAL.hitTest.textFieldHitBitmap(text_field, hidemask)){
      //    inFocus.alert();
      //  }
      //}
    }
    stage.removeEventListener(MouseEvent.MOUSE_MOVE, movePlaceholder);
  }

  private function onMouseUp(e:MouseEvent){	
    MouseTrap.release();
    stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
//  	addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
  }
  
  private function movePlaceholder(e:MouseEvent){
    
      var moveX:Float = e.stageX * GLOBAL.Zoom.toMouse();
      var moveY:Float = e.stageY * GLOBAL.Zoom.toMouse();
      var pos:Float = ( moveX - hitPoint.x) + startPoint.x;
      inFocus.x = pos;
      pos = ( moveY - hitPoint.y) + startPoint.y;
      inFocus.y = pos;
  }

  private function onLoadFrontShot(e:IKEvent):Void{
//    trace( 'onLoadFrontShot', e.getParam().getString());
    imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadFrontShotComplete);
    imageLoader.load(new URLRequest(e.getParam().getString()));
  }
  
  //!!! is this in use
  override public function getModel():IModel{
  	return model;
  }
  
  private function onLoadFrontShotComplete(e:Event):Void{
    imageLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoadFrontShotComplete);
    backdrop = e.target.loader.content;
    addChild(backdrop);
    var filter = new DropShadowFilter(2,45,5,0.2, 10.0, 10.0,1.0);
    backdrop.filters = [filter];
    
    var mask_url:String = model.getString('mask_url');
    //mask_url == '/assets/fallback/hide_mask.png';? allImagesLoaded(): loadGuideMask();
    
    if(mask_url == '')
      pageDesignImageLoaded();
    else
      loadGuideMask(mask_url);
	}
	
  private function loadGuideMask(mask_url:String):Void{
    if(mask_url == '/assets/fallback/hide_mask.png'){
      var hide_mask_url:String = model.getString('hide_mask_url');
      loadHideMask(hide_mask_url);
    }else{
      var request:URLRequest  = new URLRequest(mask_url);
      maskLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadGuideMaskComplete);
      maskLoader.load(request);
    } 
  }
  
  private function onLoadGuideMaskComplete(e:Event):Void{
    
    maskLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoadGuideMaskComplete);
    guideMask = e.target.loader.content;
    addChild(guideMask);
    guideMask.visible = false;
    Pages.addEventListener(EVENT_ID.SHOW_MASK, onShowMask);

    var hide_mask_url:String = model.getString('hide_mask_url');
    loadHideMask(hide_mask_url);
    
  }
  
  private function loadHideMask(hide_mask_url:String):Void{

    if(hide_mask_url == '/assets/fallback/hide_mask.png'){
      allImagesLoaded();
    }else{
      hideMaskPresent = true;
      var request:URLRequest  = new URLRequest(model.getString('hide_mask_url'));
      maskLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadHideMaskComplete);
      maskLoader.load(request);
    }
  }
  
  private function onLoadHideMaskComplete(e:Event):Void{
    maskLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoadHideMaskComplete);
    hideMask                    = e.target.loader.content;
    addChild(hideMask);
    hideMask.visible            = false;
    backdrop.mask               = hideMask;
    backdrop.cacheAsBitmap      = true;
    hideMask.cacheAsBitmap      = true;
    allImagesLoaded();
  }
  
  private function allImagesLoaded():Void{

    if( model.getInt('pageId') == 0){
      GLOBAL.size_x = backdrop.width;
      GLOBAL.size_y = backdrop.height;
      Application.setString(EVENT_ID.ALL_IMAGES_LOADED, 'foo');
    }
    loadPagePresetXML();
  }
  
  private function pageDesignImageLoaded():Void{
    Application.setString(EVENT_ID.ALL_IMAGES_LOADED, 'foo');
  }
  
  public function useHideMask(b:Bool):Void{
    if(hideMask != null ){
      backdrop.mask = b ? hideMask:null;
      backdrop.cacheAsBitmap = true;
      hideMask.cacheAsBitmap = true;
    }
  }
  
  private function onShowMask(e:IKEvent):Void{
  	guideMask.visible = e.getBool();
  }
  
  public function onGetString(e:KEvent): Void {
    for(i in 0...placeholders.length){
      placeholders[i].getText();
    }
  }
  
  public function hasHideMask():Bool{
    return hideMaskPresent;
  }
  
//  public function onGetPageSize():Void{
//    Zoom.setTopPageSize(backdrop.width, backdrop.height);
//    Application.dispatchParameter(new Parameter(EVENT_ID.SET_DESKTOP_POS));
//  }
}

