class FontStruct {

	
	public var styleName(default, setStyleName): String;
	function setStyleName(s) return styleName = s
	
	public var defaultSize(default, setDefaultSize): Int;
	function setDefaultSize(i) return defaultSize = i
	
	public var fileName(default, setFileName): String;
	function setFileName(s) return fileName = s
	
	public var letterSpacing(default, setletterSpacing): Int;
	function setletterSpacing(i) return letterSpacing = i
	
	
	
	// add color and align here
	
	public function new( styleName:String, defaultSize:Int, fileName:String):Void{
		this.styleName 						= styleName;
		this.defaultSize 					= defaultSize;
		this.fileName 						= fileName;
		this.letterSpacing        = 0;
	}
}