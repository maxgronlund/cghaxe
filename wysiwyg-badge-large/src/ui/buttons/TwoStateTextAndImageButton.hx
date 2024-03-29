import flash.events.Event;
import flash.events.MouseEvent;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.geom.Point;

class TwoStateTextAndImageButton extends TwoStateTextButton
{
	public function new(){
		super();
	}
	
	override public function init( 	controller:IController,  
																	param:IParameter, 
																	text:String,
																	id:Int, 
																	font:String,
																	bmp:Bitmap,
																	backdropHeight:Int){
		super.init(controller, param, text, id, font, backdropHeight);

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

		}

		setState(param.getBool());

		newState = param.getBool();
	}
	
	private function setState(state:Bool):Void{
		if (mouseOver)
			multiStateImage.state(new Point(state? 3:1,0));
		else
			multiStateImage.state(new Point(state? 2:0,0));
	}
	


}

