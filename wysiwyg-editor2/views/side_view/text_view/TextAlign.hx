import flash.events.Event;
import flash.geom.Point;

class TextAlign extends View
{
  private var textAlingLeftButton:OneStateButton;
  private var textAlingCenterButton:OneStateButton;
  private var textAlingRightButton:OneStateButton;
  
  
  
  public function new(textController:IController){	
  	super(textController);	
  	
  	textAlingLeftButton = new OneStateButton();
  	textAlingCenterButton = new OneStateButton();
  	textAlingRightButton = new OneStateButton();
  }
  
  override public function init():Void { 
  	textAlingLeftButton.init( controller,
          new Point(32,32), 
          new TextAlignLeftButton(), 
          new Parameter( EVENT_ID.ALIGN_LEFT));
  	textAlingLeftButton.jumpBack(false);
  	textAlingLeftButton.fireOnMouseUp(false);
  	
  
  	textAlingCenterButton.init( controller,
          new Point(32,32), 
          new TextAlignCenterButton(), 
          new Parameter( EVENT_ID.ALIGN_CENTER));
  	textAlingCenterButton.jumpBack(false);
  	textAlingCenterButton.fireOnMouseUp(false);
  
  	textAlingRightButton.init( controller,
          new Point(32,32), 
          new TextAlignRightButton(), 
          new Parameter( EVENT_ID.ALIGN_RIGHT));
  	textAlingRightButton.jumpBack(false);
  	textAlingRightButton.fireOnMouseUp(false);
  	
  	Application.addEventListener(EVENT_ID.UPDATE_SIDE_VIEWS, onUpdateSideView);
  }
  
  private function onUpdateSideView(e:IKEvent):Void{
	  if(GLOBAL.GLOBAL.Font.fontAlign == 'left'){
	    setLeft();
	  }
	  else if(GLOBAL.GLOBAL.Font.fontAlign == 'center'){
	    setLCenter();
	  }
	  else if(GLOBAL.GLOBAL.Font.fontAlign == 'right'){
	    setRight();
	  }
	}
  
  override public function onAddedToStage(e:Event){
  	super.onAddedToStage(e);
  	addChild(textAlingLeftButton);
  	addChild(textAlingCenterButton);
  	textAlingCenterButton.x = 32;
  	addChild(textAlingRightButton);
  	textAlingRightButton.x = 64;
  }
  
  
  
  override public function setParam(param:IParameter):Void{
    switch ( param.getLabel() ){
      case EVENT_ID.ALIGN_LEFT: setLeft();
      case EVENT_ID.ALIGN_CENTER: setLCenter();
      case EVENT_ID.ALIGN_RIGHT:  setRight();
      //case EVENT_ID.UPDATE_TEXT_TOOLS: setSelectedButton();

    }
	}

  
  private function setLeft():Void{
    textAlingLeftButton.setOn(true);
    textAlingCenterButton.setOn(false);
    textAlingRightButton.setOn(false);
  }
  
  private function setLCenter():Void{
    textAlingLeftButton.setOn(false);
    textAlingCenterButton.setOn(true);
    textAlingRightButton.setOn(false);
  }
  
  private function setRight():Void{
    textAlingLeftButton.setOn(false);
    textAlingCenterButton.setOn(false);
    textAlingRightButton.setOn(true);
  }
  
	
}