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

  private var focus:Bool;
  private var collition:Bool;
  private var alertBox:Sprite;
  private var foiled:Bool;
  private var foil:Sprite;
  private var foilTexture:Bitmap;
  private var foilTextureOverlay:Bitmap;
  private var foilBitmapDataForOverlay:BitmapData;
  private var backdrop:Sprite;
  private var lines:Vector<Shape>;
  
  private var bitmap:Bitmap;
  private var colorTransform:ColorTransform;
  private var default_colorTransform:ColorTransform;
  
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
    foilTexture                       = new FoilTexture();
    lines                             = new Vector<Shape>();
    
    trace('new');

  }
  
  override public function getBitmapMask():Bitmap {
    return bitmap;
  }
  
  private function updateBackdrop(c:UInt):Void{
    if(backdrop != null){
      removeChild(backdrop);
      backdrop = null;
    }
      
    var scale:Float = 150/72;
    backdrop = new Sprite();
    addChild(backdrop);
    backdrop.graphics.lineStyle(1/scale,c);
    backdrop.graphics.beginFill(0xffffff);
    backdrop.graphics.drawRect(0,0,100,100);
    backdrop.graphics.endFill();
    backdrop.alpha = 0.5;
    //backdrop.x = 100 * scale;
  }
  
  private function createLines():Void{
    // left
    createLine(new Point(-10,0), new Point(0,0));
    createLine(new Point(-10,0), new Point(0,0));
    createLine(new Point(-10,0), new Point(0,0));
                                    
    // bottom side                  
    createLine(new Point(0,0), new Point(0,10));
    createLine(new Point(0,0), new Point(0,10));
    createLine(new Point(0,0), new Point(0,10));
                                                
    // right side                               
    createLine(new Point(0,0), new Point(10,0));
    createLine(new Point(0,0), new Point(10,0));
    createLine(new Point(0,0), new Point(10,0));
                                    
    // top side                     
    createLine(new Point(0,0), new Point(0,-10));
    createLine(new Point(0,0), new Point(0,-10));
    createLine(new Point(0,0), new Point(0,-10));

    
  }
  
  
  private function createLine(start:Point, end:Point):Void{
    var line:Shape = new Shape();
    line.graphics.lineStyle(1, 0x000000, 1);
    line.graphics.moveTo(start.x , start.y); 
    line.graphics.lineTo(end.x, end.y);
    addChild(line);
    lines.push(line);
  }
  
  private function drawCuttingMarks():Void{
    // left 
    drawVertical( 0, backdrop.x);
    // bottom
    drawHorizontal( 3, backdrop.height);
    // right
    drawVertical( 6, backdrop.x+backdrop.width );
    // top
    drawHorizontal( 9, 0);
  }
  
  private function drawHorizontal(offset:UInt, posY:Float):Void{
    
    lines[offset].x    = backdrop.x;
    lines[offset+1].x  = backdrop.x + (backdrop.width/2);
    lines[offset+2].x  = backdrop.x + backdrop.width;
    
    lines[offset].y    = posY;
    lines[offset+1].y  = posY;
    lines[offset+2].y  = posY;
  }
  
  private function drawVertical(offset:UInt, posX:Float):Void{
     
     lines[offset].x    = posX;
     lines[offset+1].x  = posX;
     lines[offset+2].x  = posX;
 
     lines[offset].y    = 0;
     lines[offset+1].y  = backdrop.height/2;
     lines[offset+2].y  = backdrop.height;
  }
  
  private function createAlertBox():Void{
    
    alertBox = new Sprite();
    alertBox.graphics.lineStyle(72/150,0xff0000);
    alertBox.graphics.beginFill(0xff8888);
    alertBox.graphics.drawRect(0,0,100,100);
    alertBox.graphics.endFill();
    alertBox.visible = false;
    alertBox.width        = vectorMovie.width;
    alertBox.height       = vectorMovie.height;
    addChild(alertBox);
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
  
  public function color(color:Int):Void {
    colorTransform = vectorMovie.transform.colorTransform;
    colorTransform.color = color;
    vectorMovie.transform.colorTransform = colorTransform;
  }
  
  public function uncolor():Void{
    vectorMovie.transform.colorTransform = default_colorTransform;
  }
  
  public function isFoiled():Bool {
    return foiled == true;
  }
  
  public function foilify(color = 0xFFFFFF):Void {
    unfoilify();
    uncolor();
    foilTextureOverlay = generateFoilOverlay(color);
    
    foil.addChild(foilTexture);
    foil.addChild(foilTextureOverlay);
    addChild(foil);
    
    foil.mask = vectorMovie;
    Foil.initFiltersOn(foil);
    foiled = true;
  }
  
  public function unfoilify():Void {
    if( this.isFoiled() ){
      removeChild(foil);
      foil.removeChild(foilTexture);
      foil.removeChild(foilTextureOverlay);
      foilTextureOverlay = null;
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

    var str:String = '\n\t\t<placeholder id=\"'+ Std.string(id) +'\">\n';
      
      str += '\t\t\t<placeholder-type>' + 'vector_placeholder' + '</placeholder-type>\n';
      str += '\t\t\t<pos-x>' + Std.string(x) + '</pos-x>\n';
      str += '\t\t\t<pos-y>' + Std.string(y) + '</pos-y>\n';
      str += '\t\t\t<url>' + url + '</url>\n';
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
    trace(event.keyCode);
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
    
    var scale:Float = 0.5;
    
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
    
    trace("size_diffrence");
    trace(bitmap.width);
    trace(vectorMovie.width);
    
    updateBackdrop(0x888888);
    createLines();
    createAlertBox();
    
    //
    color(0xFF0000);
    //foilify(0x00FF00);
    
    backdrop.width = vectorMovie.width;
    backdrop.height = vectorMovie.height;
    drawCuttingMarks();
    
    var param:IParameter = new Parameter(EVENT_ID.SWF_LOADED);
    param.setInt(id);
    model.setParam(param);
    
    setFocus(false);
    

  }
  
  private function hitTest():Void{
    pageView.hitTest();
  }
  
  override public function onUpdatePlaceholder(event:Event):Void {
    foilify(GLOBAL.Font.fontColor);
    //storedAlign       = vectorFileAlign;
    ////vectorFile.setText(insertTags(textWithTags));
    //anchorPoint       = calculateAnchorPoint();
    //repossition       = true;
    //storeTags();
    //removeChild(vectorMovie);
    //vectorFile = null;
    //loadVectorFile();
    
    trace('update vectorView');
    
    
  }
  
  override public function setFocus(b:Bool):Void{
    
    focus = b;
    updateFocus();
    backdrop.alpha = b ? 0.5:0;
    for( i in 0...lines.length){
      lines[i].visible = b;
    } 
  }

  private function updateFocus():Void{
    
    if(focus){
      GLOBAL.Pages.addEventListener(EVENT_ID.MOVE_TOOL, onMoveTool);
//     GLOBAL.Pages.addEventListener(EVENT_ID.TEXT_TOOL, onTextTool);
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

  override private function onMouseOver(e:MouseEvent){
    mouseOver = true;
    super.onMouseOver(e);
  }

  override private function onMouseDown(e:MouseEvent){
    
    MouseTrap.capture();
    super.onMouseDown(e);
    pageView.setPlaceholderInFocus(this);
    
    if(GLOBAL.MOVE_TOOL) pageView.enableMove(e);
    
    updateSideView();
  }
  
  //!!! move this to super class
  private function updateSideView(): Void{
    var param:IParameter = new Parameter(EVENT_ID.UPDATE_SIDE_VIEWS);
    param.setString(getPlaceholderType());
    GLOBAL.Application.dispatchParameter(param);
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
    return 'vector_placeholder';
  }
  
  override public function alert(b:Bool):Void{
      alertBox.visible = b;
  }
}
