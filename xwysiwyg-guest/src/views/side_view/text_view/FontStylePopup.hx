import flash.display.Sprite;
import flash.events.Event;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.Vector;



class FontStylePopup extends AView {
	
	private var dropDownMenu:DropDownMenu;

	public function new(textController:IController) {
		super(textController);
		dropDownMenu = new DropDownMenu( textController, 
																			new FontStylePopupBitmap(), 
																			new Parameter('foo'),
																			104, 120);
																			
		addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
	}
	
	override public function onAddedToStage(e:Event){
		removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		addChild(dropDownMenu);
	}
	
	override public function setParam( param:IParameter ): Void{
		addFontStyle(param.getFontPackage());
	}
	

	
	private function addFontStyle(fontPackage:FontPackage):Void{
		
		
		dropDownMenu.removeItems();
		
	//	trace(fontPackage.styles());
		
		for (i in 0...fontPackage.styles()){
			
			var param = new Parameter( EVENT_ID.FONT_STYLE);
			param.setString(fontPackage.fontStruct(i).fileName);
			param.setInt(i);
			
			dropDownMenu.addItem( param, fontPackage.fontStruct(i).styleName);
		}
		dropDownMenu.selectItem(0);
	}
	
	public function deselectItem(id:Int):Void{
		dropDownMenu.deselectItem(id);
	}
	
	public function show(b:Bool):Void{
		dropDownMenu.show(b);
		
	}
}