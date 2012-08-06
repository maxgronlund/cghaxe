import flash.events.Event;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.geom.Point;
import flash.Vector;

class DesignsPane extends View, implements IView{

	private var selectedButton:Int;
	private var designsButtons:Vector<OneStateTextAndImageButton>;
	private var buttonIndex:UInt;
	private var buttonPos:UInt;

	
	
	public function new(designsController:IController){	
		super(designsController);
		bmpData 				= new BitmapData(172,20,false, COLOR.SCROLLPANE );
		backdrop				= new Bitmap(bmpData);
		
		designsButtons = new Vector<OneStateTextAndImageButton>();
		buttonIndex	= 0;
		selectedButton = 0;
		buttonPos	= 0;
		selectedButton = 0;
	}
	
	override public function init():Void{

	}
	
	override public function onAddedToStage(e:Event):Void{

		super.onAddedToStage(e);
		addChild(backdrop);

	}

	
  override public function setParam(param:IParameter):Void{
    
    switch ( param.getLabel() ){
      case EVENT_ID.ADD_DESIGN_BUTTON:{
        param.setLabel(EVENT_ID.DESIGN_SELECTED);
        addButton(param);
      }
      
      case EVENT_ID.DESIGN_SELECTED:{
        selectButton( param.getInt());
      }
    }
  }
  
  private function selectButton(id:Int):Void{
    if(id != selectedButton){
      designsButtons[selectedButton].setOn(false);
      designsButtons[id].setOn(true);
      selectedButton = id;
    }
    
  }
  
  private function addButton(param:IParameter	):Void{

    var designTitle:String;
    
    for( title in param.getXml().elementsNamed("title") ) {
      designTitle = title.firstChild().nodeValue;
      param.setString(designTitle);
      //trace(param.getXml().toString());
      //trace(param.getXml().toString());
      //param.setXml(param.getXml());
    }
    param.setInt(buttonIndex);
    var oneStateTextAndImageButton:OneStateTextAndImageButton = new OneStateTextAndImageButton();
    oneStateTextAndImageButton.init( controller, new Point(171, 27), new PlaceholderButton(), param );
    oneStateTextAndImageButton.fireOnMouseUp(false);
    oneStateTextAndImageButton.jumpBack(false);
    oneStateTextAndImageButton.setText(designTitle);
    
    designsButtons[buttonIndex] = oneStateTextAndImageButton;
    addChild(designsButtons[buttonIndex]);
    designsButtons[buttonIndex].y = buttonPos;
    
    buttonPos += 27;
    buttonIndex++;
    
    selectButton(0);
    
  //  trace(param.getXml().toString());
    
	}


	override public function getFloat(id:String):Float{
		//switch ( id ){
		//	case 'height':
		//		return buttonPos;
		//}
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
	
	public function doStuff():Void{
	  
	}
	

	
}