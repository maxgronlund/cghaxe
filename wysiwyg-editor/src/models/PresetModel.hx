import flash.external.ExternalInterface;


import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.net.URLRequestMethod;
import flash.net.URLVariables;
import flash.net.FileReference;
import flash.events.Event;
import flash.geom.Point;


class PresetModel extends Model, implements IModel
{

//	public var productXml:Xml;						//!!! replace with a reference
	private var preset:String;
//	private var Application:IModel;

	private var productSelected:String;
	private var loader:URLLoader;
//	private var productId:Int;
	private var presetName:String;
	private var placeholders:UInt;
	
	public function new()
	{
		super();
		preset = '';
		productSelected = 'na';
		placeholders = 0;
		loader = new URLLoader();
//		productId = -1;
		
	}
	
	override public function init():Void{
		super.init();
		Application.addEventListener(EVENT_ID.PASS_PRESET_FILE, onPassPreset);
    Pages.addEventListener(EVENT_ID.SAVE_XML, savePreset);
	}


	public function savePreset(e:IKEvent):Void{
    
    //trace('savePreset+++++++++++++++++++++++++++++++++++++++++++++++++');
    var request:URLRequest              = new URLRequest(GLOBAL.save_path); 
    request.method                      = URLRequestMethod.POST;  
    var variables:URLVariables          = new URLVariables();
    
    variables.authenticity_token 			  = GLOBAL.authenticity_token;
    variables._wysiwyg_session 				  = GLOBAL.wysiwyg_session;
    variables.xml_data 				          = Pages.getString('file_xml');//'get a life, become a programmer .-)';//getPresetString();
    variables.preset_sibling_selected 	= productSelected;
    
    variables._method = 'put';
    request.data = variables;
    
    loader.addEventListener(Event.COMPLETE, onSavedComplete);
    loader.load(request);
    
	}
	
  //override public function setXml(id:String, xml:Xml):Void{
  //  
  //  switch (id) {
  //    
  //    case EVENT_ID.PASS_PRESET_FILE:{
  //      var xml2:Xml = Xml.parse(StringTools.htmlUnescape(xml.toString()));
  //      passPreset(xml2);
  //      
  //    }
  //  }
	//}

  private function onPassPreset(e:IKEvent):Void{

    var xml:Xml = Xml.parse(StringTools.htmlUnescape(e.getXml().toString()));

    trace('xml.toString()');
    var page_count:Int = 0;

    for( preset in xml.elementsNamed("preset") ) {
      for( title in preset.elementsNamed("title") ) {
        presetName = title.firstChild().nodeValue;
      }
      
      for(configurable_place in preset.elementsNamed("configurable-place") ) {
        var param:IParameter = new Parameter(EVENT_ID.BUILD_PAGE);
        param.setXml(configurable_place);
        param.setInt(page_count);
        dispatchParameter(param);
        page_count++;
      }

      page_count=0;
      
      for(product_place in preset.elementsNamed("product-place") ) {
        for(front_shoot in product_place.elementsNamed("front-shoot") ) {
          for(url in front_shoot.elementsNamed("url") ) {
            var param:IParameter = new Parameter(EVENT_ID.LOAD_FRONT_SHOT);
            param.setString(url.firstChild().nodeValue.toString());
            param.setInt(page_count);
            dispatchParameter(param);
          }
        }
        page_count++;
      }
      
      page_count  = 0;
      
      for(xml_data in preset.elementsNamed("xml-data") ) {

        for(page in xml_data.elementsNamed("page") ) {
          countPlaceHolders(page);
          var param:IParameter = new Parameter(EVENT_ID.PAGE_XML_LOADED);
          param.setXml(page);
          param.setInt(page_count);
          dispatchParameter(param);
          page_count++;
        }
        
        for( stage in xml_data.elementsNamed('stage') ) {
          //passStage(stage);
          var param:IParameter = new Parameter(EVENT_ID.LOAD_PAGE_POS_AND_ZOOM);
          param.setXml(stage);
          dispatchParameter(param);
        }
      }
      
      for( design in preset.elementsNamed("design") ) {
        //designs for the sidebar
        dispatchXML(EVENT_ID.PAGE_DESIGNS_LOADED, design);
      }
      
      for( user in preset.elementsNamed("user") ){
        GLOBAL.userParser.parseUser(user);
      }
    }
    
    var param:IParameter        = new Parameter(EVENT_ID.PLACEHOLDER_COUNT);
    param.setInt(placeholders);
    dispatchParameter(param);
  }
  
  private function countPlaceHolders(xml:Xml):Void{
    for( placeholder in xml.elementsNamed("placeholder") ) {
        placeholders++;
    }
  }
  

  //private function passUser(xml:Xml):Void{
  //  GLOBAL.userParser.parseUser(xml);
  //  
  //}
  
  private function buildPageData(page_id:Int):Void{
    
  }
	
	private function onSavedComplete(e:Event):Void{
		//trace('save completed');
	}
  
	private function onProductSelected(e:IKEvent){
	//	this.productXml = e.getXml();
	//	// save sibling selected in db field so fallback image can be loaded
	//	for( id in e.getXml().elementsNamed("id") ) {
	//		productSelected = id.firstChild().nodeValue;
  //
	//	}	
	}
	
//	public function getProductId():Int{
//		return productId;
//	}
}