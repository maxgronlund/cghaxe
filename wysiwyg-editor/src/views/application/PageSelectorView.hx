import flash.events.Event;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.geom.Point;
import flash.Vector;

class PageSelectorView extends View, implements IView {
  
  private var pageButtons:Vector<TwoStateTextButton>;
  private var pages:Int;
  private var pageButtonPosX:Float;
  
  // backdrop
  private var lineData:BitmapData;
  private var line:Bitmap;
  
  public function new(pageSelectController:IController){	
    
    super(pageSelectController);
    
    bmpData     = new BitmapData(SIZE.DESKTOP_WIDTH, SIZE.PAGESELESCTOR_HEIGHT,false, 0xffffff );
    backdrop    = new Bitmap(bmpData);
    lineData    = new BitmapData(SIZE.DESKTOP_WIDTH,1,false,COLOR.GRAY_LINE );
    line        = new Bitmap(lineData);
    line.y      = SIZE.PAGESELESCTOR_HEIGHT;
    pages       = 0;
  }
  
  override public function init():Void { 
    
    Application.addEventListener(EVENT_ID.RESET_WYSIWYG, onClearConfiguration);
    Preset.addEventListener(EVENT_ID.BUILD_PAGE, onBuildPage);
    Pages.addEventListener(EVENT_ID.PAGE_SELECTED, onPageSelected);
    Application.addEventListener(EVENT_ID.LOAD_DEFAULT_PAGE, onLoadDefaultPage);
    
	}
	private function onLoadDefaultPage(e:IKEvent):Void{
    pageButtons[0].bang();
  }
  
	
  override public function onAddedToStage(e:Event){
    super.onAddedToStage(e);	
    addChild(backdrop);
    addChild(line);
    backdrop.width = SIZE.MAIN_VIEW_WIDTH - SIZE.SIDEBAR_VIEW_WIDTH;
  }
  
  private function onClearConfiguration(e:IKEvent):Void{
    Application.removeEventListener(EVENT_ID.RESET_WYSIWYG, onClearConfiguration);
  	if(pageButtons != null){
    	for( button in 0...pages){
      	removeChild(pageButtons[button]);
      }
    }
    pages = 0;
    pageButtons = null;
    pageButtons = new Vector<TwoStateTextButton>();
    pageButtonPosX = 0;
  }

  private function onBuildPage(e:IKEvent):Void{
    for(title in e.getXml().elementsNamed("title") ) {
      addPageSelectorLink(title.firstChild().nodeValue.toString());
    }
    pages++;
  }
  
  private function onPageSelected(e:IKEvent):Void{
  
    if(pageButtons != null){
      for( i in 0...pages){
	      pageButtons[i].setOn( pageButtons[i].getId() == e.getInt() );
      }
      GLOBAL.desktop_view.glimmerFoils();
    }
  }

  private function addPageSelectorLink(pageName:String):Void{
  	createPageButton(Std.string(pages+1) + '.' + pageName, pages);
  }
  private function createPageButton(label:String, pageId:Int):Void{ 
    
    var param:IParameter = new Parameter( EVENT_ID.PAGE_SELECTED);
    param.setInt(pageId);
    
    pageButtons.push(new TwoStateTextButton());
    pageButtons[pages].init(controller, param, label, pageId, 'helvetica', 22);
    addChild(pageButtons[pages]);
    pageButtons[pages].x = pageButtonPosX;
    pageButtonPosX += pageButtons[pages].getWidth()+1;
  }
  
}

