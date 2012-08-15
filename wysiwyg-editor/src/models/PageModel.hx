import flash.Vector;
import flash.text.TextFormat;

class PageModel extends Model, implements IModel
{
  private var pageId:Int;
  private var pageOrder:Int;
  private var print_mask_url:String;
  private var hide_mask_url:String;
  private var front_shoot_url:String;
  private var page_name:String;
  private var fileStr:String;
  private var front_of_paper:Bool;
  private var print_types:Xml;
  private var designs:Xml;
  
  private var amount_std_pms_color:UInt;
  private var amount_custom_pms1_color:UInt;
  private var amount_custom_pms2_color:UInt;
  private var amount_foil_color:UInt;
  private var amount_greetings:UInt;
  private var amount_laser_color:UInt;
    
  public function new(){	
    super();
    fileStr   = '';
    print_mask_url  = '';
    hide_mask_url = '';
  
    
  }
  
  override public function setParam(param:IParameter):Void{
    //trace('setParam');
    switch ( param.getLabel() ){
      case EVENT_ID.PLACEHOLDER_SELECTED:{
      	dispatchParameter(param);
      	GLOBAL.text_controller.setParam(param);
      }
      case EVENT_ID.SWF_LOADED:{
        Pages.dispatchParameter(param);
      }
      case EVENT_ID.ADD_PLACEHOLDER:{
        GLOBAL.Font.leading = 0;
        param.setModel(this);
      	param.setInt(pageId);
      	dispatchParameter(param);
      }
      case EVENT_ID.TRASH_PLACEHOLDER:{
       dispatchParameter(param); 
      }
      //case EVENT_ID.UPDATE_TEXT_TOOLS:{
      //  GLOBAL.text_view.setParam(param);
      //}
      case EVENT_ID.BUILD_PAGE_DESIGNS:{
        trace(designs.toString(),'------------------------------>>>>>>>>>>>>>>>>');
        param.setXml(designs);
        Pages.dispatchParameter(param);
      }
      
      case EVENT_ID.ADD_PRICE_COLUMN:{
        GLOBAL.price_view.setParam(param);
      }
      
      //case EVENT_ID.UPDATE_SIDE_VIEWS:{
      //
      //}
    }
	}

  override public function setInt(id:String, i:Int):Void{
    switch (id) {
      case 'pageOrder':   pageOrder   = i;
      case 'pageId':      pageId      = i;
      case 'amount_std_pms_color':{amount_std_pms_color = i;}
      case 'amount_custom_pms1_color':{amount_custom_pms1_color = i;}
      case 'amount_custom_pms2_color':{amount_custom_pms2_color = i;}
      case 'amount_foil_color':{amount_foil_color = i;}
      case 'amount_greetings':{amount_greetings = i;}
      case 'amount_laser_color':{amount_laser_color = i;}
    }
  }
  
  override public function getInt(id:String):Int{
    switch ( id ){
      case 'pageId': return pageId;
      case 'pageOrder':return pageOrder;
      case 'amount_std_pms_color':{return amount_std_pms_color;}
      case 'amount_custom_pms1_color':{return amount_custom_pms1_color;}
      case 'amount_custom_pms2_color':{return amount_custom_pms2_color;}
      case 'amount_foil_color':{return amount_foil_color;}
      case 'amount_greetings':{return amount_greetings;}
      case 'amount_laser_color':{return amount_laser_color;}
    }
    return -1;
  }
  
  override public function setBool(id:String, b:Bool):Void{
    switch (id) {
      case 'front_of_paper':   front_of_paper   = b;
    }
  }
  
  override public function getBool(id:String):Bool{
    switch ( id ){
      case 'front_of_paper': return front_of_paper;
    }
    return false;
  }
  
  override function setString(id:String, s:String):Void{

    switch(id) {
      case 'print_mask_url':          print_mask_url  = s; 
      case 'hide_mask_url':           hide_mask_url   = s;
      case 'front_shoot_url':         front_shoot_url = s;
      case 'no_move':{ trace('no move'); 	}
      case 'page_name':               page_name       = s;
      case EVENT_ID.SET_PAGE_XML:     fileStr         += s;


    }
  }
  
  override function getString(id:String):String{

    switch(id) {
      case 'print_mask_url':    return print_mask_url; 
      case 'hide_mask_url':     return hide_mask_url; 
      case 'front_shoot_url':   return front_shoot_url; 
      case 'page_name':         return page_name;
      default:                  return '';
    }
  }
  
 

  
  override public function setXml(id:String, xml:Xml):Void{
    
    //front_of_paper = false;
//    trace(xml.toString());
    
    for(front in xml.elementsNamed('front')){  front_of_paper = front.firstChild().nodeValue == 'true';}

    for(hide_mask in xml.elementsNamed('hide-mask')){
      hide_mask_url = hide_mask.firstChild().nodeValue;
    }
    

    for(print_mask in xml.elementsNamed('print-mask')){
      print_mask_url = print_mask.firstChild().nodeValue;
    }
    
    for(front_shot in xml.elementsNamed('front-shot')){
      front_shoot_url = front_shot.firstChild().nodeValue;
    }
    
    for(printTypes in xml.elementsNamed('print-types')){
      print_types = printTypes;
    }
    
    for(_designs in xml.elementsNamed('designs')){
      designs = _designs;
      
      //trace(designs.toString);
      //trace('===============================>>>>>>>>>>>', pageId);
      ////for(design in designs.elementsNamed('design')){
      //  trace('-----------------------------');
      //}
    }
  }

  override public function getXml(cmd:String):String{
    
    switch ( cmd ){
      case CONST.XML_FILE:{
        fileStr = '\t<page id="'+Std.string(pageId)+'">\n';

        var param:IParameter = new Parameter(EVENT_ID.GET_PAGE_POS_XML + Std.string(pageId));
        dispatchParameter(param);

        var param:IParameter = new Parameter(EVENT_ID.GET_PAGE_XML + Std.string(pageId));
        dispatchParameter(param);

        fileStr += '\t</page>\n';
        return fileStr;
      }
      case CONST.PRINT_TYPES:{
        return print_types.toString();
      }
    }

    
    return null;
    
    
  }
  
  public function onFontSelected(param:IParameter):Void {
    //trace('onFontSelected');
    dispatchParameter(param);
  }
  
  public function releaseFocus():Void{
    var param:IParameter = new Parameter(EVENT_ID.RELEASE_FOCUS );
    dispatchParameter(param);
  }
  
  
}

