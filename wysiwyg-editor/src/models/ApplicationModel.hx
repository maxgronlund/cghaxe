package;

import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.events.Event;

//class ApplicationModel extends PresetModel, implements IModel
class ApplicationModel extends Model, implements IModel
{
	private var configurationLoader:ILoader;
	private var presetLoader:ILoader;
	private var priceLoader:ILoader;
	private var pageDesignLoader:ILoader;
	private var presetPageDesignLoader:ILoader;
	private var pageDesignsLoader:ILoader;
	private var loadIndex:UInt;
	private var loadStage:Array<String>;	
	private var presetXml:Xml;
	private var priceXml:Xml;
  private var pageDesignXml:Xml;

  public function new(){	
    super();
    presetLoader              = new XmlLoader();
    priceLoader               = new XmlLoader();
    pageDesignLoader          = new XmlLoader();
    presetPageDesignLoader    = new XmlLoader();
    pageDesignsLoader         = new XmlLoader();
    loadIndex   = 0;
    loadStage                 = new Array<String>();
  }
  
  
  override public function init():Void{
  	super.init();
  }
  
  override public function setString( id:String, s:String):Void{
    switch(id){        
      case EVENT_ID.START_LOAD_SEQ:{
        loadIndex   = 0;
        startLoadSeq(); //!!! <-- remove param
      }
      // triggered when all images is loaded
      case EVENT_ID.ALL_PHOTOS_LOADED: {
        dispatchParameter(new Parameter(EVENT_ID.ALL_PHOTOS_LOADED));
        loadSeq();
      }
      case EVENT_ID.UPDATE_LOAD_PROGRESS:{
        loadProgress(s);
      }
      case EVENT_ID.CLOSE_LOAD_PROGRESS:{
        var param = new Parameter(EVENT_ID.CLOSE_LOAD_PROGRESS);
         param.setString(s);
         dispatchEvent(new KEvent(param.getLabel(),param));
      }
    }
  }

  private function startLoadSeq():Void{
    loadProgress('Start Load Sequence');
    switch (GLOBAL.edit_mode) {
      
      
      case 'user_preset':{
        loadStage = [ 'reset wysiwyg',
                      'load preset files from backend',
                      'parse preset',
                      //'parse preset price',
                      'add pages to stage',
                      'set defaults',
                      'show fonts',
                      'load custom pms',
                      'add_scroll_bars'
                      ];
        loadSeq();
      }
      
      case 'system_preset':{
        
        loadStage = [ 'reset wysiwyg',
                      'load preset files from backend', 
                      'parse preset',
                      //'parse preset price',
                      'add pages to stage',
                      'set defaults',
                      'show fonts',
                      'load custom pms',
                      'add_scroll_bars'
                      ];
        loadSeq();
      }
      
      case 'system_design':{
       
        loadStage = [ 'reset wysiwyg',
                      'load preset files from backend',
                      //'load price xml from backend',  
                      'parse preset',
                      //'parse preset price',
                      'add pages to stage',
                      'set defaults',
                      'load custom pms',
                      'add_scroll_bars'
                      //'init zoom'
                      //'reset mouse'
                      ];
        loadSeq();
      }
      //case 'system_design':{
      //  loadStage = [ 'reset wysiwyg',
      //                'load design files from backend',
      //                'parse design',
      //                'add pages to stage',
      //                'set defaults',
      //                'show design page'
      //                //'add placeholders', 
      //                //'init zoom'
      //                //'reset mouse'
      //                ];
      //  loadSeq();
      //}
    }
  }
  
  private function loadSeq():Void{
    
    var stage:String = loadStage[loadIndex];
    loadIndex++;
    
    switch( stage ) {
      case 'reset wysiwyg':{
        dispatchParameter(new Parameter(EVENT_ID.RESET_WYSIWYG));
        loadProgress('Reset Interface');
        loadSeq();
      }
      case 'load preset files from backend':{
        loadProgress('Request Preset XML');
        presetLoader.addEventListener( EVENT_ID.PRESET_FILE_LOADED, onPresetLoaded); 
        presetLoader.load(GLOBAL.preset_file_url+"&language_id="+GLOBAL.language_id, EVENT_ID.PRESET_FILE_LOADED);
        
      }
      
      //case 'load price xml from backend':{
      //  if(GLOBAL.price_file_url == 'na'){
      //    loadSeq();
      //  }else{
      //    priceLoader.addEventListener( EVENT_ID.PRICE_FILE_LOADED, onPriceLoaded); 
      //    priceLoader.load(GLOBAL.price_file_url, EVENT_ID.PRICE_FILE_LOADED);
      //  }
      //  
      //}
      
      //case 'load design files from backend':{
      //  pageDesignLoader.addEventListener( EVENT_ID.DESIGN_FILE_LOADED, onDesignLoaded);
      //  pageDesignLoader.load(GLOBAL.design_file_url, EVENT_ID.DESIGN_FILE_LOADED);
      //}
 
      case 'parse preset':{
        dispatchXML(EVENT_ID.PASS_PRESET_FILE, presetXml);
        loadSeq();
        
      }
      
      //case 'parse preset price':{
      //  loadProgress('Parse Price XML');
      //  //trace('onParsePrice', priceXml.toString());
      //  dispatchXML(EVENT_ID.PASS_PRICE_FILE, priceXml);
      //  loadSeq();
      //}
      
      case 'parse design':{
        loadProgress('Parse Design ');
        dispatchXML(EVENT_ID.PASS_DESIGN_FILE, pageDesignXml);
        loadSeq();                                               
      }
      
      case 'add pages to stage':{
        dispatchParameter(new Parameter(EVENT_ID.ADD_PAGES_TO_STAGE));
      }
      case 'add placeholders':{
        loadProgress('Add Placeholders');
        Designs.setParam(new Parameter(EVENT_ID.ADD_DESIGN));
      } 
      case 'configure preset side view': configurePresetSideView();
      case 'set defaults':{
        loadProgress('Set Defaults');
        dispatchParameter(new Parameter(EVENT_ID.LOAD_DEFAULT_SIDEVIEW));
        dispatchParameter(new Parameter(EVENT_ID.DESELECT_PLACEHOLDERS));
        dispatchParameter(new Parameter(EVENT_ID.SET_DEFAULT_TOOL));
        dispatchParameter(new Parameter(EVENT_ID.LOAD_DEFAULT_PAGE));
        loadSeq();
      }
      case 'show design page':{
        loadProgress('Show Pagedesign');
        var param:IParameter = new Parameter( EVENT_ID.PAGE_SELECTED);
        param.setInt(0);
        Pages.dispatchParameter(param);
        
        loadSeq();
      }
      case 'show fonts':{
        dispatchParameter(new Parameter(EVENT_ID.SHOW_FONT_SET));
        dispatchParameter(new Parameter(EVENT_ID.LOAD_DEFAULT_FONT));
        loadProgress('Show Fonts');
        loadSeq();
      }
      //case 'clead selected page':{
      //  dispatchParameter(new Parameter(EVENT_ID.TRASH_PLACEHOLDERS));
      //  loadProgress('Clear Selected Page');
      //  loadSeq();
      //}
      
      //case 'parse preset page design':{
      //  var param:IParameter = new Parameter(EVENT_ID.PRESET_PAGEDESIGN_XML);
      //  param.setXml(pageDesignXml);
      //  dispatchParameter(param);
      //}
      
      case 'load custom pms':{
        loadProgress('Load Custom PMS Colors');
        dispatchParameter(new Parameter(EVENT_ID.LOAD_CUSTOM_PMS_COLORS));
        loadSeq();
      }
      case 'add_scroll_bars':{
        loadProgress('Add Scrollbars');
        dispatchParameter(new Parameter(EVENT_ID.ADD_SCROLL_BARS));
        loadSeq();
      }
    }
  }

  private function configurePresetSideView():Void{
    loadSeq();
  }
  
  private function configureDesignSideView():Void{
    loadSeq();
  }
  
  private function onPresetLoaded(e:XmlEvent):Void{
    loadProgress('Preset XML Loaded');
    presetLoader.removeEventListener( EVENT_ID.PRESET_FILE_LOADED, onPresetLoaded);
    presetXml = e.getXml();
    loadSeq();
  }
  
  //private function onPriceLoaded(e:XmlEvent):Void{
  //  priceLoader.removeEventListener( EVENT_ID.PRICE_FILE_LOADED, onPriceLoaded);
  //  priceXml = e.getXml();
  //  loadSeq();
  //}
  
  public function loadProgress(s:String):Void{
     var param = new Parameter(EVENT_ID.UPDATE_LOAD_PROGRESS);
     param.setString(s);
     dispatchEvent(new KEvent(param.getLabel(),param));
  }
  

                   
  //private function onDesignLoaded(e:XmlEvent):Void{
  // 
  //  pageDesignLoader.removeEventListener( EVENT_ID.DESIGN_FILE_LOADED, onDesignLoaded);
  //  pageDesignXml = e.getXml();
  //  loadSeq();
  //}

  
}

