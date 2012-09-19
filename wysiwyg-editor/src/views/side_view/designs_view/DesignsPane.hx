import flash.events.Event;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.geom.Point;
import flash.Vector;


class DesignsPane extends View, implements IView{
  
  private var selectedButton:Int;
  private var designsButtons:Vector<OneStateTextAndImageButton>;
  private var buttonIndex:UInt;
  private var buttonPos:UInt;
  private var page:Vector<Xml>;
  private var pageIndex:Int;
  private var swapIndex:Int; 
  private var swapPageToDesigns:Array<Int>;
  
  
  
  public function new(designsController:IController){	
    super(designsController);
    bmpData           = new BitmapData(172,20,false, COLOR.SCROLLPANE );
    backdrop          = new Bitmap(bmpData);
    
    designsButtons    = new Vector<OneStateTextAndImageButton>();
    buttonIndex	      = 0;
    selectedButton    = 0;
    buttonPos	        = 0;
    page             = new Vector<Xml>();
    swapPageToDesigns  = new Array<Int>();
    pageIndex         = 0;
    swapIndex         = 0;
    
    //Pages.addEventListener(EVENT_ID.BUILD_PAGE, onBuildPage);
    Preset.addEventListener(EVENT_ID.BUILD_PAGE, onBuildPage);
    Pages.addEventListener(EVENT_ID.PAGE_SELECTED, onPageSelected);
    Designs.addEventListener(EVENT_ID.DESIGN_SELECTED, onDesignSelected);

    //trace('new');
    
  }
  

  override public function onAddedToStage(e:Event):Void{
  	super.onAddedToStage(e);
  	addChild(backdrop);
  	//trace('onAddedToStage');
  }


  
  public function selectButton(id:Int):Void{
    //trace(id);
    if(id != selectedButton){
      designsButtons[selectedButton].setOn(false);
      designsButtons[id].setOn(true);
      selectedButton = id;
    }
  }
  
  private function removeButtons():Void{
    //trace('remove buttons');
    buttonPos = 0;
    buttonIndex = 0;
    for(i in  0...designsButtons.length){
      //trace(i);
      removeChild(designsButtons[i]);
      designsButtons[i] = null;
    }
    designsButtons = null;
    designsButtons    = new Vector<OneStateTextAndImageButton>();
  }

  private function addButton(xml:Xml	):Void{
    //trace('add buttons');
    
    for( designs in xml.elementsNamed("designs") ) {
      for( design in designs.elementsNamed("design") ) {
        
        var param:IParameter = new Parameter(EVENT_ID.DESIGN_SELECTED);
        var designTitle:String;
        for( title in design.elementsNamed("title") ) 
          designTitle = title.firstChild().nodeValue;
        param.setString(designTitle);
        param.setXml(design);
        param.setInt(buttonIndex);

        var oneStateTextAndImageButton:OneStateTextAndImageButton = new OneStateTextAndImageButton();
        oneStateTextAndImageButton.init( controller, new Point(171, 27), new PlaceholderButton(), param );
        oneStateTextAndImageButton.fireOnMouseUp(false);
        oneStateTextAndImageButton.jumpBack(false);
        oneStateTextAndImageButton.setText(designTitle);
    
        designsButtons[buttonIndex] = oneStateTextAndImageButton;
        addChild(designsButtons[buttonIndex]);
        designsButtons[buttonIndex].y = buttonPos;
    
        buttonPos += 27;
        buttonIndex++;
      }
      selectButton(0);
    }
    
	}
	


  override public function getFloat(id:String):Float{
    switch ( id ){
      case 'height':
        return buttonPos;
    }
    return 0;
  }
  
  private function onBuildPage(e:IKEvent):Void{
    //trace('onBuildPage');
    //trace(e.getXml().toString());
    var designOnPage:Bool = false;

    for(designs in e.getXml().elementsNamed("designs") ){
      page.push(e.getXml());
	    
	    designOnPage = true;
    }
    
    if(designOnPage){
      
      swapPageToDesigns[pageIndex] = swapIndex;
      swapIndex++;
    }else{
      swapPageToDesigns[pageIndex] = -1;
    }
    pageIndex++;

  }
  
  private function onPageSelected(e:IKEvent):Void{
    //trace('onPageSelected');
    removeButtons();
    var i = swapPageToDesigns[e.getInt()];
    if(i != -1){
      addButton(page[i]);
    }
  }
  
  private function onDesignSelected(e:IKEvent):Void{
    selectButton( e.getInt());
    //trace('design selecter', e.getInt());
  }
  
  override public function setInt(id:String, i:Int):Void{
    switch ( id )	{
    	case EVENT_ID.PAGE_SELECTED:{
    		trace('page_selected: ', i);
    	}
    
    }
  }
  

}