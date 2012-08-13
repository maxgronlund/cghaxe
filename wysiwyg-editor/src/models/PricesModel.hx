package;
import flash.events.Event;

class PricesModel extends Model, implements IModel
{
  //private var prices:Array<PriceModel>;

	public function new(){	
		super();	
		//prices = new Array();
	}
	
	override public function init():Void{	
		super.init();
		Application.addEventListener(EVENT_ID.PRESET_PRICES, onParsePrice);
	}
	
	private function onParsePrice(e:XmlEvent):Void {
	  //parsePrice(e.getXml());
	  Application.dispatchXML(EVENT_ID.PRESET_PRICES_XML_PARSED, e.getXml());
	  
	  
	  //trace("Getting a foil price for fun..");
	  //trace("0 foils");
	  //trace(getPrintPrice(0, "foil"));
	  //trace("3 foils");
	  //trace(getPrintPrice(3, "foil"));
	  //trace("49 foils");
	  //trace(getPrintPrice(49, "foil"));
	  //trace("50 foils");
	  //trace(getPrintPrice(50, "foil"));
	  //trace("51 foils");
	  //trace(getPrintPrice(51, "foil"));
	  //trace("100 foils");
	  //trace(getPrintPrice(100, "foil"));
	  //trace("200 foils");
	  //trace(getPrintPrice(200, "foil"));
	  //trace("5439 foils");
	  //trace(getPrintPrice(5439, "foil"));
	}
	
	
	
	
}


