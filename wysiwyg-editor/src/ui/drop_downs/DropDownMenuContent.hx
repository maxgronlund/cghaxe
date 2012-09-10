import flash.display.Sprite;
import flash.events.Event;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Shape;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.Vector;


class DropDownMenuContent extends Sprite{
	
	private var controller:IController;    
	private var twoStateTextButtons:Vector<TwoStateTextButton>;
	private var menuItem:Int;
	private var menuItemPosY:Int;
	private var selectedItemId:Int;
	private var borders:Shape;
	private var bmpData:BitmapData;
	private var backdrop:Bitmap;
	private var menuOpen:Bool;
	private var sizeX:Int;
	
	public function new( controller:IController, bmp:Bitmap, param:Parameter,sizeX:Int) {
		super();
		this.controller 			= controller;
		menuItem 							= 0;
		menuItemPosY 					= 0;
		selectedItemId 				= 0;
		this.sizeX            = sizeX;
		twoStateTextButtons 	= new Vector<TwoStateTextButton>();
		bmpData 							= new BitmapData(sizeX,22,false,0xffffff );
		backdrop							= new Bitmap(bmpData);
		addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		menuOpen = false;
	}
	
	//sourceRect:Rectangle = new Rectangle(0, 0, bitmapData.width, bitmapData.height);
	private function onAddedToStage(e:Event){
		addChild(backdrop);
		backdrop.y = 18;
		backdrop.visible = false;
	}
	

	public function removeItems(): Void {
		
		var items = twoStateTextButtons.length;
		
		if(twoStateTextButtons != null){
			for( index in 0...items){
		  	removeChild(twoStateTextButtons[index]);
		  }
		}
		menuItem = 0;
		twoStateTextButtons = null;
		menuItemPosY = 0;
		selectedItemId = 0;
		twoStateTextButtons = new Vector<TwoStateTextButton>();
	}
	
	
	public function addItem( param:IParameter, label:String ): Void {
		var twoStateTextButton:TwoStateTextButton = new TwoStateTextButton();

		twoStateTextButton.init(controller, param, label, 0, 'helvetica', 18);
		addChild(twoStateTextButton);
		menuItemPosY += 18;
		menuItem++;
		twoStateTextButton.y = menuItemPosY;
		backdrop.height = menuItemPosY;
		twoStateTextButtons.push(twoStateTextButton);
		show(false);
	}
	
	public function setParam(param:IParameter):Void{
		deselectItem(param.getInt());
	}

	
	public function deselectItem( id:Int ): Void{
	  
		twoStateTextButtons[selectedItemId].setOn(false);
		this.selectedItemId = id;
	}
	
	public function selectItem(id:Int):Void{

		twoStateTextButtons[id].setOn(true);
		this.selectedItemId = id;
	}
	
	public function openMenu(b:Bool):Void{
		if(menuOpen && b){
			show(false);
		}
		else if(b){
			show(true);
			addEventListener(MouseEvent.ROLL_OUT, onMouseOut);
		}
	}
	
	private function onMouseOver(e:MouseEvent):Void{
		removeEventListener(MouseEvent.ROLL_OVER, onMouseOver);
		addEventListener(MouseEvent.ROLL_OUT, onMouseOut);
		stage.removeEventListener(MouseEvent.MOUSE_DOWN, onCloseMouseDown);
  }

 	private function onMouseOut(e:MouseEvent){
		removeEventListener(MouseEvent.ROLL_OUT, onMouseOut);
		addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
		stage.addEventListener(MouseEvent.MOUSE_DOWN, onCloseMouseDown);
  }
	
	private function onCloseMouseDown(e:MouseEvent){
		show(false);
	}
	
	private function closeOnMouseUp(){
		addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
	}
	
	private function onMouseUp(e:MouseEvent){
		removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		show(false);
	}

	public function show(b:Bool): Void{
	  
		backdrop.visible = b;
		showItems(b);
		showBorders(b);
		menuOpen = b;	
		if(b){
		  for( index in 0...twoStateTextButtons.length){
		    this.setChildIndex(twoStateTextButtons[index], this.numChildren - 1);
  	  }
		}
		
	}
	
	private function showItems(b:Bool):Void{
	//	var items = twoStateTextButtons.length;
		backdrop.visible = b;
		if(twoStateTextButtons != null){
			for( index in 0...twoStateTextButtons.length){
		  	twoStateTextButtons[index].visible = b;
		  }
		}
	}
	
	private function showBorders(b:Bool):Void{
		if(borders != null){
			removeChild(borders);
			borders = null;
		}
		if(b){
			drawBorders(menuItemPosY);
		}
	}
	
	private function drawBorders(height:Int):Void{
		borders = new Shape();
		borders.graphics.lineStyle(1, 0xaaaaaa, 1);
		borders.graphics.moveTo(0 , 0); 
		borders.graphics.lineTo(sizeX, 0); 
		borders.graphics.lineTo(sizeX, height); 
		borders.graphics.lineTo(0, height);
		borders.graphics.lineTo(0, 0);
		addChild(borders);
		borders.y = 18;
	}
	
	public function getItemtemName(id:Int):String{
		return twoStateTextButtons[id].getText();
		return 'foo';
	}
	
	public function setItem(s:String):Void{
	  for( index in 0...twoStateTextButtons.length){
	    if ( s == twoStateTextButtons[index].getText() ) selectButton(index);
	  }
	}
	
	private function selectButton(id:Int):Void{
	  twoStateTextButtons[selectedItemId].setOn(false);
  	this.selectedItemId = id;
    twoStateTextButtons[selectedItemId].setOn(true);
	}
	
	public function enable(b:Bool):Void{
	  
	  for( index in 0...twoStateTextButtons.length){
	    twoStateTextButtons[index].enable(b);
	  }
	}
}