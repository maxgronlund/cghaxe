import flash.events.MouseEvent;
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
  
  private var _imgWidth :Int;
  private var _imgHeight :Int;
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
	this.x = 10;
  }
  
  override public function setParam(param:IParameter):Void{
    
    switch ( param.getLabel() ){
      case EVENT_ID.ADD_SYMBOL_BUTTON:{
        param.setLabel(EVENT_ID.START_DRAG_SYMBOL);
        _imgWidth = 50;
		_imgHeight = 50;
		addButton(param);
      }
      case EVENT_ID.SYMBOL_SELECTED:{
        selectButton( param.getInt());
      }
	  case EVENT_ID.ADD_LOGO_BUTTON:{
        param.setLabel(EVENT_ID.START_DRAG_LOGO);
        _imgWidth = 152;
		_imgHeight = 152;
		addButton(param);
		
      }
	  case EVENT_ID.ADD_IMAGE_BUTTON:{
        param.setLabel(EVENT_ID.START_DRAG_LOGO);
		_imgWidth = 152;
		_imgHeight = 152;
        addButton(param);
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
		 var imgDragBtn = new ImageDragButton();
		 imgDragBtn.setSize(_imgWidth, _imgHeight);
		 imgDragBtn.init(controller, param, vectorURL);
		 imgDragBtn.addEventListener(EVENT_ID.LOAD_NEXT_IMAGE,onLoadNextImage);
		 
		 imgDragBtn.fireOnMouseUp(false);
		 imgDragBtn.jumpBack(false);
	 
		_vectorsButtons[_buttonIndex] = imgDragBtn;
		addChild(_vectorsButtons[_buttonIndex]);
		
		if (param.getLabel() == EVENT_ID.START_DRAG_LOGO)
		{
			_vectorsButtons[_buttonIndex].x = 5;
			_vectorsButtons[_buttonIndex].y = _buttonPos;
			_buttonPos += _imgHeight + _imgOff;
		}
		else
		{
			_vectorsButtons[_buttonIndex].x = (_buttonIndex % 3) * (_imgWidth + _imgOff)+5;
			_vectorsButtons[_buttonIndex].y = _buttonPos;
			if ((_buttonIndex % 3) == 2)_buttonPos += _imgHeight + _imgOff;
		}
		
		
		_buttonIndex++;
		selectButton(0);
   }
   
    private function onLoadNextImage(e:KEvent):Void {
	   dispatchEvent(new KEvent(EVENT_ID.LOAD_NEXT_IMAGE,e.getParam()));
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
	  case 'logo_height':
		  var h :Int = Math.ceil(_buttonIndex) * (_imgHeight + _imgOff);
		  return h;
    }
    return 0;
  }
  
  

}