class ColorController extends Controller, implements IController{
  private var pms_converter:PMSColorToRGBConverter;
  
  public function new(){	
  	super();
  	pms_converter = new PMSColorToRGBConverter();
  }

  override public function setParam(param:IParameter):Void{
    switch ( param.getLabel() ){
      case EVENT_ID.SHOW_COLOR_PICKERS:{
        GLOBAL.side_view.showView(EVENT_ID.SHOW_COLOR_PICKERS, param.getBool());
      }
      case EVENT_ID.STD_PMS_COLOR_SELECTED:{ onStdPmsColorSelected(param);}
      case EVENT_ID.FOIL_COLOR_SELECTED:{ onFoilColorSelected(param);}
      case EVENT_ID.COLOR_SELECTED:{ onColorSelected(param);}
      case EVENT_ID.PMS1_COLOR_SELECTED:{ onPms1ColorSelected(param);}
      case EVENT_ID.PMS2_COLOR_SELECTED:{ onPms2ColorSelected(param);}
      case EVENT_ID.UPDATE_PMS1:{ updatePms1Color(param);}
      case EVENT_ID.UPDATE_PMS2:{ updatePms2Color(param);}
      case EVENT_ID.FULL_COLOR:{onFullColorSelected(param);}
    }	
  }

  private function onStdPmsColorSelected(param:IParameter):Void{
    GLOBAL.printType    = CONST.STD_PMS_COLOR;
    GLOBAL.stdPmsColor  = param.getUInt();
    GLOBAL.text_view.setParam(param);
    Pages.setParam(new Parameter(EVENT_ID.UPDATE_PLACEHOLDER));
    Pages.setParam(param);
    //GLOBAL.color_view.setString('uncheck full color', 'fo');
  }
  
  private function onPms1ColorSelected(param:IParameter):Void{
    GLOBAL.printType        = CONST.CONST.CUSTOM_PMS1_COLOR;
    GLOBAL.pms1Color        = param.getInt();
    GLOBAL.text_view.setParam(param);
    Pages.setParam(new Parameter(EVENT_ID.UPDATE_PLACEHOLDER));
    Pages.setParam(param);
  }
  
  private function onPms2ColorSelected(param:IParameter):Void{
    GLOBAL.printType    = CONST.CONST.CUSTOM_PMS2_COLOR;
    GLOBAL.pms2Color    = param.getInt();
    GLOBAL.text_view.setParam(param);
    Pages.setParam(new Parameter(EVENT_ID.UPDATE_PLACEHOLDER));
    Pages.setParam(param);
  }
  
  private function updatePms1Color(param:IParameter):Void{
    // trickered by the text field
    GLOBAL.pms1ColorString    = param.getString();
    GLOBAL.pms1Color          = convertPmsStrToRgb(GLOBAL.pms1ColorString);
    param.setInt(GLOBAL.pms1Color);
    // update the color picker
    Application.dispatchParameter(param);
    // update all pms1 fields
    Pages.setParam(new Parameter(EVENT_ID.UPDATE_PMS1));

  }
  
  private function updatePms2Color(param:IParameter):Void{
    // trickered by the text field
    GLOBAL.pms2ColorString    = param.getString();
    GLOBAL.pms2Color          = convertPmsStrToRgb(GLOBAL.pms2ColorString);
    param.setInt(GLOBAL.pms2Color);
    // update the color picker
    Application.dispatchParameter(param);
    // update all pms2 fields
    Pages.setParam(new Parameter(EVENT_ID.UPDATE_PMS2));
  }
  
  private function convertPmsStrToRgb(s:String):Int{
    // dummy parser
    //trace(s);
    return pms_converter.convertPMSToRGB(s);
    //return Std.parseInt(s);
  }
  
  private function onFoilColorSelected(param:IParameter):Void{
    GLOBAL.printType    = CONST.FOIL_COLOR;
    GLOBAL.foilColor    = param.getString();
    GLOBAL.text_view.setParam(param);
    Pages.setParam(new Parameter(EVENT_ID.UPDATE_PLACEHOLDER));
    Pages.setParam(param);
  }
  private function onColorSelected(param:IParameter):Void{
    GLOBAL.printType    = CONST.DIGITAL_PRINT;
    GLOBAL.laserColor  = param.getUInt();
    GLOBAL.text_view.setParam(param);
    Pages.setParam(new Parameter(EVENT_ID.UPDATE_PLACEHOLDER));
    Pages.setParam(param);
  }
  
  private function onFullColorSelected(param:IParameter):Void{
    GLOBAL.printType    = CONST.DIGITAL_PRINT;
    GLOBAL.stdPmsColor  = param.getUInt();
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
