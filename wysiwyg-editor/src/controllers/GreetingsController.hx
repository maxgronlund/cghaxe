class GreetingsController extends Controller, implements IController{

  public function new(){	
  	super();
  }

  override public function setParam(param:IParameter):Void{
    switch ( param.getLabel() ){
      case EVENT_ID.SHOW_GREETINGS:{
        GLOBAL.side_view.showView(EVENT_ID.SHOW_GREETINGS, param.getBool());
      }
      case EVENT_ID.GREETING_SELECTED:{
        GLOBAL.greetings_view.setParam(param);
        Greetings.setParam(param);
      }

      case EVENT_ID.ADD_GREETING_TO_PAGE:{Greetings.setParam(param);}
      case EVENT_ID.GREETING_SCROLL:{GLOBAL.greetings_view.setFloat(EVENT_ID.GREETING_SCROLL, param.getFloat());}

    }	
  }
  
  private function onScroll(param:IParameter):Void{
    switch ( param.getLabel() ){
      case EVENT_ID.GREETING_SCROLL:{
        GLOBAL.greetings_view.setFloat(EVENT_ID.GREETING_SCROLL, param.getFloat());
      }
    }	
	}
}
