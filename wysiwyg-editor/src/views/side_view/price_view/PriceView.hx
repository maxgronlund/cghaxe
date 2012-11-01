import flash.geom.Point;
import flash.events.Event;

class PriceView extends PropertyView, implements IView{
  
  private var productHeader:FormatedText;
  private var shopItemTitle:FormatedText;
  private var totalPriceLabel:FormatedText;
  private var totalPrice:FormatedText;
  
  private var shopItemPrice:FormatedText;
  //private var shop_item_price_units_label:FormatedText;
  private var units:EditableTextField;
  public var iAlreadyHaveACliche:Hash<Bool>;
  private var prices:Array<PriceModel>;
  private var priceColumns:Array<PriceColumn>;
  private var productHeaderBack:Rectangle;
  private var marginLeft:Int;
  
  public function new(priceController:IController){	
    super(priceController);
    backdrop				            = new PriceViewBack();
    
    productHeaderBack           = new Rectangle(190, 18, 0x000000, 0x999999, Rectangle.DONT_DRAW_LINES, Rectangle.USE_FILL);
    productHeader               = new FormatedText('helvetica', '0.0', 12, false, 0xffffff);
    
    shopItemTitle               = new FormatedText('helvetica', '0.0', 12, false);
    shopItemPrice               = new FormatedText('helvetica', '0.0', 12, false);
    shopItemTitle.setColor(0xdedede);
    
    units                       = new EditableTextField();
    // !!! DANGER IT'S POSSIBLE TO ACCESS A TEXTFIELD EVEN IT THERE IS NO PRICE VIEW
    // NEVER EXPOSE THE INTERFACE TO THE APPLICATION 
    GLOBAL.preset_quantity_text_field = units;
    
    totalPriceLabel = new FormatedText('helvetica', '0.0', 12, false);
    totalPrice = new FormatedText('helvetica', '0.0', 12, false);
    
    
    
    prices                      = new Array();
    priceColumns                = new Array();
    iAlreadyHaveACliche         = new Hash();
    GLOBAL.iAlreadyHaveACliche  = iAlreadyHaveACliche;
    
    marginLeft=8;
    
    Application.addEventListener(EVENT_ID.PRESET_PRICES_XML_PARSED, onParsePrice);
	}
	
	override public function onAddedToStage(e:Event):Void{
    super.onAddedToStage(e);
    
    addChild(productHeaderBack);
    //productHeaderBack.setSize(190, 30);
    productHeaderBack.x   = 0;
    productHeaderBack.y   = 30;
    
    addChild(productHeader);
    productHeader.x       = marginLeft;
    productHeader.y       = 30;

    addChild(shopItemTitle);
    shopItemTitle.x       = marginLeft;
    shopItemTitle.y       = 60;
    
    addChild(units);
    units.init();
    units.x              = 100;
    units.y              = 60;
    

    addChild(shopItemPrice);
    shopItemPrice.x       = 140;
    shopItemPrice.y       = 60;

    addChild(totalPriceLabel);
    totalPriceLabel.setLabel('');
    totalPriceLabel.x = marginLeft;
    totalPriceLabel.y = 76;
    
    addChild(totalPrice);
    totalPrice.setLabel('0');
    totalPrice.x = 140;
    totalPrice.y = 76;
    
  }
	
	override public function init():Void{
		selectButton.init( controller,
                        new Point(190,30), 
                        new PriceViewButton(), 
                        new Parameter( EVENT_ID.SHOW_PRICES));
    Application.addEventListener(EVENT_ID.SET_DEFAULT_TOOL, onLoadDefaultTool);
	}
	
	private function onLoadDefaultTool(e:IKEvent):Void{

	  productHeader.setLabel(TRANSLATION.card);
	  totalPriceLabel.setLabel(TRANSLATION.total_price_label);
	  
  }
	
	//public function getIAlreadyHaveACliche():Hash{
	//  return iAlreadyHaveACliche;
	//}
	
	private function clearColumns():Void{
	  for(i in 0...priceColumns.length){
	    iAlreadyHaveACliche.set(priceColumns[i].getTitle(), priceColumns[i].getIAlreadyHaveACliche());
	    removeChild(priceColumns[i]);
    }
    GLOBAL.iAlreadyHaveACliche = iAlreadyHaveACliche;
	  priceColumns = new Array();
	}
	
  override public function addColumn(model:IModel):Void{

    var price_column:PriceColumn = new PriceColumn(model.getString('page_name'));

    var haveACliche:Bool = iAlreadyHaveACliche.get(price_column.getTitle());
    price_column.setIAlreadyHaveACliche(haveACliche);
    
    price_column.set_amount_std_pms_color(model.getInt('amount_std_pms_color'));
    price_column.set_amount_custom_pms1_color(model.getInt('amount_custom_pms1_color'));
    price_column.set_amount_custom_pms2_color(model.getInt('amount_custom_pms2_color'));
    price_column.set_amount_foil_color(model.getInt('amount_foil_color'));
    price_column.set_amount_greetings(model.getInt('amount_greetings'));
    price_column.set_amount_laser_color(model.getInt('amount_laser_color'));

	  price_column.set_amount_cliche(model.getInt('amount_cliche'));
    priceColumns.push(price_column);
  }
  
  
  override public function getString(id:String):String {

    switch ( id )
    {
      case "viewId":{
        trace('got you');
        addAllPrices();
        return EVENT_ID.SHOW_PRICES;
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
    
    
   
    shopItemTitle.setLabel(GLOBAL.product_name);
    
    //units.y = 40+18;
    //units.x = 97;
    ////shop_item_price_units_label.setLabel(Std.string(GLOBAL.preset_quantity));
    //
    //shopItemPrice.y = 40+18;
    //shopItemPrice.x = 140;
    var shop_item_price_rounded:Float = Std.int(GLOBAL.Pages.getFloat('shop_item_unit_price')*Std.parseInt(GLOBAL.preset_quantity)*100)/100.0;
    shopItemPrice.setLabel(Std.string(shop_item_price_rounded));
    
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
    if(priceColumns.length > 0){
      totalPriceLabel.y = priceColumns[priceColumns.length-1].y + priceColumns[priceColumns.length-1].height;
      totalPrice.y = totalPriceLabel.y;
    } else {
      totalPriceLabel.y = 76;
      totalPrice.y = 76;
    }
    
    var rounded_total_price:Float = Std.int(total_price*100)/100;
    
    totalPrice.setLabel(Std.string(rounded_total_price));
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