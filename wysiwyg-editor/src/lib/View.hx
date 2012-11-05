import flash.events.Event;
import flash.display.BitmapData;
import flash.display.Bitmap;

class View extends AView{
  
  private var Zoom:ZoomTools;
  private var Application:IModel;
  private var Menu:IModel;
  private var Configuration:IModel;
  private var Preset:IModel;
  private var Pages:IModel;
  private var Designs:IModel;
  private var Vectors:IModel;
  private var Greetings:IModel;
  private var Symbols:IModel;
  private var Logos:IModel;
  private var controller:IController;
  private var bmpData:BitmapData;
  private var backdrop:Bitmap;
  private var viewId:String;
  
  public function new(controller:IController){
    
    super(controller);
    this.controller   = controller;
    Zoom              = GLOBAL.Zoom;
    Application	      = GLOBAL.Application;
    Menu      	      = GLOBAL.Menu;
    Preset            = GLOBAL.Preset;
    Pages             = GLOBAL.Pages;
    Designs           = GLOBAL.Designs;
    Greetings         = GLOBAL.Greetings;
    Symbols           = GLOBAL.Symbols;
    Logos             = GLOBAL.Logos;
    addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
  }
  
  override public function addView(view:AView, posX:Int, posY:Int, id:String = null):Void{
    view.setString('viewId', id);
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
  
  override public function setString(id:String, s:String):Void{
    switch ( id ){
      case 'viewId':
        viewId = s;
    }
  }
  override public function getString(id:String):String{
    switch ( id ) {
      case 'viewId':
         return viewId;
    }
    return 'foo';
  }
  override public function getHeight():Int{
		return 516;
	}
}