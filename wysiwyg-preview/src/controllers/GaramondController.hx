
import flash.text.TextFormat;

class GaramondController extends Controller, implements IController
{

	private var color:UInt;
	private var fontSize:UInt;
	private var fontStyle:UInt;
	private var fontVariation:UInt;
		
	public function new(){	
		super();
	}

//	override public function setParam(param:IParameter):Void{
//		switch ( param.getType() ){
//			case PARAM_TYPE.SIDE_VIEW:
//				propertySelected(param);
//		}
////		trace(param.getDynamic().variation(0).font());  // store font size color etc here
////		textView.setParam(param);
//		
//
//		
////		Layout.setParam(param);
//		
//		
//	}
	
	override public function setParam(param:IParameter):Void{
		switch ( param.getLabel() )
		{
			case EVENT_ID.SHOW_GARAMOND:
				GLOBAL.side_view.showView(EVENT_ID.SHOW_GARAMOND, true);
		}	
	}
}