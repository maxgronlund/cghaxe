
package;

class ParameterParser
{
  private var Application:IModel;
  
	public function new(PreviewModel:IModel){

    this.Application = PreviewModel;
    
	}
	
	public function parse(params:Dynamic<String>):Void{
	  //trace('ParameterParser::parse');
	  
	  if(params.language_name != null){
	    trace(params.language_name);
	    GLOBAL.language_name = params.language_name;
	  }
	  
	  if(params.authenticity_token != null){
      //trace('authenticity_token: ', params.authenticity_token);
      GLOBAL.authenticity_token = params.authenticity_token;
    }
    
    if(params.wysiwyg_session != null){
      //trace('wysiwyg_session: ', params.wysiwyg_session);
      GLOBAL.wysiwyg_session = params.wysiwyg_session;
    }
    
    if(params.user_id != null){
      GLOBAL.user_id = params.user_id;
    }
    
    if(params.ie7hack != null){
      if(params.ie7hack == 'IE7FIX'){
        GLOBAL.admin_mode = true;
      }
      else{
        GLOBAL.admin_mode = false;
        GLOBAL.wysiwyg_status = 'show_system_preset';
      }
    }
    
    // preset
    if(params.preset_file_url != null){
      GLOBAL.preset_file_url = params.preset_file_url;
    }
    
    // page design
    if(params.pagedesign_xml_file_url != null){
      GLOBAL.preset_file_url = params.pagedesign_xml_file_url;
    }

    if(params.save_path != null){
      GLOBAL.save_path = params.save_path;
      //trace('save path: ', params.save_path);
    }

    if(params.edit_mode != null){
      GLOBAL.edit_mode = params.edit_mode;
      //trace(GLOBAL.edit_mode);
      
      switch ( params.edit_mode ){
        case 'system_design':{
          GLOBAL.side_view.addView(GLOBAL.color_view, 0,0, EVENT_ID.SHOW_COLOR_PICKERS);
          GLOBAL.side_view.addView(GLOBAL.text_view, 0,0,EVENT_ID.SHOW_TEXT);
          GLOBAL.side_view.addView(GLOBAL.greetings_view, 0,0,EVENT_ID.SHOW_GREETINGS);
          GLOBAL.side_view.addView(GLOBAL.text_suggestion_view, 0,0,EVENT_ID.SHOW_TEXT_SUGGESTIONS);
          //GLOBAL.side_view.addView(GLOBAL.design_greetings_view, 0,0,EVENT_ID.SHOW_DESIGN_IMAGES);
        }
    
        case 'system_preset':{
          GLOBAL.side_view.addView(GLOBAL.color_view, 0,0, EVENT_ID.SHOW_COLOR_PICKERS);
          GLOBAL.side_view.addView(GLOBAL.text_view, 0,0,EVENT_ID.SHOW_TEXT);
          //GLOBAL.side_view.addView(GLOBAL.designs_view, 0,0,EVENT_ID.SHOW_PAGE_DESIGN);
          GLOBAL.side_view.addView(GLOBAL.greetings_view, 0,0,EVENT_ID.SHOW_GREETINGS);
          GLOBAL.side_view.addView(GLOBAL.designs_view, 0,0,EVENT_ID.SHOW_DESIGNS);
        } 
        
        case 'user_preset':{
          GLOBAL.side_view.addView(GLOBAL.color_view, 0,0, EVENT_ID.SHOW_COLOR_PICKERS);
          //trace('system_preset: ', params.system_preset);
          GLOBAL.side_view.addView(GLOBAL.text_view, 0,0,EVENT_ID.SHOW_TEXT);
          //GLOBAL.side_view.addView(GLOBAL.designs_view, 0,0,EVENT_ID.SHOW_PAGE_DESIGN);
          GLOBAL.side_view.addView(GLOBAL.greetings_view, 0,0,EVENT_ID.SHOW_GREETINGS);
        }
        
        case 'system_preview':{

        }
      }
    }
    
    if(params.start_load_seq != null){
      //trace('start_load_seq: ', params.start_load_seq);
      Application.setString(EVENT_ID.START_LOAD_SEQ, 'bang');
    }
    //trace('end of parse');
	}
	

}