class LogosController extends Controller, implements IController{

  public function new(){	
  	super();
  }

  override public function setParam(param:IParameter):Void{
      
    switch ( param.getLabel() ){
      
      case EVENT_ID.SHOW_MY_UPLOADS:{
        GLOBAL.side_view.showView(EVENT_ID.SHOW_MY_UPLOADS, param.getBool());
      }
      
      case EVENT_ID.LOGO_SELECTED:{
        GLOBAL.logos_view.setParam(param);
        Logos.setParam(param);
      }
      
      case EVENT_ID.UPLOAD_LOGO:{
        Logos.setParam(param);
      }
      
      case EVENT_ID.UPLOAD_PHOTO:{
        Logos.setParam(param);
      }
      
      case EVENT_ID.PHOTO_SELECTED:{
        GLOBAL.logos_view.setParam(param);
        Logos.setParam(param);
      }

      case EVENT_ID.ADD_LOGO_TO_PAGE:{
        // EVENT_ID.FULL_COLOR
        GLOBAL.printType    = CONST.DIGITAL_PRINT;
        Logos.setParam(param);
      }
      case EVENT_ID.ADD_PHOTO_TO_PAGE:{Logos.setParam(param);}
      case EVENT_ID.LOGO_SCROLL:{GLOBAL.logos_view.setFloat(EVENT_ID.LOGO_SCROLL, param.getFloat());}
      case EVENT_ID.PHOTO_SCROLL:{GLOBAL.logos_view.setFloat(EVENT_ID.PHOTO_SCROLL, param.getFloat());}
    }	
  }

  //private function onScroll(param:IParameter):Void{
  //  switch ( param.getLabel() ){
  //    case EVENT_ID.LOGO_SCROLL:{
  //      GLOBAL.logos_view.setFloat(EVENT_ID.LOGO_SCROLL, param.getFloat());
  //    }
  //  }	
	//}
}
