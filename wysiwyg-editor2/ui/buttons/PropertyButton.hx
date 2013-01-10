import flash.events.Event;
import flash.events.MouseEvent;
import flash.display.Bitmap;
import flash.geom.Point;

class PropertyButton extends MouseHandler
{
  private var controller:IController;
  private var multiStateImage:MultiStateImage;
  private var mouseDown:Bool;
  private var mouseOver:Bool;
  private var param:IParameter;
  private var selected:Bool;
  
  private var formattedText:FormatedText;
//  private var labelText:String;
  private var onStage:Bool;
  //private var posX:Int;
  //private var posY:Int;
//  private var color:Int;
//  private var align:String;
  
  
  public function new(){
    super();
    formattedText 	= new FormatedText('helvetica', 'text', 14, false, 0xFFFFFF);
    addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    //align = 'left';
  }
  
  public function init(  controller:IController, size:Point, bmp:Bitmap, param:IParameter){
    this.controller = controller;
    multiStateImage = new MultiStateImage(bmp, size);
    this.param = param;
    mouseDown = false;
    mouseOver = false;
    selected	= false;
  }
  
  private function onAddedToStage(e:Event):Void{	
    addChild(multiStateImage);
    addChild(formattedText);
    //formattedText.setLabel(labelText);
    //formattedText.setColor(color);
    
    onStage = true;
  }
  
  override private function onMouseOver(e:MouseEvent){	
  	super.onMouseOver(e); 
  	setState(selected ? 2:1);
  	mouseOver = true;
  }
  
  override private function onMouseOut(e:MouseEvent){	
  	super.onMouseOut(e); 
  	setState(selected ? 2:0);
  	mouseOver = false;
  }
  
  override private function onMouseDown(e:MouseEvent){
    super.onMouseDown(e); 
    
    mouseDown = true;
    selected	= !selected;
    setState(selected ? 2:0);
    param.setBool(selected);
    controller.setParam(param);
  }
  
  private function setState(state:Int):Void{
    multiStateImage.state(new Point(state,0));
  }
  
  public function getWith():Float{
    return multiStateImage.width/3;
  }
  
  public function setOn(b:Bool):Void{
    //trace(b);
    selected = b;
    setState(b?2:0);
  }
  public function setText(s:String):Void{
    formattedText.setLabel(s);
    formattedText.x = 8;
    formattedText.y = 5;
    //labelText = s;
    //updateLabel();
  }
  //public function updateLabel():Void{
  //  formattedText.setLabel(labelText);
  //  //alignText();
  //}
  
  //public function setFormat(posX:Int, posY:Int, color:Int, align:String = 'left'):Void{
  //  this.posX   = posX;
  //  this.posY   = posY;
  //  this.color  = color;
  //  this.align  = align;
  //  
  //}
  //
  //private function alignText():Void{
  //  switch ( align ){
  //    case 'center':{
  //      var posX = (getWidth() - formattedText.getWidth())*0.5;
  //      formattedText.x = posX;
  //    }
  //  }
  //}
  //
  //private function getWidth():Float{
  //  return multiStateImage.width/3;
  //}
}

