package;
import flash.events.Event;

class PricesModel extends Model, implements IModel
{
  private var prices:Array<PriceModel>;

	public function new(){	
		super();	
		prices = new Array();
	}
	
	override public function init():Void{	
		super.init();
		Application.addEventListener(EVENT_ID.PRESET_PRICES, onParsePrice);
	}
	
	private function onParsePrice(e:XmlEvent):Void {
	  parsePrice(e.getXml());
	  trace("Getting a foil price for fun..");
	  trace("0 foils");
	  trace(getPrice(0, "foil"));
	  trace("3 foils");
	  trace(getPrice(3, "foil"));
	  trace("49 foils");
	  trace(getPrice(49, "foil"));
	  trace("50 foils");
	  trace(getPrice(50, "foil"));
	  trace("51 foils");
	  trace(getPrice(51, "foil"));
	  trace("100 foils");
	  trace(getPrice(100, "foil"));
	  trace("200 foils");
	  trace(getPrice(200, "foil"));
	  trace("5439 foils");
	  trace(getPrice(5439, "foil"));
	}
	
	private function getPrice(units:UInt, print_type:String):Float {
	  if(units <= 0) {
	    return 0.0;
	  }
	  
	  var selected_price:PriceModel = null;
	  
	  for( i in 0...prices.length ) {
      var price:PriceModel = prices[i];
      
      if(units >= price.getUnits()) {
        
        if(selected_price != null) {
          if(selected_price.getUnits() < price.getUnits()){
            selected_price = price;
          }
          
        } else {
          selected_price = price;
        }
      }
    }
    
    if(selected_price == null) {
      //trace("Selecting lowest units");
      for( i in 0...prices.length ) {
        var price:PriceModel = prices[i];
        if(selected_price != null) {
          if(price.getUnits() < selected_price.getUnits()){
            selected_price = price;
          }
        } else {
          selected_price = price;
        }
      }
    }
      //trace("Error selecting PriceModel!");
	  
	  switch ( print_type )
	  {
	   case "foil":
	     return selected_price.getFoilPrice();
	   case "one-pms-color":
	     return selected_price.getOnePmsColorPrice();
	   case "std-color":
	     return selected_price.getStdColorPrice();
	   default:
	     trace("Error selecting print_type!");
	     return 0.0;
	  }
	  
	  // Function should never reach this point
	  return 0.0;
	}
	
	private function parsePrice(prices_xml:Xml):Void{
		
		for( print_price_xml in prices_xml.elementsNamed("print-price") ) {
		  
		  var units:UInt;
		  var foil_price:Float;
		  var one_pms_color_price:Float;
		  var std_color_price:Float;
		  
		  for( units_xml in print_price_xml.elementsNamed("units")) {
			  units = Std.parseInt(units_xml.firstChild().nodeValue.toString());
			}
			for( foil_price_xml in print_price_xml.elementsNamed("foil")) {
			  foil_price = Std.parseFloat(foil_price_xml.firstChild().nodeValue.toString());
			}
			for( one_pms_color_price_xml in print_price_xml.elementsNamed("one-pms-color")) {
			  one_pms_color_price = Std.parseFloat(one_pms_color_price_xml.firstChild().nodeValue.toString());
			}
			for( std_color_price_xml in print_price_xml.elementsNamed("std-color")) {
			  std_color_price = Std.parseFloat(std_color_price_xml.firstChild().nodeValue.toString());
			}
			
			prices.push(new PriceModel(units, foil_price, one_pms_color_price, std_color_price));
			
		}
	}
	
	
}


