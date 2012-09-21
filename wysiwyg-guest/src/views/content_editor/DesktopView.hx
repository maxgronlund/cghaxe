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
  
  private var glimmer_foils_index:UInt;

  
  public function new(desktopController:IController){	
  	super(desktopController);
  	GLOBAL.foilEffect = 0.25;
  	pagesView = new PagesView(desktopController);
  	Application.addEventListener(EVENT_ID.ZOOM, onZoom);
    Preset.addEventListener(EVENT_ID.PLACEHOLDER_COUNT, onPlaceholderCount);
    Pages.addEventListener(EVENT_ID.SWF_LOADED, onFontLoaded);
    Application.addEventListener(EVENT_ID.ALL_IMAGES_LOADED, onAllImagesLoaded);
    Application.addEventListener(EVENT_ID.RESET_STAGE_SIZE, onResetDesktopSize);
    addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
    addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
    addEventListener(Event.ENTER_FRAME, onEnterFrame);
    Designs.addEventListener(EVENT_ID.LOAD_PAGE_POS_AND_ZOOM, onLoadPos);
    Preset.addEventListener(EVENT_ID.LOAD_PAGE_POS_AND_ZOOM, onLoadPos);
    //Pages.addEventListener(EVENT_ID.PAGE_SELECTED, centerPage);
    bmpData    = new BitmapData(SIZE.DESKTOP_WIDTH,SIZE.DESKTOP_HEIGHT,false, COLOR.DESKTOP );
    backdrop   = new Bitmap(bmpData);
    
    Application.addEventListener(EVENT_ID.CENTER_PAGE, centerPage);
    
  }
  
  
  
  
  private function centerPage(e:Event):Void{
    glimmerFoils();
    this.x = 0;
    this.y = 0;
    pagesView.setString('set_pages_to_top_left', 'foo');
    setSizes();
    pageView  = pagesView.getView(0);
    pageView.x = 0;
    pageView.y = 0;
    
    pageView  = pagesView.getView(0);
    var zoomW = SIZE.DESKTOP_WIDTH /  pageView.width;
    var zoomH = SIZE.DESKTOP_HEIGHT / pageView.height;
    
    var z = zoomW < zoomH ? zoomW : zoomH;
    z *= 0.98;
    
    sizeX = this.width  ;
    sizeY = this.height ;
    
    this.width    *= z;
    this.height   *= z;
    
    
    Zoom.setZoom(1/z);
    
    this.x += (SIZE.DESKTOP_WIDTH-(pageView.width/Zoom.getZoomFactor()))/2.0;
    this.y += ((SIZE.DESKTOP_HEIGHT-(pageView.height/Zoom.getZoomFactor()))/2.0)+6;
    
  }
  
  private function setSizes():Void{
    sizeX = pagesView.width;
    sizeY = pagesView.height;
    
    this.visible = true;
  }
  
  private function onZoom(e:Event):Void{
    updateZoom();
  }
  
  private function updateZoom():Void{

    pagesView.width 	= sizeX * Zoom.getZoomFactor();
    pagesView.height 	= sizeY * Zoom.getZoomFactor();
  }
  
  
  private function onEnterFrame(e:Event):Void{
    //updateFoilEffects(0.002);
  }
   
  private function onResetDesktopSize(e:KEvent):Void{
    sizeX = pagesView.width/Zoom.getZoomFactor();
    sizeY = pagesView.height/Zoom.getZoomFactor();
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
  	pagesView.x = 0;
  	pagesView.y = 0;
  	glimmerFoils();
  }
  
  override public function glimmerFoils():Void{
    glimmer_foils_index = 0;
    addEventListener(Event.ENTER_FRAME, onUpdateGlimmerFoils);
  }
  
  private function onUpdateGlimmerFoils(e:Event):Void{
    updateGlimmerFoils();
  }
  
  public function updateGlimmerFoils():Void{
    glimmer_foils_index += 1;
    
    updateFoilEffects(0.015);
    
    if(glimmer_foils_index > 45){
      removeEventListener(Event.ENTER_FRAME, onUpdateGlimmerFoils);
    }
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
  }
  
  private function onFontLoaded(e:KEvent):Void{
    
    sizeX = pagesView.width/Zoom.getZoomFactor();
    sizeY = pagesView.height/Zoom.getZoomFactor();
    
    placeholders--;
    if(placeholders == 0)
      setSizes();
  }
  
  private function onAllImagesLoaded(e:KEvent):Void{
    if(placeholders == 0) {
      placeholders--;
      setSizes();       
    }
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
    
    updateFoilEffects(0.01);
    
    GLOBAL.pos_x = x;
    GLOBAL.pos_y = y;
  }
  
  override public function updateFoilEffects(offset_offset:Float=0.01):Void{
    var param = new Parameter(EVENT_ID.DESKTOP_VIEW_MOVE);
    GLOBAL.foilEffect += offset_offset;
    if(GLOBAL.foilEffect > 1.0){
      GLOBAL.foilEffect -= 1.0;
    }
    
    param.setFloat(GLOBAL.foilEffect);
    Application.dispatchParameter(param);
  }
}