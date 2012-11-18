import flash.geom.Point;
import flash.events.Event;


class InfoMessageView extends View, implements IView
{
  private var rect:Rectangle;
  private var titleTexField:FormatedText;
  private var bodyTextField:FormatedText;
  private var linkTextField:FormatedText;
  private var horizontalAlign:String;
  private var verticalAlign:String;
  private var id:String;


  
  public function new(controller:IController, id:String, horizontalAlign:String = 'left', verticalAlign='top'){	
    super(controller);
    this.horizontalAlign = horizontalAlign;
    this.verticalAlign = verticalAlign;
  
    rect            = new Rectangle(10, 10, 0x000000, 0xE9E8DB, Rectangle.DRAW_LINES, Rectangle.USE_FILL);
    titleTexField   = new FormatedText('helvetica', 'title', 14, false, 0x000000, 250);
    bodyTextField   = new FormatedText('helvetica', 'body', 11, false, 0x000000, 250);
    linkTextField   = new FormatedText('helvetica', '', 11, false, 0x0000AA, 250);
    
    GLOBAL.Application.addEventListener(id, onToolTip);

  }
  
  private function onToolTip(e:KEvent):Void{
    if(e.getBool() )
      this.visible = !this.visible;

  }
  
  public function setContent(title:String, body:String, link:String){	

    titleTexField.x = 8;
    titleTexField.y = 6;
    

    bodyTextField.x = 8;
    bodyTextField.y = 24;
    
    linkTextField.x = 8;
    
    titleTexField.setLabel(title);
    bodyTextField.setLabel(body);
    linkTextField.setLink(link);
    

    var width = titleTexField.getWidth();
    if( bodyTextField.getWidth() > width) width = bodyTextField.getWidth();
    
    
    var height = titleTexField.getHeight();
    
    if( bodyTextField.getHeight() > height) height = bodyTextField.getHeight();
    

    linkTextField.y = height+24;
    
    rect.setSize(width+20, height+26+24);
    
    if(horizontalAlign == 'right'){
      this.x -= width+22;
    }
    if(verticalAlign == 'bottom'){
      this.y -= height;
    }
    
    
  }
  override public function onAddedToStage(e:Event):Void{
//    trace('onAddedToStage');
    
    super.onAddedToStage(e);
    addChild(rect);
    
    addChild(titleTexField);
    //titleTexField.x = 8;
    //titleTexField.y = 6;
    
    addChild(bodyTextField);
    //bodyTextField.x = 8;
    //bodyTextField.y = 24;

    parent.setChildIndex(this, parent.numChildren - 1);
    
    //var width = titleTexField.getWidth();
    //if( bodyTextField.getWidth() > width) width = bodyTextField.getWidth();
    //
    //var height = titleTexField.getHeight();
    //if( bodyTextField.getHeight() > width) width = bodyTextField.getHeight();
    
    addChild(linkTextField);
    
    this.visible = false;
    //linkTextField.setLink('foo');
    //linkTextField.y = height+20;
    
    //rect.setSize(width+20, height+26+20);
    //
    //if(horizontalAlign == 'right'){
    //  this.x -= width+22;
    //}
    //if(verticalAlign == 'bottom'){
    //  this.y -= height;
    //}
    
  }

  

}