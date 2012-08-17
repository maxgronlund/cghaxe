import flash.display.MovieClip;

class OnePrice extends MovieClip {
	
	private var print_type:String;
	private var item_label:FormatedText;
	private var units_label:FormatedText;
	private var price_label:FormatedText;
	
	public function new(print_type:String){		
	  super();
	  
	  this.print_type = print_type;
	  
	  if(print_type != "foil" && print_type != "one-pms-color" && print_type != "std-color")
	    trace("Error selecting print_type!!!", print_type);
	  
		item_label = new FormatedText('helvetica', 'item', 12, false);
  	units_label = new FormatedText('helvetica', 'units', 12, false);
  	price_label = new FormatedText('helvetica', 'price', 12, false);
  	
  	addChild(item_label);
  	addChild(units_label);
  	addChild(price_label);
  	
    item_label.x = 8;
    item_label.y = 0;
    
    units_label.x = 87;
    units_label.y = 0;
    
    price_label.x = 141;
    price_label.y = 0;
	}
	
	public function getPrintType():String{
	  return print_type;
	}
	
	public function getPrettyPrintType():String{
	  switch ( getPrintType() )
	  {
	   case 'foil':
	     return "Foil Color";
	     
	   case 'greeting':
   	   return "Greeting";
	     
	   case 'one-pms-color':
	     return "PMS color";
	     
	   case 'std-color':
	     return "STD PMS color";
	     
	   case 'laser':
   	   return "Laser";
	     
	   default:
	     return "Extra";
	  }
	}
	
	public function setItemLabel(s:String):Void {
	  item_label.setLabel(s);
	}
	
	public function setUnitsLabel(s:String):Void {
	  units_label.setLabel(s);
	}
	
	public function setPriceLabel(s:String):Void {
	  price_label.setLabel(s);
	}

}