import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFieldType;
import flash.display.Sprite;
import flash.text.TextFieldAutoSize;

class PMSColorTextField extends Sprite {

	public var textField:TextField;
	
	public function new() {
		super();
		var format:TextFormat = new TextFormat();
        format.font="Helvetica";
        format.size=12;
        
		textField = new TextField();
		textField.setTextFormat(format);
		textField.defaultTextFormat = format;
		addChild(textField);
		textField.selectable = true;
		//textField.maxChars = 4;
		//textField.restrict = "0-9";
		textField.type = TextFieldType.INPUT;
		textField.restrict = "0-9 X";
		textField.border = false;
		textField.width = 125;
    textField.height = 18;
	}
	
	public function init():Void{
	  //setText("");
	}
	
	public function setText(string:String):Void{
	  textField.text = string;
	}
	
	public function getText():String{
	  return textField.text;
	}

}