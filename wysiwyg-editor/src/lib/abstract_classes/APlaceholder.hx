package;



import flash.events.Event;
import flash.events.MouseEvent;

class APlaceholder extends MouseHandler{

  
  public function new(parrent:PageView, id:Int, model:IModel, text:String){	
    super();

  }
  
  public function getText(): Void {
    trace("getText: must be overriden in a subclass");

  }
  
  public function getXml() : String {
    trace("getXml: must be overriden in a subclass");

    return '';
  }
  
  public function onUpdatePlaceholder(event:Event):Void{
    trace("onUpdatePlaceholder: must be overriden in a subclass");
  }
  
  public function setFocus(b:Bool):Void{
    trace("setFocus: must be overriden in a subclass");
  }
}
