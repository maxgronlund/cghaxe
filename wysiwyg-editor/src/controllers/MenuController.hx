
class MenuController extends Controller, implements IController
{
	private var menuView:IView;
	public function new(){	
		super();
		
		//Application.addEventListener(EVENT_ID.SELECT_MOVE_TOOL, onSelectMoveTool);
	}
	private function onSelectMoveTool(e:IKEvent):Void{
	  trace('onSelectMoveTool');
	 //moveButton.setOn(true);
	 
	 setParam(new Parameter(EVENT_ID.MOVE_TOOL));
  }
//	override public function setParam(param:IParameter):Void{
//			switch ( param.getType() ){
//				case PARAM_TYPE.MENU:
//					onMenu(param);
//			}
//	}
	
	override public function setParam(param:IParameter):Void{
	  
	  //trace(param.getLabel());
	  
    switch ( param.getLabel()){
      case EVENT_ID.SHOW_CARD: 	GLOBAL.menu_view.update(EVENT_ID.SHOW_CARD, 0, 'na');
      case EVENT_ID.SHOW_INSERT: GLOBAL.menu_view.update(EVENT_ID.SHOW_INSERT, 0, 'na');
      //case EVENT_ID.SHOW_ENVELOPE: GLOBAL.menu_view.update(EVENT_ID.SHOW_ENVELOPE, 0, 'na');
      case EVENT_ID.SHOW_MASK: Pages.setParam(param);
      case EVENT_ID.SAVE_XML: Pages.setParam(param);
      case EVENT_ID.TRASH_PLACEHOLDER: Pages.setParam(param);
      //case EVENT_ID.MOVE_TOOL:{
      //  //GLOBAL.MOVE_TOOL = param.getBool();
      //  Pages.setParam(param);
      //  GLOBAL.menu_view.update(EVENT_ID.MOVE_TOOL, 0, 'foo');
      //  GLOBAL.MOVE_TOOL = true;
      //  //Application.dispatchParameter(new Parameter(EVENT_ID.RESET_STAGE_SIZE));
      //}
      //case EVENT_ID.TEXT_TOOL:{
      //  GLOBAL.MOVE_TOOL = false;
      //  Pages.setParam(param);
      //  GLOBAL.menu_view.update(EVENT_ID.TEXT_TOOL, 0, 'foo');
      //  //Application.dispatchParameter(new Parameter(EVENT_ID.RESET_STAGE_SIZE));
      //}
      case EVENT_ID.GRID_ON:{
        Application.dispatchParameter(param);
      }
      
    }	
	}
}
