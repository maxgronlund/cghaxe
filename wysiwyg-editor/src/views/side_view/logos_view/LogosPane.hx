import flash.events.Event;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.geom.Point;
import flash.Vector;

class LogosPane extends View, implements IView{
  
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
    buttonPos	      = 0;
    selectedButton  = 0;

  }
  
  override public function init():Void{
  
  }
  
  override public function onAddedToStage(e:Event):Void{
  	super.onAddedToStage(e);
  	addChild(backdrop);
  }


  override public function setParam(param:IParameter):Void{
    
    switch ( param.getLabel() ){
      case EVENT_ID.ADD_LOGO_BUTTON:{
        param.setLabel(EVENT_ID.LOGO_SELECTED);
        addButton(param);
      }
      
      case EVENT_ID.LOGO_SELECTED:{
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
    
    //var logoTitle:String = 'Logo-'+Std.string(buttonIndex);
    //
    //for(title in logo.elementsNamed('title')){
    //  logoTitle = title.firstChild().nodeValue.toString();
    //}
    //
    //
    //
    //param.setString(logoTitle);
    
    
    param.setInt(buttonIndex);
    var oneStateTextAndImageButton:OneStateTextAndImageButton = new OneStateTextAndImageButton();
    oneStateTextAndImageButton.init( controller, new Point(171, 27), new PlaceholderButton(), param );
    oneStateTextAndImageButton.fireOnMouseUp(false);
    oneStateTextAndImageButton.jumpBack(false);
    oneStateTextAndImageButton.setText(param.getString());
    
    vectorsButtons[buttonIndex] = oneStateTextAndImageButton;
    addChild(vectorsButtons[buttonIndex]);
    vectorsButtons[buttonIndex].y = buttonPos;
    
    buttonPos += 26;
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
    
    //switch ( id )	{
    //	case 'load_default_font':{
    //		fontButtons[0].setOn(true);
    //	}
    //	case EVENT_ID.FONT: selectFont(s);
    //}
  }
  
  //public function doStuff():Void{
  //  
  //}
  
  
  
}