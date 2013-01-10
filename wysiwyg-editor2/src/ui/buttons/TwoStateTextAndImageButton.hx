import flash.events.Event;
import flash.events.MouseEvent;
import flash.display.Bitmap;
import flash.geom.Point;

class TwoStateTextAndImageButton extends TwoStateButton
{	
  private var formattedText:FormatedText;
  private var labelText:String;
  private var onStage:Bool;
  private var posX:Int;
  private var posY:Int;
  private var color:Int;
  private var align:String;
  
  public function new(){
    super();
    labelText = 'na';
    formattedText 	= new FormatedText('helvetica', 'text', 12, false);
    onStage = false;
    posX = 4;
    posY = 6;
    align = 'left';
  }
  
  override private function onMouseDown(e:MouseEvent){	
    super.onMouseDown(e); 
    //setState(2);
  }
  
  override private function onMouseUp(e:MouseEvent){
    super.onMouseUp(e); 
  }
  
  public function setText(s:String):Void{
    labelText = s;
  }
  
  public function updateLabel():Void{
    formattedText.setLabel(labelText);
    alignText();
  }
  
  public function setFormat(posX:Int, posY:Int, color:Int, align:String = 'left'):Void{
    this.posX   = posX;
    this.posY   = posY;
    this.color  = color;
    this.align  = align;
    
  }
  
  override private function onAddedToStage(e:Event):Void{	
    
    super.onAddedToStage(e);
    addChild(formattedText);
    formattedText.setLabel(labelText);
    formattedText.setColor(color);
    formattedText.x = posX;
    formattedText.y = posY;
    onStage = true;
    
  }
  
  private function alignText():Void{
    switch ( align ){
      case 'center':{
        var posX = (getWidth() - formattedText.getWidth())*0.5;
        formattedText.x = posX;
      }
    }
  }
}