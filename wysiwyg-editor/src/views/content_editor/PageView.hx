/* Shows an image of a page
* can be transparent
* holds placeholders
* the page handles placeholder focus
*/

import flash.events.Event;
import flash.events.IOErrorEvent;
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
  private var inFocus:Dynamic;
  private var placeholders:Vector<APlaceholder>; 
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
  private var designXml:Xml;
  private var deletable:Bool;
  private var placeHolderCount:UInt;

  
  public function new(controller:IController){	

    super(controller);
    imageLoader	                  = new Loader();
    printMaskLoader	              = new Loader();
    placeholders                  = new Vector<APlaceholder>();
    hitPoint                      = new Point(0,0);
    startPoint                    = new Point(0,0);
    placeholderHasMouse           = false;
    hideMaskPresent               = false;
    deletable                     = false;
    placeHolderCount              = 0;
    
    Pages.addEventListener(EVENT_ID.CALCULATE_PRICE, calculatePrice);
  }
  
  private function calculatePrice(e:Event): Void {    

    var std_pms_colors                = new Array();
    var custom_pms1_colors            = new Array();
    var custom_pms2_colors            = new Array();
    var text_foil_colors              = new Array();
    var greeting_foil_colors          = new Array();
                                      
    var amount_std_pms_color:UInt     = 0;
    var amount_custom_pms1_color:UInt = 0;
    var amount_custom_pms2_color:UInt = 0;
    var amount_custom_pms4_color:UInt = 0;
    var amount_foil_color:UInt        = 0;
    var amount_greetings:UInt         = 0;
    var amount_digital_print:UInt       = 0;
    var amount_cliche:UInt             = 0;
    
    var empty_string:EReg = ~/^[\s]*$/;
    
    for(i in 0...placeholders.length) {      
      if(true){
        if(StringTools.trim(placeholders[i].getTextFieldText()) != ''){
          switch ( placeholders[i].getPrintType() )
          {
            case CONST.STD_PMS_COLOR:{
              // Count diffrent colors
              var color:String = placeholders[i].getStdPmsColor();
              var text_color_is_used:Bool = false;
          
              for(i in 0...std_pms_colors.length) {
                if(std_pms_colors[i] == color) {
                  text_color_is_used = true;
                }
              }
          
              if(!text_color_is_used) {
                if(color != "9672088"){
                  std_pms_colors.push(color);
                  amount_std_pms_color += 1;
                }
              }
              
            }
            case CONST.CUSTOM_PMS1_COLOR:{
              var color:String = placeholders[i].getPms1Color();
              var text_color_is_used:Bool = false;
          
              for(i in 0...custom_pms1_colors.length) {
                if(custom_pms1_colors[i] == color) {
                  text_color_is_used = true;
                }
              }
          
              if(!text_color_is_used) {
                custom_pms1_colors.push(color);
                amount_custom_pms1_color += 1;
              }
              
            }
            case CONST.CUSTOM_PMS2_COLOR:{
              var color:String = placeholders[i].getPms2Color();
              var text_color_is_used:Bool = false;
          
              for(i in 0...custom_pms2_colors.length) {
                if(custom_pms2_colors[i] == color) {
                  text_color_is_used = true;
                }
              }
          
              if(!text_color_is_used) {
                custom_pms2_colors.push(color);
                amount_custom_pms2_color += 1;
              }
              
            }
            
            case CONST.FOIL_COLOR:{
              //Check if there's already a foil color
              var color:String = placeholders[i].getFoilColor();              
              
              if( placeholders[i].getPlaceholderType() == 'text_place_holder' ) {
                var text_color_is_used:Bool = false;
                for(i in 0...text_foil_colors.length) {
                  if(text_foil_colors[i] == color) {
                    text_color_is_used = true;
                  }
                }
                if(!text_color_is_used) {
                  text_foil_colors.push(color);
                  amount_foil_color += 1;
                  if(placeholders[i].isGaramond() != 'true'){
                    amount_cliche = 1;
                  }
                }
              } else if( placeholders[i].getPlaceholderType() == 'vector_placeholder' ) {
                var text_color_is_used:Bool = false;
                for(i in 0...text_foil_colors.length) {
                  if(text_foil_colors[i] == color) {
                    text_color_is_used = true;
                  }
                }
                if(!text_color_is_used) {
                  text_foil_colors.push(color);
                  amount_foil_color += 1;
                }
              } else if( placeholders[i].getPlaceholderType() == 'bitmap_place_holder' ) {
                var text_color_is_used:Bool = false;
                amount_cliche = 1;
                for(i in 0...text_foil_colors.length) {
                  if(text_foil_colors[i] == color) {
                    text_color_is_used = true;
                  }
                }
                if(!text_color_is_used) {
                  text_foil_colors.push(color);
                  amount_foil_color += 1;
                }
              }
          
              
            }
            case CONST.DIGITAL_PRINT:{
              //amount_digital_print = 1;
              amount_custom_pms4_color = 1;
            }
            default:{
              amount_digital_print = 1;
            }
          }
        }
      }
    }
    
    
    if(amount_custom_pms4_color > 0){
      model.setInt('amount_std_pms_color', 0);
      model.setInt('amount_custom_pms1_color', 0);
      model.setInt('amount_custom_pms2_color', 0);
      model.setInt('amount_custom_pms4_color', amount_custom_pms4_color);
      
    } else {
      model.setInt('amount_custom_pms1_color', amount_custom_pms1_color);
      model.setInt('amount_custom_pms2_color', amount_custom_pms2_color);
      model.setInt('amount_custom_pms4_color', 0);
      model.setInt('amount_std_pms_color', amount_std_pms_color);
    }
    
    model.setInt('amount_foil_color', amount_foil_color);
    model.setInt('amount_greetings', amount_greetings);
    model.setInt('amount_digital_print', amount_digital_print);
    model.setInt('amount_cliche', amount_cliche);

    GLOBAL.price_view.addColumn(model);
    GLOBAL.price_view.update('addAllPrices', 0, '');

  }
  
  override public function onAddedToStage(e:Event): Void{
    Application.setString(EVENT_ID.UPDATE_LOAD_PROGRESS,'Page Added to Desktop');
    super.onAddedToStage(e);
    Application.addEventListener(EVENT_ID.DESELECT_PLACEHOLDERS, onDeselectPlaceholders);
    Designs.addEventListener(EVENT_ID.ADD_TEXT_SUGGESTION, onAddTextSuggestion);
    addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
    addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
    Preset.addEventListener(EVENT_ID.PLACEHOLDER_COUNT, onPlaceholderCount);

  }

  override public function setModel(model:IModel):Void{
    this.model = model;
    model.addEventListener(EVENT_ID.ADD_PLACEHOLDER, onAddTextPlaceholder);
    model.addEventListener(EVENT_ID.GET_STRING, onGetString);           // !!! rename this nonsens
    model.addEventListener(EVENT_ID.RELEASE_FOCUS, onReleasePageFocus);
    model.addEventListener(EVENT_ID.TRASH_PLACEHOLDER, onDestroyPlaceholder);
    model.addEventListener(EVENT_ID.PAGE_XML_LOADED, onPageXmlLoaded);
    model.addEventListener(EVENT_ID.GET_PAGE_POS_XML + Std.string(model.getInt('pageId')), onGetPagePosXml  );
    model.addEventListener(EVENT_ID.UPDATE_PMS1, onPms1Update);
    model.addEventListener(EVENT_ID.UPDATE_PMS2, onPms2Update);
    loadFrontShot();
    
  }
  
  private function onPms1Update(e:IKEvent):Void{
    
    for(i in 0...placeholders.length) {
      if(placeholders[i].getPrintType() == CONST.CUSTOM_PMS1_COLOR){
        placeholders[i].updateColor( GLOBAL.pms1Color);
      }
    }

  }
  
  private function onPms2Update(e:IKEvent):Void{
    
    for(i in 0...placeholders.length) {
      
      if(placeholders[i].getPrintType() == CONST.CUSTOM_PMS2_COLOR){
        placeholders[i].updateColor( GLOBAL.pms2Color);
      }
    }

  }

  override public function setParam(param:IParameter):Void{
    switch ( param.getLabel() ){
      case EVENT_ID.ADD_DESIGN_TO_PAGE:{addDesignToPage(param);}
      case EVENT_ID.ADD_GREETING_TO_PAGE:{parseVectorPlaceholder( param.getXml(), onPosX(), onPosY(), false);}
      case EVENT_ID.ADD_SYMBOL_TO_PAGE:{parseVectorPlaceholder( param.getXml(), onPosX(), onPosY(), true);}
      case EVENT_ID.ADD_LOGO_TO_PAGE:{addBitmapPlaceholder( param.getXml(),   onPosX(), onPosY(), -1, -1);}
      case EVENT_ID.ADD_PHOTO_TO_PAGE:{addBitmapPlaceholder( param.getXml(),  onPosX(), onPosY(), -1, -1);}
    }
  }
  
  private function addDesignToPage(param:IParameter):Void{

    onRemovePlaceholders();
    var xml:Xml = Xml.parse(StringTools.htmlUnescape(param.getXml().toString()));
    for( design  in xml.elementsNamed("design") ) {
      for( xml_file  in design.elementsNamed("xml-file") ) {
        pagePresetXML = xml_file;
        parsePagePresetXml();
      }
    }
  }

  private function onPageXmlLoaded(e:IKEvent):Void{  
    Application.setString(EVENT_ID.UPDATE_LOAD_PROGRESS,'Page XML loaded');
    pagePresetXML = Xml.parse(StringTools.htmlUnescape(e.getXml().toString()));
  }
  
  private function parsePagePresetXml():Void{
    
    if(pagePresetXML != null){
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
    Application.setString(EVENT_ID.UPDATE_LOAD_PROGRESS,'Page XML Parsed');
    if( placeHolderCount == 0 && model.getInt('pageId') == 0){
      Application.setString(EVENT_ID.CLOSE_LOAD_PROGRESS,'foo');
    }
  }
  
  private function onPlaceholderCount(e:KEvent):Void{
    placeHolderCount = e.getInt();
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
      case "bitmap_place_holder":
        parseBitmapPlaceholder(xml, posX, posY);
      
      default:
        return;
    }

  }
  
  override public function setString(id:String,s:String ): Void
  {
    switch ( id ){
      case EVENT_ID.DELETE_KEY_PRESSED:{
        
        if(deletable){
          onDestroyPlaceholder();
          GLOBAL.Pages.calculatePrice();
        }
      }
        
      case EVENT_ID.ENABLE_DELETE_KEY:{
        deletable = true;
      }
      case EVENT_ID.DISABLE_DELETE_KEY:{
        deletable = false;
      }
    }
  }
  
  private function parseVectorPlaceholder(xml:Xml, posX:Float, posY:Float, resizable:Bool = false):Void{
    
    var sizeX = -1;
    var sizeY = -1;
    var canResize = resizable;
    
    for(foil_color in xml.elementsNamed("foil-color") ) 
      GLOBAL.foilColor = foil_color.firstChild().nodeValue.toString();
    
    for(pms_color in xml.elementsNamed("std-pms-color") ) 
      GLOBAL.stdPmsColor = Std.parseInt(pms_color.firstChild().nodeValue);
      
    for( pms1_color in xml.elementsNamed("pms1-color") ) 
      GLOBAL.pms1Color =  Std.parseInt(pms1_color.firstChild().nodeValue);
    
    for( pms2_color in xml.elementsNamed("pms2-color") ) 
        GLOBAL.pms2Color =  Std.parseInt(pms2_color.firstChild().nodeValue);
    
    for(print_type in xml.elementsNamed("print-type") ) 
      GLOBAL.printType = print_type.firstChild().nodeValue.toString();
      
    for( size_x in xml.elementsNamed("size-x") )
        sizeX = Std.parseInt(size_x.firstChild().nodeValue);
    
    for( size_y in xml.elementsNamed("size-y") ) 
        sizeY = Std.parseInt(size_y.firstChild().nodeValue);
        
    for( can_resize in xml.elementsNamed("resizable") ) 
        canResize = can_resize.firstChild().nodeValue == 'true';
        
    for(url_xml in xml.elementsNamed("url") ){
      var placeholder:APlaceholder = addVectorPlaceholder(url_xml, posX, posY, canResize);
      placeholder.setSize(sizeX, sizeY);
    }
  }
  
  private function addVectorPlaceholder(xml:Xml, posX:Float, posY:Float, resizable:Bool):APlaceholder{

    var url:String = xml.firstChild().nodeValue.toString();
    setPlaceholderInFocus(null);
    
    var placeholder:APlaceholder	= new VectorPlaceholderView(this, placeholders.length, model, url, resizable);
    placeholder.x = posX;
  	placeholder.y = posY;
    placeholders.push(placeholder);
    addChild(placeholder);
    return placeholder;
  }
  
  
  private function parseBitmapPlaceholder(xml:Xml, posX:Float, posY:Float):Void{
    
    var sizeX, sizeY;
    //var url;
    
    for( size_x in xml.elementsNamed("size-x") )
      sizeX = Std.parseInt(size_x.firstChild().nodeValue);
    
    for( size_y in xml.elementsNamed("size-y") ) 
      sizeY = Std.parseInt(size_y.firstChild().nodeValue);
        
    for(foil_color in xml.elementsNamed("foil-color") ) 
      GLOBAL.foilColor = foil_color.firstChild().nodeValue.toString();
    //
    for(pms_color in xml.elementsNamed("std-pms-color") ) 
      GLOBAL.stdPmsColor = Std.parseInt(pms_color.firstChild().nodeValue);
    
    for(print_type in xml.elementsNamed("print-type") ) 
      GLOBAL.printType = print_type.firstChild().nodeValue.toString();
    
    for( url in xml.elementsNamed("url") ) {
      var placeholder:APlaceholder = addBitmapPlaceholder(url, posX, posY, sizeX, sizeY);
      //placeholder.setSize(sizeX, sizeY);
    }
    
    
  }
  
  private function addBitmapPlaceholder(xml:Xml, posX:Float, posY:Float, sizeX:Float, sizeY:Float):APlaceholder{
    
    var url:String = xml.firstChild().nodeValue.toString();
    setPlaceholderInFocus(null);
    var placeholder:APlaceholder	= new BitmapPlaceholder(this, placeholders.length, model, url);
    placeholder.x = posX;
  	placeholder.y = posY;
    placeholders.push(placeholder);
    placeholder.setSize(sizeX, sizeY);
    addChild(placeholder);
    return placeholder;
  }
  
  private function parseTextPlaceholder(xml:Xml):Void{
    

    for( anchor_point in xml.elementsNamed("anchor-point") ) 
      GLOBAL.Font.anchorPoint =  Std.parseFloat(anchor_point.firstChild().nodeValue);
    
    for( font_file_name in xml.elementsNamed("font-file-name") ) 
      GLOBAL.Font.fileName =  font_file_name.firstChild().nodeValue.toString();

    for( print_type in xml.elementsNamed("print-type") ) 
      GLOBAL.printType =  print_type.firstChild().nodeValue;
      
    for( std_pms_color in xml.elementsNamed("std-pms-color") ) 
      GLOBAL.stdPmsColor =  Std.parseInt(std_pms_color.firstChild().nodeValue);
      
    for( pms1_color in xml.elementsNamed("pms1-color") ) 
      GLOBAL.pms1Color =  Std.parseInt(pms1_color.firstChild().nodeValue);
      
    for( pms2_color in xml.elementsNamed("pms2-color") ) 
      GLOBAL.pms2Color =  Std.parseInt(pms2_color.firstChild().nodeValue);
      
    for( foil_color in xml.elementsNamed("foil-color") ) 
      GLOBAL.foilColor =  foil_color.firstChild().nodeValue;
      
    for( lazer_color in xml.elementsNamed("laser-color") ) 
      GLOBAL.laserColor =  Std.parseInt(lazer_color.firstChild().nodeValue);
             
    for( line_space in xml.elementsNamed("line-space") ) 
      GLOBAL.Font.leading =  Std.parseInt(line_space.firstChild().nodeValue);
    
    for( font_size in xml.elementsNamed("font-size") ) 
      GLOBAL.Font.fontSize =  Std.parseInt(font_size.firstChild().nodeValue);
    
    for( font_align in xml.elementsNamed("font-align") ) 
      GLOBAL.Font.fontAlign =  font_align.firstChild().nodeValue.toString();
    
    for( text in xml.elementsNamed("text") ) 
      TEXT_SUGGESTION.text =  text.firstChild().nodeValue.toString();
    
    for( gara in xml.elementsNamed("garamond") ){
      GLOBAL.garamond = gara.firstChild().nodeValue == 'true';
    }
    
    
    addTextPlaceholder(posX,posY);
  }
  
  private function onDeselectPlaceholders(e:IKEvent):Void {
    setPlaceholderInFocus(null);
  }
  
  private function onAddTextSuggestion(e:IKEvent):Void {
    addTextPlaceholder(10,10);
  }
  
  private function onDestroyPlaceholder(e:IKEvent = null ){
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
  	addTextPlaceholder(onPosX() ,onPosY());
  }
  
  private function onPosX():Float{
    return (-GLOBAL.desktop_view.getPosX() * 2.08) - this.x;
  }
  
  private function onPosY():Float{
    return ((-GLOBAL.desktop_view.getPosY() * 2.08) - this.y)+200;
  }
  
  private function addTextPlaceholder(posX:Float, posY:Float):Void{
    var placeholder:APlaceholder		= new TextPlaceholderView(this, placeholders.length, model, TEXT_SUGGESTION.text);
    placeholder.x = posX;
  	placeholder.y = posY;
    placeholders.push(placeholder);
    addChild(placeholder);

  }

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
    stage.addEventListener(MouseEvent.MOUSE_MOVE, movePlaceholder);
    startPoint.x = inFocus.x;
    startPoint.y = inFocus.y;
    hitPoint.x = e.stageX * GLOBAL.Zoom.toMouse();
    hitPoint.y = e.stageY * GLOBAL.Zoom.toMouse();

  }
  
  public function enableResize(e:MouseEvent):Void{
    stage.addEventListener(MouseEvent.MOUSE_MOVE, resizePlaceholder);
    startPoint.x = inFocus.x;
    startPoint.y = inFocus.y;
    hitPoint.x = e.stageX * GLOBAL.Zoom.toMouse();
    hitPoint.y = e.stageY * GLOBAL.Zoom.toMouse();

  }
  
  public function disableResize(e:MouseEvent):Void{
    stage.removeEventListener(MouseEvent.MOUSE_MOVE, resizePlaceholder);
    hitTest();
  }
   
  public function disableMove():Void{
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
    
    if(model.getString('mask_url') != '/assets/fallback/hide_mask.png'){
      if(GLOBAL.hitTest.textFieldHitBitmap(textField, -Std.int(inFocus.x*(72/150)), -Std.int(inFocus.y*(72/150)), guideMask, 0, 0))
        inFocus.alert(true);
      else
        inFocus.alert(false);
    }
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
      setPlaceholderInFocus(null);
      removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
      stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
      stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
      
      hitPointX = ((e.stageX* GLOBAL.Zoom.toMouse()) - this.x);
      hitPointY = ((e.stageY* GLOBAL.Zoom.toMouse()) - this.y);
    }
  }
  
  private function onMouseUp(e:MouseEvent){	

    MouseTrap.release();
    stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
    stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
    addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
    Application.dispatchParameter(new Parameter(EVENT_ID.RESET_STAGE_SIZE));
  }
  
  private function onMouseMove(e:MouseEvent){
    
    var moveX:Float = e.stageX * GLOBAL.Zoom.toMouse();
    var moveY:Float = e.stageY * GLOBAL.Zoom.toMouse();
    
    var endPosX:Float = moveX - hitPointX;
    var endPosY:Float = moveY - hitPointY;
    
    GLOBAL.desktop_view.updateFoilEffects();

    this.x = endPosX;
    this.y = endPosY;

  }
  
  private function movePlaceholder(e:MouseEvent){

    var moveX:Float = e.stageX * GLOBAL.Zoom.toMouse();
    var moveY:Float = e.stageY * GLOBAL.Zoom.toMouse();
    var pos:Float = ( moveX - hitPoint.x) + startPoint.x;
    inFocus.x = pos;
    pos = ( moveY - hitPoint.y) + startPoint.y;
    inFocus.y = pos;
  }
  
  private function resizePlaceholder(e:MouseEvent){
    
    var inFocusWidth:Float    = Math.abs(inFocus.x-this.mouseX);
    var inFocusHeight:Float   = Math.abs(inFocus.y-this.mouseY);
    inFocus.setSize((inFocusWidth+(inFocus.getWidthHeightRatio()*inFocusHeight))/2, ((inFocusWidth/inFocus.getWidthHeightRatio())+inFocusHeight)/2);

  }
  
  //!!! is this in use
  override public function getModel():IModel{
  	return model;
  }

  private function loadFrontShot():Void{
    Application.setString(EVENT_ID.UPDATE_LOAD_PROGRESS,'Loading Front Shot');
    imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadFrontShotComplete);
    imageLoader.addEventListener(IOErrorEvent.IO_ERROR, frontShotErrorHandler);
    imageLoader.load(new URLRequest(model.getString('front_shoot_url')));
  }
  
  private function frontShotErrorHandler(Event:IOErrorEvent):Void {
      trace("ioErrorHandler: " + Event);
  }

  private function onLoadFrontShotComplete(e:Event):Void{
    Application.setString(EVENT_ID.UPDATE_LOAD_PROGRESS,'Front Shot Loaded');
    imageLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoadFrontShotComplete);
    imageLoader.removeEventListener(IOErrorEvent.IO_ERROR, frontShotErrorHandler);
    backdrop = e.target.loader.content;
    addChild(backdrop);
    var filter = new DropShadowFilter(2,45,5,0.2, 10.0, 10.0,1.0);
    backdrop.filters = [filter];
    
    var print_mask_url:String = model.getString('print_mask_url');
    
    loadPrintMask();
	}
	
  private function loadPrintMask():Void{
    Application.setString(EVENT_ID.UPDATE_LOAD_PROGRESS,'Loading Print Mask');
    var print_mask_url:String = model.getString('print_mask_url');
    if(print_mask_url == ''){
      loadHideMask();
    }else{
      var request:URLRequest  = new URLRequest(print_mask_url);
      printMaskLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onloadPrintMaskComplete);
      printMaskLoader.addEventListener(IOErrorEvent.IO_ERROR, printMaskErrorHandler);
      printMaskLoader.load(request);
    } 
  }
  
  private function printMaskErrorHandler(Event:IOErrorEvent):Void {
    Application.setString(EVENT_ID.UPDATE_LOAD_PROGRESS,'ERROR Loading Print Mask');
    trace("ioErrorHandler: " + Event);
  }
  
  private function onloadPrintMaskComplete(e:Event):Void{
    Application.setString(EVENT_ID.UPDATE_LOAD_PROGRESS,'Print Mask Loaded');
    printMaskLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onloadPrintMaskComplete);
    printMaskLoader.removeEventListener(IOErrorEvent.IO_ERROR, printMaskErrorHandler);
    guideMask = e.target.loader.content;
    addChild(guideMask);
    guideMask.visible = false;
    guideMask.alpha = 0.5;
    Pages.addEventListener(EVENT_ID.SHOW_MASK, onShowMask);

    loadHideMask();
    
  }
  
  private function loadHideMask():Void{
    Application.setString(EVENT_ID.UPDATE_LOAD_PROGRESS,'Loading Hide Mask');
    var hide_mask_url:String = model.getString('hide_mask_url');

    if(hide_mask_url == '' || hide_mask_url == null ||  hide_mask_url == '/assets/fallback/hide_mask.png'){
      allImagesLoaded();
    }else{
      
      hideMaskPresent = true;
      var request:URLRequest  = new URLRequest(hide_mask_url);
      printMaskLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadHideMaskComplete);
      printMaskLoader.addEventListener(IOErrorEvent.IO_ERROR, hideMaskErrorHandler);
      printMaskLoader.load(request);
    }
    //allImagesLoaded();
  }
  
  private function hideMaskErrorHandler(Event:IOErrorEvent):Void {
    Application.setString(EVENT_ID.UPDATE_LOAD_PROGRESS,'ERROR Loading Hide Mask');
      trace("ioErrorHandler: " + Event);
  }
  
  private function onLoadHideMaskComplete(e:Event):Void{
    Application.setString(EVENT_ID.UPDATE_LOAD_PROGRESS,'Hide Mask Loaded');
    printMaskLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoadHideMaskComplete);
    printMaskLoader.removeEventListener(IOErrorEvent.IO_ERROR, hideMaskErrorHandler);
    hideMask                    = e.target.loader.content;
    addChild(hideMask);
    hideMask.visible            = false;
    backdrop.mask               = hideMask;
    backdrop.cacheAsBitmap      = true;
    hideMask.cacheAsBitmap      = true;
    allImagesLoaded();
  }
  
  private function allImagesLoaded():Void{
    Application.setString(EVENT_ID.UPDATE_LOAD_PROGRESS,'All Page Images Loaded');
    Application.dispatchParameter(new Parameter(EVENT_ID.RESET_STAGE_SIZE));
    if( model.getInt('pageId') == 0){
      GLOBAL.size_x = backdrop.width;
      GLOBAL.size_y = backdrop.height;
     
      Application.setString(EVENT_ID.ALL_PHOTOS_LOADED, 'foo');
      parsePagePresetXml();

      var param = new Parameter(EVENT_ID.CENTER_PAGE);
      param.setInt(0);
      Application.dispatchParameter(param);
    }
    else{
      parsePagePresetXml();

    }
  }
  
  private function pageDesignImageLoaded():Void{
    Application.setString(EVENT_ID.UPDATE_LOAD_PROGRESS,'Page Design Backdrop Loaded');
    Application.setString(EVENT_ID.ALL_PHOTOS_LOADED, 'foo');
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

  private function onGetPagePosXml( e:KEvent ): Void{
    var str:String = '\t\t<pos-x>' + Std.string(this.x) + '</pos-x>\n';
    str += '\t\t<pos-y>' + Std.string(this.y) + '</pos-y>\n';
    model.setString(EVENT_ID.SET_PAGE_XML,str);
  }
}
