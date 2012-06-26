
class ZoomTools
{
  private var toScreenFactor:Float;
  private var zoomFactor:Float;
  private var pageScreenSizeX:Float;
  private var pageScreenSizeY:Float;
  private var loadedZoom:Float;
  private var zoom:Float;
  
  private var Application:IModel;

  public function new(){
    toScreenFactor      = 72/150;
    zoomFactor          = 1;
    pageScreenSizeX     = 1;
    pageScreenSizeX     = 1;
    loadedZoom          = -1;
//    zoom                = 1;
    Application         = GLOBAL.Application;
    GLOBAL.Preset.addEventListener(EVENT_ID.LOAD_PAGE_POS_AND_ZOOM, onLoadPagePosAndZoom);
    GLOBAL.Designs.addEventListener(EVENT_ID.LOAD_PAGE_POS_AND_ZOOM, onLoadPagePosAndZoom);
    //Application.addEventListener(EVENT_ID.SET_PAGE_POS_AND_ZOOM, onSetPagePosAndZoom);
    
  }
  
  private function onLoadPagePosAndZoom(e:IKEvent):Void{
    //zoomFactor = e.getFloat()/1000;
    for( stage_zoom in e.getXml().elementsNamed('zoom') ) 
      zoomFactor = Std.parseFloat(stage_zoom.firstChild().nodeValue.toString())/1000;
      
    //trace(zoomFactor);
  }
  
  //private function onSetPagePosAndZoom(e:IKEvent):Void{
  //  
  //  if(loadedZoom != -1){
  //    zoomFactor = loadedZoom;
  //    zoom = loadedZoom;
  //    updateGui();
  //  }
  //}
  
  public function toScreen(size:Float):Float{
  	return size * toScreenFactor;
  }

  public function zoomIn():Void{
    //trace('zoomIn');
    zoomFactor *= 1.03;
    zoom = 1.03;
    updateGui();
    //trace(  zoomFactor);
  }
  
  public function zoomOut():Void{
    //trace('zoomOut');
    zoom = 1/1.03;
    zoomFactor *= zoom;
    updateGui();
  }	
  
  public function resetZoom():Void{
    zoomFactor = 1;
    zoom = 1/zoom;
    updateGui();
  }

   public function toMouse():Float{
     return 1 / (zoomFactor * toScreenFactor);
  }
  
  private function updateGui():Void{
    
    //-trace(zoomFactor);
    Application.dispatchParameter(new Parameter( EVENT_ID.ZOOM ) );
  }
  
  public function getZoomFactor():Float{
    return zoomFactor * toScreenFactor;
  }
  
  public function saveZoom():Float{
    return zoomFactor;
  }
  
  public function getZoom():Float{
    return zoom;
  }
}