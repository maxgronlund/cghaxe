package;

import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.events.Event;

//class ApplicationModel extends PresetModel, implements IModel
class ApplicationModel extends Model, implements IModel
{
	private var configurationLoader:ILoader;
	private var presetLoader:ILoader;
	private var pageDesignLoader:ILoader;
	private var presetPageDesignLoader:ILoader;
	private var pageDesignsLoader:ILoader;
	private var loadIndex:UInt;
	private var loadStage:Array<String>;	
	private var presetXml:Xml;
  private var pageDesignXml:Xml;

  public function new(){	
    super();
    presetLoader              = new XmlLoader();
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
        startLoadSeq(GLOBAL.edit_mode); //!!! <-- remove param
      }
      // triggered when all images is loaded
      case EVENT_ID.ALL_IMAGES_LOADED: {
        dispatchParameter(new Parameter(EVENT_ID.ALL_IMAGES_LOADED));
        loadSeq();
      }
    }
  }

  private function startLoadSeq(mode:String):Void{
    //xmlFilesLoaded = 0;
    

    switch (GLOBAL.edit_mode) {
      
      
      case 'user_preset':{
        
        loadStage = [ 'reset wysiwyg',
                      'load preset files from backend',
                      'pass preset',
                      'add pages to stage',
                      'set defaults',
                      //'init zoom'
                      //'reset mouse'
                      ];
        loadSeq();
      }
      
      case 'system_preset':{
        
        loadStage = [ 'reset wysiwyg',
                      'load preset files from backend',
                      'pass preset',
                      'add pages to stage',
                      'set defaults',
                      //'init zoom'
                      //'reset mouse'
                      ];
        loadSeq();
      }
      case 'system_design':{
        loadStage = [ 'reset wysiwyg',
                      'load design files from backend',
                      'pass page design',
                      'add pages to stage',
                      'set defaults'
                      //'add placeholders', 
                      //'init zoom'
                      //'reset mouse'
                      ];
        loadSeq();
      }
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
        presetLoader.addEventListener( EVENT_ID.PRESET_FILE_LOADED, onPresetLoaded); 
        presetLoader.load(GLOBAL.preset_file_url, EVENT_ID.PRESET_FILE_LOADED);
      }
      
      case 'load design files from backend':{
        pageDesignLoader.addEventListener( EVENT_ID.PAGEDESIGN_FILE_LOADED, onPageDesignLoaded);
        pageDesignLoader.load(GLOBAL.preset_file_url, EVENT_ID.PAGEDESIGN_FILE_LOADED);
      }
 
      case 'pass preset':{
        dispatchXML(EVENT_ID.PASS_PRESET_FILE, presetXml);
        loadSeq();
      }
      
      case 'pass page design':{
        dispatchXML(EVENT_ID.PASS_DESIGN_FILE, pageDesignXml);
        loadSeq();                                               
      }
      
      case 'add pages to stage':dispatchParameter(new Parameter(EVENT_ID.ADD_PAGES_TO_STAGE));
      case 'add placeholders': Designs.setParam(new Parameter(EVENT_ID.ADD_DESIGN));
      case 'configure preset side view': configurePresetSideView();
      case 'set defaults':{
        dispatchParameter(new Parameter(EVENT_ID.LOAD_DEFAULT_PAGE));
        dispatchParameter(new Parameter(EVENT_ID.LOAD_DEFAULT_SIDEVIEW));
        dispatchParameter(new Parameter(EVENT_ID.LOAD_DEFAULT_FONT));
        dispatchParameter(new Parameter(EVENT_ID.DESELECT_PLACEHOLDERS));
        dispatchParameter(new Parameter(EVENT_ID.SET_DEFAULT_TOOL));
        
        // update DesktopView if there is no placeholders
        
        
        loadSeq();
      }
      
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
                   
  private function onPageDesignLoaded(e:XmlEvent):Void{
    pageDesignLoader.removeEventListener( EVENT_ID.PAGEDESIGN_FILE_LOADED, onPageDesignLoaded);
    pageDesignXml = e.getXml();
    loadSeq();
  }

  
}


