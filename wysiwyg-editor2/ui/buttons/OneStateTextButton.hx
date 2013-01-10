import flash.events.Event;
import flash.events.MouseEvent;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.geom.Point;

class OneStateTextButton extends MouseHandler
{
	
	private var controller:IController;
	private var mouseDown:Bool;
	private var mouseOver:Bool;
	private var param:IParameter;
	private var selected:Bool;	
	private var label:TextString;
	private var text:String;
	private var id:Int;
	private var fontName:String;
	private var bmpData:BitmapData;
	private var backdrop:Bitmap;
	private var backdropHeight:Int;


	public function new(){
		super();
		addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
	}
	
	public function init( controller:IController,  
												param:IParameter, 
												text:String,
												id:Int, 
												fontName:String,
												backdropHeight:Int){

		this.controller = controller;
		this.param	 		= param;
		this.text 	= text;
		this.id					= id;
		this.fontName 	= fontName;
		bmpData 				= new BitmapData(100,backdropHeight,false,0xff0000 );
		backdrop				= new Bitmap(bmpData);
		mouseDown 			= false;
		mouseOver 			= false;
		selected				= false;
		label 					= new TextString();
		addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
	}
	
	public function onAddedToStage(e:Event):Void{	

		removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		addChild(backdrop);
		backdrop.alpha = 0;
		
		label.init( 14 , 190,  17,  'calligraphic', false, true);
		addChild(label);
		label.text(text);
		label.x = 10;
		if(backdropHeight == 22)
			label.y = 1;
		else
			label.y = 4;
		label.color(0x888888);
		//backdrop.alpha = 0;
		backdrop.width = label.getWidth() + 20;
		backdrop.height = backdropHeight;
	}
	
	public function setText(s:String):Void{
		label.text(s);
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
		switch ( state )
		{
			case 0:
				label.color( COLOR.DESELECTED);
			case 1:
				label.color( COLOR.MOUSE_OVER);
			case 2:
				label.color( COLOR.SELECTED);
		}
	}

	public function setOn(b:Bool):Void{
		selected = b;
		setState(b?2:0);
	}	
	public function getWidth():Float{
		return width;
	}
	
	public function getId():Int{
		return id;
	}
	
	public function getText():String{
		return text;
	}
	
}

