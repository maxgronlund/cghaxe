import flash.display.MovieClip;

class PriceColumn extends MovieClip {
  
  private var prices:Array<PriceModel>;
	private var price_labels:Array<OnePrice>;
	private var total_label:FormatedText;
	private var title_label:FormatedText;
	private var title:String;
	
	private var amount_std_pms_color:UInt;
  private var amount_custom_pms1_color:UInt;
  private var amount_custom_pms2_color:UInt;
  private var amount_foil_color:UInt;
  private var amount_greetings:UInt;
  private var amount_laser_color:UInt;
  private var amount_cliche:UInt;

  private var column_total_price:Float;
	
	public function new(title:String){		
	  super();
	  
	  this.title = title;
	  prices = new Array();
  	price_labels = new Array();
  	//price_labels.push(new OnePrice('foil'));
  	//price_labels.push(new OnePrice('one-pms-color'));
  	//price_labels.push(new OnePrice('std-color'));
  	title_label = new FormatedText('helvetica', 'Item', 12, false);
  	total_label = new FormatedText('helvetica', 'total', 12, false);
	}
	
	public function setPrices(price_array:Array<PriceModel>):Void {
	  prices = price_array;
	}
	
	public function addAllPrices():Void {
	  for(i in 0...price_labels.length) {
	    removeChild(price_labels[i]);
    }
	  price_labels = new Array();
	  
	  if(amount_std_pms_color > 0) {
	    price_labels.push(new OnePrice('std-color'));
	  }
	  if(amount_custom_pms1_color > 0) {
	    price_labels.push(new OnePrice('one-pms-color'));
	  }
	  if(amount_custom_pms2_color > 0) {
	    price_labels.push(new OnePrice('one-pms-color'));
	  }
	  if(amount_cliche > 0) {
	    for(i in 0...amount_cliche) {
	      price_labels.push(new OnePrice('cliche'));
	    }
	  }
	  if(amount_foil_color > 0) {
	    for(i in 0...amount_foil_color) {
	      price_labels.push(new OnePrice('foil'));
	    }
	    
	  }
	  if(amount_greetings > 0) {
	    for(i in 0...amount_greetings) {
  	    price_labels.push(new OnePrice('greeting'));
	    }
	  }
	  if(amount_laser_color > 0) {
	    price_labels.push(new OnePrice('laser'));
	  }
    
    var total_price:Float = 0;

    for(i in 0...price_labels.length) {
      
      var price:OnePrice = price_labels[i];
      addChild(price);
      price.x = 0;
    	price.y = 18*i;
    	switch ( price.getPrintType() )
    	{
    	 case 'cliche':
    	   price.setUnitsLabel("1");
    	 default:
         price.setUnitsLabel(Std.string(GLOBAL.preset_quantity));
    	}
    	
    	price.setItemLabel(price.getPrettyPrintType());
    	
    	var units:Int = Std.parseInt(GLOBAL.preset_quantity);
    	var print_price:Float = getPrintPrice(units, price.getPrintType());
    	total_price += print_price;
    	price.setPriceLabel(Std.string(print_price));
    }
    
    column_total_price = total_price;
    
    if(price_labels.length == 0)
      return;
      
    addChild(title_label);
    addChild(total_label);
    
    title_label.x = 0;
    title_label.y = -18;
    title_label.setLabel(title);
    
    total_label.x = 140;
    total_label.y = 18*price_labels.length;
    total_label.setLabel(Std.string(total_price));
    
  }
  
  public function getColumnTotalPrice():Float{
    return column_total_price;
  }
  
  //public function getPriceLabels():Array{
  //  return price_labels;
  //}
  
  public function removeAllPrices():Void {
    for(i in 0...price_labels.length) {
      removeChild(price_labels[i]);
    }
  }
  
  public function set_amount_std_pms_color(amount:UInt):Void {
    amount_std_pms_color = amount;
  }  
  public function set_amount_custom_pms1_color(amount:UInt):Void {
    amount_custom_pms1_color = amount;
  }
  public function set_amount_custom_pms2_color(amount:UInt):Void {
    amount_custom_pms2_color = amount;
  }
  public function set_amount_foil_color(amount:UInt):Void {
    amount_foil_color = amount;
  }
  public function set_amount_greetings(amount:UInt):Void {
    amount_greetings = amount;
  }
  public function set_amount_laser_color(amount:UInt):Void {
    amount_laser_color = amount;
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
	     trace("Error selecting print_type!!!", print_type);
	     return 0.0;
	  }
	  
	  // Function should never reach this point
	  return 0.0;
	}

}