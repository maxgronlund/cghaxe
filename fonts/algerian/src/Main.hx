import flash.display.MovieClip;
import flash.Lib;

class Main extends MovieClip{
	
	private var formatedText:FormatedText;
	
	static function main(){
		
		new Main();
	}
	
	public function new(){	
		
		super();
		Lib.current.algerian = this;																	//<<------- CHANGE HERE
	}
	
	public function init(defaultText:String, fontSize:Int):Void{
		
		formatedText = new FormatedText('algerian',defaultText, fontSize, true);			//<<------- CHANGE HERE
		Lib.current.addChild(formatedText);

	}
	
	public function getText():String{
		
		return formatedText.getText();
	}
	
	public function setFocus(b:Bool):Void{
		
		formatedText.setFocus(b);
	}

}
