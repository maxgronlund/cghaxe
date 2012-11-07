package;

class LanguageParser
{
  public function new(){
    
  }
  
  public function parse(xml_data:Xml):Void{
    
    GLOBAL.Application.setString(EVENT_ID.UPDATE_LOAD_PROGRESS,'Parsing Language');
    
    for(text in xml_data.elementsNamed("text") ) 
      TRANSLATION.text = text.firstChild().nodeValue.toString();

    for(id in xml_data.elementsNamed("id") ) 
      TRANSLATION.id = id.firstChild().nodeValue.toString();

    for(name in xml_data.elementsNamed("name") )
      TRANSLATION.name = name.firstChild().nodeValue.toString();

    for(front in xml_data.elementsNamed("front") ) 
      TRANSLATION.front = front.firstChild().nodeValue.toString();

    for(back in xml_data.elementsNamed("back") ) 
      TRANSLATION.back = back.firstChild().nodeValue.toString();

    for(envelope in xml_data.elementsNamed("envelope") ) 
      TRANSLATION.envelope = envelope.firstChild().nodeValue.toString();

    for(insert in xml_data.elementsNamed("insert") ) 
      TRANSLATION.insert = insert.firstChild().nodeValue.toString();

    for(text_button in xml_data.elementsNamed("text-button") ) 
      TRANSLATION.text_button = text_button.firstChild().nodeValue.toString();

    for(designs_button in xml_data.elementsNamed("designs-button") ) 
      TRANSLATION.designs_button = designs_button.firstChild().nodeValue.toString();

    for(text_color in xml_data.elementsNamed("text-color") ) 
      TRANSLATION.text_color = text_color.firstChild().nodeValue.toString();

    for(foil_color in xml_data.elementsNamed("foil-color") ) 
      TRANSLATION.foil_color = foil_color.firstChild().nodeValue.toString();

    for(greetings_button in xml_data.elementsNamed("greetings-button") ) 
      TRANSLATION.greetings_button = greetings_button.firstChild().nodeValue.toString();

    for(add_ons_button in xml_data.elementsNamed("add-ons-button") ) 
      TRANSLATION.add_ons_button = add_ons_button.firstChild().nodeValue.toString();

    for(save_button in xml_data.elementsNamed("save-button") ) 
      TRANSLATION.save_button = save_button.firstChild().nodeValue.toString();

    for(buy_button in xml_data.elementsNamed("buy-button") ) 
      TRANSLATION.buy_button = buy_button.firstChild().nodeValue.toString();

    for(standard_pms in xml_data.elementsNamed("standard-pms") ) 
      TRANSLATION.standard_pms = standard_pms.firstChild().nodeValue.toString();

    for(custom_pms_1 in xml_data.elementsNamed("custom-pms-1") ) 
      TRANSLATION.custom_pms_1 = custom_pms_1.firstChild().nodeValue.toString();

    for(custom_pms_2 in xml_data.elementsNamed("custom-pms-2") ) 
      TRANSLATION.custom_pms_2 = custom_pms_2.firstChild().nodeValue.toString();

    for(foil_color_picker in xml_data.elementsNamed("foil-color-picker") ) 
      TRANSLATION.foil_color_picker = foil_color_picker.firstChild().nodeValue.toString();

    for(digital_print_picker in xml_data.elementsNamed("laser-color-picker") ) 
      TRANSLATION.digital_print_picker = digital_print_picker.firstChild().nodeValue.toString();
      
    for(full_color_button in xml_data.elementsNamed("full-color-button") ) 
      TRANSLATION.full_color_button = full_color_button.firstChild().nodeValue.toString();

    for(upload_image in xml_data.elementsNamed("upload-image") ) 
      TRANSLATION.upload_image = upload_image.firstChild().nodeValue.toString();

    for(color_button in xml_data.elementsNamed("color-button") ) 
      TRANSLATION.color_button = color_button.firstChild().nodeValue.toString();

    for(print_button in xml_data.elementsNamed("print-button") ) 
      TRANSLATION.print_button = print_button.firstChild().nodeValue.toString();

    for(symbols_button in xml_data.elementsNamed("symbols-button") ) 
      TRANSLATION.symbols_button = symbols_button.firstChild().nodeValue.toString();

    for(price_button in xml_data.elementsNamed("price-button") ) 
      TRANSLATION.price_button = price_button.firstChild().nodeValue.toString();

    for(my_uploads_button in xml_data.elementsNamed("my-uploads-button") ) 
      TRANSLATION.my_uploads_button = my_uploads_button.firstChild().nodeValue.toString();

    for(line_space in xml_data.elementsNamed("line-space") ) 
      TRANSLATION.line_space = line_space.firstChild().nodeValue.toString();

    for(font_size in xml_data.elementsNamed("font_-size") ) 
      TRANSLATION.font_size = font_size.firstChild().nodeValue.toString();

    for(font_align in xml_data.elementsNamed("font-align") ) 
      TRANSLATION.font_align = font_align.firstChild().nodeValue.toString();

    for(select_font in xml_data.elementsNamed("select-font") ) 
      TRANSLATION.select_font = select_font.firstChild().nodeValue.toString();

    for(add_text_field in xml_data.elementsNamed("add-text-field") ) 
      TRANSLATION.add_text_field = add_text_field.firstChild().nodeValue.toString();

    for(upload_logo in xml_data.elementsNamed("upload-logo") ) 
      TRANSLATION.upload_logo = upload_logo.firstChild().nodeValue.toString();

    for(upload_image in xml_data.elementsNamed("upload-image") ) 
      TRANSLATION.upload_image = upload_image.firstChild().nodeValue.toString();

    for(add_logo in xml_data.elementsNamed("add-logo") ) 
      TRANSLATION.add_logo = add_logo.firstChild().nodeValue.toString();

    for(add_image in xml_data.elementsNamed("add-image") ) 
      TRANSLATION.add_image = add_image.firstChild().nodeValue.toString();

    for(total_price_label in xml_data.elementsNamed("total-price-label") ) 
      TRANSLATION.total_price_label = total_price_label.firstChild().nodeValue.toString();

    for(i_got_a_cliche in xml_data.elementsNamed("i-got-a-cliche") ) 
      TRANSLATION.i_got_a_cliche = i_got_a_cliche.firstChild().nodeValue.toString();

    for(card in xml_data.elementsNamed("card") ) 
      TRANSLATION.card = card.firstChild().nodeValue.toString();

    for(units in xml_data.elementsNamed("units") ) 
      TRANSLATION.units = units.firstChild().nodeValue.toString();
    
    for(logo in xml_data.elementsNamed("logo") ) 
      TRANSLATION.logo = logo.firstChild().nodeValue.toString();
      
    for(cliche in xml_data.elementsNamed("cliche") ) 
      TRANSLATION.cliche = cliche.firstChild().nodeValue.toString();
      
    GLOBAL.Application.setString(EVENT_ID.UPDATE_LOAD_PROGRESS,'Language Parsed');

  }
}