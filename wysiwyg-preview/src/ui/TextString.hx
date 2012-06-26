import flash.text.TextField;
import flash.text.TextFormat;
import flash.display.Sprite;
import flash.text.TextFieldAutoSize;
//import flash.display.Shape;

class TextString extends Sprite {

	private var textField:TextField;
	
	public function new() {
		super();
	}
	
	public function init(fontSize:Int, width:Int, height:Int, fontName:String, mouseEnabled:Bool, autoSize:Bool):Void{
		
		textField 				= new TextField();
		addChild(textField);
		textField.embedFonts = true;
		var textFormat = new TextFormat(fontName);
		textFormat.size = fontSize;
		
		textField.defaultTextFormat = textFormat;
		textField.textColor = 0x000000;
		textField.mouseEnabled = mouseEnabled;
		if(autoSize)
			textField.autoSize = TextFieldAutoSize.LEFT ;
		else
			textField.width = width;
	}
	
	public function text(s:String):Void{
		textField.text = s;

	}
	
	public function color(col:Int = 0x00f7ff):Void{
		textField.textColor = col;
	}
	
	public function getWidth():Float{
		return textField.width;
	}

}

