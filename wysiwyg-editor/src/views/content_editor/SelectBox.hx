


import flash.events.Event;
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFieldType;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormatAlign;
import flash.events.KeyboardEvent;
import flash.display.Shape;
import flash.Vector;
import flash.geom.Point;
import flash.geom.ColorTransform;
import flash.events.Event;
import flash.events.MouseEvent;

import flash.display.Sprite;

import flash.Lib;
import flash.display.MovieClip;

class SelectBox extends MouseHandler
{
  private var scale:Float;
  private var combindeMargins:Float;
  private var backdrop:Sprite;
  private var alertBox:Sprite;
  private var outline:Vector<Shape>;
  private var pageView:Dynamic;
  private var placeHolderView:Dynamic;
  private var selected:Bool;
  
  public function new(pageView:Dynamic, placeHolderView:Dynamic)
  {
    super();
    this.pageView = pageView;
    this.placeHolderView = placeHolderView;
    scale = 150/72;
    outline = new Vector<Shape>();
    
    createAlertBox();
    createBackdrop();
    createOutline();
    
    alertBox.visible = false;
    selected = false;
    //backdrop.visible = false;
    backdrop.alpha                  = 0.5;
    
    //addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
    addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    
  }
  private function onAddedToStage(e:Event){
    trace('onAddedToStage');
  }
  
  //public function getPlaceHolderView():Dynamic {
  //  return placeHolderView;
  //}
  
  override private function onMouseOver(e:MouseEvent){
    
    super.onMouseOver(e);
    
  }
  
  override private function onMouseDown(e:MouseEvent){
    if(selected)
      placeHolderView.setTextOnTop(true);
    selected          =     true;
  	super.onMouseDown(e); 
  	MouseTrap.capture();
  	pageView.setPlaceholderInFocus(placeHolderView);
  	placeHolderView.updateGlobals();
  	//if(GLOBAL.MOVE_TOOL) {
  	  //placeHolderView.setOnTop('select_box');
  	  pageView.enableMove(e);
  	//}
  	//else
  	//  placeHolderView.makeFontSelecetable();
  	
  }
  
  override private function onMouseUp(e:MouseEvent){
    super.onMouseUp(e);
    trace('onMouseUp');
    //placeHolderView.makeFontSelecetable();
    //placeHolderView.setOnTop('text_field');
     
    MouseTrap.release();
    pageView.disableMove();
    GLOBAL.Application.dispatchParameter(new Parameter(EVENT_ID.RESET_STAGE_SIZE));
    
  }
  
  private function createOutline():Void{
    
    // left
    createLine(new Point(-10,0), new Point(0,0));
    createLine(new Point(-10,0), new Point(0,0));
    createLine(new Point(-10,0), new Point(0,0));
                                               
    // bottom side                             
    createLine(new Point(0,0), new Point(0,10) );
    createLine(new Point(0,0), new Point(0,10) );
    createLine(new Point(0,0), new Point(0,10) );
                                               
    // right side                              
    createLine(new Point(0,0), new Point(10,0) );
    createLine(new Point(0,0), new Point(10,0) );
    createLine(new Point(0,0), new Point(10,0) );
                                               
    // top side                                
    createLine(new Point(0,0), new Point(0,-10));
    createLine(new Point(0,0), new Point(0,-10));
    createLine(new Point(0,0), new Point(0,-10));
    
  }
  
  private function createLine(start:Point, end:Point):Void{
    var line:Shape = new Shape();
    line.graphics.lineStyle(1, 0x000000, 1);
    line.graphics.moveTo(start.x , start.y); 
    line.graphics.lineTo(end.x, end.y);
    addChild(line);
    outline.push(line);
  }
  
  private function createAlertBox():Void{
    alertBox = new Sprite();
    addChild(alertBox);
    alertBox.graphics.lineStyle(1/scale,0xff0000);
    alertBox.graphics.beginFill(0xff8888);
    alertBox.graphics.drawRect(0,0,100,100);
    alertBox.graphics.endFill();
    //alertBox.visible = false;
    
  }
  
  private function createBackdrop():Void{
    backdrop = new Sprite();
    addChild(backdrop);
    backdrop.graphics.lineStyle(1/scale,0x888888);
    backdrop.graphics.beginFill(0xffffff);
    backdrop.graphics.drawRect(0,0,100,100);
    backdrop.graphics.endFill();
  }
  
  public function alert(b:Bool):Void{
    alertBox.visible = b;
    placeHolderView.alert(b);
  }
  
  public function setFocus( b:Bool ): Void{
    
//    trace('setFocus-----------------');
//    resetMouse();
    
    
    backdrop.alpha = b?0.5:0;
    for( i in 0...outline.length){
      outline[i].visible = b;
    }
    
    //placeHolderView.setFocus(b);
    //if(!b){
    //  //placeHolderView.setOnTop('select_box');
    //  //resetMouse();
    //}
  }

  public function resizeBackdrop(textfield_width:Float, textfield_height:Float, x:Float, combindeMargins:Float):Void{
    resizeAlertBox(textfield_width, textfield_height, x, combindeMargins);
    resizeBack(textfield_width, textfield_height, x, combindeMargins);
    drawCuttingMarks(textfield_width, textfield_height);
  }
  
  private function resizeBack(textfield_width:Float, textfield_height:Float, x:Float, combindeMargins:Float):Void{
    backdrop.width        = 16+textfield_width-(scale*combindeMargins);
    backdrop.height       = textfield_height;
    backdrop.x            = x + combindeMargins;
  }
  
  private function resizeAlertBox(textfield_width:Float, textfield_height:Float, x:Float, combindeMargins:Float):Void{
    alertBox.width        = 16+textfield_width-(scale*combindeMargins);
    alertBox.height       = textfield_height;
    alertBox.x            = x + combindeMargins;
  }
  
  private function drawCuttingMarks(textfield_width:Float, textfield_height:Float):Void{
    // left 
    drawVertical( 0, backdrop.x, outline);
    // bottom
    drawHorizontal( 3, textfield_height,outline);
    // right
    drawVertical( 6, backdrop.x+backdrop.width,outline );
    // top
    drawHorizontal( 9, 0,outline);
  }
  
  private function drawHorizontal(offset:UInt, posY:Float, lines:Vector<Shape>):Void{
    
    lines[offset].x    = backdrop.x;
    lines[offset+1].x  = backdrop.x + (backdrop.width/2);
    lines[offset+2].x  = backdrop.x + backdrop.width;
    
    lines[offset].y    = posY;
    lines[offset+1].y  = posY;
    lines[offset+2].y  = posY;
  }
  
  private function drawVertical(offset:UInt, posX:Float,lines:Vector<Shape>):Void{
     
     lines[offset].x    = posX;
     lines[offset+1].x  = posX;
     lines[offset+2].x  = posX;
 
     lines[offset].y    = 0;
     lines[offset+1].y  = backdrop.height/2;
     lines[offset+2].y  = backdrop.height;
  }
  
  public function getPlaceholderType():String{
    return 'text_place_holder';
  }
}