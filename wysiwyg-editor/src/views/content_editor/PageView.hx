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
import flash.text.TextFieldAutoSize;



class PageView extends View{
  
  private var imageLoader:Loader;
  private var printMaskLoader:Loader;
  private var model:IModel;
  private var guideMask:Bitmap;
  private var hideMask:Bitmap;
  private var loaded_bitmap:Bitmap;
  private var bitmap_data:BitmapData;
  //private var placeholder:Placeholder;
  private var inFocus:Dynamic;
  
  private var placeholders:Vector<APlaceholder>; 
//  private var designImagePlaceholders:Vector<APlaceholder>;
  private var hitPoint:Point;
  private var startPoint:Point;
  private var placeholderHasMouse:Bool;
  private var pagePresetXML:Xml;
  private var hideMaskPresent:Bool;
  
  private var frontShotSizeX:Float;
  private var frontShotSizeY:Float;
  
  private var hitPointX:Float;
  private var hitPointY:Float;
  
  private var posX:Float;
  private var posY:Float;

  
  public function new(controller:IController){	

    super(controller);
    
    imageLoader	                  = new Loader();
    printMaskLoader	              = new Loader();
    placeholders                  = new Vector<APlaceholder>();
//    designImagePlaceholders       = new Vector<APlaceholder>();
    hitPoint                      = new Point(0,0);
    startPoint                    = new Point(0,0);
    placeholderHasMouse           = false;
    hideMaskPresent               = false;
    
  }
  
  override public function onAddedToStage(e:Event): Void{

    super.onAddedToStage(e);
    Application.addEventListener(EVENT_ID.DESELECT_PLACEHOLDERS, onDeselectPlaceholders);
//    Application.addEventListener(EVENT_ID.DISABLE_MOUSE_ON_PAGES, onDisableMouse);
    Designs.addEventListener(EVENT_ID.ADD_TEXT_SUGGESTION, onAddTextSuggestion);
    //DesignImages.addEventListener(EVENT_ID.ADD_DESIGN_IMAGE_TO_PAGE, onAddDesignImage);
    
    addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
    addEventListener(MouseEvent.ROLL_OVER, onMouseOver);

  }
  /*
  private function onDisableMouse(e:IKEvent):Void{
    trace('onDisableMouse', e.getBool());
    //enableMouse
    enableMouse(e.getBool());
  }*/
  /*
  override public function enableMouse(b:Bool):Void{
		
		if(b){
		  addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
      addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
		}else{
		  stage.removeEventListener(MouseEvent.MOUSE_MOVE, movePlaceholder);
		  removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
      removeEventListener(MouseEvent.ROLL_OVER, onMouseOver);
      removeEventListener(MouseEvent.MOUSE_DOWN, onMouseUp);
      removeEventListener(MouseEvent.ROLL_OUT, onMouseOut);
		}

	}
	*/
	
  override public function setModel(model:IModel):Void{
    
//    trace('model set');
    this.model = model;
    
    //model.addEventListener(EVENT_ID.LOAD_FRONT_SHOT, onLoadFrontShot); 	
    model.addEventListener(EVENT_ID.ADD_PLACEHOLDER, onAddTextPlaceholder);
    model.addEventListener(EVENT_ID.GET_STRING, onGetString);           // !!! rename this nonsens
    model.addEventListener(EVENT_ID.RELEASE_FOCUS, onReleasePageFocus);
    model.addEventListener(EVENT_ID.TRASH_PLACEHOLDER, onDestroyPlaceholder);
    model.addEventListener(EVENT_ID.PAGE_XML_LOADED, onPageXmlLoaded);
    model.addEventListener(EVENT_ID.GET_PAGE_POS_XML + Std.string(model.getInt('pageId')), onGetPagePosXml  );
    //Designs.addEventListener(EVENT_ID.LOAD_FRONT_SHOT, onLoadFrontShot);
    //Designs.addEventListener(EVENT_ID.PAGE_XML_LOADED, onPageXmlLoaded); 
    loadFrontShot();
    
  }

  override public function setParam(param:IParameter):Void{
    switch ( param.getLabel() ){
      case EVENT_ID.ADD_DESIGN_TO_PAGE:{
        addDesignToPage(param);
      }

      case EVENT_ID.ADD_GREETING_TO_PAGE:{
        parseVectorPlaceholder( param.getXml(), onPosX(),onPosY());
        /*
        var url:String;
        for(url_xml in param.getXml().elementsNamed("url") ) {
          url = url_xml.firstChild().nodeValue.toString();
        }
        setPlaceholderInFocus(null);
        var placeholder:APlaceholder	= new VectorPlaceholderView(this, placeholders.length, model, url);
        placeholder.x = 10;
      	placeholder.y = 10;
        placeholders.push(placeholder);
        addChild(placeholder);
        */
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
    //trace(imageUrl);
    setPlaceholderInFocus(null);
    
    var placeholder:APlaceholder		= new DesignImagePlaceholderView(this, placeholders.length, model, imageUrl);
  
    placeholder.x = posX;
  	placeholder.y = posY;
    placeholders.push(placeholder);
    addChild(placeholder);
  
  }

  private function onPageXmlLoaded(e:IKEvent):Void{  

    pagePresetXML = Xml.parse(StringTools.htmlUnescape(e.getXml().toString()));

  }
  
  private function loadPagePresetXML():Void{

    for( page  in pagePresetXML.elementsNamed("page") ) {
      for( pos_x in page.elementsNamed("pos-x") ) {
           this.x = (Std.parseFloat(pos_x.firstChild().nodeValue));
      }
      for( pos_y in page.elementsNamed("pos-y") ) {
           this.y = (Std.parseFloat(pos_y.firstChild().nodeValue));
      }
      for( placeholder in page.elementsNamed("placeholder") ) {
          parsePlaceholder(placeholder);
      }
    }
  }
 
  private function parsePlaceholder(xml:Xml):Void{
    
    for( pos_x in xml.elementsNamed("pos-x") ) 
       posX =  Std.parseFloat(pos_x.firstChild().nodeValue);
    
    for( pos_y in xml.elementsNamed("pos-y") ) 
      posY =  Std.parseFloat(pos_y.firstChild().nodeValue);
    

    var placeholder_type:String = '';
    for( plc_type in xml.elementsNamed("placeholder-type") ){
      
      placeholder_type = plc_type.firstChild().nodeValue;
      
    }

    switch( placeholder_type){
      case "vector_placeholder":
        parseVectorPlaceholder(xml, posX, posY);
      case "text_placeholder":
        parseTextPlaceholder(xml);
      default:
        parseTextPlaceholder(xml);
    }

  }
  
  private function parseVectorPlaceholder(xml:Xml, posX:Float, posY:Float):Void{
   trace(xml.toString());
    var url:String;

    
    
    for(url_xml in xml.elementsNamed("url") ) {
      url = url_xml.firstChild().nodeValue.toString();
    }
    for(foil_color in xml.elementsNamed("foil-color") ) {
      GLOBAL.foilColor = foil_color.firstChild().nodeValue.toString();
      
    }
    for(pms_color in xml.elementsNamed("pms-color") ) {
      GLOBAL.stdPmsColor = Std.parseInt(pms_color.firstChild().nodeValue);
    }
    for(print_type in xml.elementsNamed("print-type") ) {
      GLOBAL.printType = print_type.firstChild().nodeValue.toString();
    }

    setPlaceholderInFocus(null);
    var placeholder:APlaceholder	= new VectorPlaceholderView(this, placeholders.length, model, url);
    placeholder.x = posX;
  	placeholder.y = posY;
  	trace(posX);
    placeholders.push(placeholder);
    addChild(placeholder);

  }
  
  private function parseTextPlaceholder(xml:Xml):Void{

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
//    trace('onDeselectPlaceholders');
    setPlaceholderInFocus(null);
  }
  
  private function onAddTextSuggestion(e:IKEvent):Void {
    addTextPlaceholder(10,10);
  }
  
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
  
  private function onAddTextPlaceholder(e:KEvent):Void {
    //trace( GLOBAL.desktop_view.getPosX());
    
  	addTextPlaceholder(onPosX() ,onPosY());
  }
  
  private function onPosX():Float{
    return (-GLOBAL.desktop_view.getPosX() * 2.08) - this.x;
  }
  
  private function onPosY():Float{
    return ((-GLOBAL.desktop_view.getPosY() * 2.08) - this.y)+200;
  }
  
  private function addTextPlaceholder(posX:Float, posY:Float):Void{

    //setPlaceholderInFocus(null);
    var placeholder:APlaceholder		= new TextPlaceholderView(this, placeholders.length, model, TEXT_SUGGESTION.text);
    placeholder.x = posX;
  	placeholder.y = posY;
    placeholders.push(placeholder);
    addChild(placeholder);
    //setPlaceholderInFocus(placeholder);
    
  }
  /*
  private function addVectorPlaceholder(posX:Float, posY:Float, url:String):Void{
    
    setPlaceholderInFocus(null);
    //var placeholder:APlaceholder		= new TextPlaceholderView(this, placeholders.length, model, TEXT_SUGGESTION.text);
    var placeholder:APlaceholder	= new VectorPlaceholderView(this, placeholders.length, model, url);
    placeholder.x = posX;
  	placeholder.y = posY;
    placeholders.push(placeholder);
    addChild(placeholder);
    
  }
*/
  private function onReleasePageFocus(e:KEvent):Void {
    setPlaceholderInFocus(null);
    MouseTrap.release();
  }
  
  public function setPlaceholderInFocus(placeholder:APlaceholder):Void{
    if(inFocus != null){
      // clean up
      inFocus.setFocus(false);
      model.removeEventListener(EVENT_ID.UPDATE_PLACEHOLDER, inFocus.onUpdatePlaceholder);
      inFocus = null;
    } 
    if(placeholder != null) {
      // set focus
      inFocus = placeholder;
      inFocus.setFocus(true);
      model.addEventListener(EVENT_ID.UPDATE_PLACEHOLDER, inFocus.onUpdatePlaceholder);
    }
  }
  
  public function enableMove(e:MouseEvent):Void{
    //trace('enableMove');
    
    stage.addEventListener(MouseEvent.MOUSE_MOVE, movePlaceholder);
    startPoint.x = inFocus.x;
    startPoint.y = inFocus.y;
    hitPoint.x = e.stageX * GLOBAL.Zoom.toMouse();
    hitPoint.y = e.stageY * GLOBAL.Zoom.toMouse();

  }
   
  public function disableMove():Void{
//    trace('disableMove');
    stage.removeEventListener(MouseEvent.MOUSE_MOVE, movePlaceholder);
    hitTest();
  }
  
  public function hitTest():Void {

    switch(inFocus.getPlaceholderType()) {
      case 'text_place_holder':
        hitTestTextPlaceholder();
        
      case "vector_placeholder":
        hitTestVectorPlaceholder();
    }
  }
  
  private function hitTestTextPlaceholder():Void {
    
    var textField:TextField = inFocus.getTextField();
    
    //if(model.getString('mask_url') != '/assets/fallback/hide_mask.png'){
    //  if(GLOBAL.hitTest.textFieldHitBitmap(textField, -Std.int(inFocus.x*(72/150)), -Std.int(inFocus.y*(72/150)), guideMask, 0, 0))
    //    inFocus.alert(true);
    //  else
    //    inFocus.alert(false);
    //
    //}
  }
  
  private function hitTestVectorPlaceholder():Void {
    if(GLOBAL.hitTest.bitmapHitBitmapMask(inFocus.getBitmapMask(), -Std.int(inFocus.x*(72/150)), -Std.int(inFocus.y*(72/150)), guideMask, 0, 0))
      inFocus.alert(true);
    else
      inFocus.alert(false);
  }

  private function onMouseOver(e:MouseEvent):Void{
    removeEventListener(MouseEvent.ROLL_OVER, onMouseOver);
    addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
    addEventListener(MouseEvent.ROLL_OUT, onMouseOut);	
  }
  
  private function onMouseOut(e:MouseEvent){

    removeEventListener(MouseEvent.ROLL_OUT, onMouseOut);
    addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
    removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
  }
  
  private function onMouseDown(e:MouseEvent){	
    
    if(MouseTrap.capture()){
      trace('page captured the mouse');
      setPlaceholderInFocus(null);
      removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
      stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
      stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
      
      hitPointX = ((e.stageX* GLOBAL.Zoom.toMouse()) - this.x);
      hitPointY = ((e.stageY* GLOBAL.Zoom.toMouse()) - this.y);
    }
  }
  
  private function onMouseUp(e:MouseEvent){	
    trace('PageView is releasing the mouse');
    MouseTrap.release();
    stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
    stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
    addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
    Application.dispatchParameter(new Parameter(EVENT_ID.RESET_STAGE_SIZE));

  	//MouseTrap.release();
  	//stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
  	//stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
  	//addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
  }
  
  private function onMouseMove(e:MouseEvent){
    
    var moveX:Float = e.stageX * GLOBAL.Zoom.toMouse();
    var moveY:Float = e.stageY * GLOBAL.Zoom.toMouse();
    
    var endPosX:Float = moveX - hitPointX;
    var endPosY:Float = moveY - hitPointY;
    
    //var endPosX:Float = ( e.stageX - hitPointX);
    //var endPosY:Float = ( e.stageY - hitPointY);
    this.x = endPosX;
    this.y = endPosY;

  }
  
  private function movePlaceholder(e:MouseEvent){
//    trace('movePlaceholder');
    var moveX:Float = e.stageX * GLOBAL.Zoom.toMouse();
    var moveY:Float = e.stageY * GLOBAL.Zoom.toMouse();
    var pos:Float = ( moveX - hitPoint.x) + startPoint.x;
    inFocus.x = pos;
    pos = ( moveY - hitPoint.y) + startPoint.y;
    inFocus.y = pos;
  }

  private function loadFrontShot():Void{
    imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadFrontShotComplete);
    imageLoader.load(new URLRequest(model.getString('front_shoot_url')));
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
    
    var print_mask_url:String = model.getString('print_mask_url');
    print_mask_url == '/assets/fallback/hide_mask.png' ? allImagesLoaded(): loadPrintMask();
    
    //if(print_mask_url == '')
    //  pageDesignImageLoaded();
    //else
    //  loadPrintMask();
	}
	
  private function loadPrintMask():Void{
    var print_mask_url:String = model.getString('print_mask_url');
    if(print_mask_url == ''){
      loadHideMask();
    }else{
      var request:URLRequest  = new URLRequest(print_mask_url);
      printMaskLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onloadPrintMaskComplete);
      printMaskLoader.load(request);
    } 
  }
  
  private function onloadPrintMaskComplete(e:Event):Void{
    
    printMaskLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onloadPrintMaskComplete);
    guideMask = e.target.loader.content;
    addChild(guideMask);
    guideMask.visible = false;
    guideMask.alpha = 0.5;
    Pages.addEventListener(EVENT_ID.SHOW_MASK, onShowMask);

    loadHideMask();
    
  }
  
  private function loadHideMask():Void{
    
    var hide_mask_url:String = model.getString('hide_mask_url');

    if(hide_mask_url == ''){
      allImagesLoaded();
    }else{
      hideMaskPresent = true;
      var request:URLRequest  = new URLRequest(hide_mask_url);
      printMaskLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadHideMaskComplete);
      printMaskLoader.load(request);
    }
  }
  
  private function onLoadHideMaskComplete(e:Event):Void{
    printMaskLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoadHideMaskComplete);
    hideMask                    = e.target.loader.content;
    addChild(hideMask);
    hideMask.visible            = false;
    backdrop.mask               = hideMask;
    backdrop.cacheAsBitmap      = true;
    hideMask.cacheAsBitmap      = true;
    allImagesLoaded();
  }
  
  private function allImagesLoaded():Void{
    Application.dispatchParameter(new Parameter(EVENT_ID.RESET_STAGE_SIZE));
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
    //trace('onShowMask');
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

  private function onGetPagePosXml( e:KEvent ): Void{
    var str:String = '\t\t<pos-x>' + Std.string(this.x) + '</pos-x>\n';
    str += '\t\t<pos-y>' + Std.string(this.y) + '</pos-y>\n';
    model.setString(EVENT_ID.SET_PAGE_XML,str);
  }
}

