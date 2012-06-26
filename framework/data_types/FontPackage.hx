import flash.Vector;

class FontPackage
{
	public var screenName(default, setScreenName): String;
	function setScreenName(s) return screenName = s
	
	
	
	private var fonts:Vector<FontStruct>;
	private var id:Int;

	
	public function new(screenName:String){
		this.screenName = screenName;
		fonts = new Vector<FontStruct>();
		id = 0;
	}
	
	public function addFont(styleName:String, defaultSize:Int, fileName:String):Void{
		var fontStruct:FontStruct;
		fontStruct = new FontStruct( styleName, defaultSize, fileName);
		fonts.push(fontStruct);
		
	}
	
	public function styles():Int{
	//	trace('onStyles');
		return fonts.length;
	}
	
	public function fontStruct(id:Int):FontStruct{
		if(id > fonts.length-1) 
			id = (fonts.length-1);
		return fonts[id];
	}

	public function styleName(i:Int):String{
		return fontStruct(i).styleName;
	}
	
	public function fileName(i:Int):String{
		return fontStruct(i).fileName;
	}
	
	public function defaultSize(i:Int):Int{
		return fontStruct(i).defaultSize;
	}
	

}