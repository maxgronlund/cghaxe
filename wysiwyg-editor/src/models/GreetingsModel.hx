import flash.events.Event;
import flash.Vector;

class GreetingsModel extends Model, implements IModel {
  
  private var greetingsXml:Xml;
  private var freeGreetings:Vector<String>;

  public function new(){	
    super();
    freeGreetings = new Vector<String>();
  }
    
 override public function init():Void{	
   super.init();
   Preset.addEventListener(EVENT_ID.GREETINGS_LOADED, onXmlLoaded);
   
 }
 
 private function onXmlLoaded(e:KEvent):Void{

   for(greeting in e.getXml().elementsNamed('greeting')){
     
     var freeGreeting:Bool = false;
     var greetingUrl:String = '';
     
     for(free in greeting.elementsNamed('free')){
       if(free.firstChild().nodeValue == 'true')
        freeGreeting = true;
     }
     if(freeGreeting){
       for(url in greeting.elementsNamed('url')){
          //trace(url.firstChild().nodeValue);
          freeGreetings.push(url.firstChild().nodeValue);
        }
     }
   }
 }
 
  override public function setParam(param:IParameter):Void{
    //trace(param.getLabel());
	//greetingsXml = param.getXml();
    switch ( param.getLabel() ){
      case EVENT_ID.GREETING_SELECTED:{
        greetingsXml = param.getXml();
        trace(greetingsXml.toString());
      }
      case EVENT_ID.ADD_GREETING_TO_PAGE:{
        if(greetingsXml != null){
          dispatchXML(EVENT_ID.ADD_GREETING_TO_PAGE, greetingsXml);
        }
      }
	  
	  case EVENT_ID.GREETING_PREVIEW:
		{
			dispatchXML(EVENT_ID.GREETING_PREVIEW, param.getXml());
		}
		
	case EVENT_ID.GREETING_FINISH_PREVIEW:
		{
			dispatchXML(EVENT_ID.GREETING_FINISH_PREVIEW, param.getXml());
		}
    }
  }

  private function onPassGreeting(e:IKEvent):Void{
    var xml:Xml = Xml.parse(StringTools.htmlUnescape(e.getXml().toString()));
  }
  
  
  
  override public function validateString(id:String, s:String):Bool{
    var b:Bool = false;
    switch ( id ){
      case EVENT_ID.IS_GREEDING_FREE:{
        b = isGreetingFree(s);
      }
    }

    return b;
  }
  
  private function isGreetingFree(url:String):Bool{
    var isFree:Bool = false;
    for( i in 0...freeGreetings.length){
	  	if(freeGreetings[i] == url)
	  	  isFree=true;
	  }
    return isFree;
  }
}