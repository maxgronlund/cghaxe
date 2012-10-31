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
  private var Greetings:IModel;
  private var Symbols:IModel;
  private var Logos:IModel;
  private var Preset:IModel;
  private var Prices:IModel;
  private var Pages:IModel;
  private var Designs:IModel;
  private var parameterParser:ParameterParser;
  
  
  // controlers
  private var applicationController:IController;
  private var colorController:IController;
  private var textController:IController;
  private var textSuggestionController:IController;
  private var designsController:IController;
  private var greetingsController:IController;
  private var symbolsController:IController;
  private var logosController:IController;
  private var foilController:IController;
  private var addOnsController:IController;
  private var pricesController:IController;
  private var menuController:IController;
  private var pageSelectController:IController;
//  private var selectionController:IController;
  private var sidebarController:IController;
  private var desktopController:IController;
  
  // views
  private var applicationView:ApplicationView;
  private var colorView:AView;
  private var sideView:AView;
  private var textView:AView;
  private var textSuggestionView:AView;
  private var designsView:AView;
  private var greetingsView:AView;
  private var symbolsView:AView;
  private var logosView:AView;
  private var blindView:AView;
  private var addOnsView:AView;
  private var priceView:AView;
  private var menuView:AView;
  private var pageSelectorView:AView;
  private var desktopView:AView;
  private var gridView:AView;
  private var selectionView:AView;
  

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
//    trace(StringTools.urlDecode("%26"));
    
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
    Application                 = new ApplicationModel();
    Menu                        = new MenuModel();
    Preset                      = new PresetModel();
    Pages                       = new PagesModel();
    Designs                     = new DesignsModel();
    Greetings                   = new GreetingsModel();
    Symbols                     = new SymbolsModel();
    Logos                       = new LogosModel();
    Prices                      = new PricesModel();
           
    setGlobalModels();
    initGlobals();
    parameterParser             = new ParameterParser(Application);
    
    // controllers
    applicationController       = new ApplicationController();
    colorController             = new ColorController();
    sidebarController           = new SidebarController();
    pageSelectController        = new PageController();
    pricesController            = new PriceController();
    menuController              = new MenuController();
    textController              = new TextController();
    textSuggestionController    = new TextSuggestionController();
    designsController           = new DesignsController();
    greetingsController         = new GreetingsController();
    symbolsController           = new SymbolsController();
    logosController             = new LogosController();
    foilController		          = new FoilController();
    addOnsController	          = new AddOnsController();
    desktopController           = new DesktopController();
//    selectionController         = new SelectionController();
    
    setGlobalControllers();     
                                
    // views                    
    applicationView             = new ApplicationView(applicationController);
    colorView                   = new ColorView(colorController);
    sideView                    = new SideView(sidebarController);
    textView                    = new TextView(textController);
    textSuggestionView          = new TextSuggestionView(textSuggestionController);
    designsView                 = new DesignsView(designsController);
    greetingsView               = new GreetingsView(greetingsController);
    symbolsView                 = new SymbolsView(symbolsController);
    logosView                   = new LogosView(logosController);
    blindView                   = new BlindView(sidebarController);
    addOnsView                  = new AddOnsView(addOnsController);
    priceView                   = new PriceView(pricesController);
    menuView                    = new MenuView(menuController);
    pageSelectorView            = new PageSelectorView(pageSelectController);
    desktopView                 = new DesktopView(desktopController);
    gridView                    = new GridView(applicationController);
//    selectionView               = new SelectionView(selectionController);
    
    // setup views
    setGlobalViews();
    
    // system
    GLOBAL.hitTest = new CGHitTest();
    
    init();
    buildInterface();
  }

  
  private function setGlobalModels():Void{
    GLOBAL.Application      = Application;
    GLOBAL.Menu             = Menu;
    GLOBAL.Preset           = Preset;
    GLOBAL.Prices           = Prices;
    GLOBAL.Pages            = Pages;
    GLOBAL.Designs          = Designs;
    GLOBAL.Greetings        = Greetings;
    GLOBAL.Symbols          = Symbols;
    GLOBAL.Logos            = Logos;
    GLOBAL.Zoom         	  = new ZoomTools();
    GLOBAL.Font             = new FontModel();
    GLOBAL.userParser       = new UserParser();
  }
  
  private function initGlobals(): Void{
    GLOBAL.shop_item_name   = 'na';
    GLOBAL.foilColor        = 'silver';
    GLOBAL.pms1Color        = 0;
    GLOBAL.pms2Color        = 0;
    GLOBAL.stdPmsColor      = 0;
    GLOBAL.printType        = CONST.STD_PMS_COLOR;
    GLOBAL.price_file_url   = 'na';
    GLOBAL.shop_item_id     = -1;
    
    GLOBAL.pms1ColorString  = '541';
    GLOBAL.pms2ColorString  = '229';

    
  }
  
  private function setGlobalViews():Void{
    GLOBAL.text_view                  = textView;
    GLOBAL.color_view                 = colorView;
    GLOBAL.text_suggestion_view       = textSuggestionView;
    GLOBAL.designs_view               = designsView;
    GLOBAL.side_view                  = sideView;
    GLOBAL.add_ons_view	              = addOnsView;
    GLOBAL.price_view                 = priceView;
    GLOBAL.menu_view                  = menuView;
    GLOBAL.page_selector_view		      = pageSelectorView;
    GLOBAL.desktop_view               = desktopView;
    GLOBAL.grid_view                  = gridView;
    GLOBAL.selection_view             = selectionView;
    GLOBAL.greetings_view             = greetingsView;
    GLOBAL.symbols_view               = symbolsView;
    GLOBAL.logos_view                 = logosView;
    GLOBAL.blind_view                 = blindView;
    GLOBAL.foil			              		= foil;
  }
  
  private function setGlobalControllers():Void{
    GLOBAL.color_controller           = colorController;
    GLOBAL.text_controller            = textController;
    GLOBAL.text_suggestion_controller = textSuggestionController;
    GLOBAL.designs_controller         = designsController;
    GLOBAL.greetings_controller       = greetingsController;
    GLOBAL.symbols_controller         = symbolsController;
    GLOBAL.logos_controller           = logosController;
    GLOBAL.sidebar_controller         = sidebarController;
    GLOBAL.desktop_controller         = desktopController;
    GLOBAL.menu_controller            = menuController;
//    GLOBAL.selection_controller       = selectionController;
    
  }

  private function init():Void{
    // models
    Application.init();
    Designs.init();
    Greetings.init();
    Symbols.init();
    Logos.init();
    Menu.init();
    Preset.init();
    Prices.init();
    Pages.init();

    // views
    menuView.init();
    colorView.init();
    textView.init();
    textSuggestionView.init();
    designsView.init();

    addOnsView.init();
    greetingsView.init();
    symbolsView.init();
    logosView.init();
    blindView.init();
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
    sideView.addView(blindView, 0,430,EVENT_ID.SHOW_BLIND_VIEW);
*/    
    applicationView.addView(menuView, 0,0);
    applicationView.addView(pageSelectorView, 0, SIZE.MENU_VIEW_HEIGHT);
    applicationView.addView(gridView, 0, SIZE.MENU_VIEW_HEIGHT + SIZE.PAGESELESCTOR_HEIGHT); 
    gridView.mouseChildren = false;
    gridView.mouseEnabled = false;

    // position views
    sideView.x = SIZE.MAIN_VIEW_WIDTH - SIZE.SIDEBAR_VIEW_WIDTH;
  }
  
  private function loadParams():Void{
    parameterParser.parse(flash.Lib.current.loaderInfo.parameters);
	}	
	
}
