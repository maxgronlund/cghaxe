import flash.geom.Point;
import flash.events.Event;

class PriceView extends PropertyView, implements IView{
  
  private var priceTitle:FormatedText;
//  private var productHeader:FormatedText;
  private var shopItemTitle:FormatedText;
  private var totalPriceLabel:FormatedText;
  private var totalPrice:FormatedText;
  private var unitsLabel:FormatedText;
  private var unitTextFiels:UnitTextField;
  private var shopItemPrice:FormatedText;
  
  public var iAlreadyHaveACliche:Hash<Bool>;
  private var prices:Array<PriceModel>;
  private var priceColumns:Array<PriceColumn>;
  private var productHeaderBack:Rectangle;
  private var marginLeft:Int;
  private var valuta:Valuta;
  private var quantity:Float;
  private var back:Rectangle;
  
  private var buyNowButton:OneStateTextAndImageButton;
  
  
  
  public function new(priceController:IController){	
    super(priceController);
    //backdrop                    = new PriceViewBack();
    back                          = new Rectangle(190, 486, 0x000000, 0xDEDEDE, Rectangle.DONT_DRAW_LINES, Rectangle.USE_FILL);                       
    productHeaderBack             = new Rectangle(190, 30, 0x000000, 0xAFAFAF, Rectangle.DONT_DRAW_LINES, Rectangle.USE_FILL);
    priceTitle                    = new FormatedText('helvetica', '0.0', 14, false, 0xffffff);
    //productHeader                 = new FormatedText('helvetica', '0.0', 11, false, 0xffffff);
                                  
    shopItemTitle                 = new FormatedText('helvetica', '0.0', 12, false);
    
    unitsLabel                    = new FormatedText('helvetica', '0.0', 11, false);
    unitTextFiels                 = new UnitTextField();
    
    shopItemPrice                 = new FormatedText('helvetica', '0.0', 11, false);
    //shopItemTitle.setColor(0xdedede);

    totalPriceLabel               = new FormatedText('helvetica', '0.0', 11, false);
    totalPrice                    = new FormatedText('helvetica', '0.0', 11, false);
                                  
    prices                        = new Array();
    priceColumns                  = new Array();
    if(GLOBAL.iAlreadyHaveACliche == null){
      //iAlreadyHaveACliche           = new Hash();
      //GLOBAL.iAlreadyHaveACliche    = iAlreadyHaveACliche;
      GLOBAL.iAlreadyHaveACliche    = new Hash();
    } else {
      //iAlreadyHaveACliche           = GLOBAL.iAlreadyHaveACliche;
    }
    
    marginLeft                    = 8;
    valuta                        = new Valuta();
    buyNowButton                  = new OneStateTextAndImageButton();
    buyNowButton.setFormat(0, 7, 0x000000, 'center');
    Application.addEventListener(EVENT_ID.PRESET_PRICES_XML_PARSED, onParsePrice);
    Preset.addEventListener(EVENT_ID.UPDATE_QUANTITY, onUpdateQuantity);
	  Pages.addEventListener(EVENT_ID.CALCULATE_PRICE, calculatePrice);
	  //Pages.addEventListener(EVENT_ID.PAGE_SELECTED, onPageSelected);
  }
  
  private function calculatePrice(e:Event): Void {
    update('clearColumns', 0, '');
  }
	
	private function onUpdateQuantity(e:KEvent):Void{
	  
	  GLOBAL.preset_quantity = e.getString();
	  unitTextFiels.setText(GLOBAL.preset_quantity);
	}
	
	override public function onAddedToStage(e:Event):Void{
	  super.onAddedToStage(e);
    addChild(back);
    back.y = 0;
    
    addChild(productHeaderBack);
    productHeaderBack.x   = 0;
    productHeaderBack.y   = 0;

    addChild(priceTitle);
    priceTitle.x            = marginLeft;
    priceTitle.y            = 6;

    addChild(shopItemTitle);
    shopItemTitle.x       = marginLeft;
    shopItemTitle.y       = 40;
    
    addChild(unitsLabel);
    unitsLabel.x          = marginLeft;
    unitsLabel.y          = 64;
    
    addChild(unitTextFiels);
    unitTextFiels.init();
    unitTextFiels.x       = 64;
    unitTextFiels.y       = 64;
    
    addChild(shopItemPrice);
    shopItemPrice.x       = 140;
    shopItemPrice.y       = 64;

    addChild(totalPriceLabel);
    totalPriceLabel.setLabel('');
    totalPriceLabel.x = marginLeft;
    totalPriceLabel.y = 94;
    
    addChild(totalPrice);
    totalPrice.setLabel('0');
    totalPrice.x = 140;
    totalPrice.y = 94;
    
    addChild(buyNowButton);
    buyNowButton.x = 20;
    buyNowButton.y = totalPrice.y;
  }
  
  override public function init():Void{
    
  	//selectButton.init( 
  	//                    controller,
    //                    new Point(190,30), 
    //                    new PriceViewButton(), 
    //                    new Parameter( EVENT_ID.SHOW_PRICES)
    //                    
    //                  );
                      
    selectButton.init( 
                        controller,
                        new Point(190,30), 
                        new PriceViewButton(), 
                        new Parameter( EVENT_ID.SHOW_PRICES)
    
                      );
    
    Application.addEventListener(EVENT_ID.SET_DEFAULT_TOOL, onLoadDefaultTool);
    
    buyNowButton.init( controller,
             new Point(150,30), 
             new OsButtonBack(), 
             new Parameter( EVENT_ID.BUY_NOW ) );
    buyNowButton.fireOnMouseUp(false);
    
  }
  
  private function onLoadDefaultTool(e:IKEvent):Void{
    priceTitle.setLabel(TRANSLATION.price_button);
    unitsLabel.setLabel(TRANSLATION.units);
    totalPriceLabel.setLabel(TRANSLATION.total_price_label);
    buyNowButton.setText(TRANSLATION.buy_button);
    buyNowButton.updateLabel();    
    
  }

  
  private function clearColumns():Void{
    for(i in 0...priceColumns.length){
      GLOBAL.iAlreadyHaveACliche.set(priceColumns[i].getTitle(), priceColumns[i].getIAlreadyHaveACliche());
      removeChild(priceColumns[i]);
    }
    priceColumns = new Array();
  }
  
  override public function addColumn(model:IModel):Void{

    var price_column:PriceColumn = new PriceColumn(model.getString('page_name'));
    var haveACliche:Bool = GLOBAL.iAlreadyHaveACliche.get(price_column.getTitle());
    price_column.setIAlreadyHaveACliche(haveACliche);
    
    price_column.set_amount_std_pms_color(model.getInt('amount_std_pms_color'));
    price_column.set_amount_custom_pms1_color(model.getInt('amount_custom_pms1_color'));
    price_column.set_amount_custom_pms2_color(model.getInt('amount_custom_pms2_color'));
    price_column.set_amount_custom_pms4_color(model.getInt('amount_custom_pms4_color'));
    price_column.set_amount_foil_color(model.getInt('amount_foil_color'));
    price_column.set_amount_greetings(model.getInt('amount_greetings'));
    //price_column.set_amount_digital_print(model.getInt('amount_digital_print'));

	  price_column.set_amount_cliche(model.getInt('amount_cliche'));
    priceColumns.push(price_column);
    
  }
  
  
  override public function getString(id:String):String {

    switch ( id )
    {
      case "viewId":{
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
  
  
  override public function update(id:String, index:Int, value:String):Void{
    super.update(id,index,value);
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
    var y:Float = 108;

    shopItemTitle.setLabel(GLOBAL.product_name);

    quantity = Std.parseInt(GLOBAL.preset_quantity);
    
    var shop_item_price:Float = GLOBAL.Pages.getFloat('shop_item_unit_price') * quantity;
    
    shopItemPrice.setLabel( valuta.toString(shop_item_price) );
    shopItemPrice.x = 180 - shopItemPrice.getWidth();
    
    total_price += GLOBAL.Pages.getFloat('shop_item_unit_price') * Std.parseInt(GLOBAL.preset_quantity);
    
    for(i in 0...priceColumns.length){
      var priceColumn:PriceColumn = priceColumns[i];
      addChild(priceColumn);
      priceColumn.y = y;
      priceColumn.setPrices(prices);
      priceColumn.addAllPrices();
      y += priceColumn.height+8;
      total_price += priceColumn.getColumnTotalPrice();
    }
    if(priceColumns.length > 0){
      totalPriceLabel.y = priceColumns[priceColumns.length-1].y + priceColumns[priceColumns.length-1].height;
      totalPrice.y = totalPriceLabel.y;
    } else {
      totalPriceLabel.y = 110;
      totalPrice.y = 110;
    }

    totalPrice.setLabel(valuta.toString(total_price));
	  totalPrice.x = 180 - totalPrice.getWidth();
	  
	  buyNowButton.y = totalPrice.y + 30;
	  
	  back.height = 900;
	  
  }
  
  
  
  private function onParsePrice(e:XmlEvent):Void{
    parsePrice(e.getXml());
    addAllPrices();
  }
  
  private function parsePrice(prices_xml:Xml):Void{
    Application.setString(EVENT_ID.UPDATE_LOAD_PROGRESS,'Parse Price XML');
    for( print_price_xml in prices_xml.elementsNamed("print-price") ) {
      var units:UInt;
      var foil_price:Float;
      var one_pms_color_price:Float;
      var two_pms_color_price:Float;
      var pms4_color_price:Float;
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
      for( two_pms_color_price_xml in print_price_xml.elementsNamed("two-pms-color")) {
        two_pms_color_price = Std.parseFloat(two_pms_color_price_xml.firstChild().nodeValue.toString());
      }
      for( pms4_color_price_xml in print_price_xml.elementsNamed("pms4-color")) {
        pms4_color_price = Std.parseFloat(pms4_color_price_xml.firstChild().nodeValue.toString());
      }
      for( std_color_price_xml in print_price_xml.elementsNamed("std-color")) {
        std_color_price = Std.parseFloat(std_color_price_xml.firstChild().nodeValue.toString());
      }
      
      prices.push(new PriceModel(units, foil_price, one_pms_color_price, std_color_price, pms4_color_price, two_pms_color_price));
    }
  }
  
}