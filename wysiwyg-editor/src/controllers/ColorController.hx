class ColorController extends Controller, implements IController{

  public function new(){	
  	super();
  }

  override public function setParam(param:IParameter):Void{
    switch ( param.getLabel() ){
      case EVENT_ID.SHOW_COLOR_PICKERS:{
        GLOBAL.side_view.showView(EVENT_ID.SHOW_COLOR_PICKERS, true);
      }
      case EVENT_ID.STD_PMS_COLOR_SELECTED:{ onStdPmsColorSelected(param);}
      case EVENT_ID.FOIL_COLOR_SELECTED:{ onFoilColorSelected(param);}
      case EVENT_ID.COLOR_SELECTED:{ onColorSelected(param);}

      //case EVENT_ID.GREETING_SELECTED:{
      //  GLOBAL.greetings_view.setParam(param);
      //  Greetings.setParam(param);
      //}
      //
      //case EVENT_ID.ADD_GREETING_TO_PAGE:{Greetings.setParam(param);}
      //case EVENT_ID.GREETING_SCROLL:{GLOBAL.greetings_view.setFloat(EVENT_ID.GREETING_SCROLL, param.getFloat());}
      //case EVENT_ID.OPEN_GREETING_COLOR_PICKER: GLOBAL.greetings_view.setParam(param);
      //case EVENT_ID.GREETING_COLOR_SELECTED: onGreetinColorSelected(param);
      //case EVENT_ID.NO_GREETING_COLOR_SELECTED:GLOBAL.text_view.setParam(param);
    }	
  }
  
  private function onStdPmsColorSelected(param:IParameter):Void{
    GLOBAL.printType    = CONST.STD_PMS_COLOR;
    GLOBAL.stdPmsColor  = param.getUInt();
    GLOBAL.text_view.setParam(param);
    Pages.setParam(new Parameter(EVENT_ID.UPDATE_PLACEHOLDER));
    Pages.setParam(param);
  }
  
  private function onFoilColorSelected(param:IParameter):Void{
    GLOBAL.printType    = CONST.FOIL_COLOR;
    GLOBAL.foilColor  = param.getString();
    GLOBAL.text_view.setParam(param);
    Pages.setParam(new Parameter(EVENT_ID.UPDATE_PLACEHOLDER));
  }
  private function onColorSelected(param:IParameter):Void{
    GLOBAL.printType    = CONST.LASER_COLOR;
    GLOBAL.laserColor  = param.getUInt();
    GLOBAL.text_view.setParam(param);
    Pages.setParam(new Parameter(EVENT_ID.UPDATE_PLACEHOLDER));
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
