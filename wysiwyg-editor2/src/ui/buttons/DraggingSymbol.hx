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
 
class DraggingSymbol extends Sprite
{
	private var _back :Rectangle = null;
	private var _controller :IController = null;
	private var _param :IParameter = null;
	
	private var _imageUrl:String;
	private var _imageLoader:Loader;
	

	  
	private var _vectorMovie:MovieClip;
	
	public function new() 
	{
		super();
		_back = new Rectangle(0, 0, 0xFF0000, 0x0, false, true);
		_back.alpha = 0.0;
		
		_imageLoader = new Loader();
		
		addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
	}
	
	public function setSize(width :Int, height :Int) :Void
	{
		_back.setSize(width, height);
	}
	
	public function init(controller:IController, param:IParameter, imgURL :String)
	{
		_controller = controller;
		_param = param;
		_imageUrl = imgURL;
	}

  
  private function loadImage() :Void
  {
	  var ldr:Loader                = new Loader(); 
		var req:URLRequest            = new URLRequest(_imageUrl); 
		var ldrContext:LoaderContext  = new LoaderContext(); 
		ldrContext.applicationDomain  = new ApplicationDomain();
		ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, onImageLoaded); 
		ldr.load(req, ldrContext);
  }
  
   private function onImageLoaded(event:Event):Void { 
	    _vectorMovie = cast event.target.loader.content;
		//var scale:Float = 0.1;
		addChild(_vectorMovie);
		
		/*if (_vectorMovie.width > _vectorMovie.height)
		{
			_vectorMovie.width = _back.width;// - 6;
			_vectorMovie.scaleY = _vectorMovie.scaleX;
		}else
		{
			_vectorMovie.height = _back.height;// - 6;
			_vectorMovie.scaleX = _vectorMovie.scaleY;
		}*/
		
		var scale:Float = 0.25;

		_vectorMovie.width *= scale;
		_vectorMovie.height *= scale;
		
		//_vectorMovie.x =  - _vectorMovie.width / 2;
		//_vectorMovie.y =  - _vectorMovie.height / 2;
		
   }
  
  public function getWidth():Float{
  	return _back.width;
  }
  
  public function getParam():IParameter{
    return _param;
  }
  
	 private function onAddedToStage(e:Event):Void
	 {	
		removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		addChild(_back);
		loadImage();
		//_imageLoader.load(new URLRequest(_imageUrl));
		addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
	}
	  private function onRemovedFromStage(e:Event):Void
	  {
		removeChild(_back);
		
		if (_vectorMovie != null) removeChild(_vectorMovie);
		
		removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
	  }
	
}