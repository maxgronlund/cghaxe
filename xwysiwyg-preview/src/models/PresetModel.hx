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
    
    trace('savePreset+++++++++++++++++++++++++++++++++++++++++++++++++');
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
        for(is_associated_product in configurable_place.elementsNamed("is-associated-product") ) {
          // store this somewhere
          if(is_associated_product.firstChild().nodeValue.toString() == 'true'){
            //trace('page is ass prod', page_index);
            //associatedProducts.push(page_index); //<<---------------- temp hack not working
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
            //trace('default ass prod', default_associated_id.firstChild().nodeValue.toString(), 'on page:', page_index);
          }
        }
        page_count++;
      }

      page_count=0;
      
      //for(product_place in preset.elementsNamed("product-place") ) {
      //  for(front_shoot in product_place.elementsNamed("front-shoot") ) {
      //    //trace(front_shoot.toString());
      //    //for(url in front_shoot.elementsNamed("url") ) {
      //    //  
      //    //  var param:IParameter = new Parameter(EVENT_ID.LOAD_FRONT_SHOT);
      //    //  param.setString(url.firstChild().nodeValue.toString());
      //    //  param.setInt(page_count);
      //    //  dispatchParameter(param);
      //    //}
      //    for(badge in front_shoot.elementsNamed("badge") ) { 
      //      for(url in badge.elementsNamed("url") ) {
      //        var param:IParameter = new Parameter(EVENT_ID.LOAD_FRONT_SHOT);
      //        param.setString(url.firstChild().nodeValue.toString());
      //        param.setInt(page_count);
      //        dispatchParameter(param);
      //      }
      //    }
      //  }
      //  page_count++;
      //}
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
        //trace(design.toString());
        // designs for the sidebar
        dispatchXML(EVENT_ID.PAGE_DESIGNS_LOADED, design);
      }
      
      for( user in preset.elementsNamed("user") ){
        passUser(user);
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
  
  //move this to stage
//  private function passStage(stage:Xml):Void{
//    var posX:Int;
//    var posY:Int;
//    var zoom:Float;
//    
//    for( stage_zoom in stage.elementsNamed('zoom') ) 
//      zoom = Std.parseFloat(stage_zoom.firstChild().nodeValue.toString());
//    
//    for( pos_x in stage.elementsNamed('pos_x') )
//      posX = Std.parseInt(pos_x.firstChild().nodeValue.toString());
//    
//    for( pos_y in stage.elementsNamed('pos_y') )
//      posY = Std.parseInt(pos_y.firstChild().nodeValue.toString());
//    
//    var point:Point = new Point(posX+1000,posY+1000);
//    var param:IParameter = new Parameter(EVENT_ID.LOAD_PAGE_POS_AND_ZOOM);
//    param.setPoint(point);
//    param.setFloat(zoom);
//    dispatchParameter(param);
//  }
  
  private function passUser(xml:Xml):Void{
    for( brides_first_name in xml.elementsNamed("brides-first-name") ){
      Designs.setString('brides_first_name', brides_first_name.firstChild().nodeValue.toString());
    }
    for( brides_last_name in xml.elementsNamed("brides-last-name") ){
      Designs.setString('brides_last_name', brides_last_name.firstChild().nodeValue.toString());
    }
    for( grooms_first_name in xml.elementsNamed("grooms-first-name") ){
      Designs.setString('grooms_first_name', grooms_first_name.firstChild().nodeValue.toString());
    }
    for( grooms_last_name in xml.elementsNamed("grooms-last-name") ){
      Designs.setString('grooms_last_name', grooms_last_name.firstChild().nodeValue.toString());
    }
    for( brides_initials in xml.elementsNamed("brides-initials") ){
      Designs.setString('brides_initials', brides_initials.firstChild().nodeValue.toString());
    }
    for( grooms_initials in xml.elementsNamed("grooms-initials") ){
      Designs.setString('grooms_initials', grooms_initials.firstChild().nodeValue.toString());
    } 
    for( wedding_date in xml.elementsNamed("wedding-date") ){
      Designs.setString('wedding_date', wedding_date.firstChild().nodeValue.toString());
    }
    for( wedding_time in xml.elementsNamed("wedding-time") ){
      Designs.setString('wedding_time', wedding_time.firstChild().nodeValue.toString());
    }
    for( church_name in xml.elementsNamed("church-name") ){
      Designs.setString('church_name', church_name.firstChild().nodeValue.toString());
    }
    for( church_location in xml.elementsNamed("church-location") ){
      Designs.setString('church_location', church_location.firstChild().nodeValue.toString());
    }
    for( party_place_name in xml.elementsNamed("party-place-name") ){
      Designs.setString('party_place_name', party_place_name.firstChild().nodeValue.toString());
    }
    for( party_place_location in xml.elementsNamed("party-place-location") ){
      Designs.setString('party_place_location', party_place_location.firstChild().nodeValue.toString());
    }
    for( reply_by_date in xml.elementsNamed("reply-by-date") ){
      Designs.setString('reply_by_date', reply_by_date.firstChild().nodeValue.toString());
    }
    for( reply_to_phone in xml.elementsNamed("reply-to-phone") ){
      Designs.setString('reply_to_phone', reply_to_phone.firstChild().nodeValue.toString());
    }
    for( reply_to_email in xml.elementsNamed("reply-to-email") ){
      Designs.setString('reply_to_email', reply_to_email.firstChild().nodeValue.toString());
    }
    for( dress_code in xml.elementsNamed("dress-code") ){
      Designs.setString('dress_code', dress_code.firstChild().nodeValue.toString());
    }
    for( company_name in xml.elementsNamed("company-name") ){
      Designs.setString('company_name', company_name.firstChild().nodeValue.toString());
    }
    for( location_name in xml.elementsNamed("location-name") ){
      Designs.setString('location_name', location_name.firstChild().nodeValue.toString());
    }
    for( location in xml.elementsNamed("location") ){
      Designs.setString('location', location.firstChild().nodeValue.toString());
    }
  }
  
  private function buildPageData(page_id:Int):Void{
    
  }
	
	private function onSavedComplete(e:Event):Void{
		trace('save completed');
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