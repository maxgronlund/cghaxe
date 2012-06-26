package;

class MenuModel extends Model, implements IModel
{
	var toolSelected:String;
	var mask:Bool;
	
//	private var handToolSelected:Bool;
//	private var toolSelected:String;


	public function new(){	
		super();	
	}
	
	override public function init():Void{
		super.init();
		toolSelected = 'na';
		mask = false;
	}
	
	override public function setParam(param:IParameter):Void{
		switch(param.getLabel()){
//			case CONST.SAVE_PRESET:{ 	dispatchEvent(new KEvent(CONST.SAVE_PRESET, param));}
//			case CONST.HAND_TOOL:{toolSelected = CONST.HAND_TOOL;}
//			case CONST.TEXT_BOX_TOOL:{ toolSelected = CONST.TEXT_BOX_TOOL;}
//			case CONST.TEXT_TOOL:{ toolSelected = CONST.TEXT_TOOL;}
//			case CONST.IMAGE_TOOL:{ toolSelected = CONST.IMAGE_TOOL;}
			//case CONST.MASK_TOOL:{ 
			//	mask = param.getBool();
			//}
		}
		dispatchEvent(new KEvent(EVENT_ID.MENU, param));
	}
	
	override public function getString(s:String):String{
		
		//switch(s){
		//	case EVENT_ID.TOOL_SELECTED:
		//		return toolSelected;
		//}

		return 'na';
	}	
	

}


