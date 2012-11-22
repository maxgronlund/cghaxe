import flash.external.ExternalInterface;


import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.net.URLRequestMethod;
import flash.net.URLVariables;
import flash.net.FileReference;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.geom.Point;
import flash.Vector;
import flash.external.ExternalInterface;


class PresetModel extends Model, implements IModel
{
  private var associatedProducts:Vector<Int>;   //<<------------- hack for test
  private var assProdIndex:UInt;                //<<------------- hack for test
  private var productSelected:String;
  private var loader:URLLoader;
  private var pms_converter:PMSColorToRGBConverter;
  
  
  public function new(){
    super();
    productSelected       = 'na';
    loader              = new URLLoader();
    associatedProducts  = new Vector<Int>();
    pms_converter       = new PMSColorToRGBConverter();
    assProdIndex        = 0;
  }
  
  override public function init():Void{
    super.init();
    Application.addEventListener(EVENT_ID.PASS_PRESET_FILE, onParsePreset);
    Pages.addEventListener(EVENT_ID.SAVE_XML, savePreset);
    Pages.addEventListener(EVENT_ID.BUY_NOW, buyNow);
  }
  
  private function onParsePreset(e:IKEvent):Void{

    var xml:Xml = Xml.parse(StringTools.htmlUnescape(e.getXml().toString()));
    for( preset in xml.elementsNamed("preset") ) {
      countPlaceholders(preset);
      parsePreset(preset);
    }
  }
  

  private function countPlaceholders(xml:Xml):Void{

    var placeholders:UInt = 0;

    for(xml_data in xml.elementsNamed("xml-data") ) {
      for( page in xml_data.elementsNamed("page") ) {
        for( placeholder in page.elementsNamed("placeholder") ) {
          placeholders++;
        }
      }
    }
    Application.setString(EVENT_ID.UPDATE_LOAD_PROGRESS,'Placeholders counted to:'+ Std.string(placeholders));
    
    var param:IParameter        = new Parameter(EVENT_ID.PLACEHOLDER_COUNT);
    param.setInt(placeholders);
    dispatchParameter(param);
    GLOBAL.placeholders = placeholders;

  }
  
  // building pages and getting url's for masks
  private function parsePreset(xml:Xml):Void{
    Application.setString(EVENT_ID.UPDATE_LOAD_PROGRESS,'Parse Preset');
    
    for( preset in xml.elementsNamed("title") ) {
       GLOBAL.product_name = preset.firstChild().nodeValue.toString();
    }
    
    for( language in xml.elementsNamed("language") ) {
       var languageParser:LanguageParser = new LanguageParser();
       languageParser.parse(language);
    }
    
    for( tool_tips in xml.elementsNamed("tool-tips") ) {
       var toolTipParser:ToolTipParser = new ToolTipParser();
       toolTipParser.parse(tool_tips);
    }

    for( preset_quantity in xml.elementsNamed("preset-quantity") ) {
      
      var param:IParameter        = new Parameter(EVENT_ID.UPDATE_QUANTITY);
      GLOBAL.preset_quantity      = preset_quantity.firstChild().nodeValue.toString();
      param.setString(GLOBAL.preset_quantity);
      
      dispatchParameter(param);
    }

    for( preset_id in xml.elementsNamed("preset-id") ) {
       GLOBAL.preset_id = preset_id.firstChild().nodeValue.toString();
    }
        
    for(pages in xml.elementsNamed("pages") ) {
      
      for(page in pages.elementsNamed("page") ) {
        buildPage(page);
      } 
    }
    
    for(xml_data in xml.elementsNamed("xml-data") ) {
      parseXmlData(xml_data);
    }
    
    for(save_path in xml.elementsNamed("save-path") ) {
      
      GLOBAL.save_path = save_path.firstChild().nodeValue.toString();
      Application.setString(EVENT_ID.UPDATE_LOAD_PROGRESS,'Save Path Loaded');
    }
    
    for(buy_path in xml.elementsNamed("buy-path") ) {
      GLOBAL.buy_path = buy_path.firstChild().nodeValue.toString();
    }
    
    for(greetings in xml.elementsNamed("greetings")){
      dispatchXML(EVENT_ID.GREETINGS_LOADED, greetings);
    }
    
    for(symbols in xml.elementsNamed("symbols")){
      
      dispatchXML(EVENT_ID.SYMBOLS_LOADED, symbols);
    }

    for(print_prices in xml.elementsNamed("print-prices")){
      Application.dispatchXML(EVENT_ID.PRESET_PRICES, print_prices);
    }
    
    for(prices in xml.elementsNamed("prices")){
      Application.dispatchXML(EVENT_ID.PASS_PRICE_FILE, prices);
    }
    
    for( cliche_price_xml in xml.elementsNamed("cliche-price")) {
		  GLOBAL.cliche_price = Std.parseFloat(cliche_price_xml.firstChild().nodeValue.toString());
		}

    for(user_tags in xml.elementsNamed("user-tags")){
      GLOBAL.userParser.parseUser(user_tags);
    }
    
    for(logos in xml.elementsNamed("logos")){
      dispatchXML(EVENT_ID.LOGOS_LOADED, logos);
    }
    
    for(photos in xml.elementsNamed("photos")){
      dispatchXML(EVENT_ID.PHOTOS_LOADED, photos);
    }
    
    for(print_types in xml.elementsNamed("print-types")){
      //trace(print_types.toString());
      dispatchXML(EVENT_ID.PRINT_TYPES_LOADED, print_types);
    }
    
    for(text_suggestion in xml.elementsNamed("text-suggestion")){
      //trace(text_suggestions.toString());
      dispatchXML(EVENT_ID.TEXT_SUGGESTION_LOADED, text_suggestion);
    }
  }
  
  private function pickUpDesignsforAssProduct(xml:Xml):Void{
    
    var param:IParameter = new Parameter(EVENT_ID.ADD_DESIGN_PAGE_TO_SIDEBAR);
    param.setXml(xml);
    dispatchParameter(param);
  }
  
  private function parseAssociatedProducts(xml:Xml):Void{
   
    //trace('INSERT ASSOCIATED PRODUCTS HERE');
    //trace(xml.toString());
    var first_associated_product:Bool = true;
    for(associated_product in xml.elementsNamed("associated-product") ) {

      for(item_number in associated_product.elementsNamed("item-number") ) {
        //trace('build button in sidebar for',item_number.firstChild().nodeValue.toString());
      }
      for(pages in associated_product.elementsNamed("pages") ) {
        for(page in pages.elementsNamed("page") ) {
          if(first_associated_product)
            
            buildPage(page);
        }
      }
      first_associated_product = false;
    }
  }
  
  private function buildPage(xml:Xml):Void{

    var param:IParameter = new Parameter(EVENT_ID.BUILD_PAGE);
    param.setXml(xml);
    dispatchParameter(param);
  }

  
  private function parseXmlData(xml_data:Xml):Void{
    GLOBAL.Application.setString(EVENT_ID.UPDATE_LOAD_PROGRESS,'Parsing XML Data');
    
    var page_index:Int = 0;
  
    for(page in xml_data.elementsNamed("page") ) {
      var param:IParameter = new Parameter(EVENT_ID.PAGE_XML_LOADED);
      param.setXml(page);
      param.setInt(page_index);
      dispatchParameter(param);
      page_index++;
    }
    
    for( stage in xml_data.elementsNamed('stage') ) {
      var param:IParameter = new Parameter(EVENT_ID.LOAD_PAGE_POS_AND_ZOOM);
      param.setXml(stage);
      dispatchParameter(param);
    }
    
    for( pms_1 in xml_data.elementsNamed('pms_1') ) {
      GLOBAL.pms1ColorString  = pms_1.firstChild().nodeValue.toString();
      
    }
    
    for( pms_2 in xml_data.elementsNamed('pms_2') ) {
      GLOBAL.pms2ColorString  = pms_2.firstChild().nodeValue.toString();
      
    }
    
    GLOBAL.pms1Color        = pms_converter.convertPMSToRGB(GLOBAL.pms1ColorString);  
    GLOBAL.pms2Color        = pms_converter.convertPMSToRGB(GLOBAL.pms2ColorString);
  }
  
  public function savePreset(e:IKEvent):Void{
    ExternalInterface.call("openSavingBox()");
    loader.addEventListener(IOErrorEvent.IO_ERROR, onError);
    loader.addEventListener(Event.COMPLETE, onSavedComplete);
    loader.load(save_preset());
    
  }
  
  private function save_preset():Dynamic{
    trace('Save preset',GLOBAL.save_path);
    var request:URLRequest              = new URLRequest(GLOBAL.save_path); 
    request.method                      = URLRequestMethod.POST;  
    var variables:URLVariables          = new URLVariables();
    
    //GLOBAL.preset_quantity              = GLOBAL.preset_quantity_text_field.getQuantity();
    
    variables.authenticity_token 			  = GLOBAL.authenticity_token;
    variables._wysiwyg_session 				  = GLOBAL.wysiwyg_session;
    variables.xml_data 				          = Pages.getString('file_xml');
    variables.xml_prices                = Pages.getString('price_xml');
    variables.quantity                  = GLOBAL.preset_quantity;
    variables.cliches                   = clicheInfo();
    variables.user_id 				          = Std.parseInt(GLOBAL.user_id);
    variables.shop_item_id              = GLOBAL.shop_item_id;
    variables.user_uuid                 = GLOBAL.user_uuid;
    //variables.language_name             = GLOBAL.language_name;
    
    variables.preset_sibling_selected 	= productSelected;

    variables._method = 'put';
    request.data = variables;
    return request;
    
    
    
  }
  
  public function buyNow(e:IKEvent):Void{
    ExternalInterface.call("openSavingBox()");
    loader.addEventListener(IOErrorEvent.IO_ERROR, onError);
    loader.addEventListener(Event.COMPLETE, onBuySavedComplete);
    loader.load(save_preset());

    
  }
  
  private function clicheInfo():String{
    var cliches:String = "{\n";
    var iterator = GLOBAL.iAlreadyHaveACliche.keys();
    var unended_comma = false;
    for(page_key in iterator) {
      if(GLOBAL.iAlreadyHaveACliche.get(page_key) == true){
        if(unended_comma){
          unended_comma = false;
          cliches = cliches + ",\n";
        }
        cliches = cliches + '"' + page_key + '":true';
        if(iterator.hasNext()) {
          unended_comma = true;
        } else {
          cliches = cliches + "\n";
        }
        
      }
    }
    cliches = cliches + "\n}"; 
    return cliches;
  }
  
  private function onBuySavedComplete(e:Event):Void{
  	loader.removeEventListener(IOErrorEvent.IO_ERROR, onError);
    loader.removeEventListener(Event.COMPLETE, onBuySavedComplete);

  	var request:URLRequest              = new URLRequest(GLOBAL.buy_path+"&preset_quantity="+GLOBAL.preset_quantity+"&shop_item_id="+GLOBAL.shop_item_id+"&preset_id="+GLOBAL.preset_id); 
    request.method                      = URLRequestMethod.GET;  

    loader.addEventListener(IOErrorEvent.IO_ERROR, onError);
    loader.addEventListener(Event.COMPLETE, onBuyComplete);
    loader.load(request);
  }
  
  private function onSavedComplete(e:Event):Void{
  	onComplete();
  }
  
  private function onBuyComplete(e:Event):Void{
    ExternalInterface.call("openCart()");
    loader.removeEventListener(IOErrorEvent.IO_ERROR, onError);
    loader.removeEventListener(Event.COMPLETE, onBuyComplete);
  }
  
  private function onError(e:Event):Void{
    onComplete();
    ExternalInterface.call("showSavingError()");
  }
  
  private function onComplete():Void{
    ExternalInterface.call("closeSavingBox()");
    ExternalInterface.call("signupDialog()");
    loader.removeEventListener(IOErrorEvent.IO_ERROR, onError);
    loader.removeEventListener(Event.COMPLETE, onSavedComplete);
  }
}