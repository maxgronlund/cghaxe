import flash.events.Event;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.geom.Point;
import flash.Vector;
import flash.display.Shape;
import flash.display.Sprite;

class SelectionView extends View, implements IView
{
  private var verticalLine:Shape;
  //private var horizontalLine:Shape;
  
  private var views:Vector<AView>;
  private var selectedView:AView;
  
  public function new(controller:IController){	
    super(controller);
    views = new Vector<AView>();
  }
  
  override public function onAddedToStage(e:Event){
    trace('on added');
    super.onAddedToStage(e);	
    
    
  }
  
  override public function addView(view:AView, posX:Int, posY:Int, id:String = null):Void{
    
      view.setString('viewId', id);
      views.push(view);
      addChild(view);
      //showView('nothing', false);

  }
  
  override public function showView(id:String, b:Bool):Void{
    trace(id, views.length);
    for( i in 0...views.length){
      if(id == views[i].getString('viewId')){
        trace('boooom');
        views[i].visible = true;
        this.setChildIndex(views[i], this.numChildren - 1);
      }else{
        trace('hush');
        views[i].visible = false;
      }
    }
    
    //selectedView.update('deselect', 0 , 'na');
    //posY = 0;
    //
    //for( i in 0...views.length){
    //  views[i].y = posY;
    //  this.setChildIndex(views[i], this.numChildren - 1);
    //  if( getIndex(id) == i ){
    //    posY += 516;
    //    views[i].update('select', i , 'na');
    //    selectedView = views[i];
    //  }
    //  else{
    //    views[i].update('deselect', i , 'na');
    //    posY += SIZE.PROPERTY_BUTTON_HEIGHT;
    //  }
    //}
    //
    //setChildIndex(selectedView, this.numChildren - 1);
  }
  
  

}

