// mostly defines. 
// HaXe don't support const's
// so my convention is to type values that never should changes
// in upper case

class GLOBAL  {
  
	
	
	public static var IS_DEBUG :Bool = true;
  
  // models
  public static var product_name:String;
  public static var shop_item_name:String;


  public static var Application:IModel;
  public static var Menu:IModel;
  public static var Preset:IModel;
  public static var Prices:IModel;
  public static var cliche_price:Float;
  public static var Pages:IModel;
  public static var Designs:IModel;
  public static var Greetings:IModel;
  public static var Symbols:IModel;
  public static var Logos:IModel;
  public static var Font:FontModel;
  public static var userParser:UserParser;
  public static var preset_quantity:String;
  //public static var preset_quantity_text_field:Dynamic;
  public static var min_quantity:UInt=1;
  public static var iAlreadyHaveACliche:Hash<Bool>;
  
  public static var shop_item_prices:ShopItemPrices;
  // system
  public static var wysiwyg_status:String;
  public static var authenticity_token:String;
  public static var wysiwyg_session:String;
  public static var preset_file_url;
  public static var design_file_url;
  public static var price_file_url;
  public static var save_path:String;
  public static var buy_path:String;
  public static var edit_mode:String;
  public static var admin_mode:Bool;
  public static var hitTest:CGHitTest;
  public static var language_id:String;
  public static var copy_preset:String;
  
  // zoom
  public static var Zoom:ZoomTools;
  public static var MOVE_TOOL:Bool;
  public static var TEXT_TOOL:Bool;
  
  public static var foilEffect:Float;
  
  // views
  public static var text_view:AView;
  public static var color_view:AView;
  public static var text_suggestion_view:AView;
  public static var designs_view:AView;
  public static var greetings_view:AView;
  public static var symbols_view:AView;
  public static var logos_view:AView;
  public static var foil_view:AView;
  public static var side_view:IView;
  public static var add_ons_view:AView;
  public static var logo_view:AView;
  public static var price_view:AView;
  public static var menu_view:IView;
  public static var page_selector_view:IView;
  public static var desktop_view:IView;
  public static var grid_view:IView;
  public static var selection_view:IView;
//  public static var blind_view:AView;
  public static var foil:Foil;
  public static var preset_id:String;
  public static var preset_shop_item_id:String;
  
  
//  public static var params:Dynamic;

  public static var printType:String;
  public static var stdPmsColor:UInt;
  public static var pms1Color:UInt;
  public static var pms2Color:UInt;
  public static var pms1ColorString:String;
  public static var pms2ColorString:String;
  public static var foilColor:String;
  public static var laserColor:UInt;
  public static var garamond:Bool;
  
  // controllers
  public static var text_controller:IController;
  public static var color_controller:IController;
  public static var text_suggestion_controller:IController;
  public static var designs_controller:IController;
//  public static var vectors_controller:IController;
  public static var greetings_controller:IController;
  public static var symbols_controller:IController;
  public static var logos_controller:IController;
//  public static var design_images_controller:IController;
  public static var sidebar_controller:IController;
  public static var desktop_controller:IController;
  public static var sibling_controller:IController;
  public static var menu_controller:IController;
  public static var tool_tips_controller:IController;
//  public static var selection_controller:IController;
  
  // zoom and pos
  public static var pos_x:Float;
  public static var pos_y:Float;
  public static var size_x:Float;
  public static var size_y:Float;
  
  // user
  public static var user_id:String;
  public static var shop_item_id:Int;
  public static var user_uuid:String;

  
  public static var tmp:Xml;
  
  public static var text:String;
  public static var id:String;
  public static var index:Int;
  public static var name:String; 
  public static var front:String; 
  public static var back:String;
  public static var envelope:String; 
  public static var insert:String; 
  public static var text_button:String; 
  public static var designs_button:String; 
  public static var text_color:String; 
  public static var foil_color:String; 
  public static var greetings_button:String; 
  public static var add_ons_button:String; 
  public static var save_button:String; 
  public static var buy_button:String;
  public static var standard_pms:String;  
  public static var custom_pms_1:String;
  public static var custom_pms_2:String;
  public static var foil_color_picker:String;
  public static var digital_print_picker:String;
  public static var color_button:String;
  public static var print_button:String;
  public static var symbols_button:String;
  public static var price_button:String;
  public static var my_uploads_button:String;
  public static var line_space:String;
  public static var font_size:String; 
  public static var font_align:String;
  public static var select_font:String;
  public static var add_text_field:String;             
  public static var upload_logo:String;
  public static var upload_image:String;
  public static var add_logo:String;
  public static var add_image:String;
  public static var placeholders:Int;
}