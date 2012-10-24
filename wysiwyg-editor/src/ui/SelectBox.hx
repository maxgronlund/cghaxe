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
  private var transparency:Float;
  private var mouseOver:Bool;
  private var resizable:Bool;
  private var resizeHandle:ResizeHandle;
  private var rect:Rectangle;

  public function new(pageView:Dynamic, placeHolderView:Dynamic, resizable:Bool = false){
    super();
    this.pageView = pageView;
    this.placeHolderView  = placeHolderView;
    scale                 = 150/72;
    outline               = new Vector<Shape>();
    this.resizable        = resizable;
    resizeHandle          = new ResizeHandle();
    rect                  = new Rectangle(0,0,0x888888);
    addChild(rect);
    if(resizable) addChild(resizeHandle);

    
    createAlertBox();
    createBackdrop();
    createLines();
    alertBox.visible    = false;
    rect.visible        = false;
    transparency                    = 0.08;
    backdrop.alpha                  = transparency;

    setFocus(false);
  }
  
  
  
  private function createLines():Void{
    // lines for thecutting marks
    // left side
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
    alertBox.alpha = 0.5;
    
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
    backdrop.alpha = b?0.0:transparency;
  }

  public function setFocus( b:Bool ): Void{
    backdrop.alpha = b?0.2:0.0;
    resizeHandle.visible = b;
    rect.visible          = b;
    for( i in 0...outline.length){
      outline[i].visible = b;
    }
  }

  public function resizeBackdrop(width:Float, height:Float, x:Float, combindeMargins:Float):Void{
    
    resizeAlertBox(width, height, x, combindeMargins);
    resizeBack(width, height, x, combindeMargins);
    positionCuttingMarks(width, height);
    
  }
  
  private function resizeBack(width:Float, height:Float, x:Float, combindeMargins:Float):Void{
    backdrop.width        = 16+width-(scale*combindeMargins);
    backdrop.height       = height;
    
    backdrop.x            = x + combindeMargins;
    resizeHandle.x        = backdrop.width - 32;
    resizeHandle.y        = backdrop.height - 32;
    
    rect.setSize(backdrop.width,height);
    rect.x = backdrop.x;
  }
  
  private function resizeAlertBox(textfield_width:Float, textfield_height:Float, x:Float, combindeMargins:Float):Void{
    alertBox.width        = 16+textfield_width-(scale*combindeMargins);
    alertBox.height       = textfield_height;
    alertBox.x            = x + combindeMargins;
  }
  
  private function positionCuttingMarks(textfield_width:Float, textfield_height:Float):Void{

    // left 
    possitionVerticalCuttingMarks( 0, backdrop.x, outline);
    // bottom
    possitionHorizontalCuttingMarks( 3, textfield_height,outline);
    // right
    possitionVerticalCuttingMarks( 6, backdrop.x+backdrop.width,outline );
    // top
    possitionHorizontalCuttingMarks( 9, 0,outline);
  }
  
  private function possitionHorizontalCuttingMarks(offset:UInt, posY:Float, lines:Vector<Shape>):Void{
    
    lines[offset].x    = backdrop.x;
    lines[offset+1].x  = backdrop.x + (backdrop.width/2);
    lines[offset+2].x  = backdrop.x + backdrop.width;
    
    lines[offset].y    = posY;
    lines[offset+1].y  = posY;
    lines[offset+2].y  = posY;
  }
  
  private function possitionVerticalCuttingMarks(offset:UInt, posX:Float,lines:Vector<Shape>):Void{
     
     lines[offset].x    = posX;
     lines[offset+1].x  = posX;
     lines[offset+2].x  = posX;
 
     lines[offset].y    = 0;
     lines[offset+1].y  = backdrop.height/2;
     lines[offset+2].y  = backdrop.height;
  }
  
  override private function onMouseDown(e:MouseEvent){

    super.onMouseDown(e);
    if(MouseTrap.capture()){
      
      if(resizable){
        if(this.mouseX > this.width-56){
          if(this.mouseY > this.height-56){
            startResize(e);
          }
          else{
            startDragging(e);
          }
        }else{
          startDragging(e);
        }
      }else{
        pageView.setPlaceholderInFocus(placeHolderView);
        pageView.enableMove(e);
        placeHolderView.updateGlobals();
      }
    }
  }
  
  override private function onMouseUp(e:MouseEvent){
    
    super.onMouseUp(e);
    MouseTrap.release();
    if(resizable){
      stopDragging(e);
      stopResize(e);
    }else{
      pageView.disableMove();
    }
    GLOBAL.Application.dispatchParameter(new Parameter(EVENT_ID.RESET_STAGE_SIZE));
    
    
  }

  override private function onMouseOver(e:MouseEvent){
    super.onMouseOver(e);
    mouseOver = true;
  }
  
  override private function onMouseOut(e:MouseEvent){
    super.onMouseOut(e);
    mouseOver = false;
  }

  private function startResize(e:MouseEvent){
    pageView.setPlaceholderInFocus(placeHolderView);
    pageView.enableResize(e);
    updateSideView();
  }
  private function stopResize(e:MouseEvent){
    
    pageView.setPlaceholderInFocus(placeHolderView);
    pageView.disableResize(e);
    updateSideView();
    GLOBAL.Application.dispatchParameter(new Parameter(EVENT_ID.RESET_STAGE_SIZE));
  }
  private function startDragging(e:MouseEvent){
    pageView.setPlaceholderInFocus(placeHolderView);
    pageView.enableMove(e);
    updateSideView();
  }
  
  private function stopDragging(e:MouseEvent){
     MouseTrap.release();
     pageView.disableMove();
     GLOBAL.Application.dispatchParameter(new Parameter(EVENT_ID.RESET_STAGE_SIZE));
  }
  
  private function updateSideView(): Void{
    //var param:IParameter = new Parameter(EVENT_ID.UPDATE_SIDE_VIEWS);
    //param.setString(getPlaceholderType());
    //GLOBAL.Application.dispatchParameter(param);
  }
  
  public function setSize(sizeX:Float, sizeY:Float):Void{

  }
  
  //public function canResize(resizable:Bool):Void{
  //  this.resizable = resizable;
  //  resizable ? addChild(resizeHandle): removeChild(resizeHandle);
  //}

  
}