import flash.events.Event;
import flash.events.MouseEvent;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.geom.Point;

class TwoStateTextButton extends MouseHandler
{
	
	
	private var controller:IController;
	private var mouseDown:Bool;
	private var mouseOver:Bool;
	private var param:IParameter;
	private var selected:Bool;	
	private var text:String;
	private var id:Int;
	private var font:String;
	private var bmpData:BitmapData;
	private var backdrop:Bitmap;
	private var backdropHeight:Int;

	
	private var formattedText:FormatedText;


	public function new(){
		super();
		addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
	}
	
	public function init( controller:IController,  
                        param:IParameter, 
                        text:String,
                        id:Int, 
                        font:String,
                        backdropHeight:Int){

		this.controller = controller;
		this.param	 		= param;
		this.text       = text;
		this.id					= id;
		bmpData 				= new BitmapData( 10, backdropHeight,false,0x888888 );
		backdrop				= new Bitmap(bmpData);
		mouseDown 			= false;
		mouseOver 			= false;
		selected				= false;
		formattedText 	= new FormatedText(font, text, 12, false);
		
		addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
	}
	
	public function onAddedToStage(e:Event):Void{	
		removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		addChild(backdrop);
		addChild(formattedText);
		
		var txtPosY:Float = (backdrop.height-formattedText.height)/2;

		formattedText.x = 8;
		formattedText.y = txtPosY;
		formattedText.setColor(COLOR.DESELECTED);
		backdrop.alpha = 0;
		backdrop.width = formattedText.width + 20;
		if(backdrop.width < 28) backdrop.width = 28;
	}
	
	override private function onMouseOver(e:MouseEvent){	
		super.onMouseOver(e); 
		setState(selected ? 2:1);
		backdrop.alpha = 0.5;
		mouseOver = true;
	}

	override private function onMouseOut(e:MouseEvent){	
		super.onMouseOut(e); 
		setState(selected ? 2:0);
		backdrop.alpha = 0.0;
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
		switch ( state )
		{
			case 0:
				formattedText.setColor( COLOR.DESELECTED);
			case 1:
				formattedText.setColor( COLOR.MOUSE_OVER);
			case 2:
				formattedText.setColor( COLOR.SELECTED);
		}
	}

	public function setOn(b:Bool):Void{
		selected = b;
		setState(b?2:0);
	}	
	public function getWidth():Float{
		return width;
	}
	
	public function bang():Void{
	  controller.setParam(param);
	  setOn(true);
	}
	
	public function getId():Int{
		return id;
	}
	
	public function getText():String{
	  //trace(text);
		return text;
	}
	
	public function enable(b:Bool):Void{
	  this.alpha = b ? 1.0 : 0.2;
	  enableMouse(b);
	}
	

}

