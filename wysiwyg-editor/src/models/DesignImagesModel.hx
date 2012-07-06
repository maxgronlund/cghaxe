

import flash.events.Event;
import flash.Vector;

class DesignImagesModel extends Model, implements IModel {
  
  private var designImagesXml:Xml;

  public function new(){	
    super();
  }
    
 override public function init():Void{	
   super.init();
   //Application.addEventListener(EVENT_ID.PASS_DESIGN_FILE, onPassDesign);
 }
 
  override public function setParam(param:IParameter):Void{
    
    switch ( param.getLabel() ){
      case EVENT_ID.DESIGN_IMAGE_SELECTED:{
        //trace('DESIGN_SELECTED');
        designImagesXml = param.getXml();
      }
      case EVENT_ID.ADD_DESIGN_IMAGE_TO_PAGE:{
        trace('ADD_DESIGN_IMAGE_TO_PAGE');
        if(designImagesXml != null){
          dispatchXML(EVENT_ID.ADD_DESIGN_IMAGE_TO_PAGE, designImagesXml);
        }
      }
    }
  }
  
  override public function setString(id:String, s:String):Void{
    
     //switch ( id ){
     //  case 'countrxy':             { countrxy = s;}
     //}
  }
  
  override public function getString(id:String):String{
     //switch ( id ){
     //  case 'countrxy':            {return countrxy;}
     //  
     //}
     return '';
  }
  
  // to do 
  private function onPassDesignImage(e:IKEvent):Void{
    
    //trace('onPassDesign');
    var xml:Xml = Xml.parse(StringTools.htmlUnescape(e.getXml().toString()));
    //trace(xml.toString());

    
    //var param:IParameter = new Parameter(EVENT_ID.BUILD_DESIGN_PAGE);
    //param.setXml(xml);
    //param.setInt(0);
    //dispatchParameter(param);
    //  
    //  
    //
    //for( design in xml.elementsNamed("design") ) {
    //  for( img in design.elementsNamed("image-url") ) {
    //    var image_url:String        = Std.string(img.firstChild().nodeValue);
    //    var param:IParameter        = new Parameter(EVENT_ID.LOAD_FRONT_SHOT);
    //    param.setString(image_url);
    //    param.setInt(0);
    //    dispatchParameter(param);
    //  }
    //  
    //  for( xml_file in design.elementsNamed("xml-file") ) {
    //    for(page in xml_file.elementsNamed("page") ) {
    //      
    //      //trace(page.toString());
    //      var param:IParameter = new Parameter(EVENT_ID.PAGE_XML_LOADED);
    //      param.setXml(page);
    //      param.setInt(0);
    //      dispatchParameter(param);
    //  
    //    }
    //    
    //    for( stage in xml_file.elementsNamed('stage') ) {
    //      var param:IParameter = new Parameter(EVENT_ID.LOAD_PAGE_POS_AND_ZOOM);
    //      param.setXml(stage);
    //      dispatchParameter(param);
    //    }
    //  }
    //  
    //  for( user in design.elementsNamed("user") ){
    //    GLOBAL.userParser.parseUser(user);
    //  }
    //  
    //  for( design_images in design.elementsNamed("design-images") ){
    //    for( design_image in design_images.elementsNamed("design-image") ){
    //      for( image in design_image.elementsNamed("image") ){
    //        for( url in image.elementsNamed("url") ){
    //          trace(url.firstChild().nodeValue.toString());
    //          var param:IParameter = new Parameter(EVENT_ID.LOAD_PAGE_POS_AND_ZOOM);
    //          param.setString(url.firstChild().nodeValue.toString());
    //        }
    //      }
    //    }
    //  }
    //  
    //}
    
  }
  
  override public function getBool(id:String):Bool{
    //switch ( id ){
    //  case 'front_of_paper': true;
    //}
    return false;
  }
}