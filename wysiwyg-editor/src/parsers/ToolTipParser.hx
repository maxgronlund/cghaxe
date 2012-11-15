package;

class ToolTipParser
{
  public function new(){
    
  }
  
  public function parse(xml_data:Xml):Void{

    GLOBAL.Application.setString(EVENT_ID.UPDATE_LOAD_PROGRESS,'Parsing Tool Tips');
    
    for( color_4_pms_body in xml_data.elementsNamed("color-4-pms-body") ) 
      TOOL_TIPS.color_4_pms_body = color_4_pms_body.firstChild().nodeValue.toString();

    for(color_4_pms_link in xml_data.elementsNamed("color-4-pms-link") ) 
      TOOL_TIPS.color_4_pms_link = color_4_pms_link.firstChild().nodeValue.toString();

    for(color_4_pms_title in xml_data.elementsNamed("color-4-pms-title") )
      TOOL_TIPS.color_4_pms_title = color_4_pms_title.firstChild().nodeValue.toString();

    for(color_custom_pms_1_body in xml_data.elementsNamed("color-custom-pms-1-body") ) 
      TOOL_TIPS.color_custom_pms_1_body = color_custom_pms_1_body.firstChild().nodeValue.toString();

    for(color_custom_pms_1_link in xml_data.elementsNamed("color-custom-pms-1-link") ) 
      TOOL_TIPS.color_custom_pms_1_link = color_custom_pms_1_link.firstChild().nodeValue.toString();

    for(color_custom_pms_1_title in xml_data.elementsNamed("color-custom-pms-1-title") ) 
      TOOL_TIPS.color_custom_pms_1_title = color_custom_pms_1_title.firstChild().nodeValue.toString();

    for(color_custom_pms_2_body in xml_data.elementsNamed("color-custom-pms-2-body") ) 
      TOOL_TIPS.color_custom_pms_2_body = color_custom_pms_2_body.firstChild().nodeValue.toString();

    for(color_custom_pms_2_link in xml_data.elementsNamed("color-custom-pms-2-link") ) 
      TOOL_TIPS.color_custom_pms_2_link = color_custom_pms_2_link.firstChild().nodeValue.toString();

    for(color_custom_pms_2_title in xml_data.elementsNamed("color-custom-pms-2-title") ) 
      TOOL_TIPS.color_custom_pms_2_title = color_custom_pms_2_title.firstChild().nodeValue.toString();

    for(color_foil_body in xml_data.elementsNamed("color-foil-body") ) 
      TOOL_TIPS.color_foil_body = color_foil_body.firstChild().nodeValue.toString();

    for(color_foil_link in xml_data.elementsNamed("color-foil-link") ) 
      TOOL_TIPS.color_foil_link = color_foil_link.firstChild().nodeValue.toString();

    for(color_foil_title in xml_data.elementsNamed("color-foil-title") ) 
      TOOL_TIPS.color_foil_title = color_foil_title.firstChild().nodeValue.toString();

    for(color_std_pms_body in xml_data.elementsNamed("color-std-pms-body") ) 
      TOOL_TIPS.color_std_pms_body = color_std_pms_body.firstChild().nodeValue.toString();

    for(color_std_pms_link in xml_data.elementsNamed("color-std-pms-link") ) 
      TOOL_TIPS.color_std_pms_link = color_std_pms_link.firstChild().nodeValue.toString();

    for(color_std_pms_title in xml_data.elementsNamed("color-std-pms-title") ) 
      TOOL_TIPS.color_std_pms_title = color_std_pms_title.firstChild().nodeValue.toString();

    for(greetings_add_body in xml_data.elementsNamed("greetings-add-body") ) 
      TOOL_TIPS.greetings_add_body = greetings_add_body.firstChild().nodeValue.toString();

    for(greetings_add_link in xml_data.elementsNamed("greetings-add-link") ) 
      TOOL_TIPS.greetings_add_link = greetings_add_link.firstChild().nodeValue.toString();

    for(greetings_add_title in xml_data.elementsNamed("greetings-add-title") ) 
      TOOL_TIPS.greetings_add_title = greetings_add_title.firstChild().nodeValue.toString();

    for(my_uploads_add_title in xml_data.elementsNamed("my-uploads-add-title") ) 
      TOOL_TIPS.my_uploads_add_title = my_uploads_add_title.firstChild().nodeValue.toString();

    for(my_uploads_add_body in xml_data.elementsNamed("my-uploads-add-body") ) 
      TOOL_TIPS.my_uploads_add_body = my_uploads_add_body.firstChild().nodeValue.toString();
      
    for(my_uploads_add_link in xml_data.elementsNamed("my-uploads-add-link") ) 
      TOOL_TIPS.my_uploads_add_link = my_uploads_add_link.firstChild().nodeValue.toString();

    for(my_uploads_upload_title in xml_data.elementsNamed("my-uploads-upload-title") ) 
      TOOL_TIPS.my_uploads_upload_title = my_uploads_upload_title.firstChild().nodeValue.toString();

    for(my_uploads_upload_body in xml_data.elementsNamed("my-uploads-upload-body") ) 
      TOOL_TIPS.my_uploads_upload_body = my_uploads_upload_body.firstChild().nodeValue.toString();

    for(my_uploads_upload_link in xml_data.elementsNamed("my-uploads-upload-link") ) 
      TOOL_TIPS.my_uploads_upload_link = my_uploads_upload_link.firstChild().nodeValue.toString();

    for(symbols_add_body in xml_data.elementsNamed("symbols-add-body") ) 
      TOOL_TIPS.symbols_add_body = symbols_add_body.firstChild().nodeValue.toString();

    for(symbols_add_link in xml_data.elementsNamed("symbols-add-link") ) 
      TOOL_TIPS.symbols_add_link = symbols_add_link.firstChild().nodeValue.toString();

    for(symbols_add_title in xml_data.elementsNamed("symbols-add-title") ) 
      TOOL_TIPS.symbols_add_title = symbols_add_title.firstChild().nodeValue.toString();

    for(text_add_body in xml_data.elementsNamed("text-add-body") ) 
      TOOL_TIPS.text_add_body = text_add_body.firstChild().nodeValue.toString();

    for(text_add_link in xml_data.elementsNamed("text-add-link") ) 
      TOOL_TIPS.text_add_link = text_add_link.firstChild().nodeValue.toString();

    for(text_add_title in xml_data.elementsNamed("text-add-title") ) 
      TOOL_TIPS.text_add_title = text_add_title.firstChild().nodeValue.toString();

    for(text_fixed_size_body in xml_data.elementsNamed("text-fixed-size-body") ) 
      TOOL_TIPS.text_fixed_size_body = text_fixed_size_body.firstChild().nodeValue.toString();

    for(text_fixed_size_link in xml_data.elementsNamed("text-fixed-size-link") ) 
      TOOL_TIPS.text_fixed_size_link = text_fixed_size_link.firstChild().nodeValue.toString();

    for(text_fixed_size_title in xml_data.elementsNamed("text-fixed-size-title") ) 
      TOOL_TIPS.text_fixed_size_title = text_fixed_size_title.firstChild().nodeValue.toString();

    for(text_resizable_body in xml_data.elementsNamed("text-resizable-body") ) 
      TOOL_TIPS.text_resizable_body = text_resizable_body.firstChild().nodeValue.toString();

    for(text_resizable_link in xml_data.elementsNamed("text-resizable-link") ) 
      TOOL_TIPS.text_resizable_link = text_resizable_link.firstChild().nodeValue.toString();

    for(text_resizable_title in xml_data.elementsNamed("text-resizable-title") ) 
      TOOL_TIPS.text_resizable_title = text_resizable_title.firstChild().nodeValue.toString();

    GLOBAL.Application.setString(EVENT_ID.UPDATE_LOAD_PROGRESS,'Tool Tips Parsed');
    
  }
}