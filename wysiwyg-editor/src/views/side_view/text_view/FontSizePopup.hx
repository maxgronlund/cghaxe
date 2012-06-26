import flash.display.Sprite;
import flash.events.Event;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.MouseEvent;

import flash.geom.Point;
import flash.Vector;

class FontSizePopup extends AView {
	
	private var dropDownMenu:DropDownMenu;
	var sizes:Array<Int>;

	public function new(textController:IController) {
		super(textController);
		sizes  = new Array<Int>();
		dropDownMenu = new DropDownMenu( textController, 
                                      new FontSizePopupBitmap(), 
                                      new Parameter('foo'),
                                      60, 48);
                                      
    addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    GLOBAL.Application.addEventListener(EVENT_ID.LOAD_DEFAULT_FONT, addSizes);
  }
  
  override public function onAddedToStage(e:Event){
    removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    addChild(dropDownMenu);
  }
  
  private function addSizes(e:IKEvent):Void{
    
    dropDownMenu.removeItems();
    //var sizes:Array<Int> = new Array<Int>();
    sizes = [9,10,11,12,14,16,18,21,24,28,34,40,48,60,76,100,120,140,150];
    
    for (i in 0...sizes.length){
      var param = new Parameter( EVENT_ID.FONT_SIZE_SELECTED);
      var v:Int = sizes[i];
      param.setFloat(v);
      param.setInt(i);
      dropDownMenu.addItem( param, Std.string(v));
    }
    
    dropDownMenu.selectItem(3);
    setInt('display', 3);
  }
  
  override public function setParam(param:IParameter):Void{
    switch ( param.getLabel() ){
      case EVENT_ID.UPDATE_TEXT_TOOLS:{
        dropDownMenu.setItem(Std.string(GLOBAL.Font.fontSize));
      }
    }
  }
  
  public function deselectItem(id:Int):Void{
  	dropDownMenu.deselectItem(id);
  }
  
  public function show(b:Bool):Void{
    dropDownMenu.show(b);
  }
  
  override public function setInt(id:String, i:Int):Void{
    //trace()
    switch ( id ){
      case 'display':
        dropDownMenu.setDisplay(Std.string(sizes[i]));
    }
  }
}