
import flash.text.TextFormat;

class DesktopController extends Controller, implements IController
{
	public function new(){	
		super();
	}
	
	override public function setParam(param:IParameter):Void{
    
    switch ( param.getLabel() ){
      case EVENT_ID.ZOOM_IN:{
        //trace('zoom');
        Zoom.zoomIn();	
      }
      case EVENT_ID.ZOOM_OUT:{
        //trace('zoom');
        Zoom.zoomOut();
      }
      case EVENT_ID.ZOOM_100:{
        //trace('ZOOM_100');
        Zoom.resetZoom();
        GLOBAL.desktop_view.setParam(param);
        
      }
    }	
	}
}