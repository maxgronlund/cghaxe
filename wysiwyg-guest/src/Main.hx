package;

import flash.Lib;
import flash.events.Event;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.display.StageScaleMode;
import flash.display.StageDisplayState; 
import flash.text.TextFormat;


class Main
{
  	// models
	public static var Application:IModel;
  private var Menu:IModel;
//  private var Configuration:IModel;
  private var Preset:IModel;
  private var Pages:IModel;
  private var Designs:IModel;
  private var parameterParser:ParameterParser;
  
  
  // controlers
  // 2.0
  private var applicationController:IController;
  private var textController:IController;
//  private var textSuggestionController:IController;
  private var designsController:IController;
  private var foilController:IController;
  private var addOnsController:IController;
  private var garamondController:IController;
  private var logoController:IController;
  private var priceController:IController;
  private var siblingController:IController;
//  private var menuController:IController;
  private var pageSelectController:IController;

  private var sidebarController:IController;
  private var desktopController:IController;


  
  // views
  private var applicationView:ApplicationView;
  private var sideView:AView;
  private var desktopView:AView;
  
  
  // system
  var version:VersionCheck;
  private var Fonts:SystemFonts;
  
  static function main(){
    new Main();
  }
  
  public function new(){	
  
    var consoleSender:ConsoleSender = new ConsoleSender();
    trace('------------------------------------------------------');
    trace('wysiwyg dev vertion Zebra',CompileDate.getDate());
    trace('------------------------------------------------------');
    
    version = new VersionCheck();
    
    if( version.check() ){
      Lib.current.scaleMode=StageScaleMode.NO_SCALE;
      buildApp();
      loadParams();
      Application.setString(EVENT_ID.ALL_FILES_LOADED, 'fo');
    }
    else{
      trace("You need a newer Flash Player.");
      trace("Your version: " + flash.system.Capabilities.version);
      trace("The minimum required version: 10.0.0.525");
    }
  }
  
  private function buildApp():Void {
    // system   
    Fonts                       = new SystemFonts();
    TEXT_SUGGESTION.text        = 'please';
    
    // models
    Application                 = new PreviewModel();
    Menu                        = new MenuModel();
//    Configuration               = new ConfigurationModel();
    Preset                      = new PresetModel();
    Pages                       = new PagesModel();
    Designs                     = new DesignsModel();
                  
    setGlobalModels();
    parameterParser             = new ParameterParser(Application);

    
    // controllers
    applicationController       = new ApplicationController();
    sidebarController           = new SidebarController();
    pageSelectController        = new PageController();
//    menuController              = new MenuController();
    textController              = new TextController();
//    textSuggestionController    = new TextSuggestionController();
    designsController           = new DesignsController();
    foilController		          = new FoilController();
    addOnsController	          = new AddOnsController();
    garamondController          = new GaramondController();
    logoController		          = new LogoController();
    desktopController           = new DesktopController();
    setGlobalControllers();     
                                
    // views                    
    applicationView             = new ApplicationView(applicationController);
    sideView                    = new SideView(sidebarController);
//    textView                    = new TextView(textController);
//    textSuggestionView          = new TextSuggestionView(textSuggestionController);
//    designsView                 = new DesignsView(designsController);
//    foilView                    = new FoilView(foilController);
//    addOnsView                  = new AddOnsView(addOnsController);
//    garamondView                = new GaramondView(garamondController);
//    logoView                    = new LogoView(logoController);
//    priceView                   = new PriceView(priceController);
//    menuView                    = new MenuView(menuController);
//    pageSelectorView            = new BadgePageSelectorView(pageSelectController);
    desktopView                 = new DesktopView(desktopController);
    
    setGlobalViews();
    
    init();
    buildInterface();
  }

  
  private function setGlobalModels():Void{
    GLOBAL.Application    = Application;
    GLOBAL.Menu           = Menu;
//    GLOBAL.Configuration  = Configuration;
    GLOBAL.Preset         = Preset;
    GLOBAL.Pages          = Pages;
    GLOBAL.Designs        = Designs;
    GLOBAL.Zoom         	= new ZoomTools();
    GLOBAL.Font           = new FontModel();
  }
  
  private function setGlobalViews():Void{
  	// only for use by dedicated controllers
//    GLOBAL.text_view                  = textView;
//    GLOBAL.text_suggestion_view       = textSuggestionView;
//    GLOBAL.designs_view               = designsView;
//    GLOBAL.foil_view                  = foilView;
    GLOBAL.side_view                  = sideView;
//    GLOBAL.add_ons_view	              = addOnsView;
//    GLOBAL.garamond_view              = garamondView;
//    GLOBAL.logo_view                  = logoView;
//    GLOBAL.price_view                 = priceView;
//    GLOBAL.menu_view                  = menuView;
//    GLOBAL.page_selector_view         = pageSelectorView;
    GLOBAL.desktop_view               = desktopView;
          		
  }
  
  private function setGlobalControllers():Void{
    GLOBAL.text_controller            = textController;
//    GLOBAL.text_suggestion_controller = textSuggestionController;
    GLOBAL.designs_controller         = designsController;
    GLOBAL.sidebar_controller         = sidebarController;
    GLOBAL.desktop_controller         = desktopController;
    GLOBAL.sibling_controller         = siblingController;
    
  }

  private function init():Void{
    // models
    Application.init();
//    Layout.init();
    Designs.init();
    Menu.init();
//    Configuration.init();
    Preset.init();
    Pages.init();

    // views
//    menuView.init();
//    textView.init();
//    textSuggestionView.init();
//    designsView.init();
//    foilView.init();
//    addOnsView.init();
//    garamondView.init();
//    logoView.init();
//    priceView.init();
//    pageSelectorView.init();
    desktopView.init();
    
    //globals
    GLOBAL.pos_x = 0;
    GLOBAL.pos_y = 0;

  }
  
  private function buildInterface():Void{
    
    // add views
    Lib.current.addChild(applicationView);
//    Lib.current.addChild(sideView);
    applicationView.addView(desktopView, 0, 0);
/*    
    sideView.addView(textView, 0,0,EVENT_ID.SHOW_TEXT);
    sideView.addView(textSuggestionView, 0,30,EVENT_ID.SHOW_TEXT_SUGGESTIONS);
    sideView.addView(foilView, 0,60,EVENT_ID.SHOW_FOIL);
    sideView.addView(addOnsView, 0,90,EVENT_ID.SHOW_ADD_ONS);
    sideView.addView(garamondView, 0,120,EVENT_ID.SHOW_GARAMOND);
    sideView.addView(logoView, 0,150,EVENT_ID.SHOW_LOGO);
    sideView.addView(priceView, 0,180,EVENT_ID.SHOW_PRICES);
    sideView.addView(blindView, 0,430,EVENT_ID.BLIND_VIEW);
*/    
//    applicationView.addView(menuView, 0,0);
//    applicationView.addView(pageSelectorView, 0, BADGE_SIZE.MAIN_VIEW_HEIGHT - BADGE_SIZE.PAGESELESCTOR_HEIGHT);
    
    // position views
    sideView.x = SIZE.MAIN_VIEW_WIDTH - SIZE.SIDEBAR_VIEW_WIDTH;
  }
  
  private function loadParams():Void{

    parameterParser.parse(flash.Lib.current.loaderInfo.parameters);
	}	
	
}
