import flash.events.Event;
import flash.events.MouseEvent;
import flash.display.Bitmap;
import flash.geom.Point;

class PropertyButton extends MouseHandler
{
	private var controller:IController;
	private var multiStateImage:MultiStateImage;
	private var mouseDown:Bool;
	private var mouseOver:Bool;
	private var param:IParameter;
	private var selected:Bool;
	
	
	public function new(){
		super();
		addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
	}
	
	public function init(  controller:IController, size:Point, bmp:Bitmap, param:IParameter){
		this.controller = controller;
		multiStateImage = new MultiStateImage(bmp, size);
		this.param = param;
		mouseDown = false;
		mouseOver = false;
		selected	= false;
		
	}
	
	private function onAddedToStage(e:Event):Void{	
		addChild(multiStateImage);
	}

	override private function onMouseOver(e:MouseEvent){	
		super.onMouseOver(e); 
		setState(selected ? 2:1);
		mouseOver = true;
	}

	override private function onMouseOut(e:MouseEvent){	
		super.onMouseOut(e); 
		setState(selected ? 2:0);
		mouseOver = false;
	}
	
	override private function onMouseDown(e:MouseEvent){
		super.onMouseDown(e); 
		controller.setParam(param);
		mouseDown = true;
		selected	= true;
		setState(2);
	}
	
	private function setState(state:Int):Void{
		multiStateImage.state(new Point(state,0));
	}
	
	public function getWith():Float{
		return multiStateImage.width/3;
	}
	
	public function setOn(b:Bool):Void{
		selected = b;
		setState(b?2:0);
	}
}

