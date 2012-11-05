import flash.Vector;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.geom.Point;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.events.MouseEvent;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.display.Shape;
import flash.display.Loader;
import flash.display.BitmapDataChannel;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.display.BlendMode;
import flash.net.URLRequest;
import flash.system.ApplicationDomain; 
import flash.system.LoaderContext;
import flash.system.SecurityDomain;
import flash.geom.ColorTransform;

class BitmapPlaceholder extends APlaceholder{
	
  private var pageView:PageView;
  private var model:IModel;
  private var mouseOver:Bool;
  private var id:Int;
  private var modelId:Int;
  //private var xml:String;
  private var anchorPoint:Float;
  private var previewMode:Bool;
  private var designMode:Bool;
  private var focus:Bool;
  
  private var imageUrl:String;
  private var imageLoader:Loader;
  private var backdrop:Bitmap;
  private var printType:String;
  
  private var foilColor:String;
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
  
  private var colorTransform:ColorTransform;
  private var default_colorTransform:ColorTransform;
  //private var enableScaling:Bool;
  
  private var sizeX:Float;
  private var sizeY:Float;
//  private var bmpSizeX:Float;
//  private var bmpSizeY:Float;
  
  private var selectBox:Rectangle;
  private var widthHeightRatio:Float;
  private var resizeHandle:ResizeHandle;

  
  public function new(pageView:PageView, id:Int, model:IModel, imageUrl:String){	
    
    super(pageView, id, model, imageUrl);
    this.pageView                     = pageView;
    this.id                           = id;
    this.model                        = model;
    this.imageUrl                     = imageUrl;
    this.modelId                      = model.getInt('pageId');
    designMode                        = GLOBAL.edit_mode == 'system_design';
    //this.alpha                        = 0.85;
    mouseOver                         = false;
    previewMode                       = true;
    focus                             = false;
    imageLoader	                      = new Loader();
    addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    printType                         = GLOBAL.printType;
    
    addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
    addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
    
    foil = new Sprite();
    silverFoilTexture                 = new SilverFoilTexture();
    goldFoilTexture                   = new GoldFoilTexture();
    yellowFoilTexture                 = new YellowFoilTexture();
    redFoilTexture                    = new RedFoilTexture();
    greenFoilTexture                  = new GreenFoilTexture();
    blueFoilTexture                   = new BlueFoilTexture();
    foilTexture = silverFoilTexture;
    
    foilShadow = new Sprite();
    foilShadow.graphics.beginFill(0x494949);
    foilShadow.alpha = 0.0;
    foilShadow.graphics.drawRect(0,0,1024,1017);
    foilShadow.graphics.endFill();    
    
    foilShine = new Sprite();
    foilShine.graphics.beginFill(0xFFFFFF);
    foilShine.alpha = 0.0;
    foilShine.graphics.drawRect(0,0,1024,1017);
    foilShine.graphics.endFill();
    
    selectBox    = new Rectangle(0,0,0x888888);
    resizeHandle    = new ResizeHandle();
    sizeX = 0;
    sizeY = 0;
    
  }
  
  private function onMouseOver(e:MouseEvent):Void{
    removeEventListener(MouseEvent.ROLL_OVER, onMouseOver);
    addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
    addEventListener(MouseEvent.ROLL_OUT, onMouseOut);	
  }
  
  private function onMouseOut(e:MouseEvent){
    removeEventListener(MouseEvent.ROLL_OUT, onMouseOut);
    addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
    addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
    
  } 
    
  private function onMouseDown(e:MouseEvent){	
    removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
    stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
    stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);

    if(MouseTrap.capture()){
      if(this.mouseX > sizeX-41){
        if(this.mouseY > sizeY-41){
          startResize(e);
        } else {
          startDragging(e);
        }
      } else {
        startDragging(e);
      }
    } 
  }
  
  private function startResize(e:MouseEvent){
    pageView.setPlaceholderInFocus(this);
    pageView.enableResize(e);
    updateGlobals();
  }
  private function stopResize(e:MouseEvent){
    pageView.setPlaceholderInFocus(this);
    pageView.disableResize(e);
    updateGlobals();
    GLOBAL.Application.dispatchParameter(new Parameter(EVENT_ID.RESET_STAGE_SIZE));
  }
  private function startDragging(e:MouseEvent){
    pageView.setPlaceholderInFocus(this);
    pageView.enableMove(e);
    updateGlobals();
  }
  
  private function stopDragging(e:MouseEvent){
     MouseTrap.release();
     pageView.disableMove();
     GLOBAL.Application.dispatchParameter(new Parameter(EVENT_ID.RESET_STAGE_SIZE));
  }
  
  private function onMouseUp(e:MouseEvent){	
    stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
    stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		
    stopDragging(e);
    stopResize(e);
  }
  
  private function onMouseMove(e:MouseEvent){}
  
  private function onAddedToStage(e:Event){
    
    imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadImageComplete);
    imageLoader.load(new URLRequest(imageUrl));
    addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
    model.addEventListener(EVENT_ID.GET_PAGE_XML+Std.string(modelId), onGetXml);
    GLOBAL.Pages.calculatePrice();

  }
  
  private function onLoadImageComplete(e:Event):Void{
    imageLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoadImageComplete);
    backdrop = e.target.loader.content;
    
    backdrop.scaleX       *= 0.5;
    backdrop.scaleY       *= 0.5;

    addChild(backdrop);
    addChild(selectBox);
    addChild(resizeHandle);
    selectBox.visible     = false;
    resizeHandle.visible  = false;
    GLOBAL.Application.dispatchParameter(new Parameter(EVENT_ID.RESET_STAGE_SIZE));
    widthHeightRatio  = this.width/this.height;
    
    if(sizeX == -1){
      sizeX = this.width;
      sizeY = this.height;
    }
    setSize(sizeX, sizeY);
    var param:IParameter = new Parameter(EVENT_ID.PLACEHOLDER_LOADED);
    param.setInt(id);
    model.setParam(param);
	}
	
	override public function setSize(sizeX:Float, sizeY:Float):Void{
	  this.sizeX = sizeX;
    this.sizeY = sizeY;
	  if(backdrop != null){
      backdrop.width     = sizeX;
      backdrop.height    = sizeY;
      selectBox.setSize(sizeX, sizeY);
      resizeHandle.x    = sizeX - 32;
      resizeHandle.y    = sizeY - 32;
    }
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

  private function onGetXml(event:Event):Void{
    model.setString(EVENT_ID.SET_PAGE_XML, getXml());
  }
  
  override public function getXml() : String {
    
    var str:String = '\t\t<placeholder id=\"'+ Std.string(id) +'\">\n';
      str += '\t\t\t<placeholder-type>' + 'bitmap_place_holder' + '</placeholder-type>\n';
      str += '\t\t\t<print-type>' + printType + '</print-type>\n';
      str += '\t\t\t<pos-x>' + Std.string(x) + '</pos-x>\n';
      str += '\t\t\t<pos-y>' + Std.string(y) + '</pos-y>\n';
      str += '\t\t\t<size-x>' + Std.string(sizeX) + '</size-x>\n';
      str += '\t\t\t<size-y>' + Std.string(sizeY) + '</size-y>\n';
      str += '\t\t\t<url>' + imageUrl + '</url>\n';
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
    //!!! TO DO
    //pageView.hitTest();
  }
  
  public function resizeBackdrop():Void {
    //!!! TO DO
  }
  
  private function hitTest():Void{
    //!!! TO DO
    //pageView.hitTest();
  }
  
  override public function onUpdatePlaceholder(event:Event):Void{    
    
    printType = GLOBAL.printType;
    // TO DO
    switch ( GLOBAL.printType ){
      case CONST.STD_PMS_COLOR:{
        unfoilify();
        color(GLOBAL.stdPmsColor);
      }
      case CONST.FOIL_COLOR:{
        foilify(GLOBAL.foilColor);
      }
    }
    // HMM NOT A PROBLEM BUT DANGERUS, MAY CRASH 
    GLOBAL.Pages.calculatePrice();
  }
  
  override public function setFocus(b:Bool):Void{
    focus = b;
    selectBox.visible = b;
    resizeHandle.visible = b;
    updateFocus();
  }

  private function updateFocus():Void{
    
    if(focus){
      GLOBAL.Pages.addEventListener(EVENT_ID.MOVE_TOOL, onMoveTool);
    }else{
      GLOBAL.Pages.removeEventListener(EVENT_ID.MOVE_TOOL, onMoveTool);
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
  
  public function updateGlobals(){
    updateSideView();    
  }

  private function onRemovedFromStage(e:Event){
    removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
  	model.removeEventListener(EVENT_ID.GET_PAGE_XML+Std.string(modelId), onGetXml);
  }

  override public function getPlaceholderType():String{
    return 'bitmap_place_holder';
  }
  
  override public function getPms1Color():String{
    return 'foo';
  }
  
  override public function getPms2Color():String{
    return 'foo';
  }
  
  override public function getPrintType():String {
    return printType;
  }
  override public function getStdPmsColor():String {
    return Std.string(0);
  }
  
  public function color(_color:UInt):Void {
    colorTransform = backdrop.transform.colorTransform;
    colorTransform.color = _color;
    backdrop.transform.colorTransform = colorTransform;
  }
  
  public function uncolor():Void{
    backdrop.transform.colorTransform = default_colorTransform;
  }
  
  public function isFoiled():Bool {
    return foiled == true;
  }
  
  public function foilify(color:String):Void {
    unfoilify();
    foilColor = color;
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
    
    foilTexture.width *= 2;
    foilTexture.height *= 2;
    
    foil.addChild(foilTexture);
    foil.addChild(foilShadow);
    foil.addChild(foilShine);
    addChild(foil);
    
    
    foil.cacheAsBitmap = true;
    backdrop.cacheAsBitmap = true;  
    foil.mask = backdrop;
    Foil.initFiltersOn(foil);
    foiled = true;
  }
  
  public function unfoilify():Void {
    if( this.isFoiled() ){
      removeChild(foil);
      foil.removeChild(foilTexture);
      foil.removeChild(foilShadow);
      foil.removeChild(foilShine);
      foil.mask = null;
      Foil.removeFiltersFrom(foil);
      foiled = false;
    }
  }
  
  public function getWidthHeightRatio():Float{
    return widthHeightRatio;
  }
  
  override public function getFoilColor():String {
    return foilColor;
  }
  

}
