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
  private var stdPmsText:FormatedText;
  private var customColor1Text:FormatedText;
  private var customColor2Text:FormatedText;
  private var foilColorText:FormatedText;
  private var colorText:FormatedText;
  private var fullColorText:FormatedText;
  private var pos:Float;
  private var back:Rectangle;
  private var fullColorButton:TwoStateButton;
  
  //

  var print_types:Xml;
  
  public function new(colorController:IController){	
    super(colorController);
    //backdrop            = new BlankBack();
    back        = new Rectangle(190, 340, 0x000000, 0xDEDEDE, Rectangle.DONT_DRAW_LINES, Rectangle.USE_FILL);
    
    Application.addEventListener(EVENT_ID.UPDATE_SIDE_VIEWS, onUpdateSideView);
    Application.addEventListener(EVENT_ID.LOAD_CUSTOM_PMS_COLORS, onLoadCustomPmsColors);
    Application.addEventListener(EVENT_ID.SET_DEFAULT_TOOL, onLoadDefaultTool);
    
    stdPmsColorPicker       = new StdPmsColorPicker(controller);
    customPms1ColorPicker   = new CustomPmsColorPicker(controller);
    customPms2ColorPicker   = new CustomPmsColorPicker(controller);
    foilColorPicker         = new FoilColorPicker(controller);
    colorPicker             = new ColorPicker(controller);
    fullColorButton         = new TwoStateButton();
    
    //foil_enable             = false;
    //pms_enable              = false;
    //laser_enable            = false;
  }
  
  
  override public function init():Void{

    selectButton.init( controller,
              new Point(190,30), 
              new ColorViewButton(), 
              new Parameter( EVENT_ID.SHOW_COLOR_PICKERS));
              
    fullColorButton.init( controller,
            new Point(55,32), 
            new FullColorButton(), 
            new Parameter( EVENT_ID.FULL_COLOR));
    
    stdPmsColorPicker.init();
    customPms1ColorPicker.init(); 
    customPms2ColorPicker.init();
    foilColorPicker.init();
    colorPicker.init();

    stdPmsText         = new FormatedText('helvetica', 'STANDARD PMS', 11, false);
    customColor1Text   = new FormatedText('helvetica', 'CUSTOM PMS 1', 11, false);
    customColor2Text   = new FormatedText('helvetica', 'CUSTOM PMS 2', 11, false);
    foilColorText      = new FormatedText('helvetica', 'FOIL', 11, false);
    colorText          = new FormatedText('helvetica', 'LASER COLOR', 11, false);
    fullColorText      = new FormatedText('helvetica', 'FULL COLOR', 11, false);
  }
  
  private function onLoadCustomPmsColors(e:IKEvent):Void{
    customPms1ColorPicker.setString('pms code', GLOBAL.pms1ColorString);
    customPms2ColorPicker.setString('pms code', GLOBAL.pms2ColorString);
  }
  
  private function onLoadDefaultTool(e:IKEvent):Void{
    

    stdPmsText.setLabel(TRANSLATION.standard_pms);
    customColor1Text.setLabel(TRANSLATION.custom_pms_1);
    customColor2Text.setLabel(TRANSLATION.custom_pms_2);
    foilColorText.setLabel(TRANSLATION.foil_color_picker);
    colorText.setLabel(TRANSLATION.standard_pms);
    fullColorText.setLabel(TRANSLATION.full_color_button);
    
    
   
/*
    uploadLogoButton.setText(TRANSLATION.upload_logo); 
    uploadLogoButton.updateLabel();      
    addLogoButton.setText(TRANSLATION.add_logo);    
    addLogoButton.updateLabel();    
*/

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
      case 'bitmap_place_holder':{
        stdPmsColorPicker.alpha         = 1.0;
        customPms1ColorPicker.alpha     = 1.0;
        customPms2ColorPicker.alpha     = 1.0;
        foilColorPicker.alpha           = 1.0;
        colorPicker.alpha               = 0.3;
      }
      default:{
        stdPmsColorPicker.alpha         = 0.3;
        customPms1ColorPicker.alpha     = 0.3;
        customPms2ColorPicker.alpha     = 0.3;
        foilColorPicker.alpha           = 0.3;
        colorPicker.alpha               = 0.3;
      }
    }
  }
  
  
  override public function onAddedToStage(e:Event):Void{
    
    super.onAddedToStage(e);
    addChild(back);
    back.y = 30;
    // texts
    addChild(stdPmsText);
    stdPmsText.setColor(0x868686);
    stdPmsText.visible = false;
    stdPmsText.x = 10;

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
    customPms1ColorPicker.setString('id', EVENT_ID.PMS1_COLOR_SELECTED);
    customPms1ColorPicker.setString('pms_value', EVENT_ID.UPDATE_PMS1);
    customPms1ColorPicker.setInt('color', 0x888800);
    
    addChild(customPms2ColorPicker);
    customPms2ColorPicker.visible = false;
    customPms2ColorPicker.x = 10;
    customPms2ColorPicker.setString('id', EVENT_ID.PMS2_COLOR_SELECTED);
    customPms2ColorPicker.setString('pms_value', EVENT_ID.UPDATE_PMS2);
    //
    customPms2ColorPicker.setInt('color', 0x008888);
    
    
    addChild(foilColorPicker);
    foilColorPicker.visible = false;
    foilColorPicker.x = 10;
    
    addChild(colorPicker);
    colorPicker.visible = false;
    colorPicker.x = 10;
    
    addChild(fullColorButton);
    fullColorButton.x = 10;
    addChild(fullColorText);
    fullColorText.setColor(0x868686);
    fullColorText.visible = true;
    fullColorText.x = 10;
    

    //colorPickerBmp.visible = false;
    //addChild(colorPickerBmp);
    //colorPickerBmp.x = 10;

    PositionPickers();
    
    Pages.addEventListener(EVENT_ID.PAGE_SELECTED, onPageSelected);
    
    stdPmsText.visible              = true;
    stdPmsColorPicker.visible         = true;
    
    
    foilColorText.visible             = true;
    foilColorPicker.visible           = true;
    colorText.visible                 = true;
    
    customColor1Text.visible          = true;
    customPms1ColorPicker.visible     = true;
    
    customColor2Text.visible          = true;
    customPms2ColorPicker.visible     = true;
    
    colorPicker.visible               = true;
    
    customPms1ColorPicker.setString("id", EVENT_ID.PMS1_COLOR_SELECTED);
    customPms2ColorPicker.setString("id", EVENT_ID.PMS2_COLOR_SELECTED);
    
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
    stdPmsText.visible                = false;
    stdPmsColorPicker.visible         = false;
    customColor1Text.visible          = false;
    customColor2Text.visible          = false;
    foilColorText.visible             = false;
    colorText.visible                 = false;
    customPms1ColorPicker.visible     = false;
    customPms2ColorPicker.visible     = false;
    foilColorPicker.visible           = false;
    colorPicker.visible               = false;
    fullColorButton.visible           = false;
    fullColorText.visible             = false;
  }
  
  private function onEnableTool(cmd:String):Void{

    switch ( cmd ){

      case 'Foil, Garamond':{
        foilColorText.visible             = true;
        foilColorPicker.visible           = true;
      }
      case 'PMS':{
        //colorText.visible                 = true;
        //colorPicker.visible               = true;
        stdPmsText.visible              = true;
        stdPmsColorPicker.visible         = true;
        customColor1Text.visible          = true;
        customColor2Text.visible          = true;
        customPms1ColorPicker.visible     = true;
        customPms2ColorPicker.visible     = true;      
        fullColorButton.visible           = true;
        fullColorText.visible             = true;              
      }
      case 'Digital Print':{
        
                  
      }
    }
 }
 

 

 override public function setParam(param:IParameter):Void{
   
   trace(param.getLabel() );
   
   switch ( param.getLabel() ){
     
     //case EVENT_ID.USE_GARAMOND:{
     //  if(param.getBool()){
     //    useGaramond();
     //    //disableTools();
     //    //onEnableTool('Foil');
     //    //PositionPickers();
     //  }else{
     //    //setPrintTypes();
     //  }
     //  
     //}
   }
 }
 
 //private function useGaramond():Void{
 //   disableTools();
 //   onEnableTool('Foil');
 //   PositionPickers();
 //}

  private function PositionPickers(): Void{

    pos = 40;
    if(customColor1Text.visible){
      stdPmsText.y = pos;
      pos = stdPmsText.y + stdPmsText.height;
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
      pos  = 10 + colorText.y + colorText.height;
    }
    
    if(fullColorButton.visible){
      fullColorText.y     = pos;
      fullColorButton.y   = pos+18;
      pos  = 10 + fullColorButton.y + fullColorButton.height;
    }
    back.height = pos-30;

    
  }
  
  //override public function setString(id:String, s:String):Void{
  //  switch ( id ){
  //    
  //    case EVENT_ID.UPDATE_TOOL_SIZES:
  //      PositionPickers();
  //  }
  //}
  
  override public function getHeight():Int{
		return Std.int(pos );
	}
}