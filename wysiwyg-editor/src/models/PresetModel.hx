import flash.external.ExternalInterface;


import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.net.URLRequestMethod;
import flash.net.URLVariables;
import flash.net.FileReference;
import flash.events.Event;
import flash.geom.Point;
import flash.Vector;


class PresetModel extends Model, implements IModel
{
  private var associatedProducts:Vector<Int>;   //<<------------- hack for test
  private var assProdIndex:UInt;                //<<------------- hack for test
  private var productSelected:String;
  private var loader:URLLoader;
  private var placeholders:UInt;
  
  public function new(){
    super();
    productSelected = 'na';
    placeholders = 0;
    loader = new URLLoader();
    associatedProducts = new Vector<Int>();
    assProdIndex = 0;
  }
  
  override public function init():Void{
  	super.init();
  	Application.addEventListener(EVENT_ID.PASS_PRESET_FILE, onParsePreset);
    Pages.addEventListener(EVENT_ID.SAVE_XML, savePreset);
  }
  
  private function onParsePreset(e:IKEvent):Void{
  
    var xml:Xml = Xml.parse(StringTools.htmlUnescape(e.getXml().toString()));
  
    for( preset in xml.elementsNamed("preset") ) {
  
      // building the pages
      parseConfigurablePlaces(preset);
      
      // loading front shots
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
      
    }
    var param:IParameter        = new Parameter(EVENT_ID.PLACEHOLDER_COUNT);
    param.setInt(placeholders);
    dispatchParameter(param);
  }
  
  // building pages and getting url's for masks
  private function parseConfigurablePlaces(preset:Xml):Void{
    
    var page_index:Int = 0;
    
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
  }
  
  private function parsePresetAssociabled(preset:Xml):Void{
    
    for(preset_associables in preset.elementsNamed("preset-associables") ) {
      for(preset_associable in preset_associables.elementsNamed("preset-associable") ) {
        for(ass_product in preset_associable.elementsNamed("ass-product") ) {
          
          var pageIndex:UInt;
          for(configurable_place_id in ass_product.elementsNamed("configurable-place-id") ) {
            pageIndex = getPageIndexFromConfPlaceId(configurable_place_id);
            
          }
          for(prod_conf in ass_product.elementsNamed("prod-conf") ) {
            for(product_places in prod_conf.elementsNamed("product-places") ) {
              for(product_place in product_places.elementsNamed("product-place") ) {
                for(front_shoot in product_place.elementsNamed("front-shoot") ) {
                  for(url in front_shoot.elementsNamed("url") ) {
                    
                    // somehow we have to show/store a list of what associated product to select from on a product place
                    // pageOptions[ getPageIndexFromConfPlaceId(configurable_place_id)].push(ass_product)
                    
                    var param:IParameter = new Parameter(EVENT_ID.LOAD_FRONT_SHOT);
                    param.setString(url.firstChild().nodeValue.toString());
                    param.setInt(associatedProducts[assProdIndex]); 
                    
                    assProdIndex++;           //<<---------------not working hack                                             
                    dispatchParameter(param); //<<---------------not working hack use pull instead of push
                    trace('******************* go go **************************');
                    trace(associatedProducts.toString());
                    trace('******************* go go **************************');
                    
                  }
                }
              }
            }
          }
        }
      }
    }
  }
  
  private function parseDesigns(preset:Xml):Void{
    for( design in preset.elementsNamed("design") ) {
      //designs for the sidebar
      dispatchXML(EVENT_ID.PAGE_DESIGNS_LOADED, design);
    }
    
  }
  
  private function parseXmlData(preset:Xml):Void{
    var page_index:Int = 0;
    
    for(xml_data in preset.elementsNamed("xml-data") ) {
  
      for(page in xml_data.elementsNamed("page") ) {
        countPlaceHolders(page);
        var param:IParameter = new Parameter(EVENT_ID.PAGE_XML_LOADED);
        param.setXml(page);
        param.setInt(page_index);
        dispatchParameter(param);
        page_index++;
      }
      
      for( stage in xml_data.elementsNamed('stage') ) {
        //passStage(stage);
        var param:IParameter = new Parameter(EVENT_ID.LOAD_PAGE_POS_AND_ZOOM);
        param.setXml(stage);
        dispatchParameter(param);
      }
    }
  }
  
  private function parseProductPlaces(preset:Xml):Void{
    var page_index:Int = 0;
    
    for(product_place in preset.elementsNamed("product-place") ) {
      for(front_shoot in product_place.elementsNamed("front-shoot") ) {
        for(url in front_shoot.elementsNamed("url") ) {
          // There might be missing frontshots for associated products but that's ok
          var param:IParameter = new Parameter(EVENT_ID.LOAD_FRONT_SHOT);
          param.setString(url.firstChild().nodeValue.toString());
          param.setInt(page_index);
          dispatchParameter(param);
        }
      }
      page_index++;
    }
  }
  
  private function parseUser(preset:Xml):Void{
    for( user in preset.elementsNamed("user") ){
      GLOBAL.userParser.parseUser(user);
    }
  }
  
  private function parseVectorFile(preset:Xml):Void{
    for( vector_file in preset.elementsNamed("vector-file") ){
      for( file in vector_file.elementsNamed("file") ){
        for( url in file.elementsNamed("url") ){
            var urlstr:String = url.firstChild().nodeValue.toString();
            GLOBAL.tmp = urlstr;
        }
      }      
    }
  }
    
  private function countPlaceHolders(xml:Xml):Void{
    for( placeholder in xml.elementsNamed("placeholder") ) {
        placeholders++;
    }
  }

  private function getPageIndexFromConfPlaceId( confPlaceId:Xml):UInt{
    // TO do find the right page to send the front shoot to
    // here use 'configurable_place_id' to find the right page index
    return 0;
  }
  
  public function savePreset(e:IKEvent):Void{
    
    var request:URLRequest              = new URLRequest(GLOBAL.save_path); 
    request.method                      = URLRequestMethod.POST;  
    var variables:URLVariables          = new URLVariables();
    
    variables.authenticity_token 			  = GLOBAL.authenticity_token;
    variables._wysiwyg_session 				  = GLOBAL.wysiwyg_session;
    variables.xml_data 				          = Pages.getString('file_xml');
    variables.preset_sibling_selected 	= productSelected;
    
    variables._method = 'put';
    request.data = variables;
    
    loader.addEventListener(Event.COMPLETE, onSavedComplete);
    loader.load(request);
    
  }
  
  private function onSavedComplete(e:Event):Void{
    // confirm save completed to enduser here
  	trace('save completed');
  }
}