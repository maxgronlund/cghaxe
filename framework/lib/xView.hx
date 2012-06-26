import flash.events.Event;
import flash.display.BitmapData;
import flash.display.Bitmap;

//import flash.Vector;

class View extends AView
{
	private var controller:IController;
	private var model:IModel;

	private var bmpData:BitmapData;
	private var backdrop:Bitmap;
	
	public function new(controller:IController){
		super(controller);
		this.controller = controller;
		addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
	}
	
	override public function addView(view:AView, posX:Int, posY:Int, id:String = null):Void{
		addChild(view);
		view.x = posX;
		view.y = posY;
	}
	
	override public function onAddedToStage(e:Event):Void{
		removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
	}
	
	override public function onRemovedFromStage(e:Event):Void{
		removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
	}
}