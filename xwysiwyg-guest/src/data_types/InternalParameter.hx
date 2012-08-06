package;

class InternalParameter implements IParameter, extends AParameter 
{
	public static inline var OPEN_TOOL_1:String = "open_tool_1";
	
	private var b:Bool;
	private var i:Int;
	
	public function new(label:String):Void
	{	
		super(label);	
		b = false;
	}
	override public function setBool(b:Bool):Void{
		this.b = b;
	}
	
	override public function getBool():Bool{
		return this.b;
	}
	
	override public function setInt(i:Int):Void{
		this.i = i;
	}
	override public function getInt():Int{
		return this.i;
	}
}