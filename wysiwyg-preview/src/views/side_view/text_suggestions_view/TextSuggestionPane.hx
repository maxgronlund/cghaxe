import flash.events.Event;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.geom.Point;
import flash.Vector;

class TextSuggestionPane extends View, implements IView{

	private var selectedButton:Int;
	private var placeholderButtons:Vector<OneStateTextAndImageButton>;
	private var buttonIndex:UInt;
	private var buttonPos:UInt;

	
	
	public function new(textController:IController){	
		super(textController);
		bmpData 				= new BitmapData(172,20,false, COLOR.SCROLLPANE );
		backdrop				= new Bitmap(bmpData);
		
		placeholderButtons = new Vector<OneStateTextAndImageButton>();
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
      case EVENT_ID.ADD_SUGGESTION_BUTTON:{
        param.setLabel(EVENT_ID.TEXT_SUGGESTION_SELECTED);
        addButton(param);
      
      }
      case EVENT_ID.TEXT_SUGGESTION_SELECTED:{
        selectButton( param.getInt());
      }
    }
  }
  
  private function selectButton(btn:Int):Void{

    placeholderButtons[selectedButton].setOn(false);
    placeholderButtons[btn].setOn(true);
    selectedButton = btn;
  }
  
  private function addButton(param:IParameter	):Void{

		
		var placeholderTitle:String;

		// get title from xml
		for( title in param.getXml().elementsNamed("title") ) {
      placeholderTitle = title.firstChild().nodeValue;
      param.setString(placeholderTitle);
    }
    
    param.setXml(param.getXml());
    
    //for( place_holder_text in param.getXml().elementsNamed("place-holder-text") ) {
    //  
    //}

		param.setInt(buttonIndex);
		var oneStateTextAndImageButton:OneStateTextAndImageButton = new OneStateTextAndImageButton();
		oneStateTextAndImageButton.init( controller, new Point(171, 27), new PlaceholderButton(), param );
		oneStateTextAndImageButton.fireOnMouseUp(false);
		oneStateTextAndImageButton.jumpBack(false);
		oneStateTextAndImageButton.setText(placeholderTitle);
		
		placeholderButtons[buttonIndex] = oneStateTextAndImageButton;
		addChild(placeholderButtons[buttonIndex]);
		placeholderButtons[buttonIndex].y = buttonPos;
		
		buttonPos += 27;
		buttonIndex++;
		// always select first button
		selectButton(0);
		
		
		
		//var param:IParameter = new Parameter(fontPackage.screenName, PARAM_TYPE.FONT_PACKAGE);
		//param.setFontPackage(fontPackage);
		//param.setInt(buttonIndex);
    //
		//fontButton.init(controller, new Point(171,27), bmp, param);
		//fontButton.jumpBack(false);
		//fontButtons[buttonIndex] = fontButton;
		//addChild(fontButtons[buttonIndex]);
		//fontButtons[buttonIndex].y = buttonPos;
		//
		//buttonPos += 27;
		//buttonIndex++;
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