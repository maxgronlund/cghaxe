/*  to do
*   sort alphabetic
*/

class EVENT_ID  {
  
  // Text Suggestion events
//	public static inline var TEXT_SUGGESTION:String           = "text_suggestion";
//  public static inline var EDIT_MODE:String                 = "edit_mode";
  
  public static inline var TEXT_SUGGESTION_SELECTED:String  = "text_suggestion_selected";
  public static inline var ADD_TEXT_SUGGESTION:String       = "add_text_suggestion";
  public static inline var ADD_SUGGESTION_BUTTON:String     = "add_text_suggestion_button";
  
  public static inline var DESIGN_SELECTED:String           = "design_selected";
  public static inline var ADD_DESIGN_BUTTON:String         = "add_designs_button";
  public static inline var ADD_DESIGN:String                = "add_design";
  public static inline var ADD_DESIGN_TO_PAGE:String        = "add_design_to_page";
  
  // side views
//  public static inline var ADD_TEXT_VIEW:String             = "add_text_view";
//  public static inline var ADD_PLACEHOLDER_VIEW:String      = "add_placeholders_view";
//  public static inline var ADD_DESIGN_VIEW:String           = "add_designs_view";
//  public static inline var ADD_VECTOR_VIEW:String           = "add_vectors_view";
//  public static inline var ADD_FOIL_VIEW:String             = "add_foil_view";
//  public static inline var ADD_ADD_ONS_VIEW:String          = "add_add_ons_view";
//  public static inline var ADD_LOGO_VIEW:String             = "add_logo_view";

  public static inline var PRESET_PRICES:String             = "preset_prices";
  public static inline var PRESET_PRICES_XML_PARSED:String  = "preset_prices_xml_parsed";
  public static inline var CALCULATE_PRICE:String           = "calculate_price";
  public static inline var ADD_PRICE_COLUMN:String          = "add_price_column";

  
  // Events
  public static inline var RESET_WYSIWYG:String             = "RESET_WYSIWYG";
  public static inline var ALL_FILES_LOADED:String          = "all_files_loaded";
  public static inline var PAGE_XML:String                  = "page_xml";
  public static inline var PAGE_XML_LOADED:String           = "page_xml_loaded";
  public static inline var DESIGN_XML_LOADED:String         = "design_xml_loaded";
  
  public static inline var DISABLE_MOUSE_ON_PAGES:String    = "disable_mouse_on_pages";


  public static inline var ADD_PAGES_TO_STAGE:String        = "add_pages_to_stage";
  public static inline var LOAD_DEFAULT_PAGE:String         = "load_default_page";
  public static inline var LOAD_DEFAULT_SIDEVIEW:String     = "load_default_sideview";
  public static inline var LOAD_DEFAULT_FONT:String         = "load_default_font";
  public static inline var SHOW_FONT_SET:String             = "show_font_set";
  //public static inline var ADD_FONT_SCROLL_BAR:String       = "add_font_scroll_bar";
  public static inline var ADD_SCROLL_BARS:String           = "add_scroll_bars";
  public static inline var PLACEHOLDER_SELECTED:String      = 'placeholder_selected';
  public static inline var PLACEHOLDER_LOADED:String               = 'font_loaded';
  public static inline var UPDATE_FONT_PANE:String          = 'update_font_pane';
  public static inline var ADD_PLACEHOLDER                  = "add_placeholder";
  
  //!!! remove me?
  public static inline var PRESET_PRODUCT_ID_LOADED         = "preset_product_id_loaded";
  
//  public static inline var CONFIGURABLE_PLACE_LOADED        = "configurable_place_loaded";
  
  public static inline var TRASH_PLACEHOLDER                = "trash_placeholder";
  public static inline var TRASH_PLACEHOLDERS               = "trash_placeholders";
  public static inline var LAYOUT_XML_FILE                  = "layout_xml_file";
  public static inline var DESELECT_PLACEHOLDERS            = "deselect_placeholders";
//  public static inline var RESET_MOUSE                      = "reset_mouse";
  
//  public static inline var PAGEDESIGN_FILE_URL              = "pagedesign_file_url";
//  public static inline var PAGEDESIGNS_FILE_URL             = "pagedesigns_file_url";
  public static inline var DESIGN_FILE_LOADED           = "design_file_loaded";
//  public static inline var PRESET_PAGEDESIGN_FILE_URL       = "preset_pagedesign_url";
//  public static inline var PRESET_PAGEDESIGN_LOADED         = "preset_pagedesign_loaded";
  public static inline var PRESET_PAGEDESIGN_XML            = "preset_pagedesign_xml";
  public static inline var PAGEDESIGN_FILE                  = "pagedesign_file";
  public static inline var PASS_DESIGN_FILE:String          = "pass_design_file";
  public static inline var PAGE_DESIGNS_LOADED:String       = "page_designs_loaded";
//  public static inline var SHOW_PAGE_DESIGN:String        = "show_page_designs";

  
  public static inline var DESKTOP_VIEW_MOVE                = "desktop_view_move";
  
  public static inline var PAGE_BACKDROP_LOADED:String      = "page_backdrop_loaded";
  public static inline var ALL_IMAGES_LOADED:String         = "ALL_IMAGES_LOADED";
  
  
//  public static inline var PRESET_FILE_URL                  = "preset_file_url";
  public static inline var PRICE_FILE_LOADED                = "price_file_loaded";
  public static inline var PRESET_FILE_LOADED               = "preset_file_loaded";
  public static inline var PASS_PRICE_FILE                  = "pass_price_file";
  public static inline var PASS_PRESET_FILE                 = "pass_preset_file";
  public static inline var PRESET_LOADED                    = "preset_loaded";
  

  
  // Text events from the text view
  public static inline var FONT_SELECTED:String             = "font_selected";
  public static inline var FONT_SIZE_SELECTED               = "font_sizes_selected";
  public static inline var LINE_SPACE_SELECTED              = "lini_space_selected";
  
//  public static inline var GET_PAGE_SIZE                    = "get_page_size";
  public static inline var LOAD_PAGE_POS_AND_ZOOM           = "set_page_pos_and_zoom";
  public static inline var RESET_STAGE_SIZE                 = "reset_stage_size";

  
   
  public static inline var MENU:String                      = "menu";
  
  

  
  public static inline var PLACEHOLDER_DATA:String          = "placeholders_data";
  public static inline var PLACEHOLDER_COUNT:String         = "placeholder_count";
  public static inline var CENTER_PAGE:String               = "center_page";
  public static inline var PAGE_SELECTED:String             = "page_selected";
  public static inline var BUILD_PAGE:String                = "build_page";
  public static inline var BUILD_DESIGN_PAGE:String         = "build_design_page";
  public static inline var ADD_DESIGN_PAGE_TO_SIDEBAR:String  = "add_design_page_to_sidebar";
  
  public static inline var ADD_PAGE_DESIGN:String           = "add_page_design";
  public static inline var ZAP_PAGES:String                 = "zap_pages";
                                                            
  // save                                                   
  public static inline var GET_PAGE_XML:String              = "get_page_xml";
  public static inline var GET_PAGE_POS_XML:String          = "get_page_pos_xml";
  public static inline var SET_PAGE_XML:String              = "set_page_xml";
  public static inline var GET_DESKTOP_POS:String           = "get_desktop_pos";
  public static inline var SET_DESKTOP_POS:String           = "set_desktop_pos";                                                          
                                                            
  // gui                                                    
  public static inline var RELEASE_FOCUS:String             = "release_focus";
  public static inline var UPDATE_PLACEHOLDER:String        = "update_placeholder";
  public static inline var UPDATE_PMS1:String               = "update_pms1";
  public static inline var UPDATE_PMS2:String               = "update_pms2";
  public static inline var LOAD_CUSTOM_PMS_COLORS:String    = "load_custim_pms_colors";
  
  // in the menu
  public static inline var SHOW_CARD:String                 = "show_card";
  public static inline var SHOW_INSERT:String               = "show_insert";
  public static inline var SHOW_MASK:String                 = "show_mask";
  public static inline var ZOOM:String                      = "zoom_id";
  public static inline var ZOOM_POPUP:String                = "menu_zoom_popup";
  public static inline var ZOOM_OUT:String                  = "menu_zoom_out";
  public static inline var ZOOM_IN:String                   = "menu_zoom_in";
  public static inline var ZOOM_100:String                  = "menu_zoom_to_100";
  public static inline var MOVE_TOOL:String                 = "move_tool";
  public static inline var TEXT_TOOL:String                 = "text_tool";
  public static inline var ALLIGN_SELECTED_LEFT:String      = "align_selected_left";
  public static inline var ALLIGN_SELECTED_CENTER:String    = "align_selected_center";
  public static inline var ALLIGN_SELECTED_RIGHT:String     = "align_selected_right";
  public static inline var GRID_ON:String                   = "grid_on";
  public static inline var SET_DEFAULT_TOOL:String          = "set_default_tool";
  
  //public static inline var SELECT_MOVE_TOOL:String          = "select_move_tool";
  

                                                            
  // text  view/ formating                                  
  public static inline var FONT_SCROLL                      = "font_scroll";
                                                            
  public static inline var ALIGN_LEFT                        = "left";
  public static inline var ALIGN_CENTER                      = "center";
  public static inline var ALIGN_RIGHT                       = "right";
  
                                                             
                                                             
  // side views                                              
  public static inline var SHOW_ADD_ONS                     = "show_add_ons";
  public static inline var SHOW_PRICES                      = "show_prices";
  public static inline var SHOW_TEXT:String                 = "show_text_view";
  public static inline var SHOW_GREETINGS:String            = "show_greetings";
  public static inline var SHOW_SYMBOLS:String              = "show_symbols";
  public static inline var SHOW_MY_UPLOADS:String           = "show_my_uploads";
  public static inline var SHOW_DESIGNS:String              = "show_designs";
  public static inline var SHOW_TEXT_SUGGESTIONS:String     = "show_text_suggestion_view";
  public static inline var TEXT_SUGGESTION_LOADED:String    = "text_suggestion_loaded";
  public static inline var SHOW_COLOR_PICKERS:String        = "show_color_pickers";
  public static inline var UPDATE_SIDE_VIEWS:String         = "update_side_views";
  public static inline var BUILD_PAGE_DESIGNS:String        = "buile_page_designs";

  
  
  
  
  public static inline var USE_GARAMOND:String               = "use_garamond"; 
  public static inline var PMS4_COLOR:String                 = "PMS4_COLOR";
  public static inline var PMS2_COLOR:String                 = "PMS2_COLOR";                                                    
  public static inline var SHOW_FOIL:String                  = "foil_view";
  public static inline var SHOW_IMAGE:String                 = "image_view";
  public static inline var SHOW_LOGO:String                  = "logo_view";
  public static inline var SHOW_BLIND_VIEW:String            = "blind_view";
  public static inline var CLOSE_TOOL_TIPS:String            = "close_tool_tips";
                                                             
  
  public static inline var CLOSE                             = "close";
  //public static inline var LOAD_FRONT_SHOTS:String           = "load_front_shots";
  public static inline var LOAD_FRONT_SHOT:String            = "load_front_shot";
  public static inline var FRONT_SHOT_LOADED:String          = "front_shot_loaded";                                                           
  public static inline var SET_PLACEHOLDER_POS               = "set_placeholder_pos";
  
                                                             
  public static inline var SAVE_XML                          = "save_xml";
  public static inline var BUY_NOW                           = "buy_now";
  public static inline var GET_STRING                        = "get_string";
  public static inline var PLACEHOLDER_TEXT                  = "placeholder_text";
  public static inline var SET_TEXT_FORMAT                   = "set_text_format";
  public static inline var OPEN_COLOR_PICKER	               = "open_color_picker";

                                                             
                                                             
  // text formatting                                         
  public static inline var FONT                              = "font";
  public static inline var FONT_STYLE                        = "text_style";
  
  public static inline var FONT_COLOR_SELECTED                = "font_color_selected"; //!!!
  public static inline var NO_COLOR_SELECTED                  = "no_color_selected";
  public static inline var TEXT_ALIGN:String                  = "text_align";
  public static inline var SET_PLACEHOLDER_XML:String        = "set_placeholder_xml"; 
//  public static inline var UPDATE_TEXT_TOOLS                  = "update_text_tools";
  
  
  public static inline var START_LOAD_SEQ                     = "start_load_seq";
                                                            
  // text suggestions 
  public static inline var SUGGESTION_SCROLL                  = "suggestion_scroll";
  
  
  // designs 
  public static inline var DESIGN_SCROLL                      = "design_scroll";

  
  // vectors
  public static inline var GREETINGS_LOADED:String            = "greetings_loaded";
  public static inline var SYMBOLS_LOADED:String              = "symbols_loaded";
  public static inline var GREETING_SCROLL                    = "greeting_scroll";
  public static inline var SYMBOL_SCROLL                      = "greeting_scroll";
  public static inline var ADD_GREETING_BUTTON                = "add_greeting_button";
  public static inline var ADD_SYMBOL_BUTTON                  = "add_symbol_button";
  public static inline var GREETING_SELECTED                  = "greeting_selected";
  public static inline var SYMBOL_SELECTED                    = "symbol_selected";
  public static inline var ADD_GREETING_TO_PAGE               = "add_greeting_to_page";
  public static inline var ADD_SYMBOL_TO_PAGE                 = "add_symbol_to_page";
  public static inline var IS_GREEDING_FREE                   = "is_greeding_free";
  
  public static inline var GREETING_PREVIEW                   = "greeting_preview";
  public static inline var GREETING_FINISH_PREVIEW            = "greeting_finish_preview";
  public static inline var LOAD_NEXT_IMAGE					  = "load_next_image";
  
  public static inline var START_DRAG_SYMBOL				  = "start_drag_symbol";
  public static inline var START_DRAG_LOGO  				  = "start_drag_logo";
  public static inline var STOP_DRAG_SYMBOL				  	  = "stop_drag_symbol";
  
  public static inline var LOAD_GREETINGS_ASSETS			  = "load_greetings_assets";
  public static inline var LOAD_SYMBOLS_ASSETS				  = "load_symbols_assets";
  
  // logos
  public static inline var LOGOS_LOADED:String                = "logos_loaded";
  public static inline var PHOTOS_LOADED:String               = "photos_loaded";
  public static inline var LOGO_SCROLL                        = "logo_scroll";
  public static inline var PHOTO_SCROLL                       = "image_scroll";
  public static inline var ADD_LOGO_BUTTON                    = "add_logo_button";
  public static inline var ADD_IMAGE_BUTTON                   = "add_image_button";
  public static inline var LOGO_SELECTED                      = "logo_selected";
  public static inline var PHOTO_SELECTED                     = "image_selected";
  public static inline var ADD_LOGO_TO_PAGE                   = "add_logo_to_page";
  public static inline var ADD_PHOTO_TO_PAGE                  = "add_image_to_page";
  
  public static inline var GREETING_COLOR_SELECTED            = "greeting_color_selected";
  public static inline var NO_GREETING_COLOR_SELECTED         = "no_greeting_color_selected";

  
  public static inline var SHOW_PMS_PICKER                    = "show_pms_picker";
  public static inline var SHOW_FOIL_PICKER                   = "show_foil_picker";
  public static inline var SHOW_COLOR_PICKER                  = "show_color_picker";
  public static inline var ENABLE_PMS_PICKER                  = "enable_pms_picker";
  public static inline var ENABLE_FOIL_PICKER                 = "enable_foil_picker";
  public static inline var ENABLE_COLOR_PICKER                = "enable_color_picker";
  public static inline var POSITION_PICKERS                   = "positions_pickers";
  
  public static inline var PMS1_COLOR_SELECTED                = "pms1_color_selected";
  public static inline var PMS2_COLOR_SELECTED                = "pms2_color_selected";
  public static inline var STD_PMS_COLOR_SELECTED             = "std_pms_color_selected";
  public static inline var FOIL_COLOR_SELECTED                = "foil_color_selected";
  public static inline var COLOR_SELECTED                     = "color_selected";
  
  public static inline var UPLOAD_LOGO                        = "upload_logo";
  public static inline var UPLOAD_PHOTO                       = "upload_image";
  public static inline var DELETE_KEY_PRESSED                 = "delete_key_pressed";
  public static inline var ENABLE_DELETE_KEY                  = "enable_delete_key";
  public static inline var DISABLE_DELETE_KEY                 = "disable_delete_key";
  
  public static inline var UPDATE_QUANTITY                    = "update_quantity";
  
  public static inline var UPDATE_LOAD_PROGRESS               = "update_load_progress";
  public static inline var CLOSE_LOAD_PROGRESS                = "close_load_progress";
  public static inline var UPDATE_TOOL_SIZES                  = "update_tool_sizes";
  public static inline var POSSITION_TOOLS                    = "possition_tools";
  public static inline var PRINT_TYPES_LOADED                 = "print_types_loaded";
  
  public static inline var SWF_LOADED                         = "swf_loaded";
  
  public static inline var UPDATE_STAGE_POSITION              = "update_stage_position";
  public static inline var UPDATE_PAGE_POSITION               = "update_page_position";
  
	
}