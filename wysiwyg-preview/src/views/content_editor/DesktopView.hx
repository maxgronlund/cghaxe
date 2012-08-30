import flash.display.BitmapData;
import flash.display.Bitmap;
//import flash.geom.Point;
import flash.events.MouseEvent;
import flash.events.Event;

class DesktopView extends View, implements IView{
	
  private var pagesView:AView;
  private var hitPointX:Float;
  private var hitPointY:Float;
  
  private var sizeX:Float;
  private var sizeY:Float;
  
  private var goToPosX:Float;
  private var goToPosY:Float;
  
  // touch
  private var stepY:Float;
  private var moveLeft:Bool;
  private var zoom:Bool;
  private var zoomFactor:Float;
  
  private var zoomDone:Bool;
  private var alignDone:Bool;

  
  private var placeholders:Int;
  private var pageView:AView;

  
  public function new(desktopController:IController){	
  	super(desktopController);
  	pagesView = new PagesView(desktopController);
  	Application.addEventListener(EVENT_ID.ZOOM, onZoom);
    Preset.addEventListener(EVENT_ID.PLACEHOLDER_COUNT, onPlaceholderCount);
    Pages.addEventListener(EVENT_ID.SWF_LOADED, onFontLoaded);
    Application.addEventListener(EVENT_ID.ALL_IMAGES_LOADED, onAllImagesLoaded);
    Application.addEventListener(EVENT_ID.RESET_STAGE_SIZE, onResetDesktopSize);
    addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
    addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
    Designs.addEventListener(EVENT_ID.LOAD_PAGE_POS_AND_ZOOM, onLoadPos);
    Preset.addEventListener(EVENT_ID.LOAD_PAGE_POS_AND_ZOOM, onLoadPos);
    Pages.addEventListener(EVENT_ID.PAGE_SELECTED, centerPage);
    bmpData    = new BitmapData(SIZE.DESKTOP_WIDTH,SIZE.DESKTOP_HEIGHT,false, COLOR.DESKTOP );
    backdrop   = new Bitmap(bmpData);
    
  }
  
  private function centerPage(e:KEvent):Void{
    
    zoomDone  = false;
    alignDone = false;
    //pageIndex = e.getInt();
    pageView  = pagesView.getView(e.getInt());
    zoom      = true;
    zoomFactor  = 1.05;
    updateGoTo();
    
    addEventListener(Event.ENTER_FRAME, OnAllignAndZoom);
  }
  
  private function updateGoTo():Void{
    
    goToPosX = -(pageView.x * Zoom.getZoomFactor());
    goToPosY = -(pageView.y * Zoom.getZoomFactor());
    
    //goToPosY  += ( SIZE.DESKTOP_HEIGHT - (pageView.height* Zoom.getZoomFactor())) * 0.5;
    //goToPosY += 50;
    moveLeft =  goToPosX - this.x > 0;
    
    if(zoom){
      var desktopSize:Float = SIZE.DESKTOP_WIDTH*SIZE.DESKTOP_HEIGHT*0.9 - 40;
      var test:Float = Zoom.getZoomFactor() * pageView.width*pageView.height;
      test = test - desktopSize;
      test *= 0.4;
      test = (test / desktopSize)+1;
      test = 0.95/test;
  
      var zoomLimit = 1.01;
      if( zoomFactor < 1/zoomLimit || zoomFactor > zoomLimit){
        zoomFactor = test;
      }
      else {
        zoom = false;
        zoomFactor = 1;
        zoomDone = true;
      } 
    }                           
  }
  
  private function OnAllignAndZoom(e:Event):Void{
     
    onAlignLeft();
    Zoom.zoomTo(zoomFactor);
  
   }
   
  public function onAlignLeft():Void
	{
    var distanceX:Float = goToPosX - this.x;
    var distanceY:Float = goToPosY - this.y;
    
	  if(moveLeft && this.x > goToPosX-1 || !moveLeft && this.x < goToPosX+1){
	    alignDone = true;
	  }
	  else{
	    this.x += (distanceX * 0.3);
  	  this.y += (distanceY * 0.3);
	  }
	  testForDone();
	  
  }
  
  private function testForDone(): Void
  {
    if(alignDone && zoomDone)
      removeEventListener(Event.ENTER_FRAME, OnAllignAndZoom);
    else
      updateGoTo();
  }
  
  private function canterPageDone():Void{
    if(zoomDone && alignDone)
      removeEventListener(Event.ENTER_FRAME, OnAllignAndZoom);
  }
  
   
  private function onResetDesktopSize(e:KEvent):Void{
    sizeX = pagesView.width/Zoom.getZoomFactor();
    sizeY = pagesView.height/Zoom.getZoomFactor();
    //trace(sizeX);
  }
  
  override public function init():Void{
  	pagesView.init();
  	this.visible = false;
  	placeholders = 0;
  }
  
  override public function onAddedToStage(e:Event){
  	super.onAddedToStage(e);
  	addChild(backdrop);
  	addChild(pagesView);
  	pagesView.x = 10;
  	pagesView.y = 10;
//  	trace('bamm');
    //addChild(new FoilTexture());
    //addChild(GLOBAL.foil);
  }
  
  private function onLoadPos(e:KEvent):Void{
    for( pos_x in e.getXml().elementsNamed('pos_x') )
      this.x = Std.parseInt(pos_x.firstChild().nodeValue.toString());
    
    for( pos_y in e.getXml().elementsNamed('pos_y') )
      this.y = Std.parseInt(pos_y.firstChild().nodeValue.toString());
      
    GLOBAL.pos_x = this.x;
    GLOBAL.pos_y = this.y;
  }
  
  override public function setParam(param:IParameter):Void{
    switch ( param.getLabel() ){
      case EVENT_ID.ZOOM_100:{
        this.x = 8;
        this.y = 48;
      }
    }
  }  
  
  private function onPlaceholderCount(e:KEvent):Void{
    placeholders = e.getInt();
//    trace(placeholders);
  }
  
  private function onFontLoaded(e:KEvent):Void{
    
    sizeX = pagesView.width/Zoom.getZoomFactor();
    sizeY = pagesView.height/Zoom.getZoomFactor();
    
    placeholders--;
    if(placeholders == 0) 
      setSizes();
  }
  
  private function onAllImagesLoaded(e:KEvent):Void{
//    trace('onAllImagesLoaded');
    if(placeholders == 0) {
      placeholders--;
      setSizes();       
    }
  }
  
  private function setSizes():Void{
    
//    trace('setSizes');
    
    sizeX = pagesView.width;
    sizeY = pagesView.height;
    
    updateZoom();
    this.visible = true;
  }
  
  private function onZoom(e:Event):Void{
    updateZoom();
  }
  
  private function updateZoom():Void{
//    trace('updateZoom');
    pagesView.width 	= sizeX * Zoom.getZoomFactor();
    pagesView.height 	= sizeY * Zoom.getZoomFactor();
    //backdrop.x = -this.x;
    //backdrop.y = -this.y;
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
      removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
      hitPointX = e.stageX - this.x;
      hitPointY = e.stageY - this.y;
      stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
      stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
      Application.dispatchParameter(new Parameter(EVENT_ID.DESELECT_PLACEHOLDERS));
    }
  }
  
  override public function getPosX():Float{
		return this.x;
	}
	
	override public function getPosY():Float{
    return this.y;
	}
  
  private function onMouseUp(e:MouseEvent){	
    backdrop.x = -this.x;
    backdrop.y = -this.y;
  	MouseTrap.release();
  	stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
  	stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
  	addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
  }
  
  private function onMouseMove(e:MouseEvent){
    var endPosX:Float = ( e.stageX - hitPointX);
    var endPosY:Float = ( e.stageY - hitPointY);
    this.x = endPosX;
    this.y = endPosY;
    GLOBAL.pos_x = x;
    GLOBAL.pos_y = y;
  }
}