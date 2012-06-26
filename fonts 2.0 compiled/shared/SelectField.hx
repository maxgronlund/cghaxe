package;
import flash.events.Event;
//import flash.text.Font;
//import flash.text.TextField;
//import flash.text.TextFormat;
//import flash.text.TextFieldType;
//import flash.text.TextFieldAutoSize;
//import flash.text.TextFormatAlign;
//import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.display.Sprite;


import flash.Lib;
import flash.display.MovieClip;
//import flash.events.Event;

class SelectField extends MovieClip
{
  private var scale:Float;
  private var backdrop:Sprite;
  public function new()
  {
    super();
    scale = 150/71;
    
    backdrop = new Sprite();
    Lib.current.addChild(backdrop);
    backdrop.graphics.lineStyle(1/scale,0x000000);
    backdrop.graphics.beginFill(0xffffff);
    backdrop.graphics.drawRect(0,0,100,100);
    backdrop.graphics.endFill();
    backdrop.x = 100 * scale;
  }
  
  public function update(sizeX:Float, sizeY:Float, transparency:Float):Void{
    
    backdrop.width        = sizeX;
    backdrop.height       = sizeY;
    backdrop.alpha        = transparency;
  }
  
  public function setFocus( b:Bool ): Void{
  	backdrop.graphics.lineStyle(1,0x888888);
    //resizeBackdrop();
    backdrop.visible = b;
  	
  }

  public function resizeBackdrop(sizeX:Float, sizeY:Float):Void{
    backdrop.width        = sizeX;
    backdrop.height       = sizeY;
  }
  
  
  
  
}