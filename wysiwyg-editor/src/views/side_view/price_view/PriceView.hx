import flash.geom.Point;
import flash.events.Event;

class PriceView extends PropertyView, implements IView{
	
	private var total_price_label:FormatedText;
	
	private var prices:Array<PriceModel>;
	private var price_labels:Array<OnePrice>;
	
	public function new(priceController:IController){	
		super(priceController);
		backdrop				= new PriceViewBack();
    
  	total_price_label = new FormatedText('helvetica', 'text', 12, false);
  	
  	prices = new Array();
  	price_labels = new Array();
  	price_labels.push(new OnePrice('foil'));
  	price_labels.push(new OnePrice('one-pms-color'));
  	price_labels.push(new OnePrice('std-color'));
  	
  	Application.addEventListener(EVENT_ID.PRESET_PRICES_XML_PARSED, onParsePrice);
	}
	
	override public function onAddedToStage(e:Event):Void{
    super.onAddedToStage(e);
  	
  	addChild(total_price_label);
  	total_price_label.setLabel('total price');
    total_price_label.x = 55;
    total_price_label.y = 360;
    
  }
  
  private function addAllPrices():Void {
    
    var total_price:Float = 0;

    for(i in 0...price_labels.length) {
      var price:OnePrice = price_labels[i];
      addChild(price);
      price.x = 0;
    	price.y = 120+18*i;
    	price.setUnitsLabel(GLOBAL.preset_quantity);
    	
    	price.setItemLabel(price.getPrettyPrintType());
    	
    	var units:Int = Std.parseInt(GLOBAL.preset_quantity);
    	var print_price:Float = getPrintPrice(units, price.getPrintType());
    	total_price += print_price;
    	price.setPriceLabel(Std.string(print_price));
    }
    
    total_price_label.setLabel(Std.string(total_price));
  }
  
  private function removeAllPrices():Void {
    for(i in 0...price_labels.length) {
      removeChild(price_labels[i]);
    }
  }
	
	override public function init():Void{
		selectButton.init( controller,
						new Point(190,30), 
						new PriceViewButton(), 
						new Parameter( EVENT_ID.SHOW_PRICES));
		
		
	}
	
	private function onParsePrice(e:XmlEvent):Void{
	  parsePrice(e.getXml());
	  addAllPrices();
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
	
	private function getPrintPrice(units:UInt, print_type:String):Float {
	  if(units <= 0) {
	    return 0.0;
	  }
	  if(prices.length == 0) {
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
      for( i in 0...prices.length ) {
        
        var price:PriceModel = prices[i];
        if(selected_price == null) {
          selected_price = price;
          
        } else {
          
          if(price.getUnits() < selected_price.getUnits()){
            selected_price = price;
          }
          
        }
        
      }
    }
	  
	  switch ( print_type )
	  {
	   case "foil":
	     return selected_price.getFoilPrice();
	   case "one-pms-color":
	     return selected_price.getOnePmsColorPrice();
	   case "std-color":
	     return selected_price.getStdColorPrice();
	   default:
	     trace("Error selecting print_type!!!");
	     return 0.0;
	  }
	  
	  // Function should never reach this point
	  return 0.0;
	}

}