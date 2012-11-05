class VectorsController extends Controller, implements IController{

  public function new(){	
  	super();
  }

  override public function setParam(param:IParameter):Void{
    switch ( param.getLabel() ){
      case EVENT_ID.SHOW_VECTORS:{
        GLOBAL.side_view.showView(EVENT_ID.SHOW_VECTORS, true);
      }
      case EVENT_ID.VECTOR_SELECTED:{
        GLOBAL.vectors_view.setParam(param);
        Vectors.setParam(param);
      }

      case EVENT_ID.ADD_VECTOR_TO_PAGE:{
        Vectors.setParam(param);
      }
      case EVENT_ID.VECTOR_SCROLL:{
        GLOBAL.vectors_view.setFloat(EVENT_ID.VECTOR_SCROLL, param.getFloat());
      }
    }	
  }
  
  private function onScroll(param:IParameter):Void{
    switch ( param.getLabel() ){
      case EVENT_ID.VECTOR_SCROLL:{
        GLOBAL.vectors_view.setFloat(EVENT_ID.VECTOR_SCROLL, param.getFloat());
      }
    }	
	}
}
