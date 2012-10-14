


class ResizeBox
{
  private var topLeftCornerHandle:CornerHandle;
  private var topRightCornerHandle:CornerHandle;
  private var bottomLeftCornerHandle:CornerHandle;
  private var resizeHandle:ResizeHandle;
  private var rectangle:Rectangle;
  
  
  public function new(){
    
  }
  private function addHandles():Void{
	  addChild(topLeftCornerHandle);
    addChild(topRightCornerHandle);
    addChild(bottomLeftCornerHandle);
    addChild(resizeHandle);
    
    topLeftCornerHandle.x     = -16;
    topLeftCornerHandle.y     = -16;
    
    topRightCornerHandle.x    = backdrop.width;
    topRightCornerHandle.y    = -16;
    
    bottomLeftCornerHandle.x  = -16;
    bottomLeftCornerHandle.y  = backdrop.height;
    
    resizeHandle.x            = backdrop.width;
    resizeHandle.y            = backdrop.height;

    rectangle.alpha = 0.1;
    topLeftCornerHandle.alpha       = 0.1;
    topRightCornerHandle.alpha      = 0.1;
    bottomLeftCornerHandle.alpha    = 0.1;
    topLeftCornerHandle.visible     = false;
    topRightCornerHandle.visible    = false;
    bottomLeftCornerHandle.visible  = false;
    resizeHandle.visible            = false;
    
    
    
    
    
    
    
    
    
    //topLeftCornerHandle     = new CornerHandle();
    //topRightCornerHandle    = new CornerHandle();
    //bottomLeftCornerHandle  = new CornerHandle();
    //resizeHandle            = new ResizeHandle();
    //rectangle = new Rectangle();
	}
	
	private function updateHandles(size:Float):Void{

     topLeftCornerHandle.setSize(16/size,16/size);
     topRightCornerHandle.setSize(16/size,16/size);
     bottomLeftCornerHandle.setSize(16/size,16/size);

     topRightCornerHandle.x    = bmpSizeX -16/size;
     bottomLeftCornerHandle.y  = bmpSizeY -16/size;

     //topRightCornerHandle.x    = rectangle.width  - topRightCornerHandle.width;
     //bottomLeftCornerHandle.y  = rectangle.width  - bottomLeftCornerHandle.height;
   }
}