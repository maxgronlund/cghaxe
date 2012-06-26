
import flash.text.TextFormat;

class TextController extends Controller, implements IController{
  
  private var textFormat:TextFormat;
  private var fontStyleIndex:Int;
  
  	
  public function new(){	
  	super();
  	fontStyleIndex = 0;
  }
  

	override public function setParam(param:IParameter):Void{
   
    switch ( param.getLabel() ){
      case EVENT_ID.FONT_STYLE: onFontStyleSelected(param);
      case EVENT_ID.OPEN_COLOR_PICKER: GLOBAL.text_view.setParam(param);
      case EVENT_ID.FONT_COLOR_SELECTED: onFontColorSelected(param);
      case EVENT_ID.NO_COLOR_SELECTED:GLOBAL.text_view.setParam(param);
      case EVENT_ID.LINE_SPACE_SELECTED: onLineSpaceSelected(param);
      case EVENT_ID.FONT_SIZE_SELECTED: onFontSizeSelected(param);
      case EVENT_ID.ALIGN_RIGHT:onTextAllign(param);
      case EVENT_ID.ALIGN_LEFT:onTextAllign(param);
      case EVENT_ID.ALIGN_CENTER:onTextAllign(param);
      case EVENT_ID.SHOW_TEXT: GLOBAL.side_view.showView(EVENT_ID.SHOW_TEXT, true);
      case EVENT_ID.FONT_SELECTED:onFontSelected(param);
      case EVENT_ID.ADD_PLACEHOLDER:{
        TEXT_SUGGESTION.text = 'Type here';
        Pages.setParam(param);
      }
      case EVENT_ID.FONT_SCROLL:GLOBAL.text_view.setFloat(EVENT_ID.FONT_SCROLL, param.getFloat());
      case EVENT_ID.PLACEHOLDER_SELECTED:onPlaceholderSelected(param);


    }
	}
  
  private function onPlaceholderSelected(param:IParameter):Void{
    GLOBAL.Font.setXml(param.getString());
  }

  
  private function onFontSelected(param:IParameter):Void {
//    trace('onFontSelected');
    
    fontStyleIndex = 0;
    // feedback to deselect old selected button
    GLOBAL.text_view.setParam(param); 
    GLOBAL.Font.fontPackage   = param.getFontPackage();
    GLOBAL.Font.fileName      = GLOBAL.Font.fontPackage.fileName(fontStyleIndex);
    
    updateFont();
  }
  
  
  private function onFontStyleSelected(param:IParameter):Void{
    // NOT IN USE 
    GLOBAL.text_view.setParam(param);
    fontStyleIndex = param.getInt();
    updateFont();
    
  }
  
  private function onFontColorSelected(param:IParameter):Void{
    

    GLOBAL.Font.fontColor = param.getUInt();
    GLOBAL.text_view.setParam(param);
    updatePlaceholder();
    
  }
  
  private function onLineSpaceSelected(param:IParameter):Void{
//    trace('font zize:', param.getFloat());
    GLOBAL.Font.leading = Std.int(param.getFloat());
    GLOBAL.text_view.setParam(param);
    updatePlaceholder();
  }

  private function onFontSizeSelected(param:IParameter):Void{

    GLOBAL.Font.fontSize = Std.int(param.getFloat());
    GLOBAL.text_view.setParam(param);
    updatePlaceholder();
  }
  
  private function updateFont():Void{
    GLOBAL.Font.styleName 	= GLOBAL.Font.fontPackage.styleName(fontStyleIndex);
    GLOBAL.Font.fileName 	= GLOBAL.Font.fontPackage.fileName(fontStyleIndex); //!!! do this inside the font model
    updatePlaceholder();
  }
  
  private function onTextAllign(param:IParameter):Void{
    GLOBAL.text_view.setParam(param);
    GLOBAL.Font.fontAlign = param.getLabel();
    updatePlaceholder();
  }

  
  
  private function updatePlaceholder():Void{
//    trace('update placeholder --------------------------------');
    Pages.setParam(new Parameter(EVENT_ID.UPDATE_PLACEHOLDER));
  
  }
}