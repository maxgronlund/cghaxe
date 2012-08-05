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



class PageView extends View{
  
  private var imageLoader:Loader;
  private var maskLoader:Loader;
  private var model:IModel;
  private var guideMask:Bitmap;
  private var hideMask:Bitmap;
  private var loaded_bitmap:Bitmap;
  private var bitmap_data:BitmapData;
  //private var placeholder:Placeholder;
  private var inFocus:Placeholder;
  
  private var placeholders:Vector<Placeholder>; 
  private var hitPoint:Point;
  private var startPoint:Point;
  private var placeholderHasMouse:Bool;
  private var pagePresetXML:Xml;
  private var hideMaskPresent:Bool;
  
  private var frontShotSizeX:Float;
  private var frontShotSizeY:Float;

  
  public function new(controller:IController){	

    super(controller);
    
    imageLoader	            = new Loader();
    maskLoader	            = new Loader();
    placeholders            = new Vector<Placeholder>();
    hitPoint                = new Point(0,0);
    startPoint              = new Point(0,0);
    placeholderHasMouse     = false;
    hideMaskPresent         = false;

  }
  
  override public function onAddedToStage(e:Event): Void{
    //trace('------- page is added to stage ----------');
    super.onAddedToStage(e);
//    addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
//    Pages.addEventListener(EVENT_ID.MOVE_TOOL, onMoveTool);
    Application.addEventListener(EVENT_ID.DESELECT_PLACEHOLDERS, onDeselectPlaceholders);
    Designs.addEventListener(EVENT_ID.ADD_TEXT_SUGGESTION, onAddTextSuggestion);
    
 //   Application.addEventListener(EVENT_ID.RESET_MOUSE, onResetMouse);
    
  }
  
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
  
	//private function onPagedesignFile(e:IKEvent):Void{
  // // trace('onPagedesignFile');
	//  var xml:Xml = Xml.parse(StringTools.htmlUnescape(e.getXml().toString()));
	//  
  //  for( xmlfile in xml.elementsNamed("xml-file") ) {
  //    for( xml_page in xmlfile.elementsNamed("page") ) {
  //      for( placeholder in xml_page.elementsNamed("placeholder") ) {
  //        parsePlaceholder(placeholder);
  //      }
  //    }
  //  }
  //}
  
  private function parsePlaceholder(xml:Xml):Void{
    var posX:Float;
    var posY:Float;
    for( pos_x in xml.elementsNamed("pos-x") ) 
      posX =  Std.parseFloat(pos_x.firstChild().nodeValue);
      
    for( pos_y in xml.elementsNamed("pos-y") ) 
      posY =  Std.parseFloat(pos_y.firstChild().nodeValue);

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

    addPlaceholder(posX,posY);
    
  }
  
  private function onDeselectPlaceholders(e:IKEvent):Void {
    //trace('boom');
    setPlaceholderInFocus(null);
  }
  
  private function onAddTextSuggestion(e:IKEvent):Void {
    trace('onAddTextSuggestion');
    
    addPlaceholder(10,10);
    //trace(TEXT_SUGGESTION.text);
    //setPlaceholderInFocus(null);
  }
  
  
  
//  private function onResetMouse(e:IKEvent):Void {
//    //trace('onReset mouse');
//    removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
//  }
  
  private function onMoveTool(e:IKEvent):Void {
    setPlaceholderInFocus(null);
  }
  
  private function onDestroyPlaceholder(e:IKEvent){
    //trace('onDestroyPlaceholder');
    var index:UInt = 0;
    for(i in 0...placeholders.length){
      if(placeholders[i] == inFocus) index = i;
    }
    placeholders.splice(index,1);
    removeChild(inFocus);
    inFocus = null;
  }
  
  private function onRemovePlaceholders(){
    for(i in 0...placeholders.length){
      removeChild(placeholders[i]);
    }
    inFocus = null;
    placeholders = null;
    placeholders            = new Vector<Placeholder>();
  }
  
  private function onAddPlaceholder(e:KEvent):Void {
    //TEXT_SUGGESTION.text = 'Type here';
  	addPlaceholder(100,100);
  }
  
  private function addPlaceholder(posX:Float, posY:Float):Void{
//    trace('add placeholder');
    setPlaceholderInFocus(null);
    var placeholder:Placeholder		= new Placeholder(this, placeholders.length, model, TEXT_SUGGESTION.text);
    placeholder.x = posX;
  	placeholder.y = posY;
    placeholders.push(placeholder);
  	addChild(placeholder);

  }
  
  //private function onFontLoaded(e:KEvent):Void {
  //  //if(inFocus != null){
  //  //  inFocus.setFocus(true);
  //  //}
  //}
  
  private function onReleasePageFocus(e:KEvent):Void {
    setPlaceholderInFocus(null);
  }
  
  public function setPlaceholderInFocus(placeholder:Placeholder):Void{
    
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
    trace('enableMove');
    stage.addEventListener(MouseEvent.MOUSE_MOVE, movePlaceholder);
    startPoint.x = inFocus.x;
    startPoint.y = inFocus.y;
    
    hitPoint.x = e.stageX * GLOBAL.Zoom.toMouse();
    hitPoint.y = e.stageY * GLOBAL.Zoom.toMouse();
    
    
  }
  
  public function disableMove():Void{
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
    trace( 'onLoadFrontShot', e.getParam().getString());
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
    //backdrop.width *= 4.54;
    //backdrop.height *= 4.54;
    var filter = new DropShadowFilter(2,45,5,0.2, 10.0, 10.0,1.0);
    backdrop.filters = [filter];
    
    //var mask_url:String = model.getString('mask_url');
    //
    //
    //if(mask_url == '')
    //  pageDesignImageLoaded();
    //else
    //  loadGuideMask(mask_url);
    var hide_mask_url:String = model.getString('hide_mask_url');
    //trace(hide_mask_url);
    loadHideMask(hide_mask_url);
	}
	
  private function loadGuideMask(mask_url:String):Void{
    //if(mask_url == '/assets/fallback/hide_mask.png'){
    //  var hide_mask_url:String = model.getString('hide_mask_url');
    //  loadHideMask(hide_mask_url);
    //}else{
    //  var request:URLRequest  = new URLRequest(mask_url);
    //  maskLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadGuideMaskComplete);
    //  maskLoader.load(request);
    //} 
  }
  
  private function onLoadGuideMaskComplete(e:Event):Void{
    
    //maskLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoadGuideMaskComplete);
    //guideMask = e.target.loader.content;
    //addChild(guideMask);
    //guideMask.visible = false;
    //Pages.addEventListener(EVENT_ID.SHOW_MASK, onShowMask);
    //
    //var hide_mask_url:String = model.getString('hide_mask_url');
    //loadHideMask(hide_mask_url);
    
  }
  
  private function loadHideMask(hide_mask_url:String):Void{

    if(hide_mask_url == '/assets/fallback/badge_hide_mask.png'){
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
    //hideMask.width *= 4.54;
    //hideMask.height *= 4.54;
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

