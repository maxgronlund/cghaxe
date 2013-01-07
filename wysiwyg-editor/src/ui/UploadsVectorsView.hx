import flash.geom.Point;
import flash.events.Event;
import flash.Vector;

class UploadsVectorsView extends VectorsView, implements IView{

  
  
  public function new(controller:IController){	
    super(controller);
    
  }
  
  
  override public function onAddedToStage(e:Event):Void{
   	
  }
  
  public function createVectorsArray(type:String,xml:Xml):Void {
	 for (vector in xml.elementsNamed(type)) {
		allLoadingVectors.push(vector);
	}
  }
  
  public function loadFirstVector(param:IParameter):Void {
	 if (currentVectorLoading == 0) {
		  var event:KEvent = new KEvent(EVENT_ID.LOAD_NEXT_IMAGE, param);
		  loadVector(event);
	  }
  }
    
  public function loadVector(e:KEvent):Void {
	 if (currentVectorLoading < allLoadingVectors.length) {
		  var vectorXml:Xml = allLoadingVectors[currentVectorLoading];
		  var str:String = vectorXml.toString();	
		  
		  var param:IParameter = e.getParam();
		  param.setXml(vectorXml);
		  vectorsPane.setParam(param);
		  
		  
		  currentVectorLoading++;
		  
		  refreshScrollBars();
	 } else {
		 refreshScrollBars();
	 }
  }
  
  private function onAddScrollBars(e:IKEvent):Void{
    
    if(vectorsPane.getFloat('height') > scrollPane.getFloat('mask_height')){
      addChild(verticalScrollbar);
      verticalScrollbar.setSize(vectorsPane.getFloat('height'), scrollPane.getFloat('mask_height'));
      verticalScrollbar.x = scrollPane.getSize().x-2;
      verticalScrollbar.y = scrollPane.y;
	  
	  verticalScrollbarAdded = true;
    } 
  }
  
  private function refreshScrollBars():Void {
	 
	  if (verticalScrollbarAdded) {
		  verticalScrollbar.setSize(vectorsPane.getFloat('height'), scrollPane.getFloat('mask_height'));
		  verticalScrollbar.x = scrollPane.getSize().x-2;
		  verticalScrollbar.y = scrollPane.y;
	  }	
	  else {
		   if(vectorsPane.getFloat('height') > scrollPane.getFloat('mask_height')){
			  addChild(verticalScrollbar);
			  verticalScrollbarAdded = true;
			  verticalScrollbar.setSize(vectorsPane.getFloat('height'), scrollPane.getFloat('mask_height'));
			  verticalScrollbar.x = scrollPane.getSize().x-2;
			  verticalScrollbar.y = scrollPane.y;
			}
		}
  }

	
	override public function setFloat(id:String, f:Float):Void{
		switch ( id ) {
		  case EVENT_ID.GREETING_SCROLL:{
			vectorsPane.y = -(vectorsPane.getFloat('height')-scrollPane.getFloat('mask_height')) * f;
		  }
		}
	}
	override public function getHeight():Int{
		var r = 0;
		if(back.visible)
			  r =  Std.int(back.height)+30;
		return r;
	}
}