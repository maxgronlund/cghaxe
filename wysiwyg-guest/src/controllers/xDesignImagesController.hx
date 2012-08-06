class DesignImagesController extends Controller, implements IController{

  public function new(){	
  	super();
  }

  override public function setParam(param:IParameter):Void{
    switch ( param.getLabel() ){
      case EVENT_ID.SHOW_DESIGN_IMAGES:{
        GLOBAL.side_view.showView(EVENT_ID.SHOW_DESIGN_IMAGES, true);
      }
      case EVENT_ID.DESIGN_IMAGE_SELECTED:{
        trace('DESIGN_IMAGE_SELECTED');
        GLOBAL.design_images_view.setParam(param);
        DesignImages.setParam(param);
      }

      case EVENT_ID.ADD_DESIGN_IMAGE_TO_PAGE:{
        //trace('ADD_DESIGN_IMAGE_TO_PAGE');
        DesignImages.setParam(param);
      }
      case EVENT_ID.DESIGN_IMAGE_SCROLL:{
        GLOBAL.design_images_view.setFloat(EVENT_ID.DESIGN_IMAGE_SCROLL, param.getFloat());
      }
    }	
  }
  
  private function onScroll(param:IParameter):Void{
    switch ( param.getLabel() ){
      case EVENT_ID.DESIGN_IMAGE_SCROLL:{
        GLOBAL.design_images_view.setFloat(EVENT_ID.DESIGN_IMAGE_SCROLL, param.getFloat());
      }
    }	
	}
}
