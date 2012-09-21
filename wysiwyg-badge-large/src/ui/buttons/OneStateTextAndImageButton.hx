import flash.events.Event;
import flash.events.MouseEvent;
import flash.display.Bitmap;
import flash.geom.Point;

class OneStateTextAndImageButton extends OneStateButton
{	
	private var formattedText:FormatedText;
	private var labelText:String;
	private var onStage:Bool;

	public function new(){
		super();
    labelText = 'na';
		formattedText 	= new FormatedText('helvetica', 'text', 12, false);
		onStage = false;
	}

	override private function onMouseDown(e:MouseEvent){	
		super.onMouseDown(e); 
		setState(2);
	}

	override private function onMouseUp(e:MouseEvent){
		super.onMouseUp(e); 
	}

	public function setText(s:String):Void{
    labelText = s;
	}
	public function updateLabel():Void{
    formattedText.setLabel(labelText);
	}

	override private function onAddedToStage(e:Event):Void{	
		
		super.onAddedToStage(e);
		addChild(formattedText);
		formattedText.setLabel(labelText);
		formattedText.x = 4;
		formattedText.y = 6;
		onStage = true;
	}
}