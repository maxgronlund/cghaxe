package;

class SidebarController extends Controller, implements IController
{
	public function new(){	
		super();
	}
	
	override public function setString(id:String, s:String):Void{
		
		switch ( id ){
			case 'set_default_tool':{
				GLOBAL.side_view.setString('set_default_tool', 'na');
			}
      case EVENT_ID.SHOW_BLIND_VIEW:{
        GLOBAL.side_view.showView(EVENT_ID.SHOW_BLIND_VIEW, true);
      }
		}
	}
}