class Controller extends AController
{
  private var Zoom:ZoomTools;
  // models
  private var Application:IModel;
  private var Menu:IModel;
  private var Preset:IModel;
  private var Pages:IModel;
  private var Designs:IModel;
  private var Greetings:IModel;
  private var Symbols:IModel;
  private var Logos:IModel;
  
  override public function new():Void{
    super();
    Zoom              = GLOBAL.Zoom;
    Application	      = GLOBAL.Application;
    Menu              = GLOBAL.Menu;
    Preset            = GLOBAL.Preset;
    Pages             = GLOBAL.Pages;
    Designs           = GLOBAL.Designs;
    Greetings         = GLOBAL.Greetings;
    Symbols           = GLOBAL.Symbols;
    Logos             = GLOBAL.Logos;
  }
}