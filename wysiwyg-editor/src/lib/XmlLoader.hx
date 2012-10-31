
import flash.events.EventDispatcher;
import flash.events.Event;

import flash.events.Event;
import flash.net.URLLoader;
import flash.net.URLRequest;




class XmlLoader implements ILoader, extends ALoader
{	
  //public static inline var ON_XML_LOADED:String = "on_xml_loaded";
  private var eventId:String;
  public function new(){	
  	super();
  }
  
  override public function load(url:String, eventId:String):Void{	
    
    //trace(GLOBAL.shop_item_id);
    
    this.eventId = eventId;
    var loader:URLLoader = new URLLoader();
    loader.addEventListener(Event.COMPLETE, onLoaded);
    var request:URLRequest = new URLRequest(url+"&shop_item_id="+GLOBAL.shop_item_id);
    loader.load(request);
  }
  
  override public function onLoaded(e:Event):Void{
  	var param:IParameter = new Parameter(eventId);
  	param.setXml(Xml.parse(e.target.data));
  	var event:XmlEvent = new XmlEvent( eventId, param);
  	dispatchEvent(event);
  
  }
  
  override public function onError(e:Event):Void{
  
  }
}

