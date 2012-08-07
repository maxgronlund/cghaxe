// the placeholder handles the mouse



import flash.events.Event;
import flash.geom.Point;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.display.Loader;

import flash.events.MouseEvent;
import flash.display.MovieClip;
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
  private var fontSize:Int;
  private var fontColor:Int;
  private var foilColor:String;
  private var printType:String;
  private var fontLeading:Int;
  private var letterSpacing:Int;
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
//  private var textOnTop:Bool;

  



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
    collition                         = false;
    foiled = false;
    was_foiled = false;


    
    silverFoilTexture                  = new SilverFoilTexture();
    goldFoilTexture                    = new GoldFoilTexture();
    yellowFoilTexture                  = new YellowFoilTexture();
    redFoilTexture                     = new RedFoilTexture();
    greenFoilTexture                   = new GreenFoilTexture();
    blueFoilTexture                    = new BlueFoilTexture();
    
    printType                         = GLOBAL.printType;
  }
  

  private function onAddedToStage(e:Event){
    model.addEventListener(EVENT_ID.GET_PAGE_XML+Std.string(modelId), onGetXml);
    addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
    loadFont();
  }
  
  public function isFoiled():Bool {
    return foiled == true;
  }
  
  public function foilify(color:String):Void {
    if(foiled != true) {

      foilTexture = silverFoilTexture;

      switch ( color )
      {
        case 'silver':
          foilTexture = silverFoilTexture;
        case 'gold': 
          foilTexture = goldFoilTexture;
        case 'yellow':
          foilTexture = yellowFoilTexture;
        case 'red': 
          foilTexture = redFoilTexture;
        case 'green':
          foilTexture = greenFoilTexture;
        case 'blue':
          foilTexture = blueFoilTexture; 
      }

      foil = new MovieClip();
      foil.addChild(foilTexture);
      foilTexture.width = this.width;
      foilTexture.height = this.height;
      this.addChild(foil);
      this.addChild(fontMovie);
      this.mask = fontMovie;
      Foil.initFiltersOn(this);
    }
    foiled = true;
  }
  
  public function unfoilify():Void {
    if(foiled == true){
      this.mask = null;
      //foil.removeChild(fontMovie);
      this.removeChild(foil);
      //this.addChild(fontMovie);
      Foil.removeFiltersFrom(this);
    }
    foiled = false;
  }
  
  private function handleKeyboard(b:Bool):Void{
    if(b){
      stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPressed);
      stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
    }
    else{
      stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyPressed);
      stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
    }
  }
   
  override public function getText(): Void {
    
    var param:IParameter = new Parameter(EVENT_ID.PLACEHOLDER_TEXT);
    param.setString(font.getText());
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
      str += '\t\t\t<print-type>' + printType + '</print-type>\n';
      if(foiled){
        str += '\t\t\t<foil-color>' + foilColor + '</foil-color>\n';
      } else{
        str += '\t\t\t<font-color>' + Std.string(fontColor) + '</font-color>\n';
      }
      str += '\t\t\t<line-space>' + Std.string(fontLeading) + '</line-space>\n';
      str += '\t\t\t<font-size>' + Std.string(fontSize) + '</font-size>\n';
      str += '\t\t\t<font-align>' + fontAlign + '</font-align>\n';
      str += '\t\t\t<anchor-point>' + Std.string(calculateAnchorPoint()) + '</anchor-point>\n';
      str += font.getXml();
    str += '\t\t</placeholder>\n';
//    trace(str);
    restoreShowTags();
    return str;
  }
  
  private function onKeyPressed(event:KeyboardEvent):Void{
    var step:Float = 150/72;
//    trace("Keycode: ");
//    trace(event.keyCode);
    switch(event.keyCode){
      case 37: this.x -=step; 
      case 39: this.x +=step; 
      case 38: this.y -=step; 
      case 40: this.y +=step;
    }
  }
  
  private function onKeyUp(event:KeyboardEvent):Void{
    //pageView.hitTest();
  }
  
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
    
    switch ( GLOBAL.printType )
    {
      case CONST.STD_PMS_COLOR:{
        //unfoilify();
        fontColor = GLOBAL.stdPmsColor;
      }
    }
    
    fontFileName                  = GLOBAL.Font.fileName;
    fontSize                      = GLOBAL.Font.fontSize;
    
    fontAlign                     = GLOBAL.Font.fontAlign;
    fontLeading                   = GLOBAL.Font.leading;
    letterSpacing                 = GLOBAL.Font.letterSpacing;

    var ldr:Loader                = new Loader(); 
    var req:URLRequest            = new URLRequest(buildUrl(fontFileName)); 
    var ldrContext:LoaderContext  = new LoaderContext(); 
    ldrContext.applicationDomain  = new ApplicationDomain();
    ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, onFontLoaded); 
    ldr.load(req, ldrContext);
  }
  
  private function onFontLoaded(event:Event):Void {
    fontMovie   =  cast event.target.loader.content;
    addChild(fontMovie);

    font        = fontMovie.font;
    font.init(  fontSize, 
                fontColor, 
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
    resizeBackdrop();
    //pageView.hitTest();
  }

  private function hitTest():Void{
    pageView.hitTest();
  }
  
  override public function onUpdatePlaceholder(event:Event):Void{

    printType = GLOBAL.printType;
    var foilIt = false;
    
    switch ( GLOBAL.printType ){
      case CONST.STD_PMS_COLOR:{
        fontColor = GLOBAL.stdPmsColor;
      }
      case CONST.FOIL_COLOR:{
        foilColor = GLOBAL.foilColor;
        trace(foilColor);
        foilIt = true;
      }
      case CONST.LASER_COLOR:{
        fontColor = GLOBAL.laserColor;
      }
    }
    storedAlign       = fontAlign;
    //font.setText(insertTags(textWithTags));
    anchorPoint       = calculateAnchorPoint();
    repossition       = true;
    storeTags();
    removeChild(fontMovie);
    font = null;
    loadFont();
    
    //!!! bue fix this
    //if(foilIt)
    //  foilify(foilColor);
  }
  
  private function showTags():Void{
    storeTags();
    tagsIsVisible   = true;
    font.setText(textWithTags);
    
  }
  
  private function hideTags():Void{
    storeTags();
    tagsIsVisible = false;
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
    focus             = b;
    updateFocus();
    
    if(!focus){
      setTextOnTop(false);
    }
  }
  
  private function updateFocus():Void{
    
    trace('update focus');
    
    selectBox.setFocus(focus);
//    selectBox.setFocus2();
    
    if(focus){
      //!GLOBAL.MOVE_TOOL ? showTags():hideTags();
      resizeBackdrop();

      if(foiled == true){
        unfoilify();
        was_foiled = true;
      }
    }else{
      //hideTags();
    
      if(!collition){
        //trace("here?");
        //selectBox.setFocus(false);
      }
      if(was_foiled == true){
        foilify('gold');
        was_foiled = false;
      }
    }
    //selectBox.setFocus(focus);
    handleKeyboard( focus );
    GLOBAL.Application.dispatchParameter(new Parameter(EVENT_ID.RESET_STAGE_SIZE));   
    
    
  }
  
  private function textFielsCapturedFocus(b:Bool):Void{

    if(b){
      MouseTrap.capture();
      pageView.setPlaceholderInFocus(this);
      setTextOnTop(true);
      trace('prevent the pageView from release the inFocus and capture the mouse here');
    }else{
      MouseTrap.release();
    }
    
  }
  
  private function setTextOnTop(b:Bool):Void {
    MouseTrap.capture();
    font.selectable(b);
    //textOnTop = b;
    if(b){
      this.setChildIndex(fontMovie, this.numChildren - 1);
      
    }else{
      this.setChildIndex(selectBox, this.numChildren - 1);
    }
    
    selectBox.resetMouse();
  }
  
  private function resizeBackdrop():Void{
    selectBox.resizeBackdrop(fontMovie.width, fontMovie.height, font.getTextField().x, font.getCombindeMargins());
  }
  
  public function textInputCapture():Void {
    resizeBackdrop();
    hitTest();
  }

  public function updateGlobals(){

    GLOBAL.Font.fileName        = fontFileName;
    GLOBAL.Font.fontSize        = fontSize;
    //GLOBAL.Font.fontColor       = fontColor;
    GLOBAL.Font.fontAlign       = fontAlign;
    GLOBAL.Font.leading         = fontLeading;
    GLOBAL.Font.letterSpacing   = letterSpacing;

    model.setParam(new Parameter(EVENT_ID.UPDATE_TEXT_TOOLS)); 
    updateSideView();    
    //if(GLOBAL.MOVE_TOOL) pageView.enableMove(e);
    
    //this.setChildIndex(font.getTextField(), this.numChildren - 1);
  }
  
  private function updateSideView(): Void{
    var param:IParameter = new Parameter(EVENT_ID.UPDATE_SIDE_VIEWS);
    param.setString(getPlaceholderType());
    GLOBAL.Application.dispatchParameter(param);
  }
  
  private function onGetXml(event:Event):Void{
    
    model.setString(EVENT_ID.SET_PAGE_XML, getXml());
  }
  
  private function letterSpacingToFont():Int{
      return fontLeading;
  }
  
  private function onRemovedFromStage(e:Event){
    //trace('onRemovedFromStage');
    removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
  	model.removeEventListener(EVENT_ID.GET_PAGE_XML+Std.string(modelId), onGetXml);
  }
  
  override public function getPlaceholderType():String{
    return 'text_place_holder';
  }
  
  override public function getTextField():TextField{
     return font.getTextField();
  }
  
  override public function alert(b:Bool):Void{
      collition = b;
  }


}
