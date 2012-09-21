import flash.events.Event;
import flash.events.MouseEvent;
import flash.display.Bitmap;
import flash.geom.Point;

class OneStateButton extends MouseHandler
{
//	private var model:IModel;
  private var controller:IController;
  private var multiStateImage:MultiStateImage;
  private var mouseDown:Bool;
  private var mouseOver:Bool;
  private var jumpUpOnMouseUp:Bool;
  private var isOn:Bool;
  private var param:IParameter;
  private var functionPointer:Dynamic;
  private var fireOnUp:Bool;
  
  
  public function new(){
  	super();
  	addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
  	mouseDown = false;
  	mouseOver = false;
  	jumpUpOnMouseUp = true;
  	isOn = false;
  	fireOnUp = true;
  }
  
  public function init(  controller:IController, size:Point, bmp:Bitmap, param:IParameter){

  	this.controller = controller;
  	multiStateImage = new MultiStateImage(bmp, size);
  	this.param = param;
  }
  
  public function setCallback( functionPointer:Dynamic ): Void{
  	this.functionPointer = functionPointer;
  }
  
  private function onAddedToStage(e:Event):Void{	
  	removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
  	addChild(multiStateImage);
  	addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
  }
  private function onRemovedFromStage(e:Event):Void{
  	removeChild(multiStateImage);
  	removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
  }
  
  override private function onMouseOut(e:MouseEvent){	
  	super.onMouseOut(e);
  	if(jumpUpOnMouseUp) 
  		setState(0);
  	else
  		setState(isOn? 2:0);
  	mouseOver = false;
  }
  
  
  override private function onMouseOver(e:MouseEvent){	
  	super.onMouseOver(e); 
  	if(jumpUpOnMouseUp) 
  		setState(mouseDown ? 2:1);
  	else
  		setState(isOn? 2:1);
  	mouseOver = true;
  
  }
  
  override private function onMouseDown(e:MouseEvent){	
    
    super.onMouseDown(e); 
    isOn      = true;
    mouseDown = true;
    setState(2);
    param.setBool(true);
    controller.setParam(param);
    if(functionPointer != null)
    	functionPointer(true);
  }
  
  override private function onMouseUp(e:MouseEvent){	
  	super.onMouseUp(e); 
  	if(mouseOver && fireOnUp){
      param.setBool(false);
      controller.setParam(param);
      if(functionPointer != null)
        functionPointer(false);
    }	
    mouseDown = false;
    
    if(jumpUpOnMouseUp)
      setState(mouseOver? 1:0);
  }
  
  private function setState(state:Int):Void {
  	multiStateImage.state(new Point(state,0));
  }
  
  public function getWidth():Float{
  	return multiStateImage.width/3;
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
  
  public function fire():Void{
    isOn      = true;
    mouseDown = true;
    setState(2);
    param.setBool(true);
    controller.setParam(param);
    if(functionPointer != null)
      functionPointer(true);
  }
}

