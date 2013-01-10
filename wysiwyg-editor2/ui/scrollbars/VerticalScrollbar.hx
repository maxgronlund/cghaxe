// To do
// add suport for vertical scrolling
// handle click out side the handle
// set the scroll position from the playhead (listen for event)

import flash.events.Event;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.MouseEvent;
import flash.geom.Point;

class VerticalScrollbar extends MouseHandler
{

//	private var horizontal:Bool;
private var bmpData:BitmapData;
//private var backdrop:Bitmap;
	
//	private var scrollPaneSize:Point;
  private var minHandleWidth:Int;
  private var scrollbarHandle:VerticalScrollbarHandle;
  private var sizeX:Float;
  private var sizeY:Float;
  private var hitPoint:Float;
  private var startPos:Float;
  private var endPos:Float;
  private var lastVal:Float;
  private var controller:IController;
  private var mouseRange:Float;
  private var ratio:Float;
  private var pos:Float;
  private var mouseIsOverHandle:Bool;
  private var param:IParameter;
  
  
  public function new(controller:IController, paramId:String){	
  	super();
  
  	
  	
  	this.controller 	= controller;	
  	scrollbarHandle		= new VerticalScrollbarHandle(controller);
    param = new Parameter( paramId);
  	lastVal = 0;
  	endPos = 0;
    startPos = 0;
  
  	mouseRange = 1;
  	mouseIsOverHandle = false;
  	pos = 0;
  	
  	addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);	
  }
  
  
  
  public function onAddedToStage(e:Event):Void{
  	removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
//		addChild(backdrop);
		addChild(scrollbarHandle);
		
	}
	
	public function setSize(paneHeight:Float, maskHeight:Float):Void{
		
		this.sizeX = 8;
		this.sizeY = maskHeight;
		
//		// for debugging only
//		backdrop.height = maskHeight;
//		backdrop.width 	= 8;
		

		if(paneHeight > maskHeight){
			scrollbarHandle.setSize(Std.int(paneHeight), Std.int(maskHeight));
		
			mouseRange = maskHeight - scrollbarHandle.height;
			
//			trace(mouseRange, scrollbarHandle.height);

		}

	//	else{}
	}

	public function setPos(pos:Float):Void{
		scrollbarHandle.y = pos * mouseRange;	
	}

// private functions

	private function updatePos(pos:Float):Void{
		this.pos = pos;
		
//		trace(pos);
		//var param:IParameter = new Parameter( EVENT_ID.FONT_SCROLL);
		param.setFloat(pos);
		controller.setParam(param);
		setPos(pos);
	}
	
	override private function onMouseDown(e:MouseEvent){
		MouseTrap.capture();
		mouseIsOverHandle = scrollbarHandle.hasMouseOver();	
		super.onMouseDown(e); 

			if(mouseIsOverHandle){
				hitPoint = e.stageY;
				startPos = endPos;
			}
			else 
				move( scrollbarHandle.y > e.localY );

		// else{}
	}
	
	override private function onMouseUp(e:MouseEvent){	
		MouseTrap.release();
		super.onMouseUp(e);
		if(mouseIsOverHandle){
			if(endPos <0) endPos = 0;
			else if(endPos > mouseRange) endPos = mouseRange;
		}
	}
	
	override private function onMouseMove(e:MouseEvent):Void{
		if(mouseIsOverHandle){
			endPos = (startPos +   e.stageY - hitPoint);

	  	
			var newVal:Float = endPos;
			if (newVal < 0 ) newVal = 0;
			else if (newVal > mouseRange) newVal = mouseRange; 
			if(lastVal != newVal ){
				lastVal = newVal;
				updatePos(lastVal/mouseRange);
			}
		}
	}
	
	private function move(jumpTo:Bool):Void{
		jumpHorizontal(jumpTo);
		endPos = scrollbarHandle.x;
	}
	
	private function jumpHorizontal(jumpTo:Bool):Void{
		if(jumpTo == CONST.LEFT){
			lastVal -= scrollbarHandle.width;
			if(lastVal <0) lastVal = 0;
		}
		else{
			lastVal += scrollbarHandle.width;
			if(lastVal > this.width - scrollbarHandle.width) lastVal = this.width - scrollbarHandle.width;
		}
		updatePos(lastVal/mouseRange);
	}
	
	private function jumpVertical(jumpTo:Bool):Void{
		if(jumpTo == CONST.LEFT){
			lastVal -= scrollbarHandle.width;
			if(lastVal <0) lastVal = 0;
		}
		else{
			lastVal += scrollbarHandle.width;
			if(lastVal > this.width - scrollbarHandle.width) lastVal = this.width - scrollbarHandle.width;
		}
		endPos = scrollbarHandle.x;
	}
	
	private function movePosOnResize():Void
	{
		if(pos > 0){
		//	if(update)  update(pos);
		}
	}
}