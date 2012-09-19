

import flash.events.Event;
import flash.Vector;

class LogosModel extends Model, implements IModel {
  
  private var logosXml:Xml;

  public function new(){	

    super();
  }
    
 override public function init():Void{	
   super.init();
 }
 
  override public function setParam(param:IParameter):Void{

    switch ( param.getLabel() ){
      case EVENT_ID.LOGO_SELECTED:{
        logosXml = param.getXml();
      }
      case EVENT_ID.ADD_LOGO_TO_PAGE:{
        if(logosXml != null){
          dispatchXML(EVENT_ID.ADD_LOGO_TO_PAGE, logosXml);
        }
      }
    }
  }
  
  override public function setString(id:String, s:String):Void{

  }
  
  override public function getString(id:String):String{
     return '';
  }
  
  private function onPassGreeting(e:IKEvent):Void{
    var xml:Xml = Xml.parse(StringTools.htmlUnescape(e.getXml().toString()));
  }
  
  override public function getBool(id:String):Bool{

    return false;
  }
}