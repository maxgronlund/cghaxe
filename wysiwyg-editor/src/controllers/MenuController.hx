
class MenuController extends Controller, implements IController
{
	private var menuView:IView;
	public function new(){	
		super();
	}
	private function onSelectMoveTool(e:IKEvent):Void{

	 setParam(new Parameter(EVENT_ID.MOVE_TOOL));
  }

	
	override public function setParam(param:IParameter):Void{
	  
	  //trace(param.getLabel());
	  
    switch ( param.getLabel()){

      case EVENT_ID.SHOW_MASK: Pages.setParam(param);
      case EVENT_ID.SAVE_XML: Pages.setParam(param);
      case EVENT_ID.BUY_NOW: Pages.setParam(param);
      case EVENT_ID.TRASH_PLACEHOLDER:{
        Pages.setParam(param);
      }

      case EVENT_ID.GRID_ON:{
        Application.dispatchParameter(param);
      }
      
    }	
	}
}
