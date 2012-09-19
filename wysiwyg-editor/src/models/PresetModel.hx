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
  
  
  public function new(){
    super();
    productSelected = 'na';
   
    loader = new URLLoader();
    associatedProducts = new Vector<Int>();
    assProdIndex = 0;
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
      // building the pages
      parsePreset(preset);
      
/*      // loading front shots
      parseProductPlaces(preset);
      
      // swap this to top of function and let parseProductPlaces pull right associated product to show
      parsePresetAssociabled(preset);
      
      // parse designs for the sidebar
      parseDesigns(preset);
     
      // user tags
      parseUser(preset);
      
      // loading user content
      parseXmlData(preset);
      
      // vector files
      parseVectorFile(preset);
*/ 
    }
  }
  
  
  
  private function countPlaceholders(xml:Xml):Void{
//    trace('..countPlaceholders.');
    var placeholders:UInt = 0;
    for(pages in xml.elementsNamed("pages") ) {
       for(page in pages.elementsNamed("page") ) {
         for( placeholder in page.elementsNamed("placeholder") ) {
             placeholders++;
         }
      }
    }
    var param:IParameter        = new Parameter(EVENT_ID.PLACEHOLDER_COUNT);
    param.setInt(placeholders);
    dispatchParameter(param);
  }
  
  // building pages and getting url's for masks
  private function parsePreset(xml:Xml):Void{
    
    for( preset in xml.elementsNamed("title") ) {
       GLOBAL.product_name = preset.firstChild().nodeValue.toString();
    }
    
    for( preset_quantity in xml.elementsNamed("preset-quantity") ) {
       GLOBAL.preset_quantity = preset_quantity.firstChild().nodeValue.toString();
       GLOBAL.preset_quantity_text_field.setText(GLOBAL.preset_quantity);
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
    }
    
    for(buy_path in xml.elementsNamed("buy-path") ) {
      GLOBAL.buy_path = buy_path.firstChild().nodeValue.toString();
    }
    
    for(greetings in xml.elementsNamed("greetings")){
      dispatchXML(EVENT_ID.GREETINGS_LOADED, greetings);
    }

    for(print_prices in xml.elementsNamed("print-prices")){
      Application.dispatchXML(EVENT_ID.PRESET_PRICES, print_prices);
    }
    
    for( cliche_price_xml in xml.elementsNamed("cliche-price")) {
		  GLOBAL.cliche_price = Std.parseFloat(cliche_price_xml.firstChild().nodeValue.toString());
		}

    for(user_tags in xml.elementsNamed("user-tags")){
      GLOBAL.userParser.parseUser(user_tags);
    }
    
    for(logos in xml.elementsNamed("logos")){
      dispatchXML(EVENT_ID.LOGOS_LOADED, logos);
      //for(logo in logos.elementsNamed("logo")){
      //  trace(logo.firstChild().nodeValue.toString());
      //}
    }
    

    
/*    var page_index:Int = 0;
    
    for(configurable_place in preset.elementsNamed("configurable-place") ) {
      var param:IParameter = new Parameter(EVENT_ID.BUILD_PAGE);
      //trace(configurable_place.toString());
      param.setXml(configurable_place);
      param.setInt(page_index);
      dispatchParameter(param);
      
      for(is_associated_product in configurable_place.elementsNamed("is-associated-product") ) {
        // store this somewhere
        if(is_associated_product.firstChild().nodeValue.toString() == 'true'){
          trace('page is ass prod', page_index);
          associatedProducts.push(page_index); //<<---------------- temp hack not working
        }
      }
      // store id so the default 'preset-associable' can find right page to send it's frontshot to
      for(id in configurable_place.elementsNamed("id") ) {
        // 
      }
      
      for(default_associated_id in configurable_place.elementsNamed("default-associated-id") ) {
        if(default_associated_id.firstChild() != null){
          // store on a product place/ page_index
          // remember to put it in the fileformat
          // handle error when stored assProduct is missing
          trace('default ass prod', default_associated_id.firstChild().nodeValue.toString(), 'on page:', page_index);
        }
      }
      page_index++;
    }
    */
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
//    trace(xml_data.toString());
    var page_index:Int = 0;
  
    for(page in xml_data.elementsNamed("page") ) {
      //countPlaceHolders(page);
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
    
    //for( language in xml_data.elementsNamed('language')){
    //  for( name in language.elementsNamed('name')){
    //    GLOBAL.language_name = name.firstChild().nodeValue.toString();
    //  }
    //}
    
  }
  
  public function savePreset(e:IKEvent):Void{
    ExternalInterface.call("openSavingBox()");
    save_preset();
  }
  
  private function save_preset():Void{

    var request:URLRequest              = new URLRequest(GLOBAL.save_path); 
    request.method                      = URLRequestMethod.POST;  
    var variables:URLVariables          = new URLVariables();
    
    GLOBAL.preset_quantity = GLOBAL.preset_quantity_text_field.getQuantity();
    
    variables.authenticity_token 			  = GLOBAL.authenticity_token;
    variables._wysiwyg_session 				  = GLOBAL.wysiwyg_session;
    variables.xml_data 				          = Pages.getString('file_xml');
    variables.xml_prices                = Pages.getString('price_xml');
    variables.shop_item_id              = GLOBAL.shop_item_id;
    variables.quantity                  = GLOBAL.preset_quantity;
    variables.cliches                   = GLOBAL.iAlreadyHaveACliche;
    variables.user_id 				          = Std.parseInt(GLOBAL.user_id);
    variables.shop_item_id              = GLOBAL.shop_item_id;
    variables.user_uuid                 = GLOBAL.user_uuid;
    variables.preset_sibling_selected 	= productSelected;

    variables._method = 'put';
    request.data = variables;
    
    loader.addEventListener(IOErrorEvent.IO_ERROR, onError);
    loader.addEventListener(Event.COMPLETE, onSavedComplete);
    loader.load(request);
    
    trace(variables.xml_data);
  }
  
  public function buyNow(e:IKEvent):Void{
    ExternalInterface.call("openSavingBox()");
    var request:URLRequest              = new URLRequest(GLOBAL.save_path); 
    request.method                      = URLRequestMethod.POST;  
    var variables:URLVariables          = new URLVariables();
    
    GLOBAL.preset_quantity = GLOBAL.preset_quantity_text_field.getQuantity();
    
    variables.authenticity_token 			  = GLOBAL.authenticity_token;
    variables._wysiwyg_session 				  = GLOBAL.wysiwyg_session;
    variables.xml_data 				          = Pages.getString('file_xml');
    variables.xml_prices                = Pages.getString('price_xml');
    variables.shop_item_id              = GLOBAL.shop_item_id;
    variables.quantity                  = GLOBAL.preset_quantity;
    variables.cliches                   = GLOBAL.iAlreadyHaveACliche;
    variables.user_id 				          = Std.parseInt(GLOBAL.user_id);
    variables.shop_item_id              = GLOBAL.shop_item_id;
    variables.user_uuid                 = GLOBAL.user_uuid;
    variables.preset_sibling_selected 	= productSelected;

    variables._method = 'put';
    request.data = variables;
    
    loader.addEventListener(IOErrorEvent.IO_ERROR, onError);
    loader.addEventListener(Event.COMPLETE, onBuySavedComplete);
    loader.load(request);
    
    
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