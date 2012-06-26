class LogoController extends Controller, implements IController{

		
	public function new(){	
		super();
	}

//	override public function setParam(param:IParameter):Void{
//			switch ( param.getType() ){
//				case PARAM_TYPE.SIDE_VIEW:
//					propertySelected(param);
//			}
//	}
//	
	override public function setParam(param:IParameter):Void{
		switch ( param.getLabel() )
		{
			case EVENT_ID.SHOW_LOGO:
				GLOBAL.side_view.showView(EVENT_ID.SHOW_LOGO, true);
		}	
	}

}