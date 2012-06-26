

import flash.events.Event;
import flash.Vector;

class DesignsModel extends Model, implements IModel {
  
  private var pageDesignXml:Xml;
  
  private var brides_first_name:String;
  private var brides_last_name:String;
  private var grooms_first_name:String;
  private var grooms_last_name:String;
  private var brides_initials:String;
  private var grooms_initials:String;
  private var wedding_date:String;
  private var wedding_time:String;
  private var church_name:String;
  private var church_location:String;
  private var party_place_name:String;
  private var party_place_location:String;
  private var reply_by_date:String;
  private var reply_to_phone:String;
  private var reply_to_phone2:String;
  private var mobile:String;
  private var reply_to_email:String;
  private var dress_code:String;
  private var company_name:String;
  private var location_name:String;
  private var location:String;
  private var reply_to_people:String;
  private var reply_to_people2:String;
  private var dinner_place_name:String;
  private var city:String;
  private var countrxy:String;

  

  public function new(){	
    super();
  }
    
 override public function init():Void{	
   super.init();
   Application.addEventListener(EVENT_ID.PASS_DESIGN_FILE, onPassDesign);
 }
 
  override public function setParam(param:IParameter):Void{
    switch ( param.getLabel() ){
      case EVENT_ID.DESIGN_SELECTED:{
        //trace('DESIGN_SELECTED');
        pageDesignXml = param.getXml();
      }
      case EVENT_ID.ADD_DESIGN_TO_PAGE:{
        //trace('ADD_DESIGN_TO_PAGE');
        if(pageDesignXml != null){
          dispatchXML(EVENT_ID.ADD_DESIGN_TO_PAGE, pageDesignXml);
        }
      }
    }
  }
  
  override public function setString(id:String, s:String):Void{
    
     switch ( id ){
       case 'brides_first_name':    { brides_first_name = s;}
       case 'brides_last_name':     { brides_last_name = s;}
       case 'grooms_first_name':    { grooms_first_name = s;}
       case 'grooms_last_name':     { grooms_last_name = s;}
       case 'brides_initials':      { brides_initials = s;}
       case 'grooms_initials':      { grooms_initials = s;}
       case 'wedding_date':         { wedding_date = s;}
       case 'wedding_time':         { wedding_time = s;}
       case 'church_name':          { church_name = s;}
       case 'church_location':      { church_location = s;}
       case 'party_place_name':     { party_place_name = s;}          
       case 'party_place_location': { party_place_location = s;}
       case 'reply_by_date':        { reply_by_date = s;}
       case 'reply_to_phone':       { reply_to_phone = s;}
       case 'reply_to_phone2':      { reply_to_phone2 = s;}
       case 'mobile':               { mobile = s;}
       case 'reply_to_email':       { reply_to_email = s;}
       case 'dress_code':           { dress_code = s;}
       case 'company_name':         { company_name = s;}
       case 'location_name':        { location_name = s;}
       case 'location':             { location = s;}
       case 'reply_to_people':      { reply_to_people = s;}
       case 'reply_to_people2':     { reply_to_people2 = s;}
       case 'dinner_place_name':    { dinner_place_name = s;}
       case 'city':                 { city = s;}
       case 'countrxy':             { countrxy = s;}
       

     }
   }
  
   override public function getString(id:String):String{
      switch ( id ){
        case 'brides_first_name':   {return brides_first_name;}
        case 'brides_last_name':    {return brides_last_name;}
        case 'grooms_first_name':   {return grooms_first_name;}
        case 'grooms_last_name':    {return grooms_last_name;}
        case 'brides_initials':     {return brides_initials;}
        case 'grooms_initials':     {return grooms_initials;}
        case 'wedding_date':        {return wedding_date;}
        case 'wedding_time':        {return wedding_time;}
        case 'church_name':         {return church_name;}
        case 'church_location':     {return church_location;}
        case 'party_place_name':    {return party_place_name;}          
        case 'party_place_location':{return party_place_location;}
        case 'reply_by_date':       {return reply_by_date;}
        case 'reply_to_phone':      {return reply_to_phone;}
        case 'reply_to_phone2':     {return reply_to_phone2;}
        case 'mobile':              {return mobile;}
        case 'reply_to_email':      {return reply_to_email;}
        case 'dress_code':          {return dress_code;}
        case 'company_name':        {return company_name;}
        case 'location_name':       {return location_name;}
        case 'location':            {return location;}
        case 'reply_to_people':     {return reply_to_people;}
        case 'reply_to_people2':    {return reply_to_people2;}
        case 'dinner_place_name':   {return dinner_place_name;}
        case 'city':                {return city;}
        case 'countrxy':            {return countrxy;}
        
      }
      return '';
    }
    

  private function onPassDesign(e:IKEvent):Void{
    
    //trace('onPassDesign');
    var xml:Xml = Xml.parse(StringTools.htmlUnescape(e.getXml().toString()));
    //trace(xml.toString());

    
    var param:IParameter = new Parameter(EVENT_ID.BUILD_DESIGN_PAGE);
    param.setXml(xml);
    param.setInt(0);
    dispatchParameter(param);
      
      
    
    for( design in xml.elementsNamed("design") ) {
      for( img in design.elementsNamed("image-url") ) {
        var image_url:String        = Std.string(img.firstChild().nodeValue);
        var param:IParameter        = new Parameter(EVENT_ID.LOAD_FRONT_SHOT);
        param.setString(image_url);
        param.setInt(0);
        dispatchParameter(param);
      }
      
      for( xml_file in design.elementsNamed("xml-file") ) {
        for(page in xml_file.elementsNamed("page") ) {
          
          //trace(page.toString());
          var param:IParameter = new Parameter(EVENT_ID.PAGE_XML_LOADED);
          param.setXml(page);
          param.setInt(0);
          dispatchParameter(param);
      
        }
        
        for( stage in xml_file.elementsNamed('stage') ) {
          var param:IParameter = new Parameter(EVENT_ID.LOAD_PAGE_POS_AND_ZOOM);
          param.setXml(stage);
          dispatchParameter(param);
        }
      }
      
      for( user in design.elementsNamed("user") ){
        GLOBAL.userParser.parseUser(user);
      }
      
      for( design_images in design.elementsNamed("design-images") ){
        dispatchXML(EVENT_ID.DESIGN_IMAGES_LOADED, design_images);
        //for( design_image in design_images.elementsNamed("design-image") ){
        //  for( image in design_image.elementsNamed("image") ){
        //    for( url in image.elementsNamed("url") ){
        //      trace(url.firstChild().nodeValue.toString());
        //      var param:IParameter = new Parameter(EVENT_ID.ADD_DESIGN_IMAGE_BUTTON);
        //      param.setString(url.firstChild().nodeValue.toString());
        //      dispatchParameter(param);
        //    }
        //  }
        //}
      }
      
    }
    
  }
  
  override public function getBool(id:String):Bool{
    switch ( id ){
      case 'front_of_paper': true;
    }
    return false;
  }
}