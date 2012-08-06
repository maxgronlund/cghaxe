import flash.display.Sprite;
import flash.events.Event;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.MouseEvent;

import flash.geom.Point;
import flash.Vector;

class LineSpacePopup extends AView {
	
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
    
    //sizes = [0,1,2,3,5,7,9,12,15,18,22];
    sizes = [-50,-40,-32,-26,-24,-22,-20,-18,-16,-13,-12,-10,-9,-6,-4,-2,0,2,4,5,6,9,10,12,16,20,26,32];
    
    for (i in 0...sizes.length){
      //var param = new Parameter( EVENT_ID.FONT_SIZE_SELECTED);
      var param = new Parameter( EVENT_ID.LINE_SPACE_SELECTED);
      var v:Int = sizes[i];
      param.setFloat(v);
      param.setInt(i);
      dropDownMenu.addItem( param, Std.string(v));
    }
    
    dropDownMenu.selectItem(9);
    setInt('display', 9);
    //FONT.fontSize = sizes[3];
  }
  
  public function deselectItem(id:Int):Void{
  	dropDownMenu.deselectItem(id);
  }
  
  public function show(b:Bool):Void{
    dropDownMenu.show(b);
  }
  
  override public function setString(id:String, s:String):Void{

    switch ( id ){
      case 'display':
        dropDownMenu.setDisplay(s);
    }
  }
  
  override public function setInt(id:String, i:Int):Void{
    //trace()
    switch ( id ){
      case 'display':
        dropDownMenu.setDisplay(Std.string(sizes[i]));
    }
  }
  
  override public function setParam(param:IParameter):Void{
    switch ( param.getLabel() ){
      case EVENT_ID.UPDATE_TEXT_TOOLS:{
        dropDownMenu.setItem(Std.string(GLOBAL.Font.leading));
      }
    }
  }
}