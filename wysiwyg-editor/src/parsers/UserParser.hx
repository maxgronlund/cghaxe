package;

class UserParser {

  //private var fontScrollPane:AView;
  private var Designs:IModel;
  private var defaultUser:Bool;
  
  public function new(){
    Designs = GLOBAL.Designs;
    defaultUser = true;
  }
  public function parseUser(xml:Xml):Void{
    //first the default user is loaded
    

    for( brides_first_name in xml.elementsNamed("brides-first-name") ){
      if(GLOBAL.params.brides_first_name != null)
        Designs.setString('brides_first_name', brides_first_name.firstChild().nodeValue.toString());      
    }
    for( brides_last_name in xml.elementsNamed("brides-last-name") ){
        Designs.setString('brides_last_name', brides_last_name.firstChild().nodeValue.toString());
    }
    for( grooms_first_name in xml.elementsNamed("grooms-first-name") ){
      if(GLOBAL.params.grooms_first_name != null)
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
      if(Designs.getString('wedding_date') != GLOBAL.params.wedding_date)
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
    for( mobile in xml.elementsNamed("mobile") ){
       Designs.setString('mobile', mobile.firstChild().nodeValue.toString());
    }
    for( reply_to_phone in xml.elementsNamed("reply-to-phone") ){
      Designs.setString('reply_to_phone', reply_to_phone.firstChild().nodeValue.toString());
    }
    for( reply_to_phone2 in xml.elementsNamed("reply-to-phone2") ){
      Designs.setString('reply_to_phone2', reply_to_phone2.firstChild().nodeValue.toString());
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
      if(Designs.getString('location_name') != GLOBAL.params.location_name)
        Designs.setString('location_name', location_name.firstChild().nodeValue.toString());
    }
    for( location in xml.elementsNamed("location") ){
        Designs.setString('location', location.firstChild().nodeValue.toString());
    }
    for( dinner_place_name in xml.elementsNamed("dinner-place-name") ){
      Designs.setString('dinner_place_name', dinner_place_name.firstChild().nodeValue.toString());
    }
    for( reply_to_people in xml.elementsNamed("reply-to-people") ){
      Designs.setString('reply_to_people', reply_to_people.firstChild().nodeValue.toString());
    }
    for( reply_to_people2 in xml.elementsNamed("reply-to-people2") ){
      Designs.setString('reply_to_people2', reply_to_people2.firstChild().nodeValue.toString());
    }
    for( city in xml.elementsNamed("city") ){
      Designs.setString('city', city.firstChild().nodeValue.toString());
    }
    for( countrxy in xml.elementsNamed("countrxy") ){
      Designs.setString('countrxy', countrxy.firstChild().nodeValue.toString());
    }
    
    // then the customor is loaded
    defaultUser = false;
  }

}