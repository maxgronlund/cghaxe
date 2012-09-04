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
    GLOBAL.Application.addEventListener(EVENT_ID.UPDATE_SIDE_VIEWS, onUpdateSideView);
  }
  
  
  private function onUpdateSideView(e:IKEvent):Void{
    
//    trace(GLOBAL.fontType);
	  dropDownMenu.setItem(Std.string(GLOBAL.Font.fontSize));
	}
  
  override public function onAddedToStage(e:Event){
    removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    addChild(dropDownMenu);
  }
  
  private function addSizes(e:IKEvent):Void{
    
    dropDownMenu.removeItems();
    sizes = [8,9,10,11,12,13,14,15,16,18,21,24,28,32,34,36,38,40,42,45,48,60,76,100,120,140,150];
    
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
  
  /*
  override public function setParam(param:IParameter):Void{
    switch ( param.getLabel() ){
      //case EVENT_ID.UPDATE_TEXT_TOOLS:{
      //  
      //}
    }
  }
  */
  
  public function enable(b:Bool):Void{
    dropDownMenu.alpha = b ? 1.0 : 0.2;
//    dropDownMenu.enable(b);

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
  
  override public function setString(id:String, s:String):Void{
    //trace()
    switch ( id ){
      case 'init garmond':{
        dropDownMenu.selectItem(8);
        dropDownMenu.setDisplay(Std.string(sizes[8]));
      }
    }
  }
}