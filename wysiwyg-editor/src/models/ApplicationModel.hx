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
    //trace(s);
    switch(id){        
      case EVENT_ID.START_LOAD_SEQ:{
        loadIndex   = 0;
        startLoadSeq(); //!!! <-- remove param
      }
      // triggered when all images is loaded
      case EVENT_ID.ALL_IMAGES_LOADED: {
        dispatchParameter(new Parameter(EVENT_ID.ALL_IMAGES_LOADED));
        loadSeq();
      }
    }
  }

  private function startLoadSeq():Void{
    trace('\n\n\n     <<<<<<<<<<<<<<<<<<<<<<<<<<<<<< - >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    * NOTHING GAINED BY BREAKING THE LOAD OF PRESET AND PRICES DOWN TO TWO REQUEST 
    * TWO ISSUES INTRODUCED
    * 1: WAIT FORTHE FIRST LOAD TO COMPLETE AND THEN DO THE NEXT LOAD 
    * 2: LOAD SIMULTANILUS AND DEAL WITH SYNCRONATION \n
    * BOTH SULUTIONS INTRODUCES SLOW PERFORMANCE AND UNNESSESERRY COMPLEXCITY
    * !NOTE THE SAVED XML FILE IS NOT THE SAME AS THE INFO REQUIRED IN THE XML FILES
    <<<<<<<<<<<<<<<<<<<<<<<<<<<<<< o >>>>>>>>>>>>>>>><<<<<<<<<<<<<>>>>>>>>\n\n');
    switch (GLOBAL.edit_mode) {
      
      
      case 'user_preset':{
        loadStage = [ 'reset wysiwyg',
                      'load preset files from backend',
                      'load price xml from backend',
                      'pass preset',
                      'pass preset price',
                      'add pages to stage',
                      'set defaults'
                      //'init zoom'
                      //'reset mouse'
                      ];
        loadSeq();
      }
      
      case 'system_preset':{
        
        loadStage = [ 'reset wysiwyg',
                      'load preset files from backend',
                      'load price xml from backend',  
                      'pass preset',
                      'pass preset price',
                      'add pages to stage',
                      'set defaults',
                      
                      //'init zoom'
                      //'reset mouse'
                      ];
        loadSeq();
      }
      
      case 'system_design':{
       
        loadStage = [ 'reset wysiwyg',
                      'load preset files from backend',
                      //'load price xml from backend',  
                      'pass preset',
                      'pass preset price',
                      'add pages to stage',
                      'set defaults',
                      
                      //'init zoom'
                      //'reset mouse'
                      ];
        loadSeq();
      }
      //case 'system_design':{
      //  loadStage = [ 'reset wysiwyg',
      //                'load design files from backend',
      //                'pass design',
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
        loadSeq();
      }
      case 'load preset files from backend':{
        trace(GLOBAL.preset_file_url);
        presetLoader.addEventListener( EVENT_ID.PRESET_FILE_LOADED, onPresetLoaded); 
        presetLoader.load(GLOBAL.preset_file_url, EVENT_ID.PRESET_FILE_LOADED);
        
      }
      
      case 'load price xml from backend':{
        if(GLOBAL.price_file_url == 'na'){
          loadSeq();
        }else{
          priceLoader.addEventListener( EVENT_ID.PRICE_FILE_LOADED, onPriceLoaded); 
          priceLoader.load(GLOBAL.price_file_url, EVENT_ID.PRICE_FILE_LOADED);
        }
        
      }
      
      //case 'load design files from backend':{
      //  pageDesignLoader.addEventListener( EVENT_ID.DESIGN_FILE_LOADED, onDesignLoaded);
      //  pageDesignLoader.load(GLOBAL.design_file_url, EVENT_ID.DESIGN_FILE_LOADED);
      //}
 
      case 'pass preset':{
        dispatchXML(EVENT_ID.PASS_PRESET_FILE, presetXml);
        loadSeq();
      }
      
      case 'pass preset price':{
        dispatchXML(EVENT_ID.PASS_PRICE_FILE, priceXml);
        loadSeq();
      }
      
      case 'pass design':{
        dispatchXML(EVENT_ID.PASS_DESIGN_FILE, pageDesignXml);
        loadSeq();                                               
      }
      
      case 'add pages to stage':{
        dispatchParameter(new Parameter(EVENT_ID.ADD_PAGES_TO_STAGE));
        //trace('add pages to stage done');
        
      }
      case 'add placeholders':{
        //trace('add placeholders');
        Designs.setParam(new Parameter(EVENT_ID.ADD_DESIGN));
        //trace('add placeholders done');
      } 
      case 'configure preset side view': configurePresetSideView();
      case 'set defaults':{
        dispatchParameter(new Parameter(EVENT_ID.LOAD_DEFAULT_SIDEVIEW));
        dispatchParameter(new Parameter(EVENT_ID.LOAD_DEFAULT_FONT));
        dispatchParameter(new Parameter(EVENT_ID.DESELECT_PLACEHOLDERS));
        dispatchParameter(new Parameter(EVENT_ID.SET_DEFAULT_TOOL));
        dispatchParameter(new Parameter(EVENT_ID.LOAD_DEFAULT_PAGE));
        loadSeq();
      }
      case 'show design page':{

        
        var param:IParameter = new Parameter( EVENT_ID.PAGE_SELECTED);
        param.setInt(0);
        Pages.dispatchParameter(param);
        
        loadSeq();
      }
      //case 'calculate prices':{
      //  trace('calculate prices');
      //  Pages.calculatePrice();
      //  loadSeq();
      //}
      
      //case 'init zoom':{
      //  trace('init zoom');
      //  //dispatchXML(EVENT_ID.INIT_ZOOM, pageDesignXml);
      //  loadSeq();                                               
      //}
      
//      case 'set zoom and pos':{
//        dispatchParameter(new Parameter(EVENT_ID.GET_PAGE_SIZE));
//        dispatchParameter(new Parameter(EVENT_ID.SET_PAGE_POS_AND_ZOOM));
//        loadSeq();
//      }
      case 'clead selected page':{
        dispatchParameter(new Parameter(EVENT_ID.TRASH_PLACEHOLDERS));
        loadSeq();
      }
      
      case 'pass preset page design':{
        var param:IParameter = new Parameter(EVENT_ID.PRESET_PAGEDESIGN_XML);
        param.setXml(pageDesignXml);
        dispatchParameter(param);
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
    //trace('onPresetLoaded');
    //trace(e.getXml().toString());
    presetLoader.removeEventListener( EVENT_ID.PRESET_FILE_LOADED, onPresetLoaded);
    presetXml = e.getXml();
    loadSeq();
  }
  
  private function onPriceLoaded(e:XmlEvent):Void{
    priceLoader.removeEventListener( EVENT_ID.PRICE_FILE_LOADED, onPriceLoaded);
    priceXml = e.getXml();
    loadSeq();
  }
                   
  //private function onDesignLoaded(e:XmlEvent):Void{
  // 
  //  pageDesignLoader.removeEventListener( EVENT_ID.DESIGN_FILE_LOADED, onDesignLoaded);
  //  pageDesignXml = e.getXml();
  //  loadSeq();
  //}

  
}


