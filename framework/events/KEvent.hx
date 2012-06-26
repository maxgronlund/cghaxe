import flash.text.TextFormat;
import flash.geom.Point;

class KEvent implements IKEvent, extends AEvent
{
	public static inline var PARAMETER:String = "parameter_event";
	public static inline var STRING:String = "string_event";
	public static inline var XML:String = "xml_event";
	public static inline var UI:String = "ui_event";
	public static inline var DYNAMIC:String = "dynamic_event";
	
	private var param:IParameter;

	public function new( label:String, param:IParameter, bubbles:Bool = false, cancelable:Bool = false ) {
		super( label ,bubbles, cancelable);
		this.param = param;
	}
	

// getters	
	override public function getLabel():String{return param.getLabel();}
	override public function getFloat():Float{return param.getFloat();	}
	override public function getInt():Int{return param.getInt();}
	override public function getString():String{return param.getString();}
	override public function getBool():Bool{return param.getBool();}
	override public function getXml():Xml{return param.getXml();}
	override public function getDynamic():Dynamic{return param.getDynamic;}
	override public function getParam():IParameter{return param;}
	override public function getPoint():Point{return param.getPoint();}
//	override public function getType():String{return param.getType();}
	override public function getFontPackage():FontPackage{return param.getFontPackage();}

	
}