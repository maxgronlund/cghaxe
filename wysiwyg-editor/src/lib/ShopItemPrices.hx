class ShopItemPrices
{
	private var shop_item_prices:Array<ShopItemPrice>;
	
	public function new()
	{
	  shop_item_prices = new Array();
	}
	
	public function push(shop_item_price:ShopItemPrice):Void{
	  shop_item_prices.push(shop_item_price);
	}
	
	public function getPrice(amount:UInt):Float{
	  var selected_shop_item_price:ShopItemPrice=null;
	  
	  for(i in 0...shop_item_prices.length){
	    var shop_item_price = shop_item_prices[i];
	    
	    if(shop_item_price.getMaxUnits() > amount){
	      if(shop_item_price.getMinUnits() <= amount){
	        selected_shop_item_price = shop_item_price;
	      }
      }
	  }
	  
	  if(selected_shop_item_price == null){
	    for(i in 0...shop_item_prices.length){
  	    var shop_item_price = shop_item_prices[i];
	    
  	    if(selected_shop_item_price == null){
    	    selected_shop_item_price = shop_item_price;
        } else {
          if(shop_item_price.getMaxUnits() > selected_shop_item_price.getMaxUnits()){
            selected_shop_item_price = shop_item_price;
          }
        }
  	  }
	  }
	  if(selected_shop_item_price != null){
	    return selected_shop_item_price.getPrice();
	  } else {
	    return 0.0;
	  }
	  
	}
	
	public function onParsePrice(e:IKEvent):Void{
    var xml:Xml = Xml.parse(StringTools.htmlUnescape(e.getXml().toString()));
    parsePrices(xml);
  }
  
  public function parsePrices(xml:Xml):Void{
    for( prices in xml.elementsNamed("prices") ) {
      for( price in prices.elementsNamed("price") ) {
        
        var _min_units:UInt;
        var _max_units:UInt;
        var _unit_price:Float;
        
        for( min_units in price.elementsNamed("min-units") ) {
          _min_units = Std.parseInt(min_units.firstChild().nodeValue.toString());
        }
        
        for( max_units in price.elementsNamed("max-units") ) {
          _max_units = Std.parseInt(max_units.firstChild().nodeValue.toString());
        }
        
        for( unit_price in price.elementsNamed("price") ) {
          _unit_price = Std.parseFloat(unit_price.firstChild().nodeValue.toString());
        }
        
        shop_item_prices.push(new ShopItemPrice(_min_units, _max_units, _unit_price));
      }
    }
    
    var min_quantity:UInt;
    if(shop_item_prices.length > 0){
      min_quantity = shop_item_prices[0].getMinUnits();
    } else {
      min_quantity = 1;
    }
      
    for(i in 0...shop_item_prices.length){
      var new_min:UInt = shop_item_prices[i].getMinUnits();
      if(new_min < min_quantity){
        min_quantity = new_min;
      }
       
      
    }
    if(min_quantity > 0){
      GLOBAL.min_quantity = min_quantity;
    }
  }
}