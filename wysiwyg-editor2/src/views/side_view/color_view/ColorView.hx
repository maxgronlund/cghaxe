import flash.geom.Point;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.display.Bitmap;

class ColorView extends PropertyView, implements IView{

  private var back:Rectangle;
  
  //pickers
  private var foilColorPicker:FoilColorPicker;
  private var colorPicker:ColorPicker;
  private var stdPmsColorPicker:StdPmsColorPicker;
  private var customPms1ColorPicker:CustomPmsColorPicker;
  private var customPms2ColorPicker:CustomPmsColorPicker;
  private var pms4Button:TwoStateButton;
  private var pms2Button:TwoStateButton;
  // labels
  private var colorLabel:FormatedText;
  private var stdPmsLabel:FormatedText;
  private var customColor1Label:FormatedText;
  private var customColor2Label:FormatedText;
  private var foilColorLabel:FormatedText;
  private var pms4Label:FormatedText;
  private var pms2Label:FormatedText;
  // open info buttons
  private var foilColorPickerI:OneStateTextAndImageButton;
  private var colorPickerI:OneStateTextAndImageButton;
  private var stdPmsColorPickerI:OneStateTextAndImageButton;
  private var customPms1ColorPickerI:OneStateTextAndImageButton;
  private var customPms2ColorPickerI:OneStateTextAndImageButton;
  private var pms4I:OneStateTextAndImageButton;
  private var pms2I:OneStateTextAndImageButton;
  // tool tips
  private var foilColorInfo:InfoMessageView;
  private var stdPmsColorInfo:InfoMessageView;
  private var colorInfo:InfoMessageView;
  private var customPms1Info:InfoMessageView;
  private var customPms2Info:InfoMessageView;
  private var pms4Info:InfoMessageView;
  private var pms2Info:InfoMessageView;

  private var pos:Float;
  private var print_types:Xml;
  
  public function new(colorController:IController){	
    super(colorController);
    //backdrop            = new BlankBack();
    back        = new Rectangle(190, 340, 0x000000, 0xDEDEDE, Rectangle.DONT_DRAW_LINES, Rectangle.USE_FILL);
    
    Application.addEventListener(EVENT_ID.UPDATE_SIDE_VIEWS, onUpdateSideView);
    Application.addEventListener(EVENT_ID.LOAD_CUSTOM_PMS_COLORS, onLoadCustomPmsColors);
    Application.addEventListener(EVENT_ID.SET_DEFAULT_TOOL, onLoadDefaultTool);
    
    Preset.addEventListener(EVENT_ID.PRINT_TYPES_LOADED, onLoadPrintTypes);

    createPickers();
    createInfoButtons();
    createToolTips();
    createLabels();
  }
  
  private function createPickers():Void{

    foilColorPicker         = new FoilColorPicker(controller);
    colorPicker             = new ColorPicker(controller);
    stdPmsColorPicker       = new StdPmsColorPicker(controller);
    customPms1ColorPicker   = new CustomPmsColorPicker(controller);
    customPms2ColorPicker   = new CustomPmsColorPicker(controller);
    pms4Button              = new TwoStateButton();
    pms2Button              = new TwoStateButton();
  }

  private function createInfoButtons():Void{

    foilColorPickerI          = new OneStateTextAndImageButton();
    foilColorPickerI.setFormat(0, 3, 0x333333, 'center');
    
    colorPickerI              = new OneStateTextAndImageButton();
    colorPickerI.setFormat(0, 3, 0x333333, 'center');
    
    stdPmsColorPickerI        = new OneStateTextAndImageButton();
    stdPmsColorPickerI.setFormat(0, 3, 0x333333, 'center');
    
    customPms1ColorPickerI    = new OneStateTextAndImageButton();
    customPms1ColorPickerI.setFormat(0, 3, 0x333333, 'center');
    
    customPms2ColorPickerI    = new OneStateTextAndImageButton();
    customPms2ColorPickerI.setFormat(0, 3, 0x333333, 'center');
    
    pms4I                     = new OneStateTextAndImageButton();
    pms4I.setFormat(0, 3, 0x333333, 'center');
    
    pms2I                     = new OneStateTextAndImageButton();
    pms2I.setFormat(0, 3, 0x333333, 'center');
  }
  
  private function createToolTips():Void{

    // tooltips
    foilColorInfo       = new InfoMessageView(GLOBAL.tool_tips_controller, TOOL_TIPS.COLOR_FOIL,'right','top'); 
    colorInfo           = new InfoMessageView(GLOBAL.tool_tips_controller, TOOL_TIPS.COLOR_PICKER,'right','top');
    stdPmsColorInfo     = new InfoMessageView(GLOBAL.tool_tips_controller, TOOL_TIPS.COLOR_STD_PMS,'right','top');  
    customPms1Info      = new InfoMessageView(GLOBAL.tool_tips_controller, TOOL_TIPS.COLOR_CUSTOM_PMS_1,'right','top'); 
    customPms2Info      = new InfoMessageView(GLOBAL.tool_tips_controller, TOOL_TIPS.COLOR_CUSTOM_PMS_2,'right','top'); 
    pms4Info            = new InfoMessageView(GLOBAL.tool_tips_controller, TOOL_TIPS.COLOR_PMS_4,'right','top'); 
    pms2Info            = new InfoMessageView(GLOBAL.tool_tips_controller, TOOL_TIPS.COLOR_PMS_2,'right','top');
  }
  
  private function createLabels():Void{
    foilColorLabel        = new FormatedText('helvetica', 'FOIL', 11, false);
    colorLabel            = new FormatedText('helvetica', 'DIGITAL PRINT', 11, false);
    stdPmsLabel           = new FormatedText('helvetica', 'STANDARD PMS', 11, false);
    customColor1Label     = new FormatedText('helvetica', 'CUSTOM PMS 1', 11, false);
    customColor2Label     = new FormatedText('helvetica', 'CUSTOM PMS 2', 11, false);
    pms4Label             = new FormatedText('helvetica', '4 PMS COLORS', 11, false);
    pms2Label             = new FormatedText('helvetica', '2 PMS COLORS', 11, false);
  }
  
  override public function init():Void{

    selectButton.init( controller,
              new Point(190,30), 
              new ToolSelectionButton(), 
              new Parameter( EVENT_ID.SHOW_COLOR_PICKERS));
              
    initPickers();
    initInfoButtons();

  }
  
  private function initPickers():Void{

    foilColorPicker.init();
    colorPicker.init();      
    stdPmsColorPicker.init();
    customPms1ColorPicker.init(); 
    customPms2ColorPicker.init();
              
    pms4Button.init( controller,
            new Point(55,32), 
            new Pms4Button(), 
            new Parameter( EVENT_ID.PMS4_COLOR));
            
    pms2Button.init( controller,
            new Point(55,32), 
            new Pms2Button(), 
            new Parameter( EVENT_ID.PMS2_COLOR));
    
    
    selectButton.init( controller,
              new Point(190,30), 
              new ToolSelectionButton(), 
              new Parameter( EVENT_ID.SHOW_COLOR_PICKERS));
    
  }
  
  private function initInfoButtons():Void{

    foilColorPickerI.init( GLOBAL.tool_tips_controller,
                                new Point(22,22), 
                                new OneStateButtonBackS(), 
                                new Parameter( TOOL_TIPS.COLOR_FOIL));
    colorPickerI.init( GLOBAL.tool_tips_controller,
                                new Point(22,22), 
                                new OneStateButtonBackS(), 
                                new Parameter( TOOL_TIPS.COLOR_PICKER));
    stdPmsColorPickerI.init( GLOBAL.tool_tips_controller,
                                new Point(22,22), 
                                new OneStateButtonBackS(), 
                                new Parameter( TOOL_TIPS.COLOR_STD_PMS));
    customPms1ColorPickerI.init( GLOBAL.tool_tips_controller,
                                new Point(22,22), 
                                new OneStateButtonBackS(), 
                                new Parameter( TOOL_TIPS.COLOR_CUSTOM_PMS_1));
    customPms2ColorPickerI.init( GLOBAL.tool_tips_controller,
                                new Point(22,22), 
                                new OneStateButtonBackS(), 
                                new Parameter( TOOL_TIPS.COLOR_CUSTOM_PMS_2));
    pms4I.init( GLOBAL.tool_tips_controller,
                                new Point(22,22), 
                                new OneStateButtonBackS(), 
                                new Parameter( TOOL_TIPS.COLOR_PMS_4));
    pms2I.init( GLOBAL.tool_tips_controller,
                                new Point(22,22), 
                                new OneStateButtonBackS(), 
                                new Parameter( TOOL_TIPS.COLOR_PMS_2));
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
    foilColorLabel.setLabel(TRANSLATION.foil_color_picker);
    colorLabel.setLabel(TRANSLATION.digital_print_picker);
    pms4Label.setLabel(TRANSLATION.pms_4);

    foilColorPickerI.setText('?');    
    foilColorPickerI.updateLabel();

    stdPmsColorPickerI.setText('?');
    stdPmsColorPickerI.updateLabel();
    
    customPms1ColorPickerI.setText('?');
    customPms1ColorPickerI.updateLabel();
    
    customPms2ColorPickerI.setText('?');
    customPms2ColorPickerI.updateLabel();
    
    pms4I.setText('?');
    pms4I.updateLabel();
    
    pms2I.setText('?');
    pms2I.updateLabel();
    
    colorPickerI.setText('?');
    colorPickerI.updateLabel();
    
    foilColorInfo.setContent( TOOL_TIPS.color_foil_title,TOOL_TIPS.color_foil_body ,TOOL_TIPS.color_foil_link);
    stdPmsColorInfo.setContent( TOOL_TIPS.color_std_pms_title,TOOL_TIPS.color_std_pms_body ,TOOL_TIPS.color_std_pms_link);
    customPms1Info.setContent( TOOL_TIPS.color_custom_pms_1_title,TOOL_TIPS.color_custom_pms_1_body ,TOOL_TIPS.color_custom_pms_1_link);
    customPms2Info.setContent( TOOL_TIPS.color_custom_pms_2_title,TOOL_TIPS.color_custom_pms_2_body ,TOOL_TIPS.color_custom_pms_2_link);
    pms4Info.setContent( TOOL_TIPS.color_4_pms_title,TOOL_TIPS.color_4_pms_body ,TOOL_TIPS.color_4_pms_link);
    pms2Info.setContent( TOOL_TIPS.color_2_pms_title,TOOL_TIPS.color_2_pms_body ,TOOL_TIPS.color_2_pms_link);
    colorInfo.setContent( TOOL_TIPS.digital_print_title,TOOL_TIPS.digital_print_body ,TOOL_TIPS.digital_print_link);
    
    
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
        pms4Label.alpha                 = 0.3;
        pms4Button.alpha                = 0.3;
      }
      case 'text_place_holder':{
        stdPmsColorPicker.alpha         = 1.0;
        customPms1ColorPicker.alpha     = 1.0;
        customPms2ColorPicker.alpha     = 1.0;
        foilColorPicker.alpha           = 1.0;
        colorPicker.alpha               = 1.0;
        pms4Label.alpha                 = 1.0;
        pms4Button.alpha                = 1.0;
      }
      
      case 'garamond_place_holder':{
        stdPmsColorPicker.alpha         = 0.3;
        customPms1ColorPicker.alpha     = 0.3;
        customPms2ColorPicker.alpha     = 0.3;
        foilColorPicker.alpha           = 1.0;
        colorPicker.alpha               = 0.3;
        pms4Label.alpha                 = 0.3;
        pms4Button.alpha                = 0.3;
      }
      case 'bitmap_place_holder':{
        stdPmsColorPicker.alpha         = 1.0;
        customPms1ColorPicker.alpha     = 1.0;
        customPms2ColorPicker.alpha     = 1.0;
        foilColorPicker.alpha           = 1.0;
        colorPicker.alpha               = 1.0;
        pms4Label.alpha                 = 1.0;
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
    addPickers();
    addLabels();
    addInfoButtons();

    positionPickers();

    customPms1ColorPicker.setString("id", EVENT_ID.PMS1_COLOR_SELECTED);
    customPms2ColorPicker.setString("id", EVENT_ID.PMS2_COLOR_SELECTED);
    Pages.addEventListener(EVENT_ID.PAGE_SELECTED, onPageSelected);
    
  }
  
  private function addPickers():Void{

    addChild(foilColorPicker);
    foilColorPicker.visible = false;
    foilColorPicker.x = 10;

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
    customPms2ColorPicker.setInt('color', 0x008888);
    
    addChild(pms4Button);
    pms4Button.x = 10;
    
    addChild(pms2Button);
    pms2Button.x = 100;
    
    addChild(colorPicker);
    colorPicker.visible = false;
    colorPicker.x = 10;
    
  }
  
  private function addInfoButtons():Void{

    addChild( foilColorPickerI);
    foilColorPickerI.x          = foilColorPicker.width + 20;
    foilColorInfo.x             = foilColorPickerI.x;
    
    addChild( stdPmsColorPickerI);
    stdPmsColorPickerI.x        = stdPmsColorPicker.x + 143;
    stdPmsColorInfo.x           = stdPmsColorPickerI.x;
    

    
    addChild( customPms1ColorPickerI);
    customPms1ColorPickerI.x    = customPms1ColorPicker.x + 143;
    customPms1Info.x            = customPms1ColorPickerI.x;
    
    addChild( customPms2ColorPickerI);   
    customPms2ColorPickerI.x    = customPms2ColorPicker.x + 143;
    customPms2Info.x            = customPms2ColorPickerI.x;
                  
    addChild( pms4I );
    pms4I.x                     = pms4Button.x + 40;
    pms4Info.x                  = pms4I.x;
    
    addChild( pms2I );
    pms2I.x                     = pms2Button.x + 40;
    pms2Info.x                  = pms2I.x;
    
    addChild( colorPickerI ); 
    colorPickerI.x  = colorPicker.x + 143;
    colorInfo.x                 = colorPickerI.x;
    
    addChild(foilColorInfo);
    addChild(stdPmsColorInfo);
    addChild(customPms1Info);
    addChild(customPms2Info);
    addChild(pms4Info);
    addChild(pms2Info);
    addChild(colorInfo);
        
  }
  
  private function addLabels():Void{

    addChild(foilColorLabel);
    foilColorLabel.setColor(0x868686);
    foilColorLabel.visible = false;
    foilColorLabel.x = 10;
    
    addChild(colorLabel);
    colorLabel.setColor(0x868686);
    colorLabel.visible = false;
    colorLabel.x = 10;
    
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
    
    addChild(pms4Label);
    pms4Label.setColor(0x868686);
    pms4Label.visible = true;
    pms4Label.x = 10;
    
    addChild(pms2Label);
    pms2Label.setColor(0x868686);
    pms2Label.visible = true;
    pms2Label.x = 100;

  }
  
  private function onPageSelected(e:IKEvent):Void{
    disableTools();
    if(Pages.getString(CONST.PRINT_TYPES) != 'na'){
      print_types = Xml.parse(Pages.getString(CONST.PRINT_TYPES));
      setPrintTypes();
    }
    positionPickers();
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
    
    foilColorLabel.visible            = false;
    foilColorPicker.visible           = false;
    foilColorPickerI.visible          = false;
    
    stdPmsLabel.visible               = false;
    stdPmsColorPicker.visible         = false;
    stdPmsColorPickerI.visible        = false;
    
    customColor1Label.visible         = false;
    customPms1ColorPicker.visible     = false;
    customPms1ColorPickerI.visible    = false;
    
    customColor2Label.visible         = false;
    customPms2ColorPicker.visible     = false;
    customPms2ColorPickerI.visible    = false;
    
    
    pms4Button.visible                = false;
    pms4Label.visible                 = false;
    pms4I.visible                     = false;
    
    pms2Button.visible                = false;
    pms2Label.visible                 = false;
    pms2I.visible                     = false;
    
    colorLabel.visible                = false;
    colorPicker.visible               = false;
    colorPickerI.visible              = false;

  }
  
  private function onEnableTool(cmd:String):Void{
//    trace(cmd);
    switch ( cmd ){

      case 'Foil, Garamond':{
        back.visible                      = true;
        selectButton.visible              = true;
        foilColorLabel.visible            = true;
        foilColorPicker.visible           = true;
        foilColorPickerI.visible          = true;
      }
      case 'PMS':{

        back.visible                      = true;
        selectButton.visible              = true;
        
        stdPmsLabel.visible               = true;
        stdPmsColorPicker.visible         = true;
        stdPmsColorPickerI.visible        = true;

        customColor1Label.visible         = true;
        customPms1ColorPicker.visible     = true;
        customPms1ColorPickerI.visible    = true;
        
        customColor2Label.visible         = true;
        customPms2ColorPicker.visible     = true;
        customPms2ColorPickerI.visible    = true;
              
        pms4Button.visible                = true;
        pms4Label.visible                 = true; 
        pms4I.visible                     = true;      
        
        pms2Button.visible                = true;
        pms2Label.visible                 = true;  
        pms2I.visible                     = true;         
      }
      case 'Digital Print':{
        back.visible                      = true;
        selectButton.visible              = true;
        colorLabel.visible                = true;
        colorPicker.visible               = true;
        colorPickerI.visible              = true;
                  
      }
    }
 }
 

 
/*
 override public function setParam(param:IParameter):Void{
   switch ( param.getLabel() ){

   }
 }
 */

  private function positionPickers(): Void{

    pos = 0;
    if(back.visible){
      pos = 34;
      if(foilColorPicker.visible){
        foilColorLabel.y           = pos;
        pos = foilColorLabel.y + foilColorLabel.height;
        foilColorPicker.y         = pos;
        foilColorPickerI.y        = pos;
        foilColorInfo.y           = pos;
        pos                       = 10 + foilColorPicker.y + foilColorPicker.height;
      }
      
      if(customColor1Label.visible){
        stdPmsLabel.y             = pos;
        pos                       = stdPmsLabel.y + stdPmsLabel.height;
        stdPmsColorPicker.y       = pos;
        stdPmsColorPickerI.y      = pos;
        stdPmsColorInfo.y         = pos;
        pos                       = 10 + stdPmsColorPicker.y + stdPmsColorPicker.height; 
      
        customColor1Label.y       = pos;
        pos = customColor1Label.y + customColor1Label.height;
        customPms1ColorPicker.y   = pos;
        customPms1ColorPickerI.y  = pos;
        customPms1Info.y          = pos;
        pos                       = 10 + customPms1ColorPicker.y + customPms1ColorPicker.height; 
        
        customColor2Label.y       = pos;
        pos = customColor2Label.y + customColor2Label.height;
        customPms2ColorPicker.y   = pos;
        customPms2ColorPickerI.y  = pos;
        customPms2Info.y          = pos;
        pos                       = 10 + customPms2ColorPicker.y + customPms2ColorPicker.height; 
      }
      
      if(pms4Button.visible){
        pms4Label.y               = pos;
        pms4Button.y              = pos+18;
        pms4I.y                   = pms4Button.y;
        pms4Info.y                = pms4I.y;
      }
      
      if(pms4Button.visible){
        pms2Label.y               = pos;
        pms2Button.y              = pos+18;
        pms2I.y                   = pms2Button.y;
        pms2Info.y                = pms2I.y;
        pos                       = 10 + pms4Button.y + pms4Button.height;
      }
      
      if(colorPicker.visible){
        colorLabel.y      = pos;
        colorPickerI.y    = pos-6;
        colorInfo.y       = pos-6;
        pos = colorLabel.y + colorLabel.height;
        colorPicker.y     = pos;
        pos               = 10 + colorPicker.y + colorPicker.height;
      }
      back.height = pos-26;
    } 
  }
  
  override public function setString(id:String, s:String):Void{
    switch ( id ){
      case 'uncheck full color':
        positionPickers();
    }
  }
  
  override public function getHeight():Int{

    return Std.int(pos+6 );
	}
}