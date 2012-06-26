class Controller extends AController
{
  private var Zoom:ZoomTools;
  // models
  private var Application:IModel;
  //private var Layout:IModel;
  private var Menu:IModel;
//  private var Configuration:IModel;
  private var Preset:IModel;
  private var Pages:IModel;
  private var Designs:IModel;
  private var DesignImages:IModel;
  
  override public function new():Void{
    super();
    Zoom              = GLOBAL.Zoom;
    Application	      = GLOBAL.Application;
    Menu              = GLOBAL.Menu;
//    Configuration     = GLOBAL.Configuration;
    Preset            = GLOBAL.Preset;
    Pages             = GLOBAL.Pages;
    Designs           = GLOBAL.Designs;
    DesignImages      = GLOBAL.DesignImages;
  }
}