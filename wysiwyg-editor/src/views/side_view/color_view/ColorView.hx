import flash.geom.Point;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.display.Bitmap;

class ColorView extends PropertyView, implements IView{
  
  private var stdPmsColorPicker:StdPmsColorPicker;
  private var customPms1ColorPicker:CustomPmsColorPicker;
  private var customPms2ColorPicker:CustomPmsColorPicker;
  private var foilColorPicker:FoilColorPicker;
  //private var stdPmsPickerBmp:Bitmap;
  //private var customPms1PickerBmp:Bitmap;
  //private var customPms2PickerBmp:Bitmap;
  //private var foilPickerBmp:Bitmap;
  private var colorPickerBmp:Bitmap;
  
  private var stdColorText:FormatedText;
  private var customColor1Text:FormatedText;
  private var customColor2Text:FormatedText;
  private var foilColorText:FormatedText;
  private var colorText:FormatedText;

  private var pos:Float;
  
  public function new(colorController:IController){	
    super(colorController);
    backdrop            = new BlankBack();
    
    Application.addEventListener(EVENT_ID.UPDATE_SIDE_VIEWS, onUpdateSideView);
    
    
    stdPmsColorPicker       = new StdPmsColorPicker(controller);
    customPms1ColorPicker   = new CustomPmsColorPicker(controller);
    customPms2ColorPicker   = new CustomPmsColorPicker(controller);
    foilColorPicker         = new FoilColorPicker(controller);
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


    //foilPickerBmp           = new FoilPickerBitmap();
    colorPickerBmp          = new ColorPickerBitmap();
    
    stdColorText 	          = new FormatedText('helvetica', 'STANDARD PMS', 11, false);
    customColor1Text 	      = new FormatedText('helvetica', 'CUSTOM PMS 1', 11, false);
    customColor2Text 	      = new FormatedText('helvetica', 'CUSTOM PMS 1', 11, false);
    foilColorText 	        = new FormatedText('helvetica', 'FOIL', 11, false);
    colorText        	      = new FormatedText('helvetica', 'COLOR 1', 11, false);
    
     
    
    

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

    // color pickers
    //stdPmsPickerBmp.visible = false;
    //addChild(stdPmsPickerBmp);
    //stdPmsPickerBmp.x = 10;
    
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
    
/*
    foilPickerBmp.visible = false;
    addChild(foilPickerBmp);
    foilPickerBmp.x = 10;
  */  
    colorPickerBmp.visible = false;
    addChild(colorPickerBmp);
    colorPickerBmp.x = 10;

    PositionPickers();
  }
  
  
  
  private function onUpdateSideView( e:IKEvent ): Void{
    //trace('update', e.getString());
    
    switch ( e.getString() ){
      
      case 'vector_placeholder':{
        trace('to do: open color tool, hide test tool, dimm text selector button');

        stdPmsColorPicker.alpha         = 1.0;
        customPms1ColorPicker.alpha     = 1.0;
        customPms2ColorPicker.alpha     = 1.0;
        foilColorPicker.alpha           = 1.0;


        colorPickerBmp.alpha            = 1.0;
      }
      default:{
        //stdPmsPickerBmp.alpha         = 0.3;
        stdPmsColorPicker.alpha         = 0.3;
        customPms1ColorPicker.alpha     = 0.3;
        customPms2ColorPicker.alpha     = 0.3;
        foilColorPicker.alpha           = 0.3;
        colorPickerBmp.alpha            = 0.3;

      }
    }
  }

  override public function setParam(param:IParameter):Void{
    
    trace('setParam');
    switch( param.getLabel() ){
      case EVENT_ID.SHOW_PMS_PICKER:{ 
        //stdPmsPickerBmp.visible       = param.getBool();
        customPms1ColorPicker.visible   = param.getBool();
        customPms2ColorPicker.visible   = param.getBool();
      }
      case EVENT_ID.ENABLE_PMS_PICKER:{ 
        //stdPmsPickerBmp.alpha         = param.getFloat();
        customPms1ColorPicker.alpha     = param.getFloat();
        customPms2ColorPicker.alpha     = param.getFloat();
      }
      case EVENT_ID.SHOW_FOIL_PICKER:     { foilColorPicker.visible   = param.getBool(); }
      case EVENT_ID.SHOW_COLOR_PICKER:    { colorPickerBmp.visible  = param.getBool(); }
      case EVENT_ID.ENABLE_FOIL_PICKER:   { foilColorPicker.alpha     = param.getFloat(); }
      case EVENT_ID.ENABLE_COLOR_PICKER:  { colorPickerBmp.alpha    = param.getFloat(); }
    }
	}
	
	override public function setFloat(id:String, f:Float):Void{
//	  trace(id);
    //switch ( id ) {
    //  case EVENT_ID.DESIGN_SCROLL:{
    //    designsPane.y = -(designsPane.getFloat('height')-designsScrollPane.getFloat('mask_height')) * f;
    //  }
    //}
  }
    
  private function PositionPickers(): Void{
    
    stdColorText.visible              = true;
    stdPmsColorPicker.visible         = true;
    customColor1Text.visible          = true;
    customColor2Text.visible          = true;
    foilColorText.visible             = true;
    colorText.visible                 = true;
    customPms1ColorPicker.visible     = true;
    customPms2ColorPicker.visible     = true;
    foilColorPicker.visible           = true;
    colorPickerBmp.visible            = true;
    
    
    
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
    
    if(colorPickerBmp.visible){
      colorText.y = pos;
      pos = colorText.y + colorText.height;
      colorPickerBmp.y    = pos;
    }

  }
}