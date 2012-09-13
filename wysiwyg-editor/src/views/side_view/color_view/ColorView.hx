import flash.geom.Point;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.display.Bitmap;

class ColorView extends PropertyView, implements IView{
  
  private var stdPmsColorPicker:StdPmsColorPicker;
  private var customPms1ColorPicker:CustomPmsColorPicker;
  private var customPms2ColorPicker:CustomPmsColorPicker;
  private var foilColorPicker:FoilColorPicker;
  private var colorPicker:ColorPicker;  
  private var stdColorText:FormatedText;
  private var customColor1Text:FormatedText;
  private var customColor2Text:FormatedText;
  private var foilColorText:FormatedText;
  private var colorText:FormatedText;
  private var pos:Float;
  
  //private var foil_enable:Bool;
  //private var pms_enable:Bool;
  //private var laser_enable:Bool;
  var print_types:Xml;
  
  public function new(colorController:IController){	
    super(colorController);
    backdrop            = new BlankBack();
    
    Application.addEventListener(EVENT_ID.UPDATE_SIDE_VIEWS, onUpdateSideView);
    
    
    stdPmsColorPicker       = new StdPmsColorPicker(controller);
    customPms1ColorPicker   = new CustomPmsColorPicker(controller);
    customPms2ColorPicker   = new CustomPmsColorPicker(controller);
    foilColorPicker         = new FoilColorPicker(controller);
    colorPicker             = new ColorPicker(controller);
    
    //foil_enable             = false;
    //pms_enable              = false;
    //laser_enable            = false;
  }
  
  
  override public function init():Void{

    selectButton.init( controller,
              new Point(190,30), 
              new ColorViewButton(), 
              new Parameter( EVENT_ID.SHOW_COLOR_PICKERS));

    stdPmsColorPicker.init();
    customPms1ColorPicker.init(); 
    customPms2ColorPicker.init();
    foilColorPicker.init();
    colorPicker.init();

    stdColorText 	          = new FormatedText('helvetica', 'STANDARD PMS', 11, false);
    customColor1Text 	      = new FormatedText('helvetica', 'CUSTOM PMS 1', 11, false);
    customColor2Text 	      = new FormatedText('helvetica', 'CUSTOM PMS 2', 11, false);
    foilColorText 	        = new FormatedText('helvetica', 'FOIL', 11, false);
    colorText        	      = new FormatedText('helvetica', 'LASER COLOR', 11, false);
  }
  
  
  
  private function onUpdateSideView( e:IKEvent ): Void{
   

    setPrintTypes();
    
    switch ( e.getString() ){
    
      case 'vector_placeholder':{
        //trace('to do: open color tool, hide test tool, dimm text selector button');
    
        stdPmsColorPicker.alpha         = 1.0;
        customPms1ColorPicker.alpha     = 1.0;
        customPms2ColorPicker.alpha     = 1.0;
        foilColorPicker.alpha           = 1.0;
        colorPicker.alpha               = 0.3;
      }
      case 'text_place_holder':{
        stdPmsColorPicker.alpha         = 1.0;
        customPms1ColorPicker.alpha     = 1.0;
        customPms2ColorPicker.alpha     = 1.0;
        foilColorPicker.alpha           = 1.0;
        colorPicker.alpha               = 1.0;
      }
      
      case 'garamond_place_holder':{
        stdPmsColorPicker.alpha         = 0.3;
        customPms1ColorPicker.alpha     = 0.3;
        customPms2ColorPicker.alpha     = 0.3;
        foilColorPicker.alpha           = 1.0;
        colorPicker.alpha               = 0.3;
      }
      default:{
        stdPmsColorPicker.alpha         = 0.3;
        customPms1ColorPicker.alpha     = 0.3;
        customPms2ColorPicker.alpha     = 0.3;
        foilColorPicker.alpha           = 0.3;
        colorPicker.alpha               = 0.3;
        //colorPickerBmp.alpha            = 0.3;
    
      }
    }
  }
  
  
  override public function onAddedToStage(e:Event):Void{
    super.onAddedToStage(e);
    // texts
    addChild(stdColorText);
    stdColorText.setColor(0x868686);
    stdColorText.visible = false;
    stdColorText.x = 10;

    addChild(customColor1Text);
    customColor1Text.setColor(0x868686);
    customColor1Text.visible = false;
    customColor1Text.x = 10;
    
    addChild(customColor2Text);
    customColor2Text.setColor(0x868686);
    customColor2Text.visible = false;
    customColor2Text.x = 10;
    
    addChild(foilColorText);
    foilColorText.setColor(0x868686);
    foilColorText.visible = false;
    foilColorText.x = 10;
    
    addChild(colorText);
    colorText.setColor(0x868686);
    colorText.visible = false;
    colorText.x = 10;
    
    addChild(stdPmsColorPicker);
    stdPmsColorPicker.visible = false;
    stdPmsColorPicker.x = 10;
    
    addChild(customPms1ColorPicker);
    customPms1ColorPicker.visible = false;
    customPms1ColorPicker.x = 10;
    
    addChild(customPms2ColorPicker);
    customPms2ColorPicker.visible = false;
    customPms2ColorPicker.x = 10;
    
    addChild(foilColorPicker);
    foilColorPicker.visible = false;
    foilColorPicker.x = 10;
    
    addChild(colorPicker);
    colorPicker.visible = false;
    colorPicker.x = 10;
    

    //colorPickerBmp.visible = false;
    //addChild(colorPickerBmp);
    //colorPickerBmp.x = 10;

    PositionPickers();
    
    Pages.addEventListener(EVENT_ID.PAGE_SELECTED, onPageSelected);
    
    stdColorText.visible              = true;
    stdPmsColorPicker.visible         = true;
    customColor1Text.visible          = true;
    customColor2Text.visible          = true;
    foilColorText.visible             = true;
    colorText.visible                 = true;
    customPms1ColorPicker.visible     = true;
    customPms2ColorPicker.visible     = true;
    foilColorPicker.visible           = true;
    colorPicker.visible               = true;
    
    customPms1ColorPicker.setString("set_pms", EVENT_ID.PMS1_COLOR_SELECTED);
    customPms2ColorPicker.setString("set_pms", EVENT_ID.PMS2_COLOR_SELECTED);
    
  }
  
  private function onPageSelected(e:IKEvent):Void{
    
    print_types = Xml.parse(Pages.getString(CONST.PRINT_TYPES));
    setPrintTypes();
    
  }
  
  private function setPrintTypes():Void{
    disableTools();
    
    for(print_types in print_types.elementsNamed('print-types')){
      for(print_type in print_types.elementsNamed('print-type')){
        for(title in print_type.elementsNamed('title')){
          onEnableTool( title.firstChild().nodeValue.toString());
        }
      }
    }
    PositionPickers();
  }
  
  private function disableTools():Void{
    stdColorText.visible              = false;
    stdPmsColorPicker.visible         = false;
    customColor1Text.visible          = false;
    customColor2Text.visible          = false;
    foilColorText.visible             = false;
    colorText.visible                 = false;
    customPms1ColorPicker.visible     = false;
    customPms2ColorPicker.visible     = false;
    foilColorPicker.visible           = false;
    colorPicker.visible               = false;
  }
  
  private function onEnableTool(cmd:String):Void{
    switch ( cmd ){
      case 'Laser':{
        colorText.visible                 = true;
        colorPicker.visible               = true;
      }
      case 'Foil':{
        foilColorText.visible             = true;
        foilColorPicker.visible           = true;
      }
      case 'PMS':{
        stdColorText.visible              = true;
        customColor1Text.visible          = true;
        customColor2Text.visible          = true;
        stdPmsColorPicker.visible         = true;
        customPms1ColorPicker.visible     = true;
        customPms2ColorPicker.visible     = true;                    
      }
    }
 }
 

 //override public function setParam(param:IParameter):Void{
 //  
 //  trace('oh no');
 //  switch ( param.getLabel() ){
 //    
 //    //case EVENT_ID.USE_GARAMOND:{
 //    //  if(param.getBool()){
 //    //    useGaramond();
 //    //    //disableTools();
 //    //    //onEnableTool('Foil');
 //    //    //PositionPickers();
 //    //  }else{
 //    //    //setPrintTypes();
 //    //  }
 //    //  
 //    //}
 //  }
 //}
 
 //private function useGaramond():Void{
 //   disableTools();
 //   onEnableTool('Foil');
 //   PositionPickers();
 //}

  private function PositionPickers(): Void{

    pos = 40;
    if(customColor1Text.visible){
      stdColorText.y = pos;
      pos = stdColorText.y + stdColorText.height;
      stdPmsColorPicker.y    = pos;
      pos = 10 + stdPmsColorPicker.y + stdPmsColorPicker.height; 

      customColor1Text.y = pos;
      pos = customColor1Text.y + customColor1Text.height;
      customPms1ColorPicker.y = pos;
      pos = 10 + customPms1ColorPicker.y + customPms1ColorPicker.height; 
      
      customColor2Text.y = pos;
      pos = customColor2Text.y + customColor2Text.height;
      customPms2ColorPicker.y = pos;
      pos = 10 + customPms2ColorPicker.y + customPms2ColorPicker.height; 
    }
    
    if(foilColorPicker.visible){
      foilColorText.y = pos;
      pos = foilColorText.y + foilColorText.height;
      foilColorPicker.y   = pos;
      pos  = 10 + foilColorPicker.y + foilColorPicker.height;
    }
    
    if(colorPicker.visible){
      colorText.y = pos;
      pos = colorText.y + colorText.height;
      colorPicker.y    = pos;
    }

  }
}