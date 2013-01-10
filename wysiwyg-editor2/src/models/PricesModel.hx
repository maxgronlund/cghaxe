package;
import flash.events.Event;

class PricesModel extends Model, implements IModel
{

	public function new(){	
		super();	
	}
	
	override public function init():Void{	
		super.init();
		Application.addEventListener(EVENT_ID.PRESET_PRICES, onParsePrice);
	}
	
	private function onParsePrice(e:XmlEvent):Void {
	  Application.dispatchXML(EVENT_ID.PRESET_PRICES_XML_PARSED, e.getXml());
	}	
	
}


