import flash.events.Event;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.geom.Point;
import flash.Vector;

class DesignImagesPane extends View, implements IView{
  
  private var selectedButton:Int;
  private var designImagesButtons:Vector<OneStateTextAndImageButton>;
  private var buttonIndex:UInt;
  private var buttonPos:UInt;
  
  
  
  public function new(designsController:IController){	
    super(designsController);
    bmpData 				= new BitmapData(172,20,false, COLOR.SCROLLPANE );
    backdrop				= new Bitmap(bmpData);
    
    designImagesButtons = new Vector<OneStateTextAndImageButton>();
    buttonIndex	= 0;
    selectedButton = 0;
    buttonPos	= 0;
    selectedButton = 0;
    
    
  }
  
  override public function init():Void{
  
  }
  
  override public function onAddedToStage(e:Event):Void{
  
  	super.onAddedToStage(e);
  	addChild(backdrop);
  
  }


  override public function setParam(param:IParameter):Void{
    
    switch ( param.getLabel() ){
      case EVENT_ID.ADD_DESIGN_IMAGE_BUTTON:{
        trace('add button');
        param.setLabel(EVENT_ID.DESIGN_IMAGE_SELECTED);
        addButton(param);
      }
      
      case EVENT_ID.DESIGN_IMAGE_SELECTED:{
        selectButton( param.getInt());
      }
    }
  }
  
  private function selectButton(id:Int):Void{
    if(id != selectedButton){
      designImagesButtons[selectedButton].setOn(false);
      designImagesButtons[id].setOn(true);
      selectedButton = id;
    }
    
  }
  
  private function addButton(param:IParameter	):Void{
    
    
    //trace(param.getXml().toString());
    
    var designImageTitle:String;
    //var designImageUrl:String;
    
    for( title in param.getXml().elementsNamed("title") ){
      param.setString(title.firstChild().nodeValue.toString() );
      designImageTitle = title.firstChild().nodeValue.toString();
    }
    
    //for( design_images in param.getXml().elementsNamed("design-images") ){
    //  for( design_image in design_images.elementsNamed("design-image") ){
    //    //for( image in design_image.elementsNamed("image") ){
    //    //  for( url in image.elementsNamed("url") ){
    //    //    designImageUrl = url.firstChild().nodeValue.toString();
    //    //  }
    //    //}
    //    for( title in design_image.elementsNamed("title") ){
    //      param.setString(title.firstChild().nodeValue.toString() );
    //      designImageTitle = title.firstChild().nodeValue.toString();
    //    }
    //    
    //  }
    //}
    //
    param.setInt(buttonIndex);
    var oneStateTextAndImageButton:OneStateTextAndImageButton = new OneStateTextAndImageButton();
    oneStateTextAndImageButton.init( controller, new Point(171, 27), new PlaceholderButton(), param );
    oneStateTextAndImageButton.fireOnMouseUp(false);
    oneStateTextAndImageButton.jumpBack(false);
    oneStateTextAndImageButton.setText(designImageTitle);
    
    designImagesButtons[buttonIndex] = oneStateTextAndImageButton;
    addChild(designImagesButtons[buttonIndex]);
    designImagesButtons[buttonIndex].y = buttonPos;
    
    buttonPos += 27;
    buttonIndex++;
    //
    selectButton(0); //!!! <------ dont do this. or do it rigt
    
  //  trace(param.getXml().toString());
    
	}


  override public function getFloat(id:String):Float{
    switch ( id ){
      case 'height':
        return buttonPos;
    }
    return 0;
  }
  
  override public function setString(id:String, s:String):Void{
    
    //switch ( id )	{
    //	case 'load_default_font':{
    //		fontButtons[0].setOn(true);
    //	}
    //	case EVENT_ID.FONT: selectFont(s);
    //}
  }
  
  //public function doStuff():Void{
  //  
  //}
  
  
  
}