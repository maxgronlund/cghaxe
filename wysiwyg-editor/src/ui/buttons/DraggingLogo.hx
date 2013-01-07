package ;

/**
 * ...
 * @author VF
 */

import flash.display.Sprite;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.MouseEvent;
import flash.display.Loader;
import flash.system.ApplicationDomain;
import flash.system.LoaderContext;
import flash.display.Bitmap;
import flash.net.URLRequest;
import flash.display.MovieClip;
 
class DraggingLogo extends DraggingSymbol
{
	
	public function new() 
	{
		super();
		
	}
	  
    override private function onImageLoaded(event:Event):Void { 
	    _vectorMovie = new MovieClip();
		_vectorMovie.addChild(cast event.target.loader.content);
		addChild(_vectorMovie);		
   }
    
}