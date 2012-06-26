import flash.events.Event;
import flash.events.MouseEvent;
import flash.display.Bitmap;
import flash.geom.Point;

class TwoStateButton extends MouseHandler
{
	private var model:IModel;
	private var controller:IController;
	private var multiStateImage:MultiStateImage;
	private var mouseDown:Bool;
	private var mouseOver:Bool;
	private var newState:Bool;
	private var param:IParameter;

	
	
	public function new(){
		super();
		addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
	}
	
	public function init( model:IModel, controller:IController, size:Point, bmp:Bitmap, param:IParameter){
		this.model 		= model;
		this.controller = controller;
		multiStateImage = new MultiStateImage(bmp, size);
		this.param	 = param;
		mouseDown 	= false;
		mouseOver 	= false;
		newState	= false;
	}
	
	private function onAddedToStage(e:Event):Void{	
		addChild(multiStateImage);
	}
	
	override private function onMouseOut(e:MouseEvent){	
		super.onMouseOut(e); 
		mouseOver = false;
		setState(param.getBool());
	}
	

	override private function onMouseOver(e:MouseEvent){	
		super.onMouseOver(e); 
		mouseOver = true;
		setState(newState == param.getBool()? param.getBool():newState);
	}

	override private function onMouseDown(e:MouseEvent){	
		super.onMouseDown(e); 
		newState = !param.getBool();
		mouseDown = true;
		setState(newState);
	}
	
	override private function onMouseUp(e:MouseEvent){	
		super.onMouseUp(e); 	
		mouseDown = false;

		if (mouseOver ){
			param.setBool(newState);
			controller.setParam(param);
			setState(param.getBool());
		}
		else{
			setState(param.getBool());
		}
		newState = param.getBool();
	}
	
	private function setState(state:Bool):Void{
		if (mouseOver)
			multiStateImage.state(new Point(state? 3:1,0));
		else
			multiStateImage.state(new Point(state? 2:0,0));
	}
	
	public function setOn(b:Bool):Void{
		param.setBool(b);
		setState(b);
		newState = b;
	}	
	public function getWith():Float{
		return multiStateImage.width/4;
	}
	
}

