import flash.geom.Point;
import flash.events.Event;

class GreetingsView extends VectorsView, implements IView{


  public function new(greetingsController:IController){	
    super(greetingsController);
    vectorsPane           = new GreetingsPane(greetingsController);
    verticalScrollbar     = new VerticalScrollbar(greetingsController, EVENT_ID.GREETING_SCROLL);
    Preset.addEventListener(EVENT_ID.GREETINGS_LOADED, onVectorLoaded);
  }
  
  override public function init():Void{
                           
    selectButton.init( controller,
              new Point(190,30), 
              new GreetingsViewButton(), 
              new Parameter( EVENT_ID.SHOW_GREETINGS));
    
    addVectorButton.init(controller,
            new Point(150,22), 
            new AddGreetingButton(), 
            new Parameter( EVENT_ID.ADD_GREETING_TO_PAGE));
    
    super.init();
  }
  
  override private function onVectorLoaded(e:KEvent):Void{

    for(greeting in e.getXml().elementsNamed('greeting')){
      var param:IParameter = new Parameter(EVENT_ID.ADD_GREETING_BUTTON);
      param.setXml(greeting);
      vectorsPane.setParam(param);
    }
  }

  override public function setParam(param:IParameter):Void{
    switch( param.getLabel() ){
      case EVENT_ID.GREETING_SELECTED: {
        vectorsPane.setParam(param);
      }
    }
	}
	
	override public function setFloat(id:String, f:Float):Void{
    switch ( id ) {
      case EVENT_ID.GREETING_SCROLL:{
        vectorsPane.y = -(vectorsPane.getFloat('height')-scrollPane.getFloat('mask_height')) * f;
      }
    }
	}
}

