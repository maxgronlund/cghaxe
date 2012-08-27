// mostly defines. 
// HaXe don't support const's
// so my convention is to type values that never should changes
// in upper case

class GLOBAL  {
  
  // models
  public static var product_name:String;
  public static var Application:IModel;
//  public static var Layout:IModel;
  public static var Menu:IModel;
//  public static var Configuration:IModel;
  public static var Preset:IModel;
  public static var Prices:IModel;
  public static var cliche_price:Float;
  public static var Pages:IModel;
  public static var Designs:IModel;
//  public static var DesignImages:IModel;
//  public static var Vectors:IModel;
  public static var Greetings:IModel;
  public static var Font:FontModel;
  public static var userParser:UserParser;
  
  public static var preset_quantity:String;
  // system
  public static var wysiwyg_status:String;
  public static var authenticity_token:String;
  public static var wysiwyg_session:String;
  public static var preset_file_url;
  public static var design_file_url;
  public static var price_file_url;
  public static var save_path:String;
  public static var edit_mode:String;
  public static var admin_mode:Bool;
  public static var hitTest:CGHitTest;
  public static var language_name:String;
  
  // zoom
  public static var Zoom:ZoomTools;
  public static var MOVE_TOOL:Bool;
  public static var TEXT_TOOL:Bool;
  
  // views
  public static var text_view:AView;
  public static var color_view:AView;
  public static var text_suggestion_view:AView;
  public static var designs_view:AView;
//  public static var vectors_view:AView;
  public static var greetings_view:AView;
//  public static var design_images_view:AView;
  public static var foil_view:AView;
  public static var side_view:IView;
  public static var add_ons_view:AView;
  public static var garamond_view:AView;
  public static var logo_view:AView;
  public static var price_view:AView;
  public static var menu_view:IView;
  public static var page_selector_view:IView;
  public static var desktop_view:IView;
  public static var grid_view:IView;
  public static var selection_view:IView;
  public static var greetingsView:IView;
  public static var blind_view:AView;
  public static var foil:Foil;
 
  
  public static var printType:String;
  public static var stdPmsColor:UInt;
  public static var pms1Color:UInt;
  public static var pms2Color:UInt;
  public static var foilColor:String;
  public static var laserColor:UInt;
  
  // controllers
  public static var text_controller:IController;
  public static var color_controller:IController;
  public static var text_suggestion_controller:IController;
  public static var designs_controller:IController;
//  public static var vectors_controller:IController;
  public static var greetings_controller:IController;
//  public static var design_images_controller:IController;
  public static var sidebar_controller:IController;
  public static var desktop_controller:IController;
  public static var sibling_controller:IController;
  public static var menu_controller:IController;
  public static var selection_controller:IController;
  
  // zoom and pos
  public static var pos_x:Float;
  public static var pos_y:Float;
  public static var size_x:Float;
  public static var size_y:Float;
  
  // user
  public static var user_id:String;
  public static var shop_item_id:String;
  
  
  
  
  
  public static var tmp:Xml;
}