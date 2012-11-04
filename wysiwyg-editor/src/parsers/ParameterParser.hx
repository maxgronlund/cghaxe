
package;

class ParameterParser
{
  private var Application:IModel;
  
	public function new(PreviewModel:IModel){

    this.Application = PreviewModel;
    
	}
	
	public function parse(params:Dynamic<String>):Void{
	  
	  if(params.shop_item_id != null){
      GLOBAL.shop_item_id = Std.parseInt(params.shop_item_id);
      
    }
	  
	  if(params.language_id != null){
	    trace(GLOBAL.language_id);
	    GLOBAL.language_id = params.language_id;
	  }
	  
	  if(params.copy_preset != null){
	    GLOBAL.copy_preset = params.copy_preset;
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
    
    if(params.user_uuid != null){
      GLOBAL.user_uuid = params.user_uuid;
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

    if(params.preset_quantity != null){
      GLOBAL.preset_quantity = params.preset_quantity;
    }
    
    
    // page design
    if(params.design_xml_file_url != null){
      //GLOBAL.design_file_url = params.design_xml_file_url;
      GLOBAL.preset_file_url = params.design_xml_file_url;
    }
    
    if(params.shop_item_name != null){
      GLOBAL.shop_item_name = params.shop_item_name;
//      trace('Shop item name', GLOBAL.shop_item_name);
    }
    
    
    if(params.save_path != null){
  //    trace(params.save_path);
      //GLOBAL.save_path = params.save_path;
    }

    if(params.edit_mode != null){
      GLOBAL.edit_mode = params.edit_mode;
      switch ( params.edit_mode ){
        
        case 'system_design':{
          GLOBAL.side_view.addView(GLOBAL.color_view, 0,0, EVENT_ID.SHOW_COLOR_PICKERS);
          GLOBAL.side_view.addView(GLOBAL.text_view, 0,0,EVENT_ID.SHOW_TEXT);
          //GLOBAL.side_view.addView(GLOBAL.designs_view, 0,0,EVENT_ID.SHOW_PAGE_DESIGN);
          GLOBAL.side_view.addView(GLOBAL.greetings_view, 0,0,EVENT_ID.SHOW_GREETINGS);
          GLOBAL.side_view.addView(GLOBAL.symbols_view, 0,0,EVENT_ID.SHOW_SYMBOLS);
          GLOBAL.side_view.addView(GLOBAL.designs_view, 0,0,EVENT_ID.SHOW_DESIGNS);
          GLOBAL.side_view.addView(GLOBAL.logos_view, 0,0,EVENT_ID.SHOW_MY_UPLOADS);
          GLOBAL.side_view.addView(GLOBAL.price_view, 0,0,EVENT_ID.SHOW_PRICES);
          GLOBAL.side_view.addView(GLOBAL.blind_view, 0,0,EVENT_ID.SHOW_BLIND_VIEW);
        }
        
        case 'system_preset':{
          GLOBAL.side_view.addView(GLOBAL.color_view, 0,0, EVENT_ID.SHOW_COLOR_PICKERS);
          GLOBAL.side_view.addView(GLOBAL.text_view, 0,0,EVENT_ID.SHOW_TEXT);
          //GLOBAL.side_view.addView(GLOBAL.designs_view, 0,0,EVENT_ID.SHOW_PAGE_DESIGN);
          GLOBAL.side_view.addView(GLOBAL.greetings_view, 0,0,EVENT_ID.SHOW_GREETINGS);
          GLOBAL.side_view.addView(GLOBAL.symbols_view, 0,0,EVENT_ID.SHOW_SYMBOLS);
          GLOBAL.side_view.addView(GLOBAL.designs_view, 0,0,EVENT_ID.SHOW_DESIGNS);
          GLOBAL.side_view.addView(GLOBAL.logos_view, 0,0,EVENT_ID.SHOW_MY_UPLOADS);
          GLOBAL.side_view.addView(GLOBAL.price_view, 0,0,EVENT_ID.SHOW_PRICES);
          GLOBAL.side_view.addView(GLOBAL.blind_view, 0,0,EVENT_ID.SHOW_BLIND_VIEW);
        } 
        
        case 'user_preset':{
          GLOBAL.side_view.addView(GLOBAL.color_view, 0,0, EVENT_ID.SHOW_COLOR_PICKERS);
          //trace('system_preset: ', params.system_preset);
          GLOBAL.side_view.addView(GLOBAL.text_view, 0,0,EVENT_ID.SHOW_TEXT);
          //GLOBAL.side_view.addView(GLOBAL.designs_view, 0,0,EVENT_ID.SHOW_PAGE_DESIGN);
          GLOBAL.side_view.addView(GLOBAL.greetings_view, 0,0,EVENT_ID.SHOW_GREETINGS);
          GLOBAL.side_view.addView(GLOBAL.symbols_view, 0,0,EVENT_ID.SHOW_SYMBOLS);
          GLOBAL.side_view.addView(GLOBAL.logos_view, 0,0,EVENT_ID.SHOW_MY_UPLOADS);
          GLOBAL.side_view.addView(GLOBAL.price_view, 0,0,EVENT_ID.SHOW_PRICES);
          GLOBAL.side_view.addView(GLOBAL.blind_view, 0,0,EVENT_ID.SHOW_BLIND_VIEW);
        }

        case 'system_preview':{

        }
      }
    }
    
    if(params.start_load_seq != null){
      //trace('start_load_seq: ', params.start_load_seq);
      Application.setString(EVENT_ID.START_LOAD_SEQ, 'bang');
    }

    if(params.brides_first_name != null){
      GLOBAL.Designs.setString('brides_first_name', params.brides_first_name);
    }
    if(params.grooms_first_name != null){
      GLOBAL.Designs.setString('grooms_first_name', params.grooms_first_name);
    }
    if(params.wedding_date != null){
      GLOBAL.Designs.setString('wedding_date', params.wedding_date);
    }
    if(params.location_name != null){
      GLOBAL.Designs.setString('location_name', params.location_name);
    }


	}
	
}