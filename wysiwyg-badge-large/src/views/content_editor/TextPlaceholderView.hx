// the placeholder handles the mouse



import flash.events.Event;
import flash.geom.Point;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.display.Loader;

import flash.events.MouseEvent;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.display.Loader;
import flash.net.URLRequest;

import flash.system.ApplicationDomain; 
import flash.system.LoaderContext;
import flash.system.SecurityDomain;

import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

import flash.geom.Point;
import flash.display.BitmapData;
import flash.display.Bitmap;

import flash.events.Event;
import flash.events.KeyboardEvent;

import flash.display.Shape;
import flash.Vector;


class TextPlaceholderView extends APlaceholder {
	
  private var fontMovie:MovieClip;
  private var font:Dynamic;
  private var pageView:PageView;
  private var model:IModel;
  private var mouseOver:Bool;
  private var id:Int;
  private var modelId:Int;
  private var xml:String;
  private var fontFileName:String;
  private var fontScreenName:String;
  private var textWithTags:String;
  private var fontSize:Float;
  private var fontLeading:Float;
  private var letterSpacing:Float;
  private var fontPosX:Float;
  private var fontAlign:String;
  private var storedAlign:String;
  private var anchorPoint:Float;
  private var repossition:Bool;
  private var previewMode:Bool;
  private var designMode:Bool;
  private var focus:Bool;
  private var tagsIsVisible:Bool;
  private var textString:String;
  private var collition:Bool;
  private var textOnTop:Bool;
  private var selectBox:TextSelectBox;
  private var foiled:Bool;
  private var was_foiled:Bool;
  private var foil:Dynamic;
  private var foilTexture:Bitmap;
  private var silverFoilTexture:Bitmap;
  private var goldFoilTexture:Bitmap;
  private var yellowFoilTexture:Bitmap;
  private var redFoilTexture:Bitmap;
  private var greenFoilTexture:Bitmap;
  private var blueFoilTexture:Bitmap;
  private var foilShadow:Sprite;
  private var foilShine:Sprite;
  private var foilGlowColor:UInt;
  private var printType:String;
  private var foilColor:String; 
  private var stdPmsColor:UInt;
  private var pms1Color:UInt; 
  private var pms2Color:UInt; 
  private var laserColor:UInt;
  private var fontScreenColor:UInt;
  private var loaded_fonts:Hash<Dynamic>;
  private var textFieldText:String;
  private var garamond:Bool;
  
  //private var loading:Bitmap;
  
  
  public function new(pageView:PageView, id:Int, model:IModel, text:String){	
    
    super(pageView, id, model, text);
    this.pageView                      = pageView;
    this.id                           = id;
    this.model                        = model;
    this.modelId                      = model.getInt('pageId');
    designMode                        = GLOBAL.edit_mode == 'system_design';
    textWithTags                      = text;
    this.alpha                        = 0.85;
    fontPosX                          = 0;
    mouseOver                         = false;
    anchorPoint                       = GLOBAL.Font.anchorPoint;
    GLOBAL.Font.anchorPoint           = 0;
    previewMode                       = true;
    focus                             = false;
    tagsIsVisible                     = false;
    storedAlign                       = GLOBAL.Font.fontAlign;
    repossition                       = false;
    addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    GLOBAL.Application.addEventListener(EVENT_ID.DESKTOP_VIEW_MOVE, onDesktopViewMove);
    collition                         = false;
    foiled                            = false;
    was_foiled                        = false;

    
    loaded_fonts = new Hash();
    
    silverFoilTexture   = new SilverFoilTexture();
    goldFoilTexture     = new GoldFoilTexture();
    yellowFoilTexture   = new YellowFoilTexture();
    redFoilTexture      = new RedFoilTexture();
    greenFoilTexture    = new GreenFoilTexture();
    blueFoilTexture     = new BlueFoilTexture();
    
  }
  

  private function onAddedToStage(e:Event){
    model.addEventListener(EVENT_ID.GET_PAGE_XML+Std.string(modelId), onGetXml);
    addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
    loadFont();
  }
  
  public function isFoiled():Bool {
    return foiled == true;
  }
  
  public function foilify():Void {
    unfoilify();
    
    var foilShineColor = 0xFFFFFF;
    var foilShadowColor = 0x000000;
    
    if(foiled != true) {
      switch ( foilColor )
      {
        case 'silver':
          foilTexture = silverFoilTexture;
          foilGlowColor = 0xCCCCCC;
        case 'gold': 
          foilTexture = goldFoilTexture;
          foilGlowColor = 0xFFEF88;
          foilShineColor = 0xf1e2be;
          foilShadowColor = 0x882244;
        case 'Yellow':
          foilTexture = yellowFoilTexture;
          foilGlowColor = 0xFFFF11;
          foilShineColor = 0xFFFFEE;
          foilShadowColor = 0xb3a800;
        case 'red': 
          foilTexture = redFoilTexture;
          foilGlowColor = 0xFF1111;
          foilShadowColor = 0x110000;
          foilShineColor = 0xFF9090;
        case 'green':
          foilTexture = greenFoilTexture;
          foilGlowColor = 0x11FF11;
          foilShadowColor = 0x006400;
          foilShineColor = 0xEEFFEE;
        case 'blue':
          foilTexture = blueFoilTexture; 
          foilGlowColor = 0x7777FF;
          foilShadowColor = 0x000064;
      }

      foilShadow = new Sprite();    
      foilShine = new Sprite();
      
      foilShine.graphics.clear();
      foilShadow.graphics.beginFill(foilShadowColor);
      foilShadow.alpha = 0.0;
      foilShadow.graphics.drawRect(0,0,1024,1017);
      foilShadow.graphics.endFill();
      
      foilShine.graphics.clear();
      foilShine.graphics.beginFill(foilShineColor);
      foilShine.alpha = 0.0;
      foilShine.graphics.drawRect(0,0,1024,1017);
      foilShine.graphics.endFill();
      
      setFoilBackdrop();
      
      foil = new MovieClip();
      foil.addChild(foilTexture);
      foil.addChild(fontMovie);
      foil.addChild(foilShadow);
      foil.addChild(foilShine);
      foil.mask = fontMovie;
      
      addChild(foil);
      Foil.initFiltersOn(foil, foilGlowColor);
      
    }
    foiled = true;
  }
  
  private function onDesktopViewMove(e:IKEvent):Void{
    updateFoilEffect(e.getFloat());
  }
  
  override public function updateFoilEffect(offset:Float):Void{
    if(foiled){
      
      foilShine.alpha = Math.pow(Math.abs(offset-0.5), 0.75);
      offset += 0.5;
      if(offset > 1.0){
        offset -= 1.0;
      }
      
      var shadowAlpha:Float = Math.pow(Math.abs(offset-0.5), 2);
      if(shadowAlpha < 0.0){
        shadowAlpha = 0.0;
      }
      foilShadow.alpha = shadowAlpha;
    }
  }
  
  public function setFoilBackdrop():Void {
    //Small workaround fix hack
    foilTexture.width = this.width;
    foilTexture.height = this.height;
    foilShadow.width = this.width;
    foilShadow.height = this.height;
    foilShine.width = this.width;
    foilShine.height = this.height;
  }
  
  public function unfoilify():Void {
    if(foiled == true){
      foil.removeChild(foilTexture);
      foil.removeChild(fontMovie);
      foil.removeChild(foilShadow);
      foil.removeChild(foilShine);
      foil.mask = null;
      Foil.removeFiltersFrom(foil);
      this.removeChild(foil);
      this.addChild(fontMovie);
    }
    foiled = false;
  }
  
  private function handleKeyboard(b:Bool):Void{
    //if(b){
    //  stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPressed);
    //  //stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
    //}
    //else{
    //  stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyPressed);
    //  //stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
    //}
  }
   
  override public function getText(): Void {
    var param:IParameter = new Parameter(EVENT_ID.PLACEHOLDER_TEXT);
    param.setString(font.getText());
    textFieldText = font.getText();
    param.setInt(id);
    model.setParam(param);
  }
  
  override public function getXml() : String {

    showTags();
    
    var str:String = '\t\t<placeholder id=\"'+ Std.string(id) +'\">\n';
    str += '\t\t\t<placeholder-type>' + 'text_placeholder' + '</placeholder-type>\n';
    str += '\t\t\t<pos-x>' + Std.string(x) + '</pos-x>\n';
    str += '\t\t\t<pos-y>' + Std.string(y) + '</pos-y>\n';
    str += '\t\t\t<font-file-name>' + fontFileName + '</font-file-name>\n';
    str += '\t\t\t<garamond>' + isGaramond() + '</garamond>\n';
    str += '\t\t\t<print-type>' + printType + '</print-type>\n';
    str += '\t\t\t<foil-color>' + foilColor + '</foil-color>\n';
    str += '\t\t\t<std_pms_color>' + Std.string(stdPmsColor) + '</std_pms_color>\n';
    str += '\t\t\t<laser-color>' + Std.string(laserColor) + '</laser-color>\n';
    str += '\t\t\t<pms1-color>' + Std.string(pms1Color) + '</pms1-color>\n';
    str += '\t\t\t<pms2-color>' + Std.string(pms2Color) + '</pms2-color>\n';
    str += '\t\t\t<line-space>' + Std.string(fontLeading) + '</line-space>\n';
    str += '\t\t\t<font-size>' + Std.string(fontSize) + '</font-size>\n';
    str += '\t\t\t<font-align>' + fontAlign + '</font-align>\n';
    str += '\t\t\t<anchor-point>' + Std.string(calculateAnchorPoint()) + '</anchor-point>\n';
    //trace('font==null', font==null);
    str += font.getXml();
    str += '\t\t</placeholder>\n';
    restoreShowTags();
//    trace(str);
    return str;
  }
  
  override public function isGaramond():String{
    return garamond ? 'true' : 'false';
  }

  private function onKeyPressed(event:KeyboardEvent):Void{
    //var step:Float = 150/72;
//  //  trace("Keycode: ");
//  //  trace(event.keyCode);
    //switch(event.keyCode){
    //  case 37: this.x -=step; 
    //  case 39: this.x +=step; 
    //  case 38: this.y -=step; 
    //  case 40: this.y +=step;
    //}
  }
  
//  private function onKeyUp(event:KeyboardEvent):Void{
//    //pageView.hitTest();
//  }
  
  private function insertTags(str:String):String{
    
    var txt:String;
    
    var r = ~/_brides_first_name/gi;
    txt = r.replace(str,GLOBAL.Designs.getString('brides_first_name')); 

    r = ~/_brides_last_name/gi;
    txt = r.replace(txt,GLOBAL.Designs.getString('brides_last_name'));

    r = ~/_grooms_first_name/gi;
    txt = r.replace(txt,GLOBAL.Designs.getString('grooms_first_name'));

    r = ~/_grooms_last_name/gi;
    txt = r.replace(txt,GLOBAL.Designs.getString('grooms_last_name'));

    r = ~/_brides_initials/gi;
    txt = r.replace(txt,GLOBAL.Designs.getString('brides_initials'));

    r = ~/_grooms_initials/gi;
    txt = r.replace(txt,GLOBAL.Designs.getString('grooms_initials'));

    r = ~/_wedding_date/gi;
    txt = r.replace(txt,GLOBAL.Designs.getString('wedding_date'));

    r = ~/_wedding_time/gi;
    txt = r.replace(txt,GLOBAL.Designs.getString('wedding_time'));

    r = ~/_church_name/gi;
    txt = r.replace(txt,GLOBAL.Designs.getString('church_name'));

    r = ~/_church_location/gi;
    txt = r.replace(txt,GLOBAL.Designs.getString('church_location'));

    r = ~/_party_place_name/gi;
    txt = r.replace(txt,GLOBAL.Designs.getString('party_place_name'));

    r = ~/_party_place_location/gi;
    txt = r.replace(txt,GLOBAL.Designs.getString('party_place_location'));  

    r = ~/_reply_by_date/gi;
    txt = r.replace(txt,GLOBAL.Designs.getString('reply_by_date'));

    r = ~/_reply_to_phone2/gi;
    txt = r.replace(txt,GLOBAL.Designs.getString('reply_to_phone2'));

    r = ~/_reply_to_phone/gi;
    txt = r.replace(txt,GLOBAL.Designs.getString('reply_to_phone'));

    r = ~/_mobile/gi;
    txt = r.replace(txt,GLOBAL.Designs.getString('mobile'));

    r = ~/_reply_to_email/gi;
    txt = r.replace(txt,GLOBAL.Designs.getString('reply_to_email'));

    r = ~/_dress_code/gi;
    txt = r.replace(txt,GLOBAL.Designs.getString('dress_code'));

    r = ~/_company_name/gi;
    txt = r.replace(txt,GLOBAL.Designs.getString('company_name'));

    r = ~/_location_name/gi;
    txt = r.replace(txt,GLOBAL.Designs.getString('location_name'));

    r = ~/_location/gi;
    txt = r.replace(txt,GLOBAL.Designs.getString('location'));

    r = ~/_reply_to_people2/gi;
    txt = r.replace(txt,GLOBAL.Designs.getString('reply_to_people2'));

    r = ~/_reply_to_people/gi;
    txt = r.replace(txt,GLOBAL.Designs.getString('reply_to_people'));

    r = ~/_dinner_place_name/gi;
    txt = r.replace(txt,GLOBAL.Designs.getString('dinner_place_name'));

    r = ~/_city/gi;
    txt = r.replace(txt,GLOBAL.Designs.getString('city'));

    r = ~/_countrxy/gi;
    txt = r.replace(txt,GLOBAL.Designs.getString('countrxy'));

    return txt;
    
  }

  private function loadFont():Void{
//    trace('load font');
    fontFileName      = GLOBAL.Font.fileName;
    fontSize          = GLOBAL.Font.fontSize;       
    fontAlign         = GLOBAL.Font.fontAlign;
    fontLeading       = GLOBAL.Font.leading;
    letterSpacing     = GLOBAL.Font.letterSpacing;
    printType         = GLOBAL.printType; 
    foilColor         = GLOBAL.foilColor;
    stdPmsColor       = GLOBAL.stdPmsColor;
    pms1Color         = GLOBAL.pms1Color;
    pms2Color         = GLOBAL.pms2Color;
    laserColor        = GLOBAL.laserColor;
    garamond          = GLOBAL.garamond;
    setFontScreenColor();
    if(fontMovie != null){
      removeChild(fontMovie);
      //trace("Removed Child fontMovie");
      fontMovie = null;
    }
    
    if(loaded_fonts.get(fontFileName) == null){
      var ldr:Loader                = new Loader(); 
      var req:URLRequest            = new URLRequest(buildUrl(fontFileName)); 
      var ldrContext:LoaderContext  = new LoaderContext(); 
      ldrContext.applicationDomain  = new ApplicationDomain();
      ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, onFontLoaded); 
      ldr.load(req, ldrContext);
      loaded_fonts.set(fontFileName, fontMovie);
    } else {
      fontMovie = loaded_fonts.get(fontFileName);
      onFontCached();
    }
  }
  
  private function onFontLoaded(event:Event):Void {
    
    fontMovie   =  cast event.target.loader.content;
    onFontCached();
  }
  
  private function onFontCached():Void {
    //removeChild(loading);
    addChild(fontMovie);    
    

    font        = fontMovie.font;
    font.init(  fontSize, 
                fontScreenColor, 
                fontAlign, 
                textWithTags, 
                letterSpacingToFont() , 
                letterSpacing,
                this); 
    
    restoreShowTags();
    
    if(repossition) moveToAnchorPoint();
    
    var param:IParameter = new Parameter(EVENT_ID.SWF_LOADED);
    param.setInt(id);
    model.setParam(param);

    if(selectBox == null) {
       selectBox   =   new TextSelectBox(pageView, this); 
       addChild(selectBox);
    }
    
    setFontPrintType();
    resizeBackdrop();
    
    GLOBAL.Pages.calculatePrice();
    //Pages.dispatchEvent( new Event(EVENT_ID.CALCULATE_PRICE));
    //GLOBAL.Pages.setString(EVENT_ID.CALCULATE_PRICE, 'foo');
    
  }
  
  private function hitTest():Void{
    trace('hit test');
    pageView.hitTest();
  }
    
  override public function onUpdatePlaceholder(event:Event):Void{
    //trace('onUpdatePlaceholder');
    
    fontFileName      = GLOBAL.Font.fileName;
    fontSize          = GLOBAL.Font.fontSize;       
    fontAlign         = GLOBAL.Font.fontAlign;
    fontLeading       = GLOBAL.Font.leading;
    letterSpacing     = GLOBAL.Font.letterSpacing;
    printType         = GLOBAL.printType; 
    foilColor         = GLOBAL.foilColor;
    stdPmsColor       = GLOBAL.stdPmsColor;
    pms1Color         = GLOBAL.pms1Color;
    pms2Color         = GLOBAL.pms2Color;
    laserColor        = GLOBAL.laserColor;
    garamond          = GLOBAL.garamond;
    
    setFontScreenColor();
    setFontPrintType();
    
    storedAlign         = fontAlign;
    anchorPoint         = calculateAnchorPoint();
    repossition         = true;
    storeTags();
    font = null;
    unfoilify();
    loadFont();
    
    GLOBAL.Pages.calculatePrice();
    
  }
  
  override public function getStdPmsColor():String {
    return Std.string(stdPmsColor);
  }
  
  override public function getPms1Color():String {
    return Std.string(pms1Color);
  }
  
  override public function getPms2Color():String {
    return Std.string(pms2Color);
  }
  
  override public function getFoilColor():String {
    return foilColor;
  }
  
  override public function getPrintType():String {
    return printType;
  }
    
  private function setFontPrintType():Void{
    
    //trace('setFontPrintType :: ', printType);
    switch ( printType ){
      case CONST.STD_PMS_COLOR:{
        was_foiled = false;
        unfoilify();
      }
      case CONST.CUSTOM_PMS1_COLOR:{
        was_foiled = false;
        unfoilify();
      }
      case CONST.CUSTOM_PMS2_COLOR:{
        was_foiled = false;
        unfoilify();
      }
      case CONST.FOIL_COLOR:{
        setFoil();
      }
      case CONST.GARAMOND:{
        setFoil();
        
      }
      case CONST.LASER_COLOR:{
        was_foiled = false;
        unfoilify();
      }
    }
  }
  
  private function setFoil():Void{
    setFontScreenColorForFoil();
    was_foiled = true;
    if(!textOnTop)
      foilify();
  }

  private function setFontScreenColor():Void{
    switch ( printType ){
      case CONST.STD_PMS_COLOR: fontScreenColor           = stdPmsColor;
      case CONST.CUSTOM_PMS1_COLOR: fontScreenColor       = pms1Color;
      case CONST.CUSTOM_PMS2_COLOR: fontScreenColor       = pms2Color;  
      case CONST.FOIL_COLOR:    setFontScreenColorForFoil();
      case CONST.GARAMOND:    setFontScreenColorForFoil(); 
      case CONST.LASER_COLOR:   fontScreenColor            = laserColor; 
    }
  }
  
  private function setFontScreenColorForFoil():Void{
    switch ( foilColor ){
      case 'silver'     :fontScreenColor  = 0xE0E0E0;
      case 'gold'       :fontScreenColor  = 0xFFD560;
      case 'Yellow'     :fontScreenColor  = 0xFFFF00;
      case 'red'        :fontScreenColor  = 0xFF0000;
      case 'green'      :fontScreenColor  = 0x00FF00;
      case 'blue'       :fontScreenColor  = 0x0000FF;
    }
  }
     
  private function showTags():Void{
    storeTags();
    tagsIsVisible   = true;
    textFieldText = textWithTags;
    font.setText(textWithTags);  
  }
  
  private function hideTags():Void{
    storeTags();
    tagsIsVisible = false;
    textFieldText = insertTags(textWithTags);
    font.setText(insertTags(textWithTags));
  }
  
  private function storeTags():Void{

    if(tagsIsVisible) 
      textWithTags  = font.getText();
  }
  
  private function restoreShowTags():Void{
    focus ? showTags():hideTags();
  }
  
  private function getTextWithoutTags():String{
    return insertTags(textWithTags);
  }
  
  private function moveToAnchorPoint():Void{
    if(anchorPoint != calculateAnchorPoint() ){
      if( storedAlign == fontAlign){
        this.x += (anchorPoint - calculateAnchorPoint())*(150/72);
      }
    }
    anchorPoint = calculateAnchorPoint();
    storedAlign  = fontAlign;
    repossition = false;
    
  }

  override public function calculateAnchorPoint():Float{
//    trace('############################################');
//    trace('#      DISPATCH EVENT TO MOVE MOUSE HIT POINT');
//    trace('############################################');
    
    
    //GLOBAL.MOVE_TOOL;
    // !!! colide with the hit test
    //font.setText(textWithTags);
    var anchor_point:Float = 0;
    switch(fontAlign){
      case 'left': anchor_point   = 0;
      case 'center': anchor_point  = font.getWidth()/2;
      case 'right': anchor_point   = font.getWidth();
      //case 'center': anchor_point  = this.width/2;
      //case 'right': anchor_point   = this.width;
    }
    // !!! colide with the hit test
    //if(!tagsIsVisible) font.setText(insertTags(textWithTags));
    return anchor_point;
  }
  
  private function buildUrl(fileName:String):String{
  	return "/assets/" + fileName+ ".swf?" + Math.random();
  }
  
  override public function setFocus(b:Bool):Void{
    //focus             = b;
    //if(!focus){
    //  
    //  hideTags();
    //  setTextOnTop(false);
    //  if(was_foiled == true)
    //    foilify();
    //}else{
    //  showTags();
    //}
    //updateFocus(); 
  }
  
  private function updateFocus():Void{
    //updatePrice();
    //resizeBackdrop();
    //selectBox.setFocus(focus);
    //handleKeyboard( focus );
    //GLOBAL.Application.dispatchParameter(new Parameter(EVENT_ID.RESET_STAGE_SIZE));   
  }
  
  private function updatePrice():Void{
    textFieldText = textWithTags;
    GLOBAL.Pages.calculatePrice();
  }
  
  private function textFielsCapturedFocus(b:Bool):Void{
    trace('textFielsCapturedFocus');
    //if(b){
    //  MouseTrap.capture();
    //  unfoilify();
    //  pageView.setPlaceholderInFocus(this);
    //  setTextOnTop(true);
    //  trace('prevent the pageView from release the inFocus and capture the mouse here');
    //}else{
    //  MouseTrap.release();
    //}
    
  }
  
  private function setTextOnTop(b:Bool):Void {
    //MouseTrap.capture();
    //
    //font.selectable(b);
    //textOnTop = b;
    //if(b){
    //   unfoilify();
    //  this.setChildIndex(fontMovie, this.numChildren - 1);
    //  
    //}else{
    //  this.setChildIndex(selectBox, this.numChildren - 1);
    //}
    //
    //selectBox.resetMouse();
  }
  
  //!!!
  private function resizeBackdrop():Void{
    // inform the page that the select box has 'moved' to avoid sudden jump on mouse move
    //selectBox.resizeBackdrop(fontMovie.width, fontMovie.height, font.getTextField().x, font.getCombindeMargins());
  }
  
  public function textInputCapture():Void {
    //updatePrice();
    //resizeBackdrop();
    //hitTest();
  }

  public function updateGlobals(){
    
    GLOBAL.Font.fileName        = fontFileName;
    GLOBAL.Font.fontSize        = fontSize;
    GLOBAL.Font.fontAlign       = fontAlign;
    GLOBAL.Font.leading         = fontLeading;
    GLOBAL.Font.letterSpacing   = letterSpacing;
    GLOBAL.printType            = printType; 
    GLOBAL.foilColor            = foilColor;
    GLOBAL.stdPmsColor          = stdPmsColor; 
    GLOBAL.pms1Color            = pms1Color;   
    GLOBAL.pms2Color            = pms2Color;   
    GLOBAL.laserColor           = laserColor;  
    GLOBAL.garamond             = garamond; 
    updateSideView();
  }
  
  private function updateSideView(): Void{
    var param:IParameter = new Parameter(EVENT_ID.UPDATE_SIDE_VIEWS);
    param.setString(getPlaceholderType());
    GLOBAL.Application.dispatchParameter(param);
  }

  private function onGetXml(event:Event):Void{
    model.setString(EVENT_ID.SET_PAGE_XML, getXml());
  }
  
  private function letterSpacingToFont():Float{
      return fontLeading;
  }
  
  private function onRemovedFromStage(e:Event){
    GLOBAL.Pages.calculatePrice();
    removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
  	model.removeEventListener(EVENT_ID.GET_PAGE_XML+Std.string(modelId), onGetXml);
  }
  
  override public function getPlaceholderType():String{
    return garamond ? 'garamond_place_holder' : 'text_place_holder';
  }
  
  override public function getTextField():TextField{
     return font.getTextField();
  }
  
  override public function getTextFieldText():String{
    return textFieldText;
  }
  
  override public function alert(b:Bool):Void{
      //collition = b;
      //selectBox.alert(b);
  }


}
