import flash.geom.Point;
import flash.events.Event;
import flash.display.Bitmap;

class ColorView extends PropertyView, implements IView{
  
  private var stdPmsPickerBmp:Bitmap;
  private var customPms1PickerBmp:Bitmap;
  private var customPms2PickerBmp:Bitmap;
  private var foilPickerBmp:Bitmap;
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
     
  }
  
  
  override public function init():Void{
    trace('init');
    selectButton.init( controller,
              new Point(190,30), 
              new ColorViewButton(), 
              new Parameter( EVENT_ID.SHOW_COLOR_PICKERS));
              
    stdPmsPickerBmp         = new StdPMSPickerBitmap();
    customPms1PickerBmp     = new CustomPMSPickerBitmap();
    customPms2PickerBmp     = new CustomPMSPickerBitmap();
    foilPickerBmp           = new FoilPickerBitmap();
    colorPickerBmp          = new ColorPickerBitmap();
    
    stdColorText 	          = new FormatedText('helvetica', 'STANDARD PMS', 11, false);
    customColor1Text 	      = new FormatedText('helvetica', 'CUSTOM PMS 1', 11, false);
    customColor2Text 	      = new FormatedText('helvetica', 'CUSTOM PMS 1', 11, false);
    foilColorText 	        = new FormatedText('helvetica', 'CUSTOM PMS 1', 11, false);
    colorText        	      = new FormatedText('helvetica', 'CUSTOM PMS 1', 11, false);
    
    

  }
  
  override public function onAddedToStage(e:Event):Void{
    super.onAddedToStage(e);
    
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

    stdPmsPickerBmp.visible = false;
    addChild(stdPmsPickerBmp);
    stdPmsPickerBmp.x = 10;
    
    customPms1PickerBmp.visible = false;
    addChild(customPms1PickerBmp);
    customPms1PickerBmp.x = 10;
    
    customPms2PickerBmp.visible = false;
    addChild(customPms2PickerBmp);
    customPms2PickerBmp.x = 10;
    
    foilPickerBmp.visible = false;
    addChild(foilPickerBmp);
    foilPickerBmp.x = 10;
    
    colorPickerBmp.visible = false;
    addChild(colorPickerBmp);
    colorPickerBmp.x = 10;
    
    PositionPickers();
  }
  
  private function onUpdateSideView( e:IKEvent ): Void
  {
    //trace('update', e.getString());
    
    switch ( e.getString() ){
      
      case 'vector_placeholder':{
        trace('to do: open color tool, hide test tool, dimm text selector button');
        stdPmsPickerBmp.alpha         = 1.0;
        customPms1PickerBmp.alpha     = 1.0;
        customPms2PickerBmp.alpha     = 1.0;
        foilPickerBmp.alpha           = 1.0;
        colorPickerBmp.alpha          = 1.0;
      }
      default:{
        stdPmsPickerBmp.alpha         = 0.3;
        customPms1PickerBmp.alpha     = 0.3;
        customPms2PickerBmp.alpha     = 0.3;
        foilPickerBmp.alpha           = 0.3;
        colorPickerBmp.alpha          = 0.3;
      }
    }
  }

  
  override public function setParam(param:IParameter):Void{
    
    trace('setParam');
    switch( param.getLabel() ){
      case EVENT_ID.SHOW_PMS_PICKER:{ 
        stdPmsPickerBmp.visible       = param.getBool();
        customPms1PickerBmp.visible   = param.getBool();
        customPms2PickerBmp.visible   = param.getBool();
      }
      case EVENT_ID.ENABLE_PMS_PICKER:{ 
        stdPmsPickerBmp.alpha         = param.getFloat();
        customPms1PickerBmp.alpha     = param.getFloat();
        customPms2PickerBmp.alpha     = param.getFloat();
      }
      case EVENT_ID.SHOW_FOIL_PICKER:     { foilPickerBmp.visible = param.getBool(); }
      case EVENT_ID.SHOW_COLOR_PICKER:    { colorPickerBmp.visible = param.getBool(); }
      case EVENT_ID.ENABLE_FOIL_PICKER:   { foilPickerBmp.alpha = param.getFloat(); }
      case EVENT_ID.ENABLE_COLOR_PICKER:  { colorPickerBmp.alpha = param.getFloat(); }
    }
	}
	
	override public function setFloat(id:String, f:Float):Void{
	  trace(id);
    //switch ( id ) {
    //  case EVENT_ID.DESIGN_SCROLL:{
    //    designsPane.y = -(designsPane.getFloat('height')-designsScrollPane.getFloat('mask_height')) * f;
    //  }
    //}
	}

	
	private function PositionPickers( ): Void{
	  
	  stdColorText.visible            = true;
	  customColor1Text.visible        = true;
	  customColor2Text.visible        = true;
	  stdPmsPickerBmp.visible         = true;
	  customPms1PickerBmp.visible     = true;
	  customPms2PickerBmp.visible     = true;
    foilPickerBmp.visible           = true;
    colorPickerBmp.visible          = true;
    
    
	  pos = 50;
	  
	  if(stdPmsPickerBmp.visible){
	    stdColorText.y = pos;
	    pos = 0 + stdColorText.y + stdColorText.height;
	    stdPmsPickerBmp.y    = pos;
	    pos = 10 + stdPmsPickerBmp.y + stdPmsPickerBmp.height; 
	    
	    customColor1Text.y = pos;
	    pos = customColor1Text.y + customColor1Text.height;
	    customPms1PickerBmp.y = pos;
	    pos = 10 + customPms1PickerBmp.y + customPms1PickerBmp.height; 
	    
	    customColor2Text.y = pos;
	    pos = customColor2Text.y + customColor2Text.height;
	    customPms2PickerBmp.y = pos;
	    pos = 10 + customPms2PickerBmp.y + customPms2PickerBmp.height; 
	  }
	  
	  if(foilPickerBmp.visible){
	    foilPickerBmp.y   = pos;
      pos  = 10 + foilPickerBmp.y + foilPickerBmp.height;
	  }
	  
	  if(colorPickerBmp.visible){
	    colorPickerBmp.y    = pos;
	  }
	    
    
    //
    
	 
	}
}