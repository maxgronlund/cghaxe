class DesignsController extends Controller, implements IController{

  public function new(){	
  	super();
  }

  override public function setParam(param:IParameter):Void{
    switch ( param.getLabel() ){
      case EVENT_ID.SHOW_PAGE_DESIGN:{
        GLOBAL.side_view.showView(EVENT_ID.SHOW_PAGE_DESIGN, true);
      }

      case EVENT_ID.DESIGN_SELECTED:{
        trace('DESIGN_SELECTED');
        GLOBAL.designs_view.setParam(param);
        Designs.setParam(param);
      }

      case EVENT_ID.ADD_DESIGN_TO_PAGE:{
        trace('ADD_DESIGN_TO_PAGE');
        Designs.setParam(param);
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
