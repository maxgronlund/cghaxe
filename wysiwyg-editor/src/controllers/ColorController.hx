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
      case EVENT_ID.PMS1_COLOR_SELECTED:{ setPms1Color(param);}
      case EVENT_ID.PMS2_COLOR_SELECTED:{ setPms2Color(param);}
     
    }	
  }
  
  private function onStdPmsColorSelected(param:IParameter):Void{
    GLOBAL.printType    = CONST.STD_PMS_COLOR;
    GLOBAL.stdPmsColor  = param.getUInt();
    GLOBAL.text_view.setParam(param);
    Pages.setParam(new Parameter(EVENT_ID.UPDATE_PLACEHOLDER));
    Pages.setParam(param);
  }
  
  private function setPms1Color(param:IParameter):Void{

    if(param.getString() == 'RGB'){
      GLOBAL.pms1Color    = param.getInt();
    }else{
      var s = param.getString();
      GLOBAL.pms1ColorString    = s;
      var RGB = convertPmsStrToRgb(s);
      param.setInt(RGB);
      GLOBAL.pms1Color = RGB;
    }
    GLOBAL.printType    = CONST.CUSTOM_PMS1_COLOR;
    GLOBAL.text_view.setParam(param);
    Pages.setParam(new Parameter(EVENT_ID.UPDATE_PLACEHOLDER));
    Pages.setParam(param);
    Application.dispatchParameter(param);
  }
  
  private function setPms2Color(param:IParameter):Void{
    if(param.getString() == 'RGB'){
      GLOBAL.pms2Color    = param.getInt();
    }else{
      var s = param.getString();
      GLOBAL.pms2ColorString    = s;
      var RGB = convertPmsStrToRgb(s);
      param.setInt(RGB);
      GLOBAL.pms2Color = RGB;
    }
    GLOBAL.printType    = CONST.CUSTOM_PMS2_COLOR;
    GLOBAL.text_view.setParam(param);
    Pages.setParam(new Parameter(EVENT_ID.UPDATE_PLACEHOLDER));
    Pages.setParam(param);
    Application.dispatchParameter(param);

  }
  
  private function convertPmsStrToRgb(s:String):Int{
    // dummy parser
    trace(s);
    return Std.parseInt(s);
  }
  
  private function onFoilColorSelected(param:IParameter):Void{
    trace(GLOBAL.printType);
    GLOBAL.printType    = CONST.FOIL_COLOR;
    GLOBAL.foilColor    = param.getString();
    GLOBAL.text_view.setParam(param);
    Pages.setParam(new Parameter(EVENT_ID.UPDATE_PLACEHOLDER));
    Pages.setParam(param);
  }
  private function onColorSelected(param:IParameter):Void{
    GLOBAL.printType    = CONST.LASER_COLOR;
    GLOBAL.laserColor  = param.getUInt();
    GLOBAL.text_view.setParam(param);
    Pages.setParam(new Parameter(EVENT_ID.UPDATE_PLACEHOLDER));
    Pages.setParam(param);
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
