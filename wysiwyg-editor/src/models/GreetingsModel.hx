

import flash.events.Event;
import flash.Vector;

class GreetingsModel extends Model, implements IModel {
  
  private var greetingsXml:Xml;

  public function new(){	
    super();
  }
    
 override public function init():Void{	
   super.init();
 }
 
  override public function setParam(param:IParameter):Void{

    switch ( param.getLabel() ){
      case EVENT_ID.GREETING_SELECTED:{
        greetingsXml = param.getXml();
        //trace(greetingsXml.toString());
      }
      case EVENT_ID.ADD_GREETING_TO_PAGE:{
        if(greetingsXml != null){
          dispatchXML(EVENT_ID.ADD_GREETING_TO_PAGE, greetingsXml);
        }
      }
    }
  }
  
  override public function setString(id:String, s:String):Void{
    
     //switch ( id ){
     //  case 'countrxy':             { countrxy = s;}
     //}
  }
  
  override public function getString(id:String):String{
     //switch ( id ){
     //  case 'countrxy':            {return countrxy;}
     //  
     //}
     return '';
  }
  
  // to do 
  private function onPassGreeting(e:IKEvent):Void{
    
    //trace('onPassDesign');
    var xml:Xml = Xml.parse(StringTools.htmlUnescape(e.getXml().toString()));

    
  }
  
  override public function getBool(id:String):Bool{
    //switch ( id ){
    //  case 'front_of_paper': true;
    //}
    return false;
  }
}