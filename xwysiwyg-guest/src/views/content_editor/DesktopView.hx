/* holds the pagesView
* can zoom
*/


//import flash.display.BitmapData;
//import flash.display.Bitmap;
//import flash.geom.Point;
import flash.events.MouseEvent;
import flash.events.Event;

class DesktopView extends View, implements IView{
	
  private var pagesView:AView;
  private var hitPointX:Float;
  private var hitPointY:Float;
  
  private var sizeX:Float;
  private var sizeY:Float;
  //private var ratio:Float;
  
  private var placeholders:Int;
  
  public function new(desktopController:IController){	
  	super(desktopController);
  	pagesView = new PagesView(desktopController);
  	Application.addEventListener(EVENT_ID.ZOOM, onZoom);
    Preset.addEventListener(EVENT_ID.PLACEHOLDER_COUNT, onPlaceholderCount);
    Pages.addEventListener(EVENT_ID.FONT_LOADED, onFontLoaded);
    Application.addEventListener(EVENT_ID.ALL_IMAGES_LOADED, onAllImagesLoaded);
    Application.addEventListener(EVENT_ID.RESET_STAGE_SIZE, onResetDesktopSize);
    addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
    addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
    Designs.addEventListener(EVENT_ID.LOAD_PAGE_POS_AND_ZOOM, onLoadPos);
    Preset.addEventListener(EVENT_ID.LOAD_PAGE_POS_AND_ZOOM, onLoadPos);
  }
  
  override public function init():Void{
  	pagesView.init();
  	this.visible = false;
  	placeholders = 0;
  }
  
  override public function onAddedToStage(e:Event){
  	super.onAddedToStage(e);
  	addChild(pagesView);
  	pagesView.x = 10;
  	pagesView.y = 10;
  	
  }

  
  private function onLoadPos(e:KEvent):Void{
//    trace(e.getXml().toString());
    for( pos_x in e.getXml().elementsNamed('pos_x') )
      this.x = Std.parseInt(pos_x.firstChild().nodeValue.toString());
    
    for( pos_y in e.getXml().elementsNamed('pos_y') )
      this.y = Std.parseInt(pos_y.firstChild().nodeValue.toString()) - (SIZE.MENU_VIEW_HEIGHT + SIZE.PAGESELESCTOR_HEIGHT);
      
    GLOBAL.pos_x = this.x;
    GLOBAL.pos_y = this.y;
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
      setSizes();       
    }
  }
  
  private function setSizes():Void{
    
    sizeX = pagesView.width;
    sizeY = pagesView.height;
    updateZoom();
    this.visible = true;
  }
  
  private function onResetDesktopSize(e:KEvent):Void{
    //trace('onResetDesktopSize');
    sizeX = pagesView.width/Zoom.getZoomFactor();
    sizeY = pagesView.height/Zoom.getZoomFactor();
  }
  
  

  private function onZoom(e:Event):Void{
    updateZoom();
  }
  
  private function updateZoom():Void{
    pagesView.width 	= sizeX * Zoom.getZoomFactor() * 0.38;
    pagesView.height 	= sizeY * Zoom.getZoomFactor() * 0.38;
    //pagesView.width 	*= Zoom.getZoom();
    //pagesView.height 	*= Zoom.getZoom();
  }
  
  private function onMouseOver(e:MouseEvent):Void{
    //removeEventListener(MouseEvent.ROLL_OVER, onMouseOver);
    //addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
    //addEventListener(MouseEvent.ROLL_OUT, onMouseOut);	
  }
  
  private function onMouseOut(e:MouseEvent){
    //removeEventListener(MouseEvent.ROLL_OUT, onMouseOut);
    //addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
    //addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
  }
  
  private function onMouseDown(e:MouseEvent){	
    
    //if(MouseTrap.capture()){
    //  //trace('on mouse down');
    //  removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
    //  hitPointX = e.stageX - this.x;
    //  hitPointY = e.stageY - this.y;
    //  stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
    //  stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
    //  
    //  Application.dispatchParameter(new Parameter(EVENT_ID.DESELECT_PLACEHOLDERS));
    //}
  }
  
  private function onMouseUp(e:MouseEvent){	
  	//MouseTrap.release();
  	//stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
  	//stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
  	//addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
  }
  
  private function onMouseMove(e:MouseEvent){
    //var endPosX:Float = ( e.stageX - hitPointX);
    //var endPosY:Float = ( e.stageY - hitPointY);
    //this.x = endPosX;
    //this.y = endPosY;
    //GLOBAL.pos_x = x;
    //GLOBAL.pos_y = y;
    
  }
}