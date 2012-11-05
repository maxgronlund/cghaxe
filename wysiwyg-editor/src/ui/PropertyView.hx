import flash.events.Event;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.geom.Point;

class PropertyView extends View, implements IView{
	
  public var selectButton:PropertyButton;
  private var blindBmp:Bitmap;
  
  
  
  
  public function new(textController:IController){	
    super(textController);
    selectButton    = new PropertyButton();
    blindBmp        = new Bitmap(new BitmapData(190,486,false,0xDEDEDE ));
  }
  
  override public function onAddedToStage(e:Event){
    super.onAddedToStage(e);
    if(backdrop != null){
      addChild(backdrop);
      backdrop.y = 30;
    }
      
    addChild(selectButton);
    addChild(blindBmp);
    blindBmp.y = 30;
  }
  
  override public function update(id:String, index:Int, value:String):Void{
    switch ( id ){
      case 'deselect':{
        selectButton.setOn(false);
        blindBmp.visible = false;
        this.setChildIndex(blindBmp, this.numChildren - 1);
      }
      case 'select':{
        selectButton.setOn(true);
        blindBmp.visible = false;
      }
    }
  }
}