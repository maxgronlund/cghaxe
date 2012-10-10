import flash.text.TextFormat;

class FontModel  {

  
  public var fontPackage(default, setFontPackage): FontPackage;
  function setFontPackage(s) return fontPackage = s
  
  public var fileName(default, setFileName): String;
  function setFileName(s) return fileName = s
  
  public var styleName(default, setStyleName): String;
  function setStyleName(s) return styleName = s
  
  public var fontSize(default, setFontSize): Float;
  function setFontSize(f) return fontSize = f
  
  public var fontColor(default, setFontColor): UInt;
  function setFontColor(s) return fontColor = s
  
  public var fontAlign(default, setFontAlign): String;
  function setFontAlign(s) return fontAlign = s
  
  public var leading(default, setLeading): Float;
  function setLeading(f) return leading = f
  
  public var letterSpacing(default, setletterSpacing): Float;
	function setletterSpacing(f) return letterSpacing = f
	
	public var anchorPoint(default, setAnchorPoint): Float;
	function setAnchorPoint(f) return anchorPoint = f
  
  
  private var xml:Xml;
  
  public function new(){
    GLOBAL.Application.addEventListener(EVENT_ID.LOAD_DEFAULT_FONT, onLoadDefaultFont);
  }
  
  private function onLoadDefaultFont(e:IKEvent):Void{
    
    switch(GLOBAL.font_set){
      case 'se', 'dk', 'en', 'de', 'fi', 'no', 'ru': {
        fontPackage = SystemFonts.avant_garde_gothic;
      }
      case 'pl':{
        fontPackage = SystemFonts.allegro;
      }
    }
    fileName    = fontPackage.fileName(0);
    fontSize    = fontPackage.defaultSize(0);
    styleName   = fontPackage.styleName(0);
    fontColor   = 0;
    leading     = 0;
    letterSpacing = 0;
    fontAlign   = 'left';
    anchorPoint = 0;
    
  }
  
  public function setXml(s:String):Void{
    var xml:Xml = Xml.parse(s);
    
    for( placeholder in xml.elementsNamed("placeholder") ) {
      for( font_file_name in placeholder.elementsNamed("font-file-name") ) {
        fileName = font_file_name.firstChild().nodeValue;
      }
      
      for( font_color in placeholder.elementsNamed("font-color") ) {
        fontColor = Std.parseInt(font_color.firstChild().nodeValue);
      }
      
      for( font_size in placeholder.elementsNamed("font-size") ) {
        fontSize = Std.parseInt(font_size.firstChild().nodeValue);
      }
      
      for( font_align in placeholder.elementsNamed("font-align") ) {
        fontAlign = font_align.firstChild().nodeValue;
      }
      for( anchor_point in placeholder.elementsNamed("anchor-point") ) {
        anchorPoint = Std.parseFloat(anchor_point.firstChild().nodeValue);
      }
    }
  }
}