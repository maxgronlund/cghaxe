
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
      
    zoomFactor;//  *= toScreenFactor;
    trace(zoomFactor);
  }
  

  
  public function toScreen(size:Float):Float{
  	return size * toScreenFactor;
  }
  
  public function zoomTo(z:Float):Void{
    zoomFactor *= z;
    zoom = z;
    updateGui();
  }

  public function zoomIn():Void{
    zoomFactor *= 1.03;
    zoom = 1.03;
    updateGui();
  }
  
  public function zoomOut():Void{
    //trace('zoomOut');
    zoom = 1/1.03;
    zoomFactor *= zoom;
    updateGui();
  }	
  
  public function resetZoom():Void{
    trace('resetZoom');
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
    trace(zoomFactor * toScreenFactor);
    return zoomFactor * toScreenFactor;
    //return 0.48;
  }
  
  public function saveZoom():Float{
    //trace(zoomFactor);
    return zoomFactor;
  }
  
  //public function getZoom():Float{
  //  return zoom;
  //}
}