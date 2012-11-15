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
    Pages.addEventListener(EVENT_ID.PAGE_SELECTED, onPageSelected);
    Pages.addEventListener(EVENT_ID.UPDATE_TOOL_SIZES, onUpdateToolSizes);
    posY = 0;
    views = new Vector<AView>();
    index = 0;
    backdrop        = new Bitmap(new BitmapData(190,486,false,0xDEDEDE ));
  }
  
  private function onPageSelected(e:IKEvent):Void{
    return;
    var print_types = Xml.parse(Pages.getString(CONST.PRINT_TYPES));
    
    
    hideAllViews();
    
    for(print_types in print_types.elementsNamed('print-types')){
      for(print_type in print_types.elementsNamed('print-type')){
        for(title in print_type.elementsNamed('title')){
          showTool( title.firstChild().nodeValue.toString());
        }
      }
    } 
  }
  
  private function hideAllViews():Void{
    //views[getIndex('show_greetings')].visible = false;
    //var i = getIndex('Greetings');
    //for( i in 0...views.length){
    //  views[i].visible = false;
    //}
  }
  
  private function showTool(id:String):Void{
    trace( id);
    switch ( id ){
      case 'Greetings':{views[getIndex('show_greetings')].visible = true;}
      case 'Logo':{}
      case 'Symbols':{}
      case 'Photo':{}
      case 'Text':{}
    }
  }
  
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
        posY += selectedView.getHeight();
      }
      else{
        posY += SIZE.PROPERTY_BUTTON_HEIGHT;
      }
    }
  }
}