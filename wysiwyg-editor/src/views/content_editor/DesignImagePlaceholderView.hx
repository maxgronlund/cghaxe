// the placeholder handles the mouse



import flash.events.Event;
import flash.geom.Point;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.display.Loader;

import flash.events.MouseEvent;
import flash.display.MovieClip;
import flash.display.Loader;
import flash.net.URLRequest;

import flash.system.ApplicationDomain; 
import flash.system.LoaderContext;
import flash.system.SecurityDomain;

import flash.text.TextField;
//import flash.text.TextFieldAutoSize;
//import flash.text.TextFormat;

import flash.geom.Point;
//import flash.display.BitmapData;
//import flash.display.Bitmap;

import flash.events.Event;
import flash.events.KeyboardEvent;

import flash.display.Shape;
import flash.Vector;

import flash.display.Loader;
import flash.display.Bitmap;




class DesignImagePlaceholderView extends APlaceholder{
	

  private var parrent:PageView;
  private var model:IModel;
  private var mouseOver:Bool;
  private var id:Int;
  private var modelId:Int;
  private var xml:String;
  private var anchorPoint:Float;
  private var previewMode:Bool;
  private var designMode:Bool;
  private var focus:Bool;
  
  private var imageUrl:String;
  private var imageLoader:Loader;
  private var backdrop:Bitmap;
  

  
  public function new(parrent:PageView, id:Int, model:IModel, imageUrl:String){	
    
    super(parrent, id, model, imageUrl);
    this.parrent                      = parrent;
    this.id                           = id;
    this.model                        = model;
    this.imageUrl                     = imageUrl;
    this.modelId                      = model.getInt('pageId');
    designMode                        = GLOBAL.edit_mode == 'system_design';
//    textWithTags                      = text;
    this.alpha                        = 0.85;
    mouseOver                         = false;
    previewMode                       = true;
    focus                             = false;
    
    imageLoader	                      = new Loader();
    
    addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    
  }
  
  private function onAddedToStage(e:Event){
    
    imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadImageComplete);
    imageLoader.load(new URLRequest(imageUrl));
    
    
    //model.addEventListener(EVENT_ID.GET_PAGE_XML+Std.string(modelId), onGetXml);
    addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
    
  }
  
  private function onLoadImageComplete(e:Event):Void{
    imageLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoadImageComplete);
  

    backdrop = e.target.loader.content;
    //backdrop.scaleX *= 2.08333333333333;
    //backdrop.scaleY *= 2.08333333333333;
    backdrop.scaleX *= 0.48;
    backdrop.scaleY *= 0.48;
    addChild(backdrop);
    //handleKeyboard( focus ); 
    GLOBAL.Application.dispatchParameter(new Parameter(EVENT_ID.RESET_STAGE_SIZE));
    
	}
   
  private function handleKeyboard(b:Bool):Void{
    
    if( b && GLOBAL.MOVE_TOOL){
      stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPressed);
    }
    else{
      stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyPressed);
    }
  }
   
  //override public function getText(): Void {
  //  
  // 
  //}
  
  override public function getXml() : String {
    
    /*
    var str:String = '\t\t<placeholder id=\"'+ Std.string(id) +'\">\n';
      str += '\t\t\t<pos-x>' + Std.string(x) + '</pos-x>\n';
      str += '\t\t\t<pos-y>' + Std.string(y) + '</pos-y>\n';
      str += '\t\t\t<font-file-name>' + fontFileName + '</font-file-name>\n';
      str += '\t\t\t<font-color>' + Std.string(fontColor) + '</font-color>\n';
      str += '\t\t\t<line-space>' + Std.string(fontLeading) + '</line-space>\n';
      str += '\t\t\t<font-size>' + Std.string(fontSize) + '</font-size>\n';
      str += '\t\t\t<font-align>' + fontAlign + '</font-align>\n';
      str += '\t\t\t<anchor-point>' + Std.string(calculateAnchorPoint()) + '</anchor-point>\n';
      str += font.getXml();
    str += '\t\t</placeholder>\n';
    

    return str;
    */
    
    return 'na';
  }
  
  private function onKeyPressed(event:KeyboardEvent):Void{
    var step:Float = 150/72;
    //trace(event.keyCode);
    switch(event.keyCode){
      case 37: this.x -=step; 
      case 39: this.x +=step; 
      case 38: this.y -=step; 
      case 40: this.y +=step;
    }
  }
  
  
  override public function setFocus(b:Bool):Void{
    focus = b;
    //updateFocus();
  }

  
  private function updateFocus():Void{
    
    if(focus){

    }else{

//      super.resetMouse();
    }
    handleKeyboard( focus ); 
    GLOBAL.Application.dispatchParameter(new Parameter(EVENT_ID.RESET_STAGE_SIZE));   
  }
  

  
//  override private function onMouseOver(e:MouseEvent){
//    mouseOver = true;
//    super.onMouseOver(e);
//  }
//
//  override private function onMouseDown(e:MouseEvent){
//
//    MouseTrap.capture();
//    super.onMouseDown(e);
//    //GLOBAL.Font.fileName        = fontFileName;
//    //GLOBAL.Font.fontSize        = fontSize;
//    //GLOBAL.Font.fontColor       = fontColor;
//    //GLOBAL.Font.fontAlign       = fontAlign;
//    //GLOBAL.Font.leading         = fontLeading;
//    //GLOBAL.Font.letterSpacing   = letterSpacing;
//    parrent.setPlaceholderInFocus(this);
//    //model.setParam(new Parameter(EVENT_ID.UPDATE_TEXT_TOOLS));
//    if(GLOBAL.MOVE_TOOL) parrent.enableMove(e);
//  }
//  
//  override private function onMouseOut(e:MouseEvent){
//    mouseOver = false;
//    removeEventListener(MouseEvent.ROLL_OUT, onMouseOut);
//    addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
//  }
//  
//  override private function onMouseUp(e:MouseEvent){
//    
//    MouseTrap.release();
//    super.onMouseUp(e);
//    parrent.disableMove();
//    
//    GLOBAL.Application.dispatchParameter(new Parameter(EVENT_ID.RESET_STAGE_SIZE));
//    
//  }
  
  
  private function onGetXml(event:Event):Void{
    model.setString(EVENT_ID.SET_PAGE_XML, getXml());
  }
  
  
  private function onRemovedFromStage(e:Event){
    removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
  	model.removeEventListener(EVENT_ID.GET_PAGE_XML+Std.string(modelId), onGetXml);
  }
}
