package;

import flash.display.Sprite;
import flash.Lib;
import flash.events.Event;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.geom.Point;
import flash.Vector;

class SideView extends View, implements IView
{
  private var views:Vector<AView>;
  private var selectedView:AView;
  
  private var textView:AView;
  private var textSuggestionView:AView;
  private var designView:AView;
  private var foilView:AView;
  private var addOnsView:AView;
  private var garamondView:AView;
  private var logoView:AView;
  private var priceView:AView;
  private var blindView:AView;
//  private var vPos:Int;
  private var posY:Float;
  private var index:Int;
  
  
  public function new(controller:IController){	
  	super(controller);
  	Application.addEventListener(EVENT_ID.LOAD_DEFAULT_SIDEVIEW, onLoadDefaultSiteView);
  	posY = 0;
  	views = new Vector<AView>();
  	index = 0;
  	backdrop        = new Bitmap(new BitmapData(190,486,false,0xDEDEDE ));
  	
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
    //showView(views[0].getString('viewId'));
    showView(EVENT_ID.SHOW_TEXT, true);
    //showView(EVENT_ID.SHOW_TEXT,true);
    //showView(views[0].getString('viewId'), true);
  }
  
  override public function showView(id:String, b:Bool):Void{
  	selectedView.update('deselect', 0 , 'na');
  	posY = 0;
  	
  	for( i in 0...views.length){
  	  views[i].y = posY;
  	  
  	  if( getIndex(id) == i ){
  	    posY += 516;
  	    views[i].update('select', i , 'na');
  	    selectedView = views[i];
  	    this.setChildIndex(views[i], this.numChildren - 1);
  	  }
  	  else{
  	    views[i].update('deselect', i , 'na');
  	    posY += SIZE.PROPERTY_BUTTON_HEIGHT;
  	  }
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
      //case EVENT_ID.EDIT_MODE:{
      //  
      //}
    }
  }
  
}