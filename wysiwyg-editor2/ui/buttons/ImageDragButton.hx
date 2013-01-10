package ;

/**
 * ...
 * @author VF
 */

import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.MouseEvent;
import flash.display.Loader;
import flash.system.LoaderContext;
import flash.display.Bitmap;
import flash.net.URLRequest;
import flash.system.ApplicationDomain; 
import flash.display.MovieClip;
 
class ImageDragButton extends ImageButton
{

  override private function onMouseDown(e:MouseEvent){	
     
    setState(0);
    _param.setBool(true);
    _controller.setParam(_param);
	  
	//_controller.setParam(_param);
    //super.onMouseDown(e); 
    //var param:IParameter = new IParameter();
	//param.setLabel(EVENT_ID.START_DRAG_SYMBOL);
	//dispatchEvent(new KEvent(EVENT_ID.START_DRAG_SYMBOL, _param));
  }
  
  override private function onMouseUp(e:MouseEvent){	
  	
  }
  
  override private function loadNextImage():Void {
	   var param:IParameter = new Parameter(EVENT_ID.ADD_SYMBOL_BUTTON);
	   dispatchEvent(new KEvent(EVENT_ID.LOAD_NEXT_IMAGE, param ));
   }
  
}