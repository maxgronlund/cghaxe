
class ZoomTools
{
  private var toScreenFactor:Float;
  private var zoomFactor:Float;
  private var loadedZoom:Float;
  //private var zoom:Float;
  private var Application:IModel;
  
  private var zoomInFactor:Float;
  private var zoomOutFactor:Float;

  public function new(){
    toScreenFactor      = 72/150;
    zoomFactor          = 1;
    loadedZoom          = -1;
    Application         = GLOBAL.Application;
    GLOBAL.Preset.addEventListener(EVENT_ID.LOAD_PAGE_POS_AND_ZOOM, onLoadPagePosAndZoom);
    GLOBAL.Designs.addEventListener(EVENT_ID.LOAD_PAGE_POS_AND_ZOOM, onLoadPagePosAndZoom);
    zoomInFactor = 1.05;
    zoomOutFactor = 1/zoomInFactor;
  }
  
  private function onLoadPagePosAndZoom(e:IKEvent):Void{
    trace('onLoadPagePosAndZoom');
    for( stage_zoom in e.getXml().elementsNamed('zoom') ) 
      zoomFactor = Std.parseFloat(stage_zoom.firstChild().nodeValue.toString())/1000;
  }

  public function toScreen(size:Float):Float{
  	return size * toScreenFactor;
  }
  
  public function zoomTo(z:Float):Void{
    trace('zoomTo', zoomTo);
    zoomFactor = z;
    updateGui();
  }

  public function zoomIn():Void{
    zoomFactor *= zoomInFactor;
    updateGui();
  }
  
  public function zoomOut():Void{
    zoomFactor *= zoomOutFactor;
    updateGui();
  }	
  
  public function setZoom(z:Float):Void{
    trace(zoomFactor);
    zoomFactor = z / toScreenFactor;
  }
  
  public function resetZoom():Void{
    zoomFactor = 1;
    updateGui();
  }
   public function toMouse():Float{
     return 1 / (zoomFactor * toScreenFactor);
  }
  
  private function updateGui():Void{
    Application.dispatchParameter(new Parameter( EVENT_ID.ZOOM ) );
  }
  
  public function getZoomFactor():Float{
    return zoomFactor * toScreenFactor;
  }

  public function saveZoom():Float{
    return zoomFactor;
  }
}