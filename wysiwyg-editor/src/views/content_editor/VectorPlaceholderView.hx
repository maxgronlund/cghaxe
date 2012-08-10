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
  //private var vectorFile:Dynamic;
  private var pageView:PageView;
  private var model:IModel;
  private var mouseOver:Bool;
  private var id:Int;
  private var modelId:Int;
  private var xml:String;
  private var vectorFileFileName:String;
  private var vectorFileScreenName:String;
//  private var textWithTags:String;
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
  private var foilBitmapDataForOverlay:BitmapData;
  private var backdrop:Sprite;
  private var lines:Vector<Shape>;
  private var bitmap:Bitmap;
  private var colorTransform:ColorTransform;
  private var default_colorTransform:ColorTransform;
  private var selectBox:SelectBox;
  private var printType:String;
 
  public function new(pageView:PageView, id:Int, model:IModel, url:String){	
    
    super(pageView, id, model, url);
    this.pageView                      = pageView;
    this.id                           = id;
    this.model                        = model;
    this.modelId                      = model.getInt('pageId');
    vectorFilePosX                          = 0;
    mouseOver                         = false;
    focus                             = false;
    addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
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
    
    lines                             = new Vector<Shape>();
    foilColor                         = GLOBAL.foilColor;
    pmsColor                          = GLOBAL.stdPmsColor;
    printType                         = GLOBAL.printType;
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
    
    switch ( color )
    {
      case 'silver':
        foilTexture = silverFoilTexture;
      case 'gold': 
        foilTexture = goldFoilTexture;
      case 'Yellow':
        foilTexture = yellowFoilTexture;
      case 'red': 
        foilTexture = redFoilTexture;
      case 'green':
        foilTexture = greenFoilTexture;
      case 'blue':
        foilTexture = blueFoilTexture; 
    }
    
    
    foil.addChild(foilTexture);
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
      //foil.removeChild(foilTextureOverlay);
      //foilTextureOverlay = null;
      foil.mask = null;
      Foil.removeFiltersFrom(foil);
      foiled = false;
    }
  }

  private function onAddedToStage(e:Event){
    loadVectorFile();
    model.addEventListener(EVENT_ID.GET_PAGE_XML+Std.string(modelId), onGetXml);
    addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
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
    trace('getXml');
    var str:String = '\n\t\t<placeholder id=\"'+ Std.string(id) +'\">\n';
      
      str += '\t\t\t<placeholder-type>' + 'vector_placeholder' + '</placeholder-type>\n';
      str += '\t\t\t<pos-x>' + Std.string(x) + '</pos-x>\n';
      str += '\t\t\t<pos-y>' + Std.string(y) + '</pos-y>\n';
      str += '\t\t\t<url>' + url + '</url>\n';
      str += '\t\t\t<print-type>' + printType + '</print-type>\n';
      str += '\t\t\t<foil-color>' + foilColor + '</foil-color>\n';
      str += '\t\t\t<pms-color>' + Std.string(pmsColor) + '</pms-color>\n';
    //  str += '\t\t\t<vectorFile-color>' + Std.string(vectorFileColor) + '</vectorFile-color>\n';
    //  str += '\t\t\t<line-space>' + Std.string(vectorFileLeading) + '</line-space>\n';
    //  str += '\t\t\t<vectorFile-size>' + Std.string(vectorFileSize) + '</vectorFile-size>\n';
    //  str += '\t\t\t<vectorFile-align>' + vectorFileAlign + '</vectorFile-align>\n';
    //  str += '\t\t\t<anchor-point>' + Std.string(calculateAnchorPoint()) + '</anchor-point>\n';
    //  str += vectorFile.getXml();
      str += '\t\t</placeholder>\n';
    
    //trace('\n---------- getXml ----------------\n', str);

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
    trace('loadVectorFile');
    var ldr:Loader                = new Loader(); 
    var req:URLRequest            = new URLRequest(url); 
    var ldrContext:LoaderContext  = new LoaderContext(); 
    ldrContext.applicationDomain  = new ApplicationDomain();
    ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, onVectorFileLoaded); 
    ldr.load(req, ldrContext);
  }
  
  private function onVectorFileLoaded(event:Event):Void { 
    trace('onVectorFileLoaded');
    vectorMovie =  cast event.target.loader.content;
    var scale:Float = 0.25;
    addChild(vectorMovie);
    
    default_colorTransform = vectorMovie.transform.colorTransform;
    vectorMovie.width *= scale;
    vectorMovie.height *= scale;
    
    
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

    //setFocus(false);
    if(selectBox == null) {
       selectBox   =   new SelectBox(pageView, this); 
       addChild(selectBox);
    }
    resizeBackdrop();
    
    switch ( printType ){
      case CONST.STD_PMS_COLOR:{
        unfoilify();
        color(pmsColor);
      }
      case CONST.FOIL_COLOR:{
        foilify(foilColor);
      }
    }
  }
  
  public function resizeBackdrop():Void {
    selectBox.resizeBackdrop(vectorMovie.width, vectorMovie.height, 0, 0);
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
  }
  
  override public function setFocus(b:Bool):Void{
    focus = b;
    updateFocus();
  }

  private function updateFocus():Void{
    
    if(focus){
      GLOBAL.Pages.addEventListener(EVENT_ID.MOVE_TOOL, onMoveTool);
//     GLOBAL.Pages.addEventListener(EVENT_ID.TEXT_TOOL, onTextTool);
//      vectorFile.selectable(!GLOBAL.MOVE_TOOL);
//      !GLOBAL.MOVE_TOOL ? showTags():hideTags();
      //vectorFile.setFocus(true);
      selectBox.setFocus(true);  
      resizeBackdrop();
    }else{
      GLOBAL.Pages.removeEventListener(EVENT_ID.MOVE_TOOL, onMoveTool);
//      if(!collition)
        //vectorFile.setFocus(false);
//      super.resetMouse();
      selectBox.setFocus(false);  
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
    removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
  	model.removeEventListener(EVENT_ID.GET_PAGE_XML+Std.string(modelId), onGetXml);
  }
  
  override public function getPlaceholderType():String{
    return 'vector_placeholder';
  }
  
  public function updateGlobals(){
    updateSideView();    
  }

  override public function alert(b:Bool):Void{
    selectBox.alert(b);//alertBox.visible = b;
  }
}
