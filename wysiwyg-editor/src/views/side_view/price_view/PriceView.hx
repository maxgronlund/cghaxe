import flash.geom.Point;
import flash.events.Event;

class PriceView extends PropertyView, implements IView{
	
	private var total_price_label:FormatedText;
	private var shop_item_price_label:FormatedText;
	private var shop_item_price_price_label:FormatedText;
	private var shop_item_price_units_label:FormatedText;
	
	
	private var prices:Array<PriceModel>;
	private var priceColumns:Array<PriceColumn>;
	
	public function new(priceController:IController){	
		super(priceController);
		backdrop				= new PriceViewBack();
    
    shop_item_price_label = new FormatedText('helvetica', '0.0', 12, false);
    shop_item_price_price_label = new FormatedText('helvetica', '0.0', 12, false);
    shop_item_price_units_label = new FormatedText('helvetica', '0.0', 12, false);
  	total_price_label = new FormatedText('helvetica', '0.0', 12, false);
  	
  	prices = new Array();
  	priceColumns = new Array();
  	
  	Application.addEventListener(EVENT_ID.PRESET_PRICES_XML_PARSED, onParsePrice);
	}
	
	private function clearColumns():Void{
	  for(i in 0...priceColumns.length){
	    removeChild(priceColumns[i]);
    }
	  priceColumns = new Array();
	}
	
	override public function addColumn(model:IModel):Void{
	  trace("#0");
	  var price_column:PriceColumn = new PriceColumn(model.getString('page_name'));
	  price_column.set_amount_std_pms_color(model.getInt('amount_std_pms_color'));
	  price_column.set_amount_custom_pms1_color(model.getInt('amount_custom_pms1_color'));
	  price_column.set_amount_custom_pms2_color(model.getInt('amount_custom_pms2_color'));
	  price_column.set_amount_foil_color(model.getInt('amount_foil_color'));
	  price_column.set_amount_greetings(model.getInt('amount_greetings'));
	  price_column.set_amount_laser_color(model.getInt('amount_laser_color'));
	  trace("#1");
	  price_column.set_amount_cliche(model.getInt('amount_cliche'));
    trace("#2");
	  priceColumns.push(price_column);
	}
	
	
	override public function getString(id:String):String {
	  return '';
	  trace(id);
	  switch ( id )
	  {
	    case "viewId":{
	      return "show_prices";
	    }
	   case "price_xml":
	     var result:String = "";
   	   for(i in 0...priceColumns.length) {
   	     result += "<page>\n";
   	     
   	       result += "<total-price>";
   	         priceColumns[i].getColumnTotalPrice();
   	       result += "</total-price>\n";
   	       
   	       
   	     
   	     result += "</page>\n";
   	   }
   	   return result;
   	  default:
   	    return "";
	  }
	  
	}
	
	//override public function setParam(param:IParameter):Void{
	//  switch ( param.id )
	//  {
	//    case EVENT_ID.ADD_PRICE_COLUMN:{
  //      addColumn(model);
  //    }
	//  }
	//}
	
	override public function update(id:String, index:Int, value:String):Void{
	  switch ( id )
	  {
	   case 'addAllPrices':
	     addAllPrices();
	   case 'clearColumns':
	     clearColumns();
	  }
	}
	
	private function addAllPrices(){
	  var total_price:Float = 0;
	  var y:Float = 120;
	  
	  shop_item_price_label.y = 40;
	  shop_item_price_label.x = 0;
	  shop_item_price_label.setLabel(GLOBAL.product_name);
	  
	  shop_item_price_units_label.y = 40+18;
	  shop_item_price_units_label.x = 97;
	  shop_item_price_units_label.setLabel(Std.string(GLOBAL.preset_quantity));
	  
	  shop_item_price_price_label.y = 40+18;
	  shop_item_price_price_label.x = 140;
	  shop_item_price_price_label.setLabel(Std.string(GLOBAL.Pages.getFloat('shop_item_unit_price')*Std.parseInt(GLOBAL.preset_quantity)));
	  
	  total_price += GLOBAL.Pages.getFloat('shop_item_unit_price')*Std.parseInt(GLOBAL.preset_quantity);
	  
	  for(i in 0...priceColumns.length){
	    var priceColumn:PriceColumn = priceColumns[i];
	    addChild(priceColumn);
	    priceColumn.y = y;
  	  priceColumn.setPrices(prices);
  	  priceColumn.addAllPrices();
  	  y += priceColumn.height+18;
  	  total_price += priceColumn.getColumnTotalPrice();
	  }
	  total_price_label.y = priceColumns[priceColumns.length-1].y + priceColumns[priceColumns.length-1].height;
	  total_price_label.setLabel("Total: " + Std.string(total_price));
	}
	
	override public function onAddedToStage(e:Event):Void{
    super.onAddedToStage(e);
  	
  	addChild(total_price_label);
  	addChild(shop_item_price_label);
  	
  	addChild(shop_item_price_label);
  	addChild(shop_item_price_price_label);
  	addChild(shop_item_price_units_label);
  	
  	total_price_label.setLabel('total price');
    total_price_label.x = 55;
    total_price_label.y = 360;
    
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

}