import flash.events.Event;
import flash.events.MouseEvent;
import flash.display.Bitmap;
import flash.geom.Point;

class OneStateButton extends MouseHandler
{
	private var model:IModel;
	private var controller:IController;
	private var multiStateImage:MultiStateImage;
	private var mouseDown:Bool;
	private var mouseOver:Bool;
	private var param:IParameter;
	
	
	public function new(){
		super();
		addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
	}
	
	public function init( model:IModel, controller:IController, size:Point, bmp:Bitmap, param:IParameter){
		this.model 		= model;
		this.controller = controller;
		multiStateImage = new MultiStateImage(bmp, size);
		this.param = param;
		mouseDown = false;
		mouseOver = false;
	}
	
	private function onAddedToStage(e:Event):Void{	
		addChild(multiStateImage);
	}
	
	override private function onMouseOut(e:MouseEvent){	
		super.onMouseOut(e); 
		setState(0);
		mouseOver = false;
	}
	

	override private function onMouseOver(e:MouseEvent){	
		super.onMouseOver(e); 
		setState(mouseDown ? 2:1);
		mouseOver = true;

	}

	override private function onMouseDown(e:MouseEvent){	
		super.onMouseDown(e); 
	//	controller.setParam(param);
		mouseDown = true;
		setState(2);
	}
	
	override private function onMouseUp(e:MouseEvent){	
		super.onMouseUp(e); 
		if(mouseOver)
			controller.setParam(param);
		mouseDown = false;
		setState(mouseOver? 1:0);
	}
	
	private function setState(state:Int):Void
	{
		multiStateImage.state(new Point(state,0));
	}
	
	public function getWith():Float{
		return multiStateImage.width/3;
	}
	
	public function setOn(b:Bool):Void{
		multiStateImage.state(new Point(0,0));
	}

}

