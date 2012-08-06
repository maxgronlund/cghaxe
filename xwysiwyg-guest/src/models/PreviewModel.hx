package;

import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.events.Event;

//class PreviewModel extends PresetModel, implements IModel
class PreviewModel extends ApplicationModel, implements IModel
{
//  private var editMode:String;


  public function new(){	
    super();
    
  }
  
  
  override public function init():Void{
  	super.init();
  }
  
 

  override private function startLoadSeq(mode:String):Void{

    switch (GLOBAL.edit_mode) {
      
      case 'system_preview':{
        trace('system_preview');
        loadStage = [ 'reset wysiwyg',
                      'load preset files from backend',
                      'pass preset',
                      'add pages to stage',
                      'set defaults',
                      ];
        loadSeq();
      }
   
    }
  }
  
  override private function loadSeq():Void{
    
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

        loadSeq();
      }

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
/*
  private function configurePresetSideView():Void{
    loadSeq();
  }
  
  private function configureDesignSideView():Void{
    loadSeq();
  }
*/  
  override private function onPresetLoaded(e:XmlEvent):Void{
    super.onPresetLoaded(e);
    //trace('onPresetLoaded');
    //trace(e.getXml().toString());
    //presetLoader.removeEventListener( EVENT_ID.PRESET_FILE_LOADED, onPresetLoaded);
    //presetXml = e.getXml();
    //loadSeq();

  }
/*                   
  private function onPageDesignLoaded(e:XmlEvent):Void{
    pageDesignLoader.removeEventListener( EVENT_ID.PAGEDESIGN_FILE_LOADED, onPageDesignLoaded);
    pageDesignXml = e.getXml();
    loadSeq();
  }
*/
  
}


