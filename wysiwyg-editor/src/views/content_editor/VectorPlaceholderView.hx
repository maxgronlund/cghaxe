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
//import flash.display.BitmapData;
//import flash.display.Bitmap;

import flash.events.Event;
import flash.events.KeyboardEvent;

import flash.display.Shape;
import flash.Vector;


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

  private var focus:Bool;
  private var collition:Bool;
  private var foiled:Bool;
  private var foilTexture:DisplayObject;
  
  public function new(pageView:PageView, id:Int, model:IModel, url:String){	
    
    super(pageView, id, model, url);
    this.pageView                      = pageView;
    this.id                           = id;
    this.model                        = model;
    this.modelId                      = model.getInt('pageId');
    //designMode                        = GLOBAL.edit_mode == 'system_design';
//    textWithTags                      = text;
    this.alpha                        = 0.85;
    vectorFilePosX                          = 0;
    mouseOver                         = false;
//    anchorPoint                       = GLOBAL.Font.anchorPoint;
    GLOBAL.Font.anchorPoint           = 0;
//    previewMode                       = true;
    focus                             = false;
//    tagsIsVisible                     = false;
    addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    collition                         = false;
    
    this.url = url;
    foilTexture = new FoilTexture();
  }
  
  
  public function isFoiled():Bool {
    return foiled == true;
  }
  
  public function foilify():Void {
    if( !this.isFoiled() ){
      addChild(foilTexture);
      foilTexture.mask = vectorMovie;
      Foil.initFiltersOn(this);
      foiled = true;
    }
  }
  
  public function unfoilify():Void {
    if( this.isFoiled() ){
      //addChild(vectorMovie);
      foilTexture.mask = null;
      removeChild(foilTexture);
      Foil.removeFiltersFrom(this);
      foiled = false;
    }
  }
  
  
  private function onAddedToStage(e:Event){
    /*
    model.addEventListener(EVENT_ID.GET_PAGE_XML+Std.string(modelId), onGetXml);
    addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);    
    */
    //imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadImageComplete);
    //imageLoader.load(new URLRequest(imageUrl));
    
    loadVectorFile();
    
    
    //model.addEventListener(EVENT_ID.GET_PAGE_XML+Std.string(modelId), onGetXml);
    addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
  }
   
  private function handleKeyboard(b:Bool):Void{
    
    if( b && GLOBAL.MOVE_TOOL){
      stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPressed);
      stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
    }
    else{
      stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyPressed);
      stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
    }
  }
  
  override public function getXml() : String {
    
    //showTags();
    //
    //var str:String = '\t\t<placeholder id=\"'+ Std.string(id) +'\">\n';
    //  str += '\t\t\t<pos-x>' + Std.string(x) + '</pos-x>\n';
    //  str += '\t\t\t<pos-y>' + Std.string(y) + '</pos-y>\n';
    //  str += '\t\t\t<vectorFile-file-name>' + vectorFileFileName + '</vectorFile-file-name>\n';
    //  str += '\t\t\t<vectorFile-color>' + Std.string(vectorFileColor) + '</vectorFile-color>\n';
    //  str += '\t\t\t<line-space>' + Std.string(vectorFileLeading) + '</line-space>\n';
    //  str += '\t\t\t<vectorFile-size>' + Std.string(vectorFileSize) + '</vectorFile-size>\n';
    //  str += '\t\t\t<vectorFile-align>' + vectorFileAlign + '</vectorFile-align>\n';
    //  str += '\t\t\t<anchor-point>' + Std.string(getAnchorPoint()) + '</anchor-point>\n';
    //  str += vectorFile.getXml();
    //str += '\t\t</placeholder>\n';
//  //  trace(str);
    //restoreShowTags();
    return "str";
  }
  
  private function onKeyPressed(event:KeyboardEvent):Void{
    var step:Float = 150/72;
    //trace(event.keyCode);
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
    
    addChild(vectorMovie);
    vectorMovie.width *= 0.25;
    vectorMovie.height *= 0.25;
    
    //this.foilify();

  }
  
  private function hitTest():Void{
    pageView.hitTest();
  }
  
  //override public function onUpdatePlaceholder(event:Event):Void{
  //
  //  storedAlign       = vectorFileAlign;
  //  //vectorFile.setText(insertTags(textWithTags));
  //  anchorPoint       = getAnchorPoint();
  //  repossition       = true;
  //  storeTags();
  //  removeChild(vectorMovie);
  //  vectorFile = null;
  //  loadVectorFile();
  //}
  
  override public function setFocus(b:Bool):Void{
    focus = b;
    updateFocus();
  }

  //private function buildUrl(fileName:String):String{
  //	return "/assets/" + fileName+ ".swf?" + Math.random();
  //}

  private function updateFocus():Void{
    
    if(focus){
      GLOBAL.Pages.addEventListener(EVENT_ID.MOVE_TOOL, onMoveTool);
      GLOBAL.Pages.addEventListener(EVENT_ID.TEXT_TOOL, onTextTool);
//      vectorFile.selectable(!GLOBAL.MOVE_TOOL);
//      !GLOBAL.MOVE_TOOL ? showTags():hideTags();
      //vectorFile.setFocus(true);
    }else{
      GLOBAL.Pages.removeEventListener(EVENT_ID.MOVE_TOOL, onMoveTool);
      if(!collition)
        //vectorFile.setFocus(false);
      super.resetMouse();
    }
    handleKeyboard( focus ); 
    GLOBAL.Application.dispatchParameter(new Parameter(EVENT_ID.RESET_STAGE_SIZE));   
  }
  
  private function onMoveTool(e:IKEvent):Void {
    updateFocus();
  }
  
  private function onTextTool(e:IKEvent):Void {
    trace('onTextTool');
    updateFocus();
  }

  override private function onMouseOver(e:MouseEvent){
    mouseOver = true;
    super.onMouseOver(e);
  }

  override private function onMouseDown(e:MouseEvent){
//    trace('on mouse down');
    MouseTrap.capture();
    super.onMouseDown(e);

    pageView.setPlaceholderInFocus(this);
    //model.setParam(new Parameter(EVENT_ID.UPDATE_TEXT_TOOLS));
    if(GLOBAL.MOVE_TOOL) pageView.enableMove(e);
  }
  
  override private function onMouseOut(e:MouseEvent){
    mouseOver = false;
    removeEventListener(MouseEvent.ROLL_OUT, onMouseOut);
    addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
  }
  
  override private function onMouseUp(e:MouseEvent){
    
    MouseTrap.release();
    super.onMouseUp(e);
    pageView.disableMove();
    
    GLOBAL.Application.dispatchParameter(new Parameter(EVENT_ID.RESET_STAGE_SIZE));
    
  }

  private function onGetXml(event:Event):Void{
    
    model.setString(EVENT_ID.SET_PAGE_XML, getXml());
  }
  
  
  private function onRemovedFromStage(e:Event){
    trace('onRemovedFromStage');
    removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
  	model.removeEventListener(EVENT_ID.GET_PAGE_XML+Std.string(modelId), onGetXml);
  }
  
  override public function getPlaceholderType():String{
    return 'vectorPlaceHolder';
  }
  
//  override public function alert(b:Bool):Void{
//      collition = b;
//      vectorFile.alert(b);
//  }
}
