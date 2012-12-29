import flash.geom.Point;
import flash.events.Event;
import flash.Vector;

class SymbolImageDialog extends View, implements IView
{
  private var _rect:Rectangle;
  private var _vectorsButtons:Vector<ImageButton>;
  
  private var _buttonIndex:UInt;
  private var _buttonPos:UInt;
  private var _selectedButton:Int;
  
  private var _imgWidth :Int = 50;
  private var _imgHeight :Int = 50;
  private var _imgOff :Int = 5;
  

  
  public function new(logosController:IController){	
    super(logosController);
  
    //_rect        = new Rectangle(560, 440, 0x000000, 0xC8C8C8, Rectangle.DONT_DRAW_LINES, Rectangle.USE_FILL);	
	
	_vectorsButtons = new Vector<ImageButton>();
  }
  override public function init():Void{
    
  }
    
  override public function onAddedToStage(e:Event):Void{
    super.onAddedToStage(e);
    //addChild(_rect);

  }
  
  override public function setParam(param:IParameter):Void{
    
    switch ( param.getLabel() ){
      case EVENT_ID.ADD_SYMBOL_BUTTON:{
        param.setLabel(EVENT_ID.SYMBOL_SELECTED);
        addButton(param);
      }
      case EVENT_ID.SYMBOL_SELECTED:{
        selectButton( param.getInt());
      }
    }
  }
  
   private function addButton(param:IParameter	):Void
   {

		var vectorURL:String;
		
		for( url in param.getXml().elementsNamed("url") ) {
		  vectorURL = url.firstChild().nodeValue;
		  param.setString(vectorURL);
		}
	
		 param.setInt(_buttonIndex);
		 var imgBtn = new ImageButton();
		 imgBtn.setSize(_imgWidth, _imgHeight);
		 imgBtn.init(controller, param, vectorURL);
		 
		 /*
		 var overParam :Parameter = new Parameter(EVENT_ID.GREETING_PREVIEW);
		overParam.setXml(param.getXml());
		 var outParam :Parameter = new Parameter(EVENT_ID.GREETING_FINISH_PREVIEW);
		outParam.setXml(param.getXml());
		imgBtn.initOverOut(overParam, outParam);
		*/
		 
		 
		 imgBtn.fireOnMouseUp(false);
		 imgBtn.jumpBack(false);
	 
		_vectorsButtons[_buttonIndex] = imgBtn;
		addChild(_vectorsButtons[_buttonIndex]);
		_vectorsButtons[_buttonIndex].x = (_buttonIndex % 3) * (_imgWidth + _imgOff);
		_vectorsButtons[_buttonIndex].y = _buttonPos;
		if ((_buttonIndex % 3) == 2)_buttonPos += _imgHeight + _imgOff;
		_buttonIndex++;
		selectButton(0);
   }
   
   private function selectButton(id:Int):Void{
    if(id != _selectedButton){
      _vectorsButtons[_selectedButton].setOn(false);
      _vectorsButtons[id].setOn(true);
      _selectedButton = id;
    }
  }
   
   override public function getFloat(id:String):Float{
    switch ( id ){
      case 'height':
		  var h :Int = Math.ceil(_buttonIndex / 3) * (_imgHeight + _imgOff);
		  return h;
    }
    return 0;
  }
}