package;

import flash.events.Event;
import flash.display.BitmapData;
import flash.display.Bitmap;

//import flash.Vector;

class ScrollView extends AScrollView
{
	
//	private var childViews:Vector<IView>;
	private var controller:IController;
	private var model:IModel;

	// data
	private var bmpData:BitmapData;
	private var backdrop:Bitmap;
	private var sizeX:Int;
	private var sizeY:Int;
	
	public function new(controller:IController)
	{
		super(controller);
		this.controller = controller;
		addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
	}
	
	override public function setSize(sizeX:Int, sizeY:Int):Void{
		this.sizeX = sizeX;
		this.sizeY = sizeY;
	}
	
	override public function addView(view:AView, posX:Int, posY:Int, id:String = null):Void{
		addChild(view);
		view.x = posX;
		view.y = posY;
	}
	
	override public function onAddedToStage(e:Event){
		removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
	}
	
	override public function scrollTo(posX:Float, posY:Float){
		
		this.x = posX;
		this.y = posY;
	}

}