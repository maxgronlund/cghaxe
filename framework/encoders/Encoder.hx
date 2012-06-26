// Abstract class for encoders
package;


class Encoder 
{
	// Abstract methods
	public function encode():Void{
		trace("setFloat: must be overriden in a subclass");
	}
	public function decode():Void{
		trace("getFloat: must be overriden in a subclass");
		return 0;
	}
	
	private function OnXmlLoaded(e:Event):Void{
		
		trace(OnXmlLoaded);
		var xml:Xml = Xml.parse(e.target.data);
		trace(xml);
		
	}
	
	
}


