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
  private var Configuration:IModel;
  private var Preset:IModel;
  private var Pages:IModel;
  private var Designs:IModel;
  private var DesignImages:IModel;
  private var parameterParser:ParameterParser;
  
  
  // controlers
  private var applicationController:IController;
  private var textController:IController;
  private var textSuggestionController:IController;
  private var designsController:IController;
  private var designImagesController:IController;
  private var foilController:IController;
  private var addOnsController:IController;
  private var garamondController:IController;
  private var logoController:IController;
  private var priceController:IController;
  private var menuController:IController;
  private var pageSelectController:IController;
  private var selectionController:IController;

  private var sidebarController:IController;
  private var desktopController:IController;


  
  // views
  private var applicationView:ApplicationView;
  private var sideView:AView;
  private var textView:AView;
  private var textSuggestionView:AView;
  private var designsView:AView;
  private var designImagesView:AView;
  private var foilView:AView;
  private var addOnsView:AView;
  private var garamondView:AView;
  private var logoView:AView;
  private var priceView:AView;
  private var menuView:AView;
  private var pageSelectorView:AView;
  private var desktopView:AView;
  private var gridView:AView;
  private var selectionView:AView;
  private var greetingsView:AView;
  private var foil:Foil;
  
  
  // system
  private var version:VersionCheck;
  private var Fonts:SystemFonts;
  private var userParser:UserParser;
  private var hitTest:CGHitTest;
  

  
  
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
    //userParser                  = new UserParser();
    TEXT_SUGGESTION.text        = 'please';
    
    // models
    Application                 = new ApplicationModel();
    Menu                        = new MenuModel();
//    Configuration               = new ConfigurationModel();
    Preset                      = new PresetModel();
    Pages                       = new PagesModel();
    Designs                     = new DesignsModel();
    DesignImages                = new DesignImagesModel();
                  
    setGlobalModels();
    parameterParser             = new ParameterParser(Application);
    
    // controllers
    applicationController       = new ApplicationController();
    sidebarController           = new SidebarController();
    pageSelectController        = new PageController();
    menuController              = new MenuController();
    textController              = new TextController();
    textSuggestionController    = new TextSuggestionController();
    designsController           = new DesignsController();
    designImagesController      = new DesignImagesController();
    foilController		          = new FoilController();
    addOnsController	          = new AddOnsController();
    garamondController          = new GaramondController();
    logoController		          = new LogoController();
    desktopController           = new DesktopController();
    selectionController         = new SelectionController();
    
    setGlobalControllers();     
                                
    // views                    
    applicationView             = new ApplicationView(applicationController);
    sideView                    = new SideView(sidebarController);
    textView                    = new TextView(textController);
    textSuggestionView          = new TextSuggestionView(textSuggestionController);
    designsView                 = new DesignsView(designsController);
    designImagesView            = new DesignImagesView(designImagesController);
    foilView                    = new FoilView(foilController);
    addOnsView                  = new AddOnsView(addOnsController);
    garamondView                = new GaramondView(garamondController);
    logoView                    = new LogoView(logoController);
    priceView                   = new PriceView(priceController);
    menuView                    = new MenuView(menuController);
    pageSelectorView            = new PageSelectorView(pageSelectController);
    desktopView                 = new DesktopView(desktopController);
    gridView                    = new GridView(applicationController);
    selectionView               = new SelectionView(selectionController);
    greetingsView               = new GreetingView(selectionController);
	  foil						            = new Foil(new FoilTexture());
    
    setGlobalViews();
    
    // system
    //hitTest = new CGHitTest();
    GLOBAL.hitTest = new CGHitTest();
    
    init();
    buildInterface();
  }

  
  private function setGlobalModels():Void{
    GLOBAL.Application    = Application;
    GLOBAL.Menu           = Menu;
//    GLOBAL.Configuration  = Configuration;
    GLOBAL.Preset         = Preset;
    GLOBAL.Pages          = Pages;
    GLOBAL.DesignImages   = DesignImages;
    GLOBAL.Designs        = Designs;
    
    GLOBAL.Zoom         	= new ZoomTools();
    GLOBAL.Font           = new FontModel();
    GLOBAL.userParser     = new UserParser();
  }
  
  private function setGlobalViews():Void{
  	// only for use by dedicated controllers
    GLOBAL.text_view                  = textView;
    GLOBAL.text_suggestion_view       = textSuggestionView;
    GLOBAL.designs_view               = designsView;
    GLOBAL.design_images_view         = designImagesView;
    GLOBAL.foil_view                  = foilView;
    GLOBAL.side_view                  = sideView;
    GLOBAL.add_ons_view	              = addOnsView;
    GLOBAL.garamond_view              = garamondView;
    GLOBAL.logo_view                  = logoView;
    GLOBAL.price_view                 = priceView;
    GLOBAL.menu_view                  = menuView;
    GLOBAL.page_selector_view		      = pageSelectorView;
    GLOBAL.desktop_view               = desktopView;
    GLOBAL.grid_view                  = gridView;
    GLOBAL.selection_view             = selectionView;
    GLOBAL.greetingsView              = greetingsView;
    GLOBAL.foil			              		= foil;
  }
  
  private function setGlobalControllers():Void{
    GLOBAL.text_controller            = textController;
    GLOBAL.text_suggestion_controller = textSuggestionController;
    GLOBAL.designs_controller         = designsController;
    GLOBAL.sidebar_controller         = sidebarController;
    GLOBAL.desktop_controller         = desktopController;
    //GLOBAL.sibling_controller         = siblingController;
    GLOBAL.menu_controller            = menuController;
    GLOBAL.selection_controller       = selectionController;
    
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
    menuView.init();
    textView.init();
    textSuggestionView.init();
    designsView.init();
    designImagesView.init();
    foilView.init();
    addOnsView.init();
    garamondView.init();
    logoView.init();
    priceView.init();
    pageSelectorView.init();
    desktopView.init();
    
    //globals
    GLOBAL.pos_x = 0;
    GLOBAL.pos_y = 0;

  }
  
  private function buildInterface():Void{
    
    // add views
    Lib.current.addChild(applicationView);
    Lib.current.addChild(sideView);
    applicationView.addView(desktopView, 0, SIZE.MENU_VIEW_HEIGHT + SIZE.PAGESELESCTOR_HEIGHT); 
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
    applicationView.addView(menuView, 0,0);
    applicationView.addView(pageSelectorView, 0, SIZE.MENU_VIEW_HEIGHT);
    applicationView.addView(gridView, 0, SIZE.MENU_VIEW_HEIGHT + SIZE.PAGESELESCTOR_HEIGHT); 
    gridView.mouseChildren = false;
    gridView.mouseEnabled = false;
    
    //applicationView.addView(selectionView, 0,0);
    //selectionView.addView(greetingsView, 0, 0, 'greetings');

    
    // position views
    sideView.x = SIZE.MAIN_VIEW_WIDTH - SIZE.SIDEBAR_VIEW_WIDTH;
  }
  
  private function loadParams():Void{
    parameterParser.parse(flash.Lib.current.loaderInfo.parameters);
	}	
	
}
