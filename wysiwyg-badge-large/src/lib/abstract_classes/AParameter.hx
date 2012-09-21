import flash.geom.Point;
import flash.text.TextFormat;


class AParameter 
{
// setters
	public function setLabel(label:String):Void{
		trace("setLabel: must be overriden in a subclass");
	}		
	public function setFloat(f:Float):Void{
		trace("setFloat: must be overriden in a subclass");
	}
	public function setInt(i:Int):Void{
		trace("setInt: must be overriden in a subclass");
	}
	public function setUInt(ui:UInt):Void{
		trace("setUInt: must be overriden in a subclass");
	}
	public function setBool(b:Bool):Void{
		trace("setFloat: must be overriden in a subclass");
	}
	public function setString(str:String):Void{
		trace("setString: must be overriden in a subclass");
	}
	public function setDynamic(obj:Dynamic):Void{
		trace("setDynamic: must be overriden in a subclass");
	}
	public function setXml(xml:Xml):Void{
		trace("setXml: must be overriden in a subclass");
	}
	public function setModel(model:IModel):Void{
		trace("setModel: must be overriden in a subclass");
	}
	public function setPoint(point:Point):Void{
		trace("setPoint: must be overriden in a subclass");
	}
	
	public function setFontPackage(fontPackage:FontPackage):Void{
		trace("setFontStruct: must be overriden in a subclass");
	}
// getters
	public function getLabel():String{
		trace("getLabel: must be overriden in a subclass");
		return null;
	}
	public function getFloat():Float{
		trace("getFloat: must be overriden in a subclass");
		return 0;
	}
	public function getInt():Int{
		trace("getInt: must be overriden in a subclass");
		return 0;
	}
	public function getUInt():UInt{
		trace("getUInt: must be overriden in a subclass");
		return 0;
	}
	public function getBool():Bool{
		trace("getBool: must be overriden in a subclass");
		return false;
	}
	public function getString():String{
		trace("getString: must be overriden in a subclass");
		return null;
	}
	public function getDynamic():Dynamic{
		trace("getDynamic: must be overriden in a subclass");
		return null;
	}
	public function getXml():Xml{
		trace("getXml: must be overriden in a subclass");
		return null;
	}
	
	public function getType():String{
		trace("getType: must be overriden in a subclass");
		return null;
	}
	
	public function getModel():IModel{
		trace("getModel: must be overriden in a subclass");
		return null;
	}
	
	public function getPoint():Point{
		trace("getModel: must be overriden in a subclass");
		return null;
	}
	public function getFontPackage():FontPackage{
		trace("getFontPackage: must be overriden in a subclass");
		return null;
	}
}


