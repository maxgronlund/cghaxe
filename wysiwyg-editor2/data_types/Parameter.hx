import flash.geom.Point;
import flash.text.TextFormat;

class Parameter  implements IParameter, extends AParameter 
{

	private var label:String;
	private var f:Float;
	private var i:Int;
	private var ui:UInt;
	private var b:Bool;
	private var s:String;
	private var xml:Xml;
	private var obj:Dynamic;
	private var model:IModel;
	private var point:Point;
	private var fontPackage:FontPackage;
	


	public function new(label:String ):Void{
		this.label = label;
		this.i = -1;
		this.b = false;
		this.ui = 0x000000;
	//	this.paramType = paramType;
	}
	
// setters
	override public function setLabel(label:String):Void{
		this.label = label;
	}
	override public function setFloat(f:Float):Void{
		this.f = f;
	}
	override public function setInt(i:Int):Void{
		this.i = i;
	}
	override public function setUInt(ui:UInt):Void{
		this.ui = ui;
	}
	override public function setBool(b:Bool):Void{
		this.b = b;
	}
  override public function setString(s:String):Void{
		this.s = s;
	}	
	override public function setDynamic(obj:Dynamic):Void{
		this.obj = obj;
	}
	override public function setXml(xml:Xml):Void{
		this.xml = xml;
	}
	override public function setModel(model:IModel):Void{
		this.model = model;
	}
	override public function setPoint(point:Point):Void{
		this.point = point;
	}
	
	override public function setFontPackage(fontPackage:FontPackage):Void{
		this.fontPackage = fontPackage;
	}
	
// getters
	override public function getLabel():String{
		return label;
	}
	override public function getFloat():Float{
		return f;
	}
	override public function getInt():Int{
		return i;
	}
	override public function getUInt():UInt{
		return ui;
	}
	override public function getBool():Bool{
		return b;
	}
	override public function getString():String{
		return s;
	}
	override public function getDynamic():Dynamic{
		return obj;
	}
	override public function getXml():Xml{
		return xml;
	}
//	override public function getType():String{
//		return paramType;
//	}
	
	override public function getModel():IModel{
		return model;
	}
	
	override public function getPoint():Point{
		return point;
	}
	
	override public function getFontPackage():FontPackage{
		return fontPackage;
	}
}