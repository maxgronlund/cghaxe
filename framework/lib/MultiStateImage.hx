

import flash.display.Sprite;
import flash.events.Event;

import flash.display.Shape;
import flash.display.Bitmap;
import flash.geom.Point;


class MultiStateImage extends Sprite
{ 
  private var bmp:Bitmap; 
  private var size:Point;
  
  public function new( bmp:Bitmap, size:Point):Void
  { 
    super();
    this.bmp = bmp;
    this.size = size;
    addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
  } 
  
  public function onAddedToStage(e:Event)
  {
    addChild(bmp);
    var mask:Shape  = new Shape();
    mask.graphics.beginFill ( 0x9900FF );
    mask.graphics.drawRect ( bmp.x, bmp.y, bmp.x+ size.x, bmp.y+ size.y);
    mask.graphics.endFill();
    addChild(mask);
    mask.visible = false;
    // apply mask
    bmp.mask = mask;
  }
  
  public function state(state:Point){	
    bmp.x = -state.x* size.x;
	  bmp.y = -state.y* size.y;
  }

}