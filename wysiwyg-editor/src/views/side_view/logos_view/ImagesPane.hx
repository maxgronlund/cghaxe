import flash.events.Event;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.geom.Point;
import flash.Vector;

class ImagesPane extends View, implements IView{
  
  private var selectedButton:Int;
  private var vectorsButtons:Vector<OneStateTextAndImageButton>;
  private var buttonIndex:UInt;
  private var buttonPos:UInt;

  
  public function new(vectorsController:IController){	
    super(vectorsController);
    bmpData         = new BitmapData(172,20,false, COLOR.SCROLLPANE );
    backdrop        = new Bitmap(bmpData);
    
    vectorsButtons  = new Vector<OneStateTextAndImageButton>();
    buttonIndex	    = 0;
    selectedButton  = 0;
    buttonPos     	= 0;
    selectedButton  = 0;
  }
  
  override public function init():Void{
  
  }
  
  override public function onAddedToStage(e:Event):Void{
  
  	super.onAddedToStage(e);
  	addChild(backdrop);
  
  }


  override public function setParam(param:IParameter):Void{
    trace('add image', param.getLabel(), EVENT_ID.ADD_IMAGE_BUTTON);
    switch ( param.getLabel() ){
      case EVENT_ID.ADD_IMAGE_BUTTON:{
        param.setLabel(EVENT_ID.IMAGE_SELECTED);
        addButton(param);
      }
      
      case EVENT_ID.IMAGE_SELECTED:{
        selectButton( param.getInt());
      }
    }
  }
  
  private function selectButton(id:Int):Void{
    if(id != selectedButton){
      vectorsButtons[selectedButton].setOn(false);
      vectorsButtons[id].setOn(true);
      selectedButton = id;
    }
    
  }
  
  private function addButton(param:IParameter	):Void{
    
    var vectorTitle:String = 'Image-'+Std.string(buttonIndex);
    param.setString(vectorTitle);
    param.setInt(buttonIndex);
    var oneStateTextAndImageButton:OneStateTextAndImageButton = new OneStateTextAndImageButton();
    oneStateTextAndImageButton.init( controller, new Point(171, 27), new PlaceholderButton(), param );
    oneStateTextAndImageButton.fireOnMouseUp(false);
    oneStateTextAndImageButton.jumpBack(false);
    oneStateTextAndImageButton.setText(vectorTitle);
    
    vectorsButtons[buttonIndex] = oneStateTextAndImageButton;
    addChild(vectorsButtons[buttonIndex]);
    vectorsButtons[buttonIndex].y = buttonPos;
    
    buttonPos += 27;
    buttonIndex++;
    
    selectButton(0);

    
	}


  override public function getFloat(id:String):Float{
    switch ( id ){
      case 'height':
        return buttonPos;
    }
    return 0;
  }
  
  override public function setString(id:String, s:String):Void{

  }

  
}