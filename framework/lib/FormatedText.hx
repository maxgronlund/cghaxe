import flash.events.Event;
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.text.TextFieldType;
import flash.text.TextFormatAlign;

class FormatedText extends Sprite
{
	private var textField:TextField;
	private var text:String;
	private var format:TextFormat;
	private var fontSize:Int;
	private var ediable:Bool;
	
	public function new(font:String, text:String, fontSize:Int, ediable:Bool){
		super();
		this.text  = text;
		this.fontSize	= fontSize;

		format = new TextFormat();
		format.font = font;
		addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		this.ediable = ediable;

	}
	
	private function onAddedToStage( e:Event ): Void{

		removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		configureLabel();
		setLabel(text);
	}
	public function setLabel(str:String):Void {
	  textField.text = str;
	}
	
	private function configureLabel():Void {

		textField = new TextField();
		textField.useRichTextClipboard 	= ediable;
		textField.selectable 						= ediable;	 
		textField.border 								= false;
		textField.borderColor 					= 0x999999;
		textField.autoSize 							= TextFieldAutoSize.LEFT;
		textField.multiline 						= true;
		textField.background 						= false;
		
		format.color 										= 0x003400;
		format.size 										= fontSize;
		format.underline 								= false;
		textField.defaultTextFormat 		= format;
		
		addChild(textField);		
	}
	
	public function getText():String{
		return textField.text;
	}
	
	public function setFocus(b:Bool):Void{
		textField.border 	= b;
		textField.mouseEnabled = b;
	}
	
	public function setColor(color:UInt):Void{
		format.color 							= 0xFF0000;
		textField.textColor = color;
		//trace(format.color);
	}
	
//	public function getWidth( ): Float {
//		
//		return 2.0;
//	}
}