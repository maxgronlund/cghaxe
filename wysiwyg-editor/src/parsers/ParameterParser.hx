
package;

class ParameterParser
{
  private var Application:IModel;
  
	public function new(PreviewModel:IModel){

    this.Application = PreviewModel;
    
	}
	
	public function parse(params:Dynamic<String>):Void{
	  
    Application.setString(EVENT_ID.UPDATE_LOAD_PROGRESS, 'Loading Parameters');
	
	if (GLOBAL.IS_DEBUG)
	{
		params.shop_item_id = "155";
		params.language_id = "3";
		params.copy_preset="true";
		params.copy_preset = "true";
		params.authenticity_token = "HhZPQ6ktzccShp55J%2FlIEepE3j4rh0jHR1yaapWN%2Ba8%3D";
		params.wysiwyg_session = 'BAh7DEkiD3Nlc3Npb25faWQGOgZFRkkiJWI1MmIxYmE0Nzc4NDZjNjZlM2I4MDUyMTliNmQ5MDJhBjsAVEkiFmdvX3RvX2FmdGVyX2xvZ2luBjsARkkiUWh0dHA6Ly93d3cuY2FsbGlncmFwaGVuLmRrL2RrL3VuaWNlZi1kYW5tYXJrLzk2P2NvcHlfcHJlc2V0PXRydWUmcHJldmlldz0xNTUGOwBGSSIUY3VycmVudF9zaXRlX2lkBjsARmkOSSIJY2FydAY7AEZpA/tSAUkiCmdvX3RvBjsARkkiHy9kay91bmljZWYtZGFubWFyay93eXNpd3lnBjsARkkiEF9jc3JmX3Rva2VuBjsARkkiMUhoWlBRNmt0emNjU2hwNTVKL2xJRWVwRTNqNHJoMGpIUjF5YWFwV04rYTg9BjsARkkiDnVzZXJfdXVpZAY7AEZJIilmMDBiOTAyMS04M2MyLTQ0NDMtYTVkZS0zODJkOGU4NmFjOGEGOwBU--2f706ddfd4b5728ae604a032cd47162004ddbc1c';
		params.user_id = "21";
		params.user_uuid = "f00b9021-83c2-4443-a5de-382d8e86ac8a";
		params.edit_mode = "user_preset";
		params.shop_item_name = "6374";
		
		//params.preset_file_url = "http://www.calligraphen.dk/dk/wysiwyg_files/909/get_pages_xml.xml?copy_preset=true&language_id=3";
		params.preset_file_url = "get_pages_xml.xml";
	
		params.start_load_seq = 'bang';
	}

	
	  if(params.shop_item_id != null){
      GLOBAL.shop_item_id = Std.parseInt(params.shop_item_id);
    }
	  
	  if(params.language_id != null){
	    GLOBAL.language_id = params.language_id;
	  }
	  
	  if(params.copy_preset != null){
	    GLOBAL.copy_preset = params.copy_preset;
	  }
	  
	  if(params.authenticity_token != null){
      GLOBAL.authenticity_token = params.authenticity_token;
    }
    
    if(params.wysiwyg_session != null){
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
      GLOBAL.preset_file_url = params.design_xml_file_url;
    }
    
    if(params.shop_item_name != null){
      GLOBAL.shop_item_name = params.shop_item_name;
    }

    if(params.edit_mode != null){
      GLOBAL.edit_mode = params.edit_mode;
      switch ( params.edit_mode ){
        
        case 'system_design':{
          GLOBAL.side_view.addView(GLOBAL.color_view, 0,0, EVENT_ID.SHOW_COLOR_PICKERS);
          GLOBAL.side_view.addView(GLOBAL.text_view, 0,0,EVENT_ID.SHOW_TEXT);
          GLOBAL.side_view.addView(GLOBAL.text_suggestion_view, 0,0,EVENT_ID.SHOW_TEXT_SUGGESTIONS);
          GLOBAL.side_view.addView(GLOBAL.greetings_view, 0,0,EVENT_ID.SHOW_GREETINGS);
          GLOBAL.side_view.addView(GLOBAL.symbols_view, 0,0,EVENT_ID.SHOW_SYMBOLS);
          //GLOBAL.side_view.addView(GLOBAL.designs_view, 0,0,EVENT_ID.SHOW_DESIGNS);
          //GLOBAL.side_view.addView(GLOBAL.logos_view, 0,0,EVENT_ID.SHOW_MY_UPLOADS);
          //GLOBAL.side_view.addView(GLOBAL.price_view, 0,0,EVENT_ID.SHOW_PRICES);
//          GLOBAL.side_view.addView(GLOBAL.blind_view, 0,0,EVENT_ID.SHOW_BLIND_VIEW);
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
//          GLOBAL.side_view.addView(GLOBAL.blind_view, 0,0,EVENT_ID.SHOW_BLIND_VIEW);
        } 
        
        case 'user_preset':{
          GLOBAL.side_view.addView(GLOBAL.color_view, 0,0, EVENT_ID.SHOW_COLOR_PICKERS);
          //trace('system_preset: ', params.system_preset);
          GLOBAL.side_view.addView(GLOBAL.text_view, 0,0,EVENT_ID.SHOW_TEXT);
          GLOBAL.side_view.addView(GLOBAL.greetings_view, 0,0,EVENT_ID.SHOW_GREETINGS);
          GLOBAL.side_view.addView(GLOBAL.symbols_view, 0,0,EVENT_ID.SHOW_SYMBOLS);
          //GLOBAL.side_view.addView(GLOBAL.designs_view, 0,0,EVENT_ID.SHOW_PAGE_DESIGN);
          GLOBAL.side_view.addView(GLOBAL.logos_view, 0,0,EVENT_ID.SHOW_MY_UPLOADS);
          GLOBAL.side_view.addView(GLOBAL.price_view, 0,0,EVENT_ID.SHOW_PRICES);
//          GLOBAL.side_view.addView(GLOBAL.blind_view, 0,0,EVENT_ID.SHOW_BLIND_VIEW);
        }

        case 'system_preview':{

        }
      }
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
    if(params.start_load_seq != null){
      Application.setString(EVENT_ID.START_LOAD_SEQ, 'bang');
    }
	}
	
}