
import flash.text.TextFormat;

class DesktopController extends Controller, implements IController
{
	public function new(){	
		super();
	}
	
	override public function setParam(param:IParameter):Void{
    
    switch ( param.getLabel() ){
      case EVENT_ID.ZOOM_IN:{
        Zoom.zoomIn();	
      }
      case EVENT_ID.ZOOM_OUT:{
        Zoom.zoomOut();
      }
      case EVENT_ID.ZOOM_100:
		  {
        Zoom.resetZoom();
        GLOBAL.desktop_view.setParam(param);
        
      }
	  
	  case EVENT_ID.TRASH_PLACEHOLDER:
		{
			  GLOBAL.menu_controller.setParam(param);
		}
    }	
	}
}