import flash.events.Event;
import flash.events.MouseEvent;
import flash.display.Bitmap;




class VerticalScrollbarHandle extends View, implements IView
{
//	private var horizontal:Bool;
	private var minHandle:Bitmap;
	private var centerHandle:Bitmap;
	private var maxHandle:Bitmap;
	private var minHandleHeight:Float;
	private var mouseOver:Bool;
	private var ratio:Float;

	
	public function new(controller:IController){	
		super(controller);	
//		this.horizontal 	= horizontal;	
		this.maxHandle		= new VerticalScrollHandleMax();
		this.centerHandle = new VerticalScrollHandleCenter();
		this.minHandle 		= new VerticalScrollHandleMin();
		mouseOver 	= false;
	} 
	
	override public function onAddedToStage(e:Event):Void{	
		super.onAddedToStage(e);
		addChild(minHandle);
		addChild(centerHandle);
		addChild(maxHandle);	
		minHandleHeight = minHandle.height + centerHandle.height + maxHandle.height;
		

		addEventListener(MouseEvent.ROLL_OVER, onMouseOver);

		// else {} add vertical code here	
	}
	
	override public function setSize(paneHeight:Int, maskHeight:Int):Void{
//			trace(paneHeight, maskHeight);
			
			ratio		= maskHeight/paneHeight;
		  var handleHeight 	= Math.abs(ratio * maskHeight);
		  if(handleHeight < minHandleHeight) handleHeight = minHandleHeight;
			centerHandle.y 				= maxHandle.height-1;
			centerHandle.height 	= Std.int(handleHeight - (minHandle.height + maxHandle.height))+2;
			minHandle.y = maxHandle.height + centerHandle.height-2; 
			
			this.height = minHandle.y + minHandle.height;
			
		
	}
	
	override public function getFloat(id:String):Float{
		switch ( id ){
			case 'ratio':
				return ratio;
		}
		return 0.0;
	}
	
	private function onMouseOver(e:MouseEvent):Void{
		removeEventListener(MouseEvent.ROLL_OVER, onMouseOver);
		mouseOver = true;
		addEventListener(MouseEvent.ROLL_OUT, onMouseOut);	
  }
  private function onMouseOut(e:MouseEvent){
		
    removeEventListener(MouseEvent.ROLL_OUT, onMouseOut);
		mouseOver = false;
    addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
  }
	public function hasMouseOver():Bool{
		return mouseOver;
	}
	

}