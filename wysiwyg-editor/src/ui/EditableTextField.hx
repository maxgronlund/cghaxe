import flash.text.TextField;
import flash.text.TextFormat;
import flash.events.Event;
import flash.events.FocusEvent;
import flash.text.TextFieldType;
import flash.display.Sprite;
import flash.text.TextFieldAutoSize;

class EditableTextField extends Sprite {

	private var textField:TextField;
	
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
		textField.maxChars = 4;
		textField.restrict = "0-9";
		textField.type = TextFieldType.INPUT;
		textField.addEventListener(Event.CHANGE,onChange);
		textField.addEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
	}
	
	public function onChange(e:Event):Void{
	  update();
	}
	
	public function update():Void{
	  if(getQuantity() >= GLOBAL.min_quantity){
	    GLOBAL.preset_quantity = Std.string(getQuantity());
  	  GLOBAL.Pages.calculatePrice();
	  }
	}
	
	public function onFocusOut(e:FocusEvent):Void{
	  if(textField.text == ""){
  	  textField.text = Std.string(GLOBAL.preset_quantity);
  	}
  	if(Std.parseInt(textField.text) < GLOBAL.min_quantity){
  	  textField.text = Std.string(GLOBAL.min_quantity);
  	}
  	update();
	}
	
	public function init():Void{
	  textField.text = Std.string(GLOBAL.preset_quantity);
	}
	
	public function getQuantity():UInt{
	  var amount:UInt = Std.parseInt(textField.text);
	  if(amount == 0){
	    amount = Std.parseInt(GLOBAL.preset_quantity);
	  }
	  return amount;
	}

}