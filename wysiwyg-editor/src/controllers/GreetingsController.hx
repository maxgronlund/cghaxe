class GreetingsController extends Controller, implements IController{

  public function new(){	
  	super();
  }

  override public function setParam(param:IParameter):Void {
	 
	  var qqq :String = param.getLabel();
    switch ( param.getLabel() ){
      case EVENT_ID.SHOW_GREETINGS:{
        GLOBAL.side_view.showView(EVENT_ID.SHOW_GREETINGS, param.getBool());
		Greetings.setParam(param);
      }
      case EVENT_ID.GREETING_SELECTED:{
        GLOBAL.greetings_view.setParam(param);
        Greetings.setParam(param);
      }
      case EVENT_ID.ADD_GREETING_TO_PAGE:
		  {
			  Greetings.setParam(param);
		  }
      case EVENT_ID.GREETING_SCROLL: { GLOBAL.greetings_view.setFloat(EVENT_ID.GREETING_SCROLL, param.getFloat()); }
	 
	  case EVENT_ID.GREETING_PREVIEW:
		{
			Greetings.setParam(param);
			
			/*
			var toolTipParam :Parameter = new Parameter(TOOL_TIPS.GREETINGS_PREVIEW);
			toolTipParam.setXml(param.getXml());
			GLOBAL.tool_tips_controller.setParam(param);
			*/
		}
		
	case EVENT_ID.GREETING_FINISH_PREVIEW:
		{
			Greetings.setParam(param);
		}

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
