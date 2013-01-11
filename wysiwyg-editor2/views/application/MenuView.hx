import flash.events.Event;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.geom.Point;


class MenuView extends View, implements IView
{
	private var saveButton:OneStateButton;
	private var buyNowButton:OneStateButton;
	private var maskButton:TwoStateButton;
	private var moveButton:TwoStateButton;
	private var textButton:TwoStateButton;
	private var alignLeftButton:OneStateButton;
	private var gridButton:TwoStateButton;
	private var trashButton:OneStateButton;
	private var zoomInButton:OneStateButton;
	private var zoomOutButton:OneStateButton;
	private var zoomTo100Button:OneStateButton;
	
//	private var positionView:PositionView;
//	
//	private var placeholdersButton:TwoStateButton;
  
  private var buttonPos:Float;
  private var adminPos:Float;
  
  public function new(controller:IController){	
    super(controller);
    
    bmpData             = new BitmapData(SIZE.DESKTOP_WIDTH,SIZE.MENU_VIEW_HEIGHT,false,COLOR.MENU );
    backdrop            = new Bitmap(bmpData);
    saveButton 		      = new OneStateButton();
    buyNowButton 		    = new OneStateButton();
    maskButton 		      = new TwoStateButton();
    alignLeftButton 		= new OneStateButton();
    gridButton 		      = new TwoStateButton();
    trashButton 		    = new OneStateButton();
    zoomInButton 	      = new OneStateButton();
    zoomOutButton       = new OneStateButton();
    zoomTo100Button     = new OneStateButton();
//    positionView        = new PositionView(GLOBAL.desktop_controller);
    Application.addEventListener(EVENT_ID.SET_DEFAULT_TOOL, onSetDefaultTool);

  }
  
  private function onSetDefaultTool(e:IKEvent):Void{

    addButtons();
	
	if (textButton == null) return;
    textButton.setOn(true);
  }
  
  override public function init():Void { 

    //SaveButtonBitmap
    saveButton.init( controller,
            new Point(80,29), 
            new SaveButtonBitmap(), 
            new Parameter( EVENT_ID.SAVE_XML));
    
    
    maskButton.init( controller,
            new Point(40,29), 
            new MaskButton(), 
            new Parameter( EVENT_ID.SHOW_MASK));
            
    alignLeftButton.init( controller,
            new Point(14,29), 
            new AlignLeftButton(), 
            new Parameter( EVENT_ID.ALLIGN_SELECTED_LEFT));

    gridButton.init( controller,
            new Point(40,29), 
            new GridButton(), 
            new Parameter( EVENT_ID.GRID_ON));
    
    trashButton.init( controller,
            new Point(40,29), 
            new TrashButton(), 
            new Parameter( EVENT_ID.TRASH_PLACEHOLDER ) );
    trashButton.fireOnMouseUp(false);
    					
    buyNowButton.init( controller,
            new Point(80,29), 
            new BuyButtonBitmap(), 
            new Parameter( EVENT_ID.BUY_NOW ) );
    buyNowButton.fireOnMouseUp(false);
    					
    zoomOutButton.init( GLOBAL.desktop_controller,
            new Point(40,29), 
            new ZoomOutButtonBitmap(), 
            new Parameter( EVENT_ID.ZOOM_OUT ) );
    zoomOutButton.fireOnMouseUp(false);

    zoomInButton.init( GLOBAL.desktop_controller,
            new Point(40,29), 
            new ZoomInButtonBitmap(), 
            new Parameter( EVENT_ID.ZOOM_IN));
    zoomInButton.fireOnMouseUp(false);
    
    zoomTo100Button.init( GLOBAL.desktop_controller,
            new Point(40,29), 
            new ZoomTo100Button(), 
            new Parameter( EVENT_ID.ZOOM_100));
    zoomTo100Button.fireOnMouseUp(false);
    
	}
	
  override public function onAddedToStage(e:Event){
    super.onAddedToStage(e);	
    addChild(backdrop);
    backdrop.width = SIZE.MENU_VIEW_WIDTH;

  }
  
  private function addButtons():Void{
    
    addChild(saveButton);
    saveButton.fireOnMouseUp(false);
    if(!GLOBAL.admin_mode){
      addChild(buyNowButton);
      buyNowButton.fireOnMouseUp(false);
    }
    
    if(GLOBAL.admin_mode){
      addChild(alignLeftButton);
      addChild(maskButton);
    }
    addChild(gridButton);
    addChild(trashButton);
    addChild(zoomOutButton);
    addChild(zoomInButton);
    addChild(zoomTo100Button);
    
    var posX      = saveButton.x + saveButton.getWidth();
    if(GLOBAL.admin_mode){
      alignLeftButton.x  = posX;
      posX          = alignLeftButton.x + alignLeftButton.getWidth();
      
      maskButton.x  = posX;
      posX          = maskButton.x + maskButton.getWidth();
    }
    gridButton.x	= posX;
    trashButton.x     = gridButton.x + gridButton.getWidth();
    if(!GLOBAL.admin_mode){
      buyNowButton.x    = trashButton.x + trashButton.getWidth();
    }
    
    
    zoomTo100Button.x   = SIZE.MENU_VIEW_WIDTH - zoomTo100Button.getWidth();
    zoomInButton.x      = zoomTo100Button.x - zoomInButton.getWidth();
    zoomOutButton.x     = zoomInButton.x - zoomOutButton.getWidth();
    
    
   // addChild(positionView);
   // positionView.x = 300;
   // positionView.y = 3;
    
  }
  
  //import flash.events.KeyboardEvent;
  //stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPressed);
  //private function onKeyUp(event:KeyboardEvent):Void{}
  //  
  //private function onKeyPressed(event:KeyboardEvent):Void{
  //   switch(event.keyCode){
  //     case 8:{
  //       controller.setParam(new Parameter(EVENT_ID.TRASH_PLACEHOLDER));
  //     }; 
  //   }
  // }
  
  override public function update(id:String, index:Int, value:String):Void{
  }
	
}
