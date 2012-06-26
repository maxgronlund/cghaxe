


class XmlEncoder implements IEncoder, extends Encoder
{	
	
	public function new()
	{	
	//	super();	
	}
	
	override public function encode():Void{
		this.b = b;
	}
	
	override public function decode():Bool{
		return true;
	}

	
}