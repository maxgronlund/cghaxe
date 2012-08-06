import flash.events.Event;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.geom.Point;

class MenuView extends View, implements IView
{
	private var saveButton:OneStateButton;
	private var maskButton:TwoStateButton;
	private var moveButton:TwoStateButton;
	private var textButton:TwoStateButton;
	private var gridButton:TwoStateButton;
	private var trashButton:OneStateButton;
	private var zoomInButton:OneStateButton;
	private var zoomOutButton:OneStateButton;
	private var zoomTo100Button:OneStateButton;
//	
//	private var placeholdersButton:TwoStateButton;
	
	private var buttonPos:Float;
	private var adminPos:Float;

	public function new(controller:IController){	
		super(controller);
		
		bmpData             = new BitmapData(SIZE.DESKTOP_WIDTH,SIZE.MENU_VIEW_HEIGHT,false,COLOR.MENU );
		backdrop            = new Bitmap(bmpData);
		                	  
		saveButton 		      = new OneStateButton();
		maskButton 		      = new TwoStateButton();
		moveButton 		      = new TwoStateButton();
		textButton 		      = new TwoStateButton();
		gridButton 		      = new TwoStateButton();
		trashButton 		    = new OneStateButton();
		zoomInButton 	      = new OneStateButton();
		zoomOutButton       = new OneStateButton();
		zoomTo100Button     = new OneStateButton();
		Application.addEventListener(EVENT_ID.SET_DEFAULT_TOOL, onSetDefaultTool);
		
		
  	
	}

	private function onSetDefaultTool(e:IKEvent):Void{
	 //trace('onSetDefaultTool');
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
    
    moveButton.init( controller,
            new Point(40,29), 
            new MoveButton(), 
            new Parameter( EVENT_ID.MOVE_TOOL));
            
    textButton.init( controller,
            new Point(40,29), 
            new TextButton(), 
            new Parameter( EVENT_ID.TEXT_TOOL));
            
    gridButton.init( controller,
            new Point(40,29), 
            new GridButton(), 
            new Parameter( EVENT_ID.GRID_ON));
    
    trashButton.init( controller,
            new Point(40,29), 
            new TrashButton(), 
            new Parameter( EVENT_ID.TRASH_PLACEHOLDER ) );
    trashButton.fireOnMouseUp(false);
    					
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
    
    addChild(saveButton);
    saveButton.fireOnMouseUp(false);
    
    addChild(maskButton);
    addChild(moveButton);
    addChild(textButton);
    addChild(gridButton);
    addChild(trashButton);
    addChild(zoomOutButton);
    addChild(zoomInButton);
    addChild(zoomTo100Button);
    
    
    maskButton.x			= saveButton.x + saveButton.getWidth();
    moveButton.x			= maskButton.x + maskButton.getWidth();
    textButton.x			= moveButton.x + moveButton.getWidth();
    gridButton.x			= textButton.x + textButton.getWidth();
    
    trashButton.x		  = gridButton.x + gridButton.getWidth();
    
    
    zoomTo100Button.x		= SIZE.MENU_VIEW_WIDTH - zoomTo100Button.getWidth();
    zoomInButton.x		= zoomTo100Button.x - zoomInButton.getWidth();
    zoomOutButton.x 	= zoomInButton.x - zoomOutButton.getWidth();
     
    
    
    
  }
  
  override public function update(id:String, index:Int, value:String):Void{
  	
    switch ( id ){
    	case EVENT_ID.TEXT_TOOL:{
    		moveButton.setOn(false);
    		textButton.setOn(true);
    	}
    	case EVENT_ID.MOVE_TOOL:{
    		textButton.setOn(false);
    		moveButton.setOn(true);
    	}
    		//selectButton.setOn(false);
    }	
  }
	
}

