package;

class Model extends AModel
{
  private var Zoom:ZoomTools;
  // models
  private var Application:IModel;
  private var Layout:IModel;
  private var Menu:IModel;
//  private var Configuration:IModel;
  private var Preset:IModel;
  private var Pages:IModel;
  private var Font:FontModel;
  private var Designs:IModel;
  private var Greetings:IModel;
  private var Logos:IModel;
  
  public function new(): Void{
  	super();
  
  }
  
  override public function init():Void{
    Zoom              = GLOBAL.Zoom;
    Application	      = GLOBAL.Application;
    Menu              = GLOBAL.Menu;
//    Configuration     = GLOBAL.Configuration;
    Preset            = GLOBAL.Preset;
    Pages             = GLOBAL.Pages;
    Font              = GLOBAL.Font;
    Designs           = GLOBAL.Designs;
    Greetings         = GLOBAL.Greetings;
    Logos             = GLOBAL.Logos;
  }
  
  override public function dispatchXML( label:String, xml:Xml):Void{
    var param:IParameter = new Parameter(label);
    param.setXml(xml);
    dispatchEvent(new XmlEvent(label, param));
  }
  
  override public function dispatchParameter(param:IParameter):Void{
    dispatchEvent(new KEvent(param.getLabel(),param));
  
  }
}