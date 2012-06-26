// the placeholder handles the mouse



import flash.events.Event;
import flash.geom.Point;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.display.Loader;

import flash.events.MouseEvent;
import flash.display.MovieClip;
import flash.display.Loader;
import flash.net.URLRequest;

import flash.system.ApplicationDomain; 
import flash.system.LoaderContext;
import flash.system.SecurityDomain;

import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

import flash.geom.Point;
import flash.display.BitmapData;
import flash.display.Bitmap;


class Placeholder extends MouseHandler{
	

  private var fontMovie:MovieClip;
  private var font:Dynamic;
  private var parrent:PageView;
  
  private var model:IModel;
  private var mouseOver:Bool;
//  private var mouseDown:Bool;
//  private var sanitizeMouse:Bool;
  private var id:Int;
  private var modelId:Int;
  
  private var xml:String;
  private var fontFileName:String;
  private var fontScreenName:String;
  private var defaultText:String;
  private var fontSize:Int;
  private var fontColor:Int;
  private var fontAlign:String;
  private var fontLeading:Int;
  private var letterSpacing:Int;
  private var fontPosX:Float;
  private var setFocusOnUpdate:Bool;
  
  var textString:String;
  
  public function new(parrent:PageView, id:Int, model:IModel, text:String){	
    

    super();
    this.parrent = parrent;
    this.id = id;
    this.model = model;
    this.modelId = model.getInt('pageId');
    addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    defaultText = text;
    this.alpha = 0.85;
    fontPosX = 0;
    mouseOver = false;
    setFocusOnUpdate = false;

    if( GLOBAL.edit_mode != 'system_design')
      insert_tags(defaultText);
    
    
  }
  
  private function insert_tags(str:String):Void{
    
    trace('reply_to_people2', GLOBAL.Designs.getString('reply_to_people2'));
    
    var r = ~/_brides_first_name/gi;
    defaultText = r.replace(str,GLOBAL.Designs.getString('brides_first_name')); 
    
    r = ~/_grooms_first_name/gi;
    defaultText = r.replace(defaultText,GLOBAL.Designs.getString('grooms_first_name'));
    
    r = ~/_brides_last_name/gi;
    defaultText = r.replace(defaultText,GLOBAL.Designs.getString('brides_last_name'));
    
    r = ~/_grooms_last_name/gi;
    defaultText = r.replace(defaultText,GLOBAL.Designs.getString('grooms_last_name'));
    
    r = ~/_brides_initials/gi;
    defaultText = r.replace(defaultText,GLOBAL.Designs.getString('brides_initials'));
    
    r = ~/_grooms_initials/gi;
    defaultText = r.replace(defaultText,GLOBAL.Designs.getString('grooms_initials'));
    
    r = ~/_wedding_date/gi;
    defaultText = r.replace(defaultText,GLOBAL.Designs.getString('wedding_date'));
    
    r = ~/_wedding_time/gi;
    defaultText = r.replace(defaultText,GLOBAL.Designs.getString('wedding_time'));
    
    r = ~/_church_name/gi;
    defaultText = r.replace(defaultText,GLOBAL.Designs.getString('church_name'));
    
    r = ~/_church_location/gi;
    defaultText = r.replace(defaultText,GLOBAL.Designs.getString('church_location'));
    
    r = ~/_party_place_name/gi;
    defaultText = r.replace(defaultText,GLOBAL.Designs.getString('party_place_name'));
    
    r = ~/_party_place_location/gi;
    defaultText = r.replace(defaultText,GLOBAL.Designs.getString('party_place_location'));  
    
    r = ~/_reply_by_date/gi;
    defaultText = r.replace(defaultText,GLOBAL.Designs.getString('reply_by_date'));
    
    r = ~/_reply_to_phone2/gi;
    defaultText = r.replace(defaultText,GLOBAL.Designs.getString('reply_to_phone2'));
    
    r = ~/_reply_to_phone/gi;
    defaultText = r.replace(defaultText,GLOBAL.Designs.getString('reply_to_phone'));
    
    r = ~/_reply_to_email/gi;
    defaultText = r.replace(defaultText,GLOBAL.Designs.getString('reply_to_email'));
    
    r = ~/_dress_code/gi;
    defaultText = r.replace(defaultText,GLOBAL.Designs.getString('dress_code'));
    
    r = ~/_company_name/gi;
    defaultText = r.replace(defaultText,GLOBAL.Designs.getString('company_name'));
    
    r = ~/_location_name/gi;
    defaultText = r.replace(defaultText,GLOBAL.Designs.getString('location_name'));
    
    r = ~/_location/gi;
    defaultText = r.replace(defaultText,GLOBAL.Designs.getString('location'));
    
    r = ~/_reply_to_people2/gi;
    defaultText = r.replace(defaultText,GLOBAL.Designs.getString('reply_to_people2'));
    
    r = ~/_reply_to_people/gi;
    defaultText = r.replace(defaultText,GLOBAL.Designs.getString('reply_to_people'));
    
    r = ~/_dinner_place_name/gi;
    defaultText = r.replace(defaultText,GLOBAL.Designs.getString('dinner_place_name'));
    
    r = ~/_city/gi;
    defaultText = r.replace(defaultText,GLOBAL.Designs.getString('city'));
    /*
    23 in total
     reply_to_people;
     reply_to_people2;
     reply_to_phone2;
     dinner_place_name;
    */

  }

  public function onAddedToStage(e:Event){
    
    loadFont();
    model.addEventListener(EVENT_ID.GET_PAGE_XML+Std.string(modelId), onGetXml);
    addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
	
  }
  
  public function onRemovedFromStage(e:Event){
    removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
  	model.removeEventListener(EVENT_ID.GET_PAGE_XML+Std.string(modelId), onGetXml);
  
  	
  }
  
  private function loadFont():Void{
    
    fontFileName                  = GLOBAL.Font.fileName;
    fontSize                      = GLOBAL.Font.fontSize;
    fontColor                     = GLOBAL.Font.fontColor;
    fontAlign                     = GLOBAL.Font.fontAlign;
    fontLeading                   = GLOBAL.Font.leading;
    letterSpacing                 = GLOBAL.Font.letterSpacing;
    
    
    var ldr:Loader                = new Loader(); 
    var req:URLRequest            = new URLRequest(buildUrl(fontFileName)); 
    var ldrContext:LoaderContext  = new LoaderContext(); 
    ldrContext.applicationDomain  = new ApplicationDomain();
    ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, onFontLoaded); 
    ldr.load(req, ldrContext);

  }
  
  private function buildUrl(fileName:String):String{
  	return "/assets/" + fileName+ ".swf?" + Math.random();
  }
  
  private function onFontLoaded(event:Event):Void { 

    fontMovie   =  cast event.target.loader.content;
    addChild(fontMovie);
    font        = fontMovie.font;
    font.init(  fontSize, 
                fontColor, 
                fontAlign, 
                defaultText, 
                letterSpacingToFont() , 
                letterSpacing);
                
                 
    var param:IParameter = new Parameter(EVENT_ID.FONT_LOADED);
    param.setInt(id);
    model.setParam(param);
    
    if(setFocusOnUpdate){
      setFocusOnUpdate = false;
      setFocus(true);
    } 
    
  }
  
  public function setFocus(b:Bool):Void{

    b ? MouseTrap.capture():MouseTrap.release();
    if(font != null){
      font.setFocus(b);
      font.selectable(!GLOBAL.MOVE_TOOL);
    }
  }
   
  override private function onMouseOver(e:MouseEvent){
    //mouseOver = true;
    //super.onMouseOver(e);
  }

  override private function onMouseDown(e:MouseEvent){

    //super.onMouseDown(e);
    //
    //GLOBAL.Font.fileName        = fontFileName;
    //GLOBAL.Font.fontSize        = fontSize;
    //GLOBAL.Font.fontColor       = fontColor;
    //GLOBAL.Font.fontAlign       = fontAlign;
    //GLOBAL.Font.leading         = fontLeading;
    //GLOBAL.Font.letterSpacing   = letterSpacing;
    //parrent.setPlaceholderInFocus(this);
    //
    //model.setParam(new Parameter(EVENT_ID.UPDATE_TEXT_TOOLS));
    //if(GLOBAL.MOVE_TOOL){
    //  parrent.enableMove(e);
    //}
  }
  
  override private function onMouseOut(e:MouseEvent){
    //mouseOver = false;
    //removeEventListener(MouseEvent.ROLL_OUT, onMouseOut);
    //addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
  }
  
  override private function onMouseUp(e:MouseEvent){
    
    //MouseTrap.release();
    //super.onMouseUp(e);
    //parrent.disableMove();
    //
    //GLOBAL.Application.dispatchParameter(new Parameter(EVENT_ID.RESET_STAGE_SIZE));
    
  }
  
  public function getText(): Void {
    
    var param:IParameter = new Parameter(EVENT_ID.PLACEHOLDER_TEXT);
    param.setString(font.getText());
    param.setInt(id);
    model.setParam(param);
  }
  
  private function onGetXml(event:Event):Void{
    model.setString(EVENT_ID.SET_PAGE_XML, getXml());
  }
  
  public function getXml() : String {
  	
    var str:String = '\t\t<placeholder id=\"'+ Std.string(id) +'\">\n';
      str += '\t\t\t<pos-x>' + Std.string(x) + '</pos-x>\n';
      str += '\t\t\t<pos-y>' + Std.string(y) + '</pos-y>\n';
      str += '\t\t\t<font-file-name>' + fontFileName + '</font-file-name>\n';
      str += '\t\t\t<font-color>' + Std.string(fontColor) + '</font-color>\n';
      str += '\t\t\t<line-space>' + Std.string(fontLeading) + '</line-space>\n';
      str += '\t\t\t<font-size>' + Std.string(fontSize) + '</font-size>\n';
      str += '\t\t\t<font-align>' + fontAlign + '</font-align>\n';
      str += font.getXml();
    str += '\t\t</placeholder>\n';
    return str;
  }
  
  public function onUpdatePlaceholder(event:Event):Void{
    defaultText = font.getText();
    removeChild(fontMovie);
    font = null;
    loadFont();
    setFocusOnUpdate = true;
	}
	
	private function letterSpacingToFont():Int
	{
	    return fontLeading;
	}

}
