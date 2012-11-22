// the placeholder handles the mouse



import flash.events.Event;
import flash.geom.Point;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.display.Loader;

import flash.events.MouseEvent;
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.Loader;
import flash.net.URLRequest;

import flash.system.ApplicationDomain; 
import flash.system.LoaderContext;
import flash.system.SecurityDomain;

import flash.geom.Point;
import flash.display.BitmapDataChannel;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.display.BlendMode;

import flash.events.Event;
import flash.events.KeyboardEvent;

import flash.display.Shape;
import flash.Vector;
import flash.display.Sprite;
import flash.geom.Matrix;
import flash.geom.ColorTransform;



class VectorPlaceholderView extends APlaceholder {
	
  private var vectorMovie:MovieClip;
  private var pageView:PageView;
  private var model:IModel;
  private var mouseOver:Bool;
  private var id:Int;
  private var modelId:Int;
  private var xml:String;
  private var vectorFileFileName:String;
  private var vectorFileScreenName:String;
  private var url:String;
  private var vectorFilePosX:Float;
  private var pmsColor:Int;
  private var foilColor:String;
  private var focus:Bool;
  private var collition:Bool;
  private var alertBox:Sprite;
  private var foiled:Bool;
  private var foil:Sprite;
  private var foilTexture:Bitmap;
  private var silverFoilTexture:Bitmap;
  private var goldFoilTexture:Bitmap;
  private var yellowFoilTexture:Bitmap;
  private var redFoilTexture:Bitmap;
  private var greenFoilTexture:Bitmap;
  private var blueFoilTexture:Bitmap;
  private var foilTextureOverlay:Bitmap;
  private var foilShadow:Sprite;
  private var foilShine:Sprite;
  private var foilBitmapDataForOverlay:BitmapData;
  private var bitmap:Bitmap;
  private var colorTransform:ColorTransform;
  private var default_colorTransform:ColorTransform;
  private var printType:String;
  private var sizeX:Float;
  private var sizeY:Float;
  //private var selectBox:SelectBox;
  private var widthHeightRatio:Float;
  private var canResize:Bool;

 
  public function new(pageView:PageView, id:Int, model:IModel, url:String, canResize:Bool){	
    
    super(pageView, id, model, url);
    this.pageView                     = pageView;
    this.id                           = id;
    this.model                        = model;
    this.modelId                      = model.getInt('pageId');
    this.canResize                    = canResize;
    vectorFilePosX                    = 0;
    mouseOver                         = false;
    focus                             = false;
    addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    GLOBAL.Application.addEventListener(EVENT_ID.DESKTOP_VIEW_MOVE, onDesktopViewMove);
    
    //addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
    //addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
    
    collition                         = false;    
    this.url = url;
    foil = new Sprite();
    silverFoilTexture                 = new SilverFoilTexture();
    goldFoilTexture                   = new GoldFoilTexture();
    yellowFoilTexture                 = new YellowFoilTexture();
    redFoilTexture                    = new RedFoilTexture();
    greenFoilTexture                  = new GreenFoilTexture();
    blueFoilTexture                   = new BlueFoilTexture();
    foilTexture = silverFoilTexture;
    
    foilShadow                        = new Sprite();
    foilShadow.graphics.beginFill(0x494949);
    foilShadow.alpha                  = 0.0;
    foilShadow.graphics.drawRect(0,0,1024,1017);
    foilShadow.graphics.endFill();
    
    foilShine                         = new Sprite();
    foilShine.graphics.beginFill(0xFFFFFF);
    foilShine.alpha                   = 0.0;
    foilShine.graphics.drawRect(0,0,1024,1017);
    foilShine.graphics.endFill();

    foilColor                         = GLOBAL.foilColor;
    pmsColor                          = GLOBAL.stdPmsColor;
    printType                         = GLOBAL.printType;
    sizeX                             = 0;
    sizeY                             = 0;
    canResize                         = false;
  }
    
  override public function getBitmapMask():Bitmap {
    return bitmap;
  }
  
  private function generateFoilOverlay(color):Bitmap {
    if(foilBitmapDataForOverlay == null) {
      foilBitmapDataForOverlay = foilTexture.bitmapData.clone();

      //Now we have the bitmapData we can make it grayscale.
      //First lock the data so it shows no changes while we are doing the changes.
      foilBitmapDataForOverlay.lock();
      //We now copy the red channel to the blue and the green channel.
      foilBitmapDataForOverlay.copyChannel(foilBitmapDataForOverlay,foilBitmapDataForOverlay.rect,new Point(),BitmapDataChannel.RED,BitmapDataChannel.BLUE);
      foilBitmapDataForOverlay.copyChannel(foilBitmapDataForOverlay,foilBitmapDataForOverlay.rect,new Point(),BitmapDataChannel.RED,BitmapDataChannel.GREEN);
      //After the change we can unlock the bitmapData.
      foilBitmapDataForOverlay.unlock();
    }
    
    
    var overlayBitmapData:BitmapData = new BitmapData(foilBitmapDataForOverlay.width,foilBitmapDataForOverlay.height,false, color);
    
    //Create the overlay with the color set in the private var fillColor
    foilTextureOverlay = new Bitmap(overlayBitmapData);
    //Set the blendMode to darken so it will will be just like the picture in the post.
    foilTextureOverlay.blendMode = BlendMode.DARKEN;
    
    return foilTextureOverlay;
  }
  
  public function color(_color:UInt):Void {
    pmsColor = _color;
    colorTransform = vectorMovie.transform.colorTransform;
    colorTransform.color = _color;
    vectorMovie.transform.colorTransform = colorTransform;
  }
  
  public function uncolor():Void{
    vectorMovie.transform.colorTransform = default_colorTransform;
  }
  
  public function isFoiled():Bool {
    return foiled == true;
  }
  
  public function foilify(color:String):Void {
    unfoilify();
    uncolor();
    foilColor = color;
    //foilTextureOverlay = generateFoilOverlay(color);
    
    //default
    //foilTexture = silverFoilTexture;
      var foilShineColor = 0xFFFFFF;
      var foilShadowColor = 0x000000;
      
      switch ( foilColor )
      {
        case 'silver':
          foilTexture = silverFoilTexture;
        case 'gold': 
          foilTexture = goldFoilTexture;
          foilShadowColor = 0x882244;
          foilShineColor = 0xf1e2be;
        case 'Yellow':
          foilTexture = yellowFoilTexture;
          foilShineColor = 0xFFFFEE;
          foilShadowColor = 0xb3a800;
        case 'red': 
          foilTexture = redFoilTexture;
          foilShadowColor = 0x110000;
          foilShineColor = 0xFF9090;
        case 'green':
          foilTexture = greenFoilTexture;
          foilShadowColor = 0x006400;
          foilShineColor = 0xEEFFEE;
        case 'blue':
          foilTexture = blueFoilTexture; 
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
      
      resizeBackdrop();
    
    
    foil.addChild(foilTexture);
    foil.addChild(foilShadow);
    foil.addChild(foilShine);
    //foil.addChild(foilTextureOverlay);
    addChild(foil);
    
    foil.mask = vectorMovie;
    Foil.initFiltersOn(foil);
    foiled = true;
  }
  
  public function unfoilify():Void {
    if( this.isFoiled() ){
      removeChild(foil);
      foil.removeChild(foilTexture);
      foil.removeChild(foilShadow);
      foil.removeChild(foilShine);
      //foil.removeChild(foilTextureOverlay);
      //foilTextureOverlay = null;
      foil.mask = null;
      Foil.removeFiltersFrom(foil);
      foiled = false;
    }
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

  private function onAddedToStage(e:Event){
    loadVectorFile();
    model.addEventListener(EVENT_ID.GET_PAGE_XML+Std.string(modelId), onGetXml);
    addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
    GLOBAL.Pages.calculatePrice();
  }
   
  private function handleKeyboard(b:Bool):Void{
    if( b){
      stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPressed);
      stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
    }
    else{
      stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyPressed);
      stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
    }
  }
  
  override public function getXml() : String {
   
    var str:String = '\n\t\t<placeholder id=\"'+ Std.string(id) +'\">\n';
    str += '\t\t\t<placeholder-type>' + 'vector_placeholder' + '</placeholder-type>\n';
    str += '\t\t\t<resizable>' + Std.string(canResize) + '</resizable>\n';
    str += '\t\t\t<pos-x>' + Std.string(x) + '</pos-x>\n';
    str += '\t\t\t<pos-y>' + Std.string(y) + '</pos-y>\n';
    str += '\t\t\t<size-x>' + Std.string(sizeX) + '</size-x>\n';
    str += '\t\t\t<size-y>' + Std.string(sizeY) + '</size-y>\n';
    str += '\t\t\t<url>' + url + '</url>\n';
    str += '\t\t\t<print-type>' + printType + '</print-type>\n';
    str += '\t\t\t<foil-color>' + foilColor + '</foil-color>\n';
    str += '\t\t\t<pms-color>' + Std.string(pmsColor) + '</pms-color>\n';
    str += '\t\t</placeholder>\n';
    return str;
  }
  
  private function onKeyPressed(event:KeyboardEvent):Void{
    var step:Float = 150/72;
    switch(event.keyCode){
      case 37: this.x -=step; 
      case 39: this.x +=step; 
      case 38: this.y -=step; 
      case 40: this.y +=step;
    }
  }
  
  private function onKeyUp(event:KeyboardEvent):Void{
    pageView.hitTest();
  }
  
  private function loadVectorFile():Void{
    var ldr:Loader                = new Loader(); 
    var req:URLRequest            = new URLRequest(url); 
    var ldrContext:LoaderContext  = new LoaderContext(); 
    ldrContext.applicationDomain  = new ApplicationDomain();
    ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, onVectorFileLoaded); 
    ldr.load(req, ldrContext);
  }
  
  private function onVectorFileLoaded(event:Event):Void { 
    vectorMovie =  cast event.target.loader.content;
    var scale:Float = 0.25;
    addChild(vectorMovie);
    
    default_colorTransform = vectorMovie.transform.colorTransform;
    vectorMovie.width *= scale;
    vectorMovie.height *= scale;
    
    widthHeightRatio = vectorMovie.width/vectorMovie.height;
    
    
    var bitmapScale:Float = 72/150 * scale;
    var bounds = vectorMovie.getBounds(vectorMovie);
    var bitmapInfo:BitmapData = new BitmapData(Std.int(bounds.width*bitmapScale+0.5), Std.int(bounds.height*bitmapScale+0.5), true, 0x00000000);
    var matrix:Matrix = new Matrix();
    matrix.scale(bitmapScale, bitmapScale);
    
    bitmapInfo.draw(vectorMovie, matrix, null, null, null, true);
    bitmap = new Bitmap(bitmapInfo);

    
    var param:IParameter = new Parameter(EVENT_ID.SWF_LOADED);
    param.setInt(id);
    model.setParam(param);

    //if(selectBox == null) {
    //   selectBox   =   new SelectBox(pageView, this, canResize); 
    //   addChild(selectBox);
    //   
    //}
//    this.setChildIndex(selectBox, this.numChildren - 1);
    resizeBackdrop();
    switch ( printType ){
      case CONST.STD_PMS_COLOR, 'std_pms_color':{
        unfoilify();
        updateColor(stdPmsColor);
      }
      case CONST.CUSTOM_PMS1_COLOR:{
        unfoilify();
        updateColor(pms1Color);
      }
      case CONST.CUSTOM_PMS2_COLOR:{
        unfoilify();
        updateColor(pms2Color);
      }
      case CONST.FOIL_COLOR:{
        foilify(foilColor);
      }
    }
    
    GLOBAL.Pages.calculatePrice();
    if(sizeX != -1){
      setSize(sizeX, sizeY);
    }
    
//    this.setChildIndex(selectBox, this.numChildren - 1);
  }
  
  public function resizeBackdrop():Void {
    foilTexture.width   = this.width;
    foilTexture.height  = this.height;
    foilShadow.width    = this.width;
    foilShadow.height   = this.height;
    foilShine.width     = this.width;
    foilShine.height    = this.height;
    
//    selectBox.resizeBackdrop(vectorMovie.width, vectorMovie.height, 0, 0);
  }
  
  override public function setSize(sizeX:Float, sizeY:Float):Void{

    if(vectorMovie != null){
      vectorMovie.width     = sizeX;
      vectorMovie.height    = sizeY;
      resizeBackdrop();
    }
    this.sizeX              = sizeX;
    this.sizeY              = sizeY;
  }
  
  private function hitTest():Void{
    pageView.hitTest();
  }    
    
  override public function onUpdatePlaceholder(event:Event):Void{    
    
    printType = GLOBAL.printType;
    
    switch ( GLOBAL.printType ){
      case CONST.STD_PMS_COLOR:{
        unfoilify();
        color(GLOBAL.stdPmsColor);
      }
      case CONST.FOIL_COLOR:{
        foilify(GLOBAL.foilColor);
      }
    }
//    this.setChildIndex(selectBox, this.numChildren - 1);
    GLOBAL.Pages.calculatePrice();
  }
  
  override public function setFocus(b:Bool):Void{
    focus = b;
    updateFocus();
//    this.setChildIndex(selectBox, this.numChildren - 1);
  }

  private function updateFocus():Void{
    
    if(focus){
      GLOBAL.Pages.addEventListener(EVENT_ID.MOVE_TOOL, onMoveTool);
//      selectBox.setFocus(true);  
      resizeBackdrop();
    }else{
      GLOBAL.Pages.removeEventListener(EVENT_ID.MOVE_TOOL, onMoveTool);
//      selectBox.setFocus(false);  
    }
    handleKeyboard( focus ); 
    GLOBAL.Application.dispatchParameter(new Parameter(EVENT_ID.RESET_STAGE_SIZE));   
  }
  
  private function onMoveTool(e:IKEvent):Void {
    updateFocus();
  }

  private function updateSideView(): Void{
    var param:IParameter = new Parameter(EVENT_ID.UPDATE_SIDE_VIEWS);
    param.setString(getPlaceholderType());
    GLOBAL.Application.dispatchParameter(param);
  }
  
  private function onGetXml(event:Event):Void{
    model.setString(EVENT_ID.SET_PAGE_XML, getXml());
  }
  
  private function onRemovedFromStage(e:Event){
    GLOBAL.Pages.calculatePrice();
    removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
  	model.removeEventListener(EVENT_ID.GET_PAGE_XML+Std.string(modelId), onGetXml);
  }
  
  override public function getStdPmsColor():String {
    return Std.string(pmsColor);
  }
  
  override public function getPms1Color():String {
    return 'pms1Color';
  }
  
  override public function getPms2Color():String {
    return 'pms2Color';
  }
  
  override public function getFoilColor():String {
    return foilColor;
  }
  
  override public function getPrintType():String {
    return printType;
  }
  
  override public function getPlaceholderType():String{
    return 'vector_placeholder';
  }
  
  public function updateGlobals(){
    updateSideView();    
  }

  override public function alert(b:Bool):Void{
//    selectBox.alert(b);//alertBox.visible = b;
  }
  
  public function getWidthHeightRatio():Float{
    return widthHeightRatio;
  }
  
  //override public function canResize(b:Bool):Void{
  //  selectBox.canResize(true);
  //}
  
}
