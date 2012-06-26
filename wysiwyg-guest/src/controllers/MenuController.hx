
class MenuController extends Controller, implements IController
{
	private var menuView:IView;
	public function new(){	
		super();
	}
	
//	override public function setParam(param:IParameter):Void{
//			switch ( param.getType() ){
//				case PARAM_TYPE.MENU:
//					onMenu(param);
//			}
//	}
	
	override public function setParam(param:IParameter):Void{
	  
	  trace(param.getLabel());
	  
    switch ( param.getLabel()){
      case EVENT_ID.SHOW_CARD:{
      	GLOBAL.menu_view.update(EVENT_ID.SHOW_CARD, 0, 'na');
      }
      case EVENT_ID.SHOW_INSERT:{
        GLOBAL.menu_view.update(EVENT_ID.SHOW_INSERT, 0, 'na');
      }
      case EVENT_ID.SHOW_ENVELOPE:{
      	GLOBAL.menu_view.update(EVENT_ID.SHOW_ENVELOPE, 0, 'na');
      }
      case EVENT_ID.SHOW_MASK:{
      	Pages.setParam(param);
      }
      case EVENT_ID.SAVE_XML:{
      	Pages.setParam(param);
      }
      case EVENT_ID.TRASH_PLACEHOLDER:{
        trace('TRASH_PLACEHOLDER');
        Pages.setParam(param);
      }
      
      case EVENT_ID.MOVE_TOOL:{
        Pages.setParam(param);
      }
      
    }	
	}
}
