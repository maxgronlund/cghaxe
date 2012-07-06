import flash.Vector;
import flash.text.TextFormat;

class PageModel extends Model, implements IModel
{
  private var pageId:Int;
  private var pageOrder:Int;
  private var mask_url:String;
  private var hide_mask_url:String;
  private var page_name:String;
  private var fileStr:String;
  private var front_of_paper:Bool;

  public function new(){	
    super();
    fileStr   = '';
    mask_url  = '';
    hide_mask_url = '';
    
  }
  
  override public function setParam(param:IParameter):Void{
    //trace('setParam');
    switch ( param.getLabel() ){
      case EVENT_ID.PLACEHOLDER_SELECTED:{
      	dispatchParameter(param);
      	GLOBAL.text_controller.setParam(param);
      }
      case EVENT_ID.FONT_LOADED:{
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
      case EVENT_ID.UPDATE_TEXT_TOOLS:{
        GLOBAL.text_view.setParam(param);
      }
      
    }
	}

  override public function setInt(id:String, i:Int):Void{
    
    switch (id) {
      case 'pageOrder':   pageOrder   = i;
      case 'pageId':      pageId      = i;
      
    }
  }
  
  override public function getInt(id:String):Int{
    
    switch ( id ){
      case 'pageId': return pageId;
      case 'pageOrder':return pageOrder;
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
      case 'mask_url':                mask_url  = s; 
      case 'hide_mask_url':           hide_mask_url = s;
      case 'page_name':               page_name = s; 
      case 'no_move':{ trace('no move'); 	}
      case EVENT_ID.SET_PAGE_XML:fileStr += s;
      
    }
  }
  
  override function getString(id:String):String{
    
    switch(id) {
      case 'mask_url':          return mask_url; 
      case 'hide_mask_url':     return hide_mask_url; 
      case 'page_name':         return page_name; 
      default:                  return '';
    }
  }
  
  override public function getXml(cmd:String):String{
    fileStr = '\t<page id="'+Std.string(pageId)+'">\n';
      // placeholders returns to setString and add data to fileStr
      var param:IParameter = new Parameter(EVENT_ID.GET_PAGE_XML + Std.string(pageId));
      dispatchParameter(param);
  
    fileStr += '\t</page>\n';
    return fileStr;
    
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

