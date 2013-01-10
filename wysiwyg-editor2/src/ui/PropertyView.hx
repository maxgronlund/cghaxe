import flash.events.Event;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.geom.Point;

class PropertyView extends View, implements IView{
	
  public var selectButton:PropertyButton;
  
  
  
  public function new(textController:IController){	
    super(textController);
    selectButton    = new PropertyButton();
  }
  
  override public function onAddedToStage(e:Event){
    super.onAddedToStage(e);
    addChild(selectButton);
  }
  
  override public function update(id:String, index:Int, value:String):Void{
    switch ( id ){
      case 'deselect':{
        selectButton.setOn(false);
      }
      case 'select':{
        selectButton.setOn(true);
      }
    }
  }
}