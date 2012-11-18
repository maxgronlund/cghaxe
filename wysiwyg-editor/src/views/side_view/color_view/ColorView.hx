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
  private var stdPmsLabel:FormatedText;
  private var customColor1Label:FormatedText;
  private var customColor2Label:FormatedText;
  private var foilColorText:FormatedText;
  private var colorLabel:FormatedText;
  private var pms4Text:FormatedText;
  private var back:Rectangle;
  private var pms4Button:TwoStateButton;
  
  private var stdPmsColorPickerI:OneStateTextAndImageButton;
  private var customPms1ColorPickerI:OneStateTextAndImageButton;
  private var customPms2ColorPickerI:OneStateTextAndImageButton;
  private var foilColorPickerI:OneStateTextAndImageButton;
  private var colorPickerI:OneStateTextAndImageButton;
  private var pms4I:OneStateTextAndImageButton;
  private var pos:Float;
  //

  var print_types:Xml;
  
  public function new(colorController:IController){	
    super(colorController);
    //backdrop            = new BlankBack();
    back        = new Rectangle(190, 340, 0x000000, 0xDEDEDE, Rectangle.DONT_DRAW_LINES, Rectangle.USE_FILL);
    
    Application.addEventListener(EVENT_ID.UPDATE_SIDE_VIEWS, onUpdateSideView);
    Application.addEventListener(EVENT_ID.LOAD_CUSTOM_PMS_COLORS, onLoadCustomPmsColors);
    Application.addEventListener(EVENT_ID.SET_DEFAULT_TOOL, onLoadDefaultTool);
    
    Preset.addEventListener(EVENT_ID.PRINT_TYPES_LOADED, onLoadPrintTypes);
    
    //dispatchXML(EVENT_ID.PRINT_TYPES_LOADED, print_types);
    
    stdPmsColorPicker       = new StdPmsColorPicker(controller);
    customPms1ColorPicker   = new CustomPmsColorPicker(controller);
    customPms2ColorPicker   = new CustomPmsColorPicker(controller);
    foilColorPicker         = new FoilColorPicker(controller);
    colorPicker             = new ColorPicker(controller);
    pms4Button              = new TwoStateButton();
    
    //foil_enable             = false;
    //pms_enable              = false;
    //laser_enable            = false;
    createInfoButtons();
  }
  
  private function createInfoButtons():Void{
    stdPmsColorPickerI     = new OneStateTextAndImageButton();
    stdPmsColorPickerI.setFormat(0, 3, 0x333333, 'center');
    
    customPms1ColorPickerI     = new OneStateTextAndImageButton();
    customPms1ColorPickerI.setFormat(0, 3, 0x333333, 'center');
    
    customPms2ColorPickerI     = new OneStateTextAndImageButton();
    customPms2ColorPickerI.setFormat(0, 3, 0x333333, 'center');
    
    foilColorPickerI     = new OneStateTextAndImageButton();
    foilColorPickerI.setFormat(0, 3, 0x333333, 'center');
    
    colorPickerI     = new OneStateTextAndImageButton();
    colorPickerI.setFormat(0, 3, 0x333333, 'center');
    
    pms4I     = new OneStateTextAndImageButton();
    pms4I.setFormat(0, 3, 0x333333, 'center');
  }
  
  
  override public function init():Void{

    selectButton.init( controller,
              new Point(190,30), 
              new ToolSelectionButton(), 
              new Parameter( EVENT_ID.SHOW_COLOR_PICKERS));
              
    pms4Button.init( controller,
            new Point(55,32), 
            new Pms4Button(), 
            new Parameter( EVENT_ID.PMS4_COLOR));
    
    stdPmsColorPicker.init();
    customPms1ColorPicker.init(); 
    customPms2ColorPicker.init();
    foilColorPicker.init();
    colorPicker.init();

    stdPmsLabel         = new FormatedText('helvetica', 'STANDARD PMS', 11, false);
    customColor1Label   = new FormatedText('helvetica', 'CUSTOM PMS 1', 11, false);
    customColor2Label   = new FormatedText('helvetica', 'CUSTOM PMS 2', 11, false);
    foilColorText      = new FormatedText('helvetica', 'FOIL', 11, false);
    colorLabel          = new FormatedText('helvetica', 'DIGITAL PRINT', 11, false);
    pms4Text          = new FormatedText('helvetica', '4 PMS COLORS', 11, false);
    
    initInfoButtons();

  }
  private function initInfoButtons():Void{
    stdPmsColorPickerI.init( GLOBAL.tool_tips_controller,
                                new Point(22,22), 
                                new OneStateButtonBackS(), 
                                new Parameter( TOOL_TIPS.MY_UPLOADS_UPLOAD));
    customPms1ColorPickerI.init( GLOBAL.tool_tips_controller,
                                new Point(22,22), 
                                new OneStateButtonBackS(), 
                                new Parameter( TOOL_TIPS.MY_UPLOADS_UPLOAD));
    customPms1ColorPickerI.init( GLOBAL.tool_tips_controller,
                                new Point(22,22), 
                                new OneStateButtonBackS(), 
                                new Parameter( TOOL_TIPS.MY_UPLOADS_UPLOAD));
    customPms2ColorPickerI.init( GLOBAL.tool_tips_controller,
                                new Point(22,22), 
                                new OneStateButtonBackS(), 
                                new Parameter( TOOL_TIPS.MY_UPLOADS_UPLOAD));
    colorPickerI.init( GLOBAL.tool_tips_controller,
                                new Point(22,22), 
                                new OneStateButtonBackS(), 
                                new Parameter( TOOL_TIPS.MY_UPLOADS_UPLOAD));
    pms4I.init( GLOBAL.tool_tips_controller,
                                new Point(22,22), 
                                new OneStateButtonBackS(), 
                                new Parameter( TOOL_TIPS.MY_UPLOADS_UPLOAD));
  }
  
  private function onLoadCustomPmsColors(e:IKEvent):Void{
    customPms1ColorPicker.setString('pms code', GLOBAL.pms1ColorString);
    customPms2ColorPicker.setString('pms code', GLOBAL.pms2ColorString);
  }
  
  private function onLoadDefaultTool(e:IKEvent):Void{
    selectButton.setText(TRANSLATION.color_button);
    stdPmsLabel.setLabel(TRANSLATION.standard_pms);
    customColor1Label.setLabel(TRANSLATION.custom_pms_1);
    customColor2Label.setLabel(TRANSLATION.custom_pms_2);
    foilColorText.setLabel(TRANSLATION.foil_color_picker);
    colorLabel.setLabel(TRANSLATION.digital_print_picker);
    pms4Text.setLabel(TRANSLATION.pms_4);

/*
    uploadLogoButton.setText(TRANSLATION.upload_logo); 
    uploadLogoButton.updateLabel();      
    addLogoButton.setText(TRANSLATION.add_logo);    
    addLogoButton.updateLabel();    
*/
    loadInfoButtons();
  }
  
  private function loadInfoButtons():Void{
    
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
        pms4Text.alpha                  = 0.3;
        pms4Button.alpha                = 0.3;
      }
      case 'text_place_holder':{
        stdPmsColorPicker.alpha         = 1.0;
        customPms1ColorPicker.alpha     = 1.0;
        customPms2ColorPicker.alpha     = 1.0;
        foilColorPicker.alpha           = 1.0;
        colorPicker.alpha               = 1.0;
        pms4Text.alpha                  = 1.0;
        pms4Button.alpha                = 1.0;
      }
      
      case 'garamond_place_holder':{
        stdPmsColorPicker.alpha         = 0.3;
        customPms1ColorPicker.alpha     = 0.3;
        customPms2ColorPicker.alpha     = 0.3;
        foilColorPicker.alpha           = 1.0;
        colorPicker.alpha               = 0.3;
        pms4Text.alpha                  = 0.3;
        pms4Button.alpha                = 0.3;
      }
      case 'bitmap_place_holder':{
        stdPmsColorPicker.alpha         = 1.0;
        customPms1ColorPicker.alpha     = 1.0;
        customPms2ColorPicker.alpha     = 1.0;
        foilColorPicker.alpha           = 1.0;
        colorPicker.alpha               = 1.0;
        pms4Text.alpha                  = 1.0;
        pms4Button.alpha                = 1.0;
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
    addChild(stdPmsLabel);
    stdPmsLabel.setColor(0x868686);
    stdPmsLabel.visible = false;
    stdPmsLabel.x = 10;
    
    

    addChild(customColor1Label);
    customColor1Label.setColor(0x868686);
    customColor1Label.visible = false;
    customColor1Label.x = 10;
    
    addChild(customColor2Label);
    customColor2Label.setColor(0x868686);
    customColor2Label.visible = false;
    customColor2Label.x = 10;
    
    addChild(foilColorText);
    foilColorText.setColor(0x868686);
    foilColorText.visible = false;
    foilColorText.x = 10;
    
    addChild(colorLabel);
    colorLabel.setColor(0x868686);
    colorLabel.visible = false;
    colorLabel.x = 10;
    
    addChild(stdPmsColorPicker);
    stdPmsColorPicker.visible = false;
    stdPmsColorPicker.x = 10;
    
    //addChild(stdPmsColorPickerI);
    //stdPmsColorPickerI.visible = false;
    //stdPmsColorPickerI.x = stdPmsColorPicker.width + 18;
    
    
    
    
    
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
    
    customPms2ColorPicker.setInt('color', 0x008888);
    
    
    addChild(foilColorPicker);
    foilColorPicker.visible = false;
    foilColorPicker.x = 10;
    
    addChild(colorPicker);
    colorPicker.visible = false;
    colorPicker.x = 10;
    
    addChild(pms4Button);
    pms4Button.x = 10;
    addChild(pms4Text);
    pms4Text.setColor(0x868686);
    pms4Text.visible = true;
    pms4Text.x = 10;
    

    //colorPickerBmp.visible = false;
    //addChild(colorPickerBmp);
    //colorPickerBmp.x = 10;

    PositionPickers();
    
    
    
    foilColorText.visible             = false;
    foilColorPicker.visible           = false;
    
    stdPmsLabel.visible                = false;
    stdPmsColorPicker.visible         = false;
//    stdPmsColorPickerI.visible        = false;
    
    colorLabel.visible                 = false;
    
    customColor1Label.visible          = false;
    customPms1ColorPicker.visible     = false;
    
    customColor2Label.visible          = false;
    customPms2ColorPicker.visible     = false;
    
    colorPicker.visible               = false;
    
    pms4Button.visible                = false;
    pms4Text.visible                  = false;
    
    customPms1ColorPicker.setString("id", EVENT_ID.PMS1_COLOR_SELECTED);
    customPms2ColorPicker.setString("id", EVENT_ID.PMS2_COLOR_SELECTED);
    Pages.addEventListener(EVENT_ID.PAGE_SELECTED, onPageSelected);
    
  }
  
  private function onPageSelected(e:IKEvent):Void{
    disableTools();
    if(Pages.getString(CONST.PRINT_TYPES) != 'na'){
      print_types = Xml.parse(Pages.getString(CONST.PRINT_TYPES));
      setPrintTypes();
    }
    PositionPickers();
  }
  
  private function onLoadPrintTypes(e:KEvent):Void{
    print_types = Xml.parse(e.getXml().toString());
    setPrintTypes();
  }
  
  private function setPrintTypes():Void{
    
    for(print_types in print_types.elementsNamed('print-types')){
      for(print_type in print_types.elementsNamed('print-type')){
        for(title in print_type.elementsNamed('title')){
          onEnableTool( title.firstChild().nodeValue.toString());
        }
      }
    }
  }
  
  private function disableTools():Void{
    back.visible                      = false;
    selectButton.visible              = false;
    
    foilColorText.visible             = false;
    foilColorPicker.visible           = false;
    
    stdPmsLabel.visible               = false;
    stdPmsColorPicker.visible         = false;

    customColor1Label.visible         = false;
    customPms1ColorPicker.visible     = false;
    
    customColor2Label.visible         = false;
    customPms2ColorPicker.visible     = false;
    
    colorLabel.visible                = false;
    colorPicker.visible               = false;
    pms4Button.visible                = false;
    pms4Text.visible                  = false;
  }
  
  private function onEnableTool(cmd:String):Void{

    switch ( cmd ){

      case 'Foil, Garamond':{
        back.visible                      = true;
        selectButton.visible              = true;
        
        foilColorText.visible             = true;
        foilColorPicker.visible           = true;
      }
      case 'PMS':{

        back.visible                      = true;
        selectButton.visible              = true;
        
        stdPmsLabel.visible               = true;
        stdPmsColorPicker.visible         = true;

        customColor1Label.visible         = true;
        customPms1ColorPicker.visible     = true;
        
        customColor2Label.visible         = true;
        customPms2ColorPicker.visible     = true;
              
        pms4Button.visible                = true;
        pms4Text.visible                  = true;              
      }
      case 'Digital Print':{
        back.visible                      = true;
        selectButton.visible              = true;
        colorLabel.visible                 = true;
        colorPicker.visible               = true;
                  
      }
    }
 }
 

 

 override public function setParam(param:IParameter):Void{
   
   //trace(param.getLabel() );
   
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
    pos = 0;
    if(back.visible){
      pos = 34;
      if(foilColorPicker.visible){
        foilColorText.y = pos;
        pos = foilColorText.y + foilColorText.height;
        foilColorPicker.y   = pos;
        pos  = 10 + foilColorPicker.y + foilColorPicker.height;
      }
      
      if(customColor1Label.visible){
        stdPmsLabel.y = pos;
        pos = stdPmsLabel.y + stdPmsLabel.height;
        stdPmsColorPicker.y    = pos;
        //stdPmsColorPickerI.y    = pos;
        pos = 10 + stdPmsColorPicker.y + stdPmsColorPicker.height; 
      
        customColor1Label.y = pos;
        pos = customColor1Label.y + customColor1Label.height;
        customPms1ColorPicker.y = pos;
        pos = 10 + customPms1ColorPicker.y + customPms1ColorPicker.height; 
        
        customColor2Label.y = pos;
        pos = customColor2Label.y + customColor2Label.height;
        customPms2ColorPicker.y = pos;
        pos = 10 + customPms2ColorPicker.y + customPms2ColorPicker.height; 
      }
      
      if(pms4Button.visible){
        pms4Text.y     = pos;
        pms4Button.y   = pos+18;
        pos  = 10 + pms4Button.y + pms4Button.height;
      }
      
      if(colorPicker.visible){
        colorLabel.y = pos;
        pos = colorLabel.y + colorLabel.height;
        colorPicker.y    = pos;
        pos  = 10 + colorPicker.y + colorPicker.height;
      }
      
      back.height = pos-26;
    }

    
  }
  
  override public function setString(id:String, s:String):Void{
    switch ( id ){
      case 'uncheck full color':
        PositionPickers();
    }
  }
  
  override public function getHeight():Int{
    trace(pos);
    return Std.int(pos );
	}
}