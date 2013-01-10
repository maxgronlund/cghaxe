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
 
class ImageButton extends MouseHandler
{
	
	private var _back :Rectangle = null;
	private var _over :Rectangle = null;
	private var _controller :IController = null;
	private var _param :IParameter = null;
	
	private var _imageUrl:String;
	private var _imageLoader:Loader;
	
	
	private var mouseDown:Bool;
	  private var mouseOver:Bool;
	  private var jumpUpOnMouseUp:Bool;
	  private var isOn:Bool;
	  private var param:IParameter;
	  private var functionPointer:Dynamic;
	  private var fireOnUp:Bool;
	  
	private var _vectorMovie:MovieClip;
	
	private var _overParam :IParameter = null;
	private var _outParam :IParameter = null;

	public function new() 
	{
		super();
		_back = new Rectangle(0, 0, 0xFF0000, 0x0, false, true);
		setState(0);
		
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
	
	public function initOverOut(overParam :IParameter, outParam :IParameter) :Void
	{
		_overParam = overParam;
		_outParam = outParam;
	}
	
	override private function onMouseOut(e:MouseEvent){	
  	super.onMouseOut(e);
  	if(jumpUpOnMouseUp) 
  		setState(0);
  	else
  		setState(isOn? 2:0);
  	mouseOver = false;
	
	//if (!isOn)
    if (_outParam != null)
	{
		_controller.setParam(_outParam);
	}
  }
  
  
  override private function onMouseOver(e:MouseEvent){	
  	super.onMouseOver(e); 
  	if(jumpUpOnMouseUp) 
  		setState(mouseDown ? 2:1);
  	else
  		setState(isOn? 2:1);
  	mouseOver = true;
	
	if ((!isOn) && (_overParam != null))
	{
		_controller.setParam(_overParam);
	}
  
  }
  
  override private function onMouseDown(e:MouseEvent){	
    
    super.onMouseDown(e); 
    isOn      = true;
    mouseDown = true;
    setState(2);
    _param.setBool(true);
    _controller.setParam(_param);
    if(functionPointer != null)
    	functionPointer(true);
		
		
	//_imageLoader.load(new URLRequest(_imageUrl));
	//_imageLoader.load(new URLRequest("greetings/test.png"));
  }
  
  override private function onMouseUp(e:MouseEvent){	
  	super.onMouseUp(e); 
  	if(mouseOver && fireOnUp){
      _param.setBool(false);
      _controller.setParam(param);
      if(functionPointer != null)
        functionPointer(false);
    }	
    mouseDown = false;
    
    if(jumpUpOnMouseUp)
      setState(mouseOver? 1:0);
	  
	  //addImage(_imageUrl, 0, 0, false, false);
	  
	  //_imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadImageComplete);
	//_imageLoader.load(new URLRequest(_imageUrl));
	
	
	
  }
  
  
  private function loadImage() :Void
  {
	  var ldr:Loader                = new Loader(); 
		var req:URLRequest            = new URLRequest(_imageUrl); 
		var ldrContext:LoaderContext  = new LoaderContext(); 
		ldrContext.applicationDomain  = new ApplicationDomain();
		ldr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoadImageError);
		ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, onImageLoaded); 
		ldr.load(req, ldrContext);
  }
  
   private function onImageLoaded(event:Event):Void { 
	    _vectorMovie = new MovieClip();
		_vectorMovie.addChild(cast event.target.loader.content);
	    
		//var scale:Float = 0.1;
		addChild(_vectorMovie);
		
		if (_vectorMovie.width > _vectorMovie.height)
		{
			_vectorMovie.width = _back.width - 6;
			_vectorMovie.scaleY = _vectorMovie.scaleX;
		}else
		{
			_vectorMovie.height = _back.height - 6;
			_vectorMovie.scaleX = _vectorMovie.scaleY;
		}
		
		_vectorMovie.x = (_back.width - _vectorMovie.width) / 2;
		_vectorMovie.y = (_back.height - _vectorMovie.height) / 2;
		loadNextImage();
   }
   
   private function onLoadImageError(event:IOErrorEvent):Void {
		trace('IO Error loading image');
		loadNextImage();
   }   
  
   private function loadNextImage():Void {
	   var param:IParameter = new Parameter(EVENT_ID.ADD_GREETING_BUTTON);
	   dispatchEvent(new KEvent(EVENT_ID.LOAD_NEXT_IMAGE,param));
   }
   
  private function setState(state:Int):Void {
  	_back.alpha = 0.0;
	
	if (state == 0) _back.alpha = 0.0;
	if (state == 1) _back.alpha = 0.2;
	if (state == 2) _back.alpha = 0.4;
  }
  
  public function getWidth():Float{
  	return _back.width;
  }
  
  public function setOn(b:Bool):Void{
  	setState(b? 2:0);
  	isOn = b;
  }
  
  public function jumpBack(b:Bool): Void {
  	jumpUpOnMouseUp = b;
  }
  
  public function fireOnMouseUp(b:Bool): Void {
  	fireOnUp = b;
  }
  public function getParam():IParameter{
    return param;
  }
  
  private function onLoadImageComplete(e:Event):Void
  {
    _imageLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoadImageComplete);
    //_imgBtm = e.target.loader.content;
    

    //addChild(_imageLoader);
   
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