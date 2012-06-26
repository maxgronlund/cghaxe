import flash.events.Event;
import flash.events.MouseEvent;
import flash.display.Bitmap;
import flash.geom.Point;

class TwoStateButton extends MouseHandler
{
//	private var model:IModel;
  private var controller:IController;
  private var multiStateImage:MultiStateImage;
  private var mouseDown:Bool;
  private var mouseOver:Bool;
  private var param:IParameter;
  
  
  
  public function new(){
  	super();
  	addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
  }
  
    public function init( controller:IController, size:Point, bmp:Bitmap, param:IParameter){
    this.controller 	= controller;
    multiStateImage 	= new MultiStateImage(bmp, size);
    this.param	 			= param;
    mouseDown 				= false;
    mouseOver 				= false;
    
  }
  
  private function onAddedToStage(e:Event):Void{
  	removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);	
  	addChild(multiStateImage);
  }
  
  override private function onMouseOut(e:MouseEvent){	
    super.onMouseOut(e); 
    mouseOver = false;
    
    if(mouseDown){
      if(param.getBool()){
        multiStateImage.state(new Point(1,0));
      } else{
        multiStateImage.state(new Point(4,0));
      }
    } else{
      if(param.getBool()){
        multiStateImage.state(new Point(3,0));
      } else{
        multiStateImage.state(new Point(0,0));
      }
    }
  }
  
  
  override private function onMouseOver(e:MouseEvent){	
    super.onMouseOver(e); 
    
    mouseOver = true;
    
    if(mouseDown){
      if(param.getBool()){
        multiStateImage.state(new Point(2,0));
      } else{
        multiStateImage.state(new Point(5,0));
      }
    } 
    else{
      if(param.getBool()){
        multiStateImage.state(new Point(4,0));
      } else{
        multiStateImage.state(new Point(1,0));
      }
    }
  }
  
  override private function onMouseDown(e:MouseEvent){	
  	super.onMouseDown(e); 
  	
  	mouseDown = true;
  	param.setBool(!param.getBool());
  	
  	if(param.getBool()){
  	  multiStateImage.state(new Point(2,0));
  	} else{
  	  multiStateImage.state(new Point(5,0));
  	}
  	
  
  }
  
  override private function onMouseUp(e:MouseEvent){	
  	super.onMouseUp(e); 	
  	mouseDown = false;
  
  	if (mouseOver ){
  		controller.setParam(param);
  	} else{
  	  param.setBool(!param.getBool());
  	}
  	
  	if(param.getBool()){
  	  multiStateImage.state(new Point(3,0));
  	} else{
  	  multiStateImage.state(new Point(0,0));
  	}
  }
  
  public function setOn(b:Bool):Void{
  	multiStateImage.state(new Point(b?3:0,0));
  	param.setBool(b);
  }	
  
  public function getWidth():Float{
  	return multiStateImage.width/6;
  }
	
}

