import flash.events.Event;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Shape;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.Vector;

class DropDownMenu extends DropDownMenuContent {
	
//	private var textController:IController;
  private var oneStateTextAndImageButton:OneStateTextAndImageButton;     
  private var buttonBmp:Bitmap;
  
  public function new( controller:IController, buttonBmp:Bitmap, param:Parameter, width:Int, sizeX:Int) {

    super(controller,buttonBmp, param, sizeX);
    this.buttonBmp		= buttonBmp;

    oneStateTextAndImageButton = new OneStateTextAndImageButton();
    oneStateTextAndImageButton.init( controller, new Point(width,buttonBmp.height), buttonBmp, param );
    oneStateTextAndImageButton.setCallback(openMenu);

  }

  override private function onAddedToStage(e:Event){

    super.onAddedToStage(e);
    addChild(oneStateTextAndImageButton);
    oneStateTextAndImageButton.setText('');
  }
  
  override public function selectItem(id:Int):Void{
    
    super.selectItem(id);
    //oneStateTextAndImageButton.setText(getItemtemName(id));
    //trace(getItemtemName(id));
  }
  
  override public function deselectItem( id:Int ): Void{
    super.deselectItem(id);
    oneStateTextAndImageButton.setText(getItemtemName(id));
    closeOnMouseUp();
  }
  
  override public function show(b:Bool): Void{
    if(b) this.setChildIndex(backdrop, this.numChildren - 1);
    super.show(b);
  }
  
  public function setDisplay(s:String):Void{
    oneStateTextAndImageButton.setText(s);
    oneStateTextAndImageButton.updateLabel();
  }
  
  override public function setItem(s:String):Void{

   super.setItem(s);
   oneStateTextAndImageButton.setText(s);
   oneStateTextAndImageButton.updateLabel();
  }
}