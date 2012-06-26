// mostly defines. 
// HaXe don't support const's
// so my convention is to type values that never should changes
// in upper case

class GLOBAL  {
  
  // models
  public static var Application:IModel;
//  public static var Layout:IModel;
  public static var Menu:IModel;
  public static var Configuration:IModel;
  public static var Preset:IModel;
  public static var Pages:IModel;
  public static var Designs:IModel;
  public static var Font:FontModel;
  
  // system
  public static var wysiwyg_status:String;
  public static var authenticity_token:String;
  public static var wysiwyg_session:String;
  public static var preset_file_url;
  public static var save_path:String;
  public static var edit_mode:String;
  public static var admin_mode:Bool;
  
  // zoom
  public static var Zoom:ZoomTools;
  public static var MOVE_TOOL:Bool;
  
  // views
  public static var text_view:AView;
  public static var text_suggestion_view:AView;
  public static var designs_view:AView;
  public static var foil_view:IView;
  public static var side_view:IView;
  public static var add_ons_view:IView;
  public static var garamond_view:IView;
  public static var logo_view:IView;
  public static var price_view:IView;
  public static var menu_view:IView;
  public static var page_selector_view:IView;
  public static var desktop_view:IView;
  
  // controllers
  public static var text_controller:IController;
  public static var text_suggestion_controller:IController;
  public static var designs_controller:IController;
  public static var sidebar_controller:IController;
  public static var desktop_controller:IController;
  public static var sibling_controller:IController;
  
  // zoom and pos
  public static var pos_x:Float;
  public static var pos_y:Float;
  public static var size_x:Float;
  public static var size_y:Float;
  
  // user
  public static var user_id:String;
  

}