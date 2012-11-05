
import flash.text.TextFormat;

class TextSuggestionController extends Controller, implements IController{

  public function new(){	
    super();
  }
  
  override public function setParam(param:IParameter):Void{

    switch ( param.getLabel() )
    {
      case EVENT_ID.SHOW_TEXT_SUGGESTIONS:{
        GLOBAL.side_view.showView(EVENT_ID.SHOW_TEXT_SUGGESTIONS, true);
      }
      case EVENT_ID.TEXT_SUGGESTION_SELECTED:{
        for(place_holder_text in param.getXml().elementsNamed('place-holder-text')){
          TEXT_SUGGESTION.text = place_holder_text.firstChild().nodeValue.toString();
        }
        GLOBAL.text_suggestion_view.setParam(param);
      }
      
      case EVENT_ID.ADD_TEXT_SUGGESTION:{
        Designs.dispatchParameter(param);
      }
      case EVENT_ID.SUGGESTION_SCROLL:{
        GLOBAL.text_suggestion_view.setFloat(EVENT_ID.SUGGESTION_SCROLL, param.getFloat());
      }
      
    }	
  }

  private function onScroll(param:IParameter):Void{
    switch ( param.getLabel() ){
      case EVENT_ID.FONT_SCROLL:{
        GLOBAL.text_suggestion_view.setFloat(EVENT_ID.FONT_SCROLL, param.getFloat());
      }
    }	
	}
}