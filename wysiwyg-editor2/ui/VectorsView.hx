import flash.geom.Point;
import flash.events.Event;
import flash.Vector;

class VectorsView extends PropertyView, implements IView{

  private var back:Rectangle;
  private var scrollPaneBack:Rectangle;
  private var scrollPane:AView;
  private var vectorsPane:AView;
  private var verticalScrollbar:VerticalScrollbar;
  
  
  private var allLoadingVectors:Vector<Xml>;
  private var currentVectorLoading:UInt;
  
  private var verticalScrollbarAdded:Bool;
  
  public function new(controller:IController){	
    super(controller);
    //back                = new Rectangle(190, 226, 0x000000, 0xDEDEDE, Rectangle.DONT_DRAW_LINES, Rectangle.USE_FILL);
	//scrollPaneBack      = new Rectangle(174, 160, 0xC3C3C3, 0xF4F4F4, Rectangle.DRAW_LINES, Rectangle.USE_FILL);
    //backdrop              = new PlaceholdersBackBitmap();
    scrollPane          = new ScrollPane(controller);
        
	verticalScrollbarAdded = false;
	
	allLoadingVectors = new Vector<Xml>();
	currentVectorLoading = 0;
	
    Application.addEventListener(EVENT_ID.ADD_SCROLL_BARS, onAddScrollBars);
  }
  
  
  override public function init():Void{
    
  }
  
  override public function onAddedToStage(e:Event):Void{
    super.onAddedToStage(e);
    addChild(back);
    back.y              = 30;
    
    addChild(scrollPaneBack);
    scrollPaneBack.x    = 8;
    scrollPaneBack.y    = 43;

    addChild(scrollPane);
    scrollPane.setSize( Std.int(scrollPaneBack.width), Std.int(scrollPaneBack.height)-1);
    scrollPane.x        = 9;
    scrollPane.y        = 44;
    scrollPane.addView(vectorsPane, 0,0);	
    

    

    vectorsPane.addEventListener(EVENT_ID.LOAD_NEXT_IMAGE, loadVector);
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