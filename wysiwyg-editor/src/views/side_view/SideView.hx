package;

import flash.display.Sprite;
import flash.Lib;
import flash.events.Event;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.geom.Point;
import flash.Vector;
import flash.display.Shape;

class SideView extends View, implements IView
{
  private var views:Vector<AView>;
  private var selectedView:AView;
//  private var verticalLine:Shape;
  private var posY:Float;
  private var index:Int;
  
  
  public function new(controller:IController){	
    super(controller);
    Application.addEventListener(EVENT_ID.LOAD_DEFAULT_SIDEVIEW, onLoadDefaultSiteView);
//    Pages.addEventListener(EVENT_ID.PAGE_SELECTED, onPageSelected);
    Pages.addEventListener(EVENT_ID.UPDATE_TOOL_SIZES, onUpdateToolSizes);
    posY = 0;
    views = new Vector<AView>();
    index = 0;
    backdrop        = new Bitmap(new BitmapData(190,486,false,0xDEDEDE ));
  }
  
//  private function onPageSelected(e:IKEvent):Void{
//    trace('on page-------------');
//    //if(Pages.getString(CONST.PRINT_TYPES) != 'na'){
//    //  var print_types = Xml.parse(Pages.getString(CONST.PRINT_TYPES));
//    //}
//    
//  }
  
 
  override public function onAddedToStage(e:Event){
    super.onAddedToStage(e);	
    addChild(backdrop);
    backdrop.y = 500;
  }
  
  override public function addView(view:AView, posX:Int, posY:Int, id:String = null):Void{ 
    view.setString('viewId', id);
    views.push(view);
    views[index].y = posY;
    posY += 30;
    addChild(views[index]);
    index++;  
  }
  
  private function onLoadDefaultSiteView(e:IKEvent):Void{
    selectedView = views[0];
    showView(EVENT_ID.SHOW_TEXT, true);
    
  }
  
  override public function showView(id:String, b:Bool):Void{
    controller.setString(EVENT_ID.CLOSE_TOOL_TIPS, 'foo');
//    trace(id);
    posY = 0;

    for( i in 0...views.length){
      views[i].y = posY;
      this.setChildIndex(views[i], this.numChildren - 1);
      if( getIndex(id) == i && b ){
        posY += views[i].getHeight();
        views[i].update('select', i , 'na');
        selectedView = views[i];
      }
      else{
        views[i].update('deselect', i , 'na');
        if(views[i].getHeight() != 0)
          posY += SIZE.PROPERTY_BUTTON_HEIGHT;
      }
    }
    if(b){
      this.setChildIndex(selectedView, this.numChildren - 1);
    }
  }

  private function getIndex(viewId:String):Int{
    
    for( i in 0...views.length){
      if( viewId == views[i].getString('viewId') )
        return i;
    }
    return 0;
  }
  
  override public function setString(id:String, s:String):Void{
    
    switch ( id ){
      case 'set_default_tool':{
        showView(EVENT_ID.SHOW_TEXT, true);
      }
    }
  }
  private function onUpdateToolSizes(e:IKEvent):Void{

    posY = 0;
    
    for( i in 0...views.length){
      views[i].y = posY;
      if(views[i] == selectedView){
        if(selectedView.getHeight() == 0){
          //shiftSelectedView();
        }
        posY += selectedView.getHeight();
      }
      else{
        if(views[i].getHeight() != 0){
          posY += SIZE.PROPERTY_BUTTON_HEIGHT;
        }  
      }
    }
  }
  private function shiftSelectedView():Void{
    for( i in 0...views.length){
      
      if(views[i].getHeight() != 0){
        views[i].update('select', i , 'na');
        selectedView = views[i];
        break;
      }
    }
  }
}