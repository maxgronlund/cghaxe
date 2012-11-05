class DesignsController extends Controller, implements IController{

  public function new(){	
  	super();
  }

  override public function setParam(param:IParameter):Void{
    switch ( param.getLabel() ){
      case EVENT_ID.SHOW_DESIGNS:{
        GLOBAL.side_view.showView(EVENT_ID.SHOW_DESIGNS, true);
      }

      case EVENT_ID.DESIGN_SELECTED:{
        GLOBAL.designs_view.setParam(param);
        Designs.setParam(param);
        //GLOBAL.designs_view.setInt(EVENT_ID.DESIGN_SELECTED, param.getInt());
      }

      case EVENT_ID.ADD_DESIGN_TO_PAGE:{
        Designs.setParam(param);
      }
      case EVENT_ID.DESIGN_SCROLL:{
        GLOBAL.designs_view.setFloat(EVENT_ID.DESIGN_SCROLL, param.getFloat());
      }
    }	
  }
  
  private function onScroll(param:IParameter):Void{
    switch ( param.getLabel() ){
      case EVENT_ID.DESIGN_SCROLL:{
        GLOBAL.designs_view.setFloat(EVENT_ID.DESIGN_SCROLL, param.getFloat());
      }
    }	
	}
}
