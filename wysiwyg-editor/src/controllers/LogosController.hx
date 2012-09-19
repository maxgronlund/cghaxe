class LogosController extends Controller, implements IController{

  public function new(){	
  	super();
  }

  override public function setParam(param:IParameter):Void{
    
    switch ( param.getLabel() ){
      case EVENT_ID.SHOW_LOGOS:{
        GLOBAL.side_view.showView(EVENT_ID.SHOW_LOGOS, true);
      }
      case EVENT_ID.LOGO_SELECTED:{
        GLOBAL.logos_view.setParam(param);
        Logos.setParam(param);
      }

      case EVENT_ID.ADD_LOGO_TO_PAGE:{Logos.setParam(param);}
      case EVENT_ID.LOGO_SCROLL:{GLOBAL.logos_view.setFloat(EVENT_ID.LOGO_SCROLL, param.getFloat());}
    }	
  }

  private function onScroll(param:IParameter):Void{
    switch ( param.getLabel() ){
      case EVENT_ID.LOGO_SCROLL:{
        GLOBAL.logos_view.setFloat(EVENT_ID.LOGO_SCROLL, param.getFloat());
      }
    }	
	}
}
