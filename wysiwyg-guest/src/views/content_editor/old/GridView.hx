import flash.events.Event;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.geom.Point;
import flash.display.Shape;
import flash.display.Sprite;

class GridView extends View, implements IView
{
  private var verticalLine:Shape;
  private var horizontalLine:Shape;
  
  public function new(controller:IController){	
  	super(controller);
  	Application.addEventListener(EVENT_ID.GRID_ON, onHideGrid);
  }
  
  //override public function init():Void { 
  //  
  //}
  
  //override public function onAddedToStage(e:Event){
  //	super.onAddedToStage(e);	
  //	//trace('in the spotlight');
  //	//drawGrid();
  //
  //}
  
  private function onHideGrid(e:IKEvent):Void{
    if(e.getBool()){
      drawGrid();
    }else{
      removeChild(verticalLine);
      removeChild(horizontalLine);
      verticalLine    = null;
      horizontalLine  = null;
    }
    
  }
  
  private function drawGrid():Void{
    var oneUnit:Float = 20;
    var bottom:Float = SIZE.DESKTOP_HEIGHT;
    var right:Float = SIZE.DESKTOP_WIDTH;

    
    verticalLine = new Shape();
    verticalLine.graphics.lineStyle(1, 0xaaaaaa, 1);
    var posX:Float = 0;
    
    for( i in 0...20){
      
      posX += oneUnit;
      verticalLine.graphics.moveTo(posX , 0); 
      verticalLine.graphics.lineTo(posX, bottom); 
      posX += oneUnit;
      verticalLine.graphics.lineTo(posX, bottom); 
      verticalLine.graphics.lineTo(posX, 0); 
      
    }
    
    
    horizontalLine = new Shape();
    horizontalLine.graphics.lineStyle(1, 0xaaaaaa, 1);
    var posY:Float = 0;
    
    for( i in 0...24){
      
      posY += oneUnit;
      horizontalLine.graphics.moveTo(0 , posY); 
      horizontalLine.graphics.lineTo(right, posY); 
      posY += oneUnit;
      horizontalLine.graphics.lineTo(right, posY); 
      horizontalLine.graphics.lineTo(0, posY); 
    }

    addChild(verticalLine);
    verticalLine.alpha = 0.4;
    //this.mouseChildren = false;
    
    addChild(horizontalLine);
    horizontalLine.alpha = 0.4;
    //this.mouseChildren = false;
    
	}
  
}

