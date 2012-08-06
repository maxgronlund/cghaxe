class GreetingsController extends Controller, implements IController{

  public function new(){	
  	super();
  }

  override public function setParam(param:IParameter):Void{
    switch ( param.getLabel() ){
      case EVENT_ID.SHOW_GREETINGS:{
        GLOBAL.side_view.showView(EVENT_ID.SHOW_GREETINGS, true);
      }
      case EVENT_ID.GREETING_SELECTED:{
        GLOBAL.greetings_view.setParam(param);
        Greetings.setParam(param);
      }

      case EVENT_ID.ADD_GREETING_TO_PAGE:{Greetings.setParam(param);}
      case EVENT_ID.GREETING_SCROLL:{GLOBAL.greetings_view.setFloat(EVENT_ID.GREETING_SCROLL, param.getFloat());}
      //case EVENT_ID.OPEN_GREETING_COLOR_PICKER: GLOBAL.greetings_view.setParam(param);
      //case EVENT_ID.GREETING_COLOR_SELECTED: onGreetinColorSelected(param);
      //case EVENT_ID.NO_GREETING_COLOR_SELECTED:GLOBAL.text_view.setParam(param);
    }	
  }
  
  private function onScroll(param:IParameter):Void{
    switch ( param.getLabel() ){
      case EVENT_ID.GREETING_SCROLL:{
        GLOBAL.greetings_view.setFloat(EVENT_ID.GREETING_SCROLL, param.getFloat());
      }
    }	
	}
	
	//private function onGreetinColorSelected(param:IParameter):Void{
  //  
  //
  //  GLOBAL.greetingColor = param.getUInt();
  //  GLOBAL.greetings_view.setParam(param);
  //  Pages.setParam(new Parameter(EVENT_ID.UPDATE_PLACEHOLDER));
  //  
  //}
  
  
}
