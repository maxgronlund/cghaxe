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
    //trace(param.getLabel());
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

  private function onPassGreeting(e:IKEvent):Void{
    var xml:Xml = Xml.parse(StringTools.htmlUnescape(e.getXml().toString()));
  }

}