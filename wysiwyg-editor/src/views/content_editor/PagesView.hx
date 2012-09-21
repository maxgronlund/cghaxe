/* Holds the stack of pages
* can be moved around
* can sort the stack
*/
import flash.events.Event;
//import flash.display.BitmapData;
//import flash.display.Bitmap;
import flash.geom.Point;
import flash.Vector;

class PagesView extends View, implements IView{
  
  private var pages:Vector<PageView>;

  private var productId:Int;
  private var pageInFocus:PageView;
  
  public function new(desktopController:IController){	
    
    super(desktopController);
    Application.addEventListener(EVENT_ID.RESET_WYSIWYG, onResetWysiwyg);

    
//    Application.addEventListener(EVENT_ID.LOAD_DEFAULT_PAGE, onLoadDefaultPage);
    Application.addEventListener(EVENT_ID.ADD_PAGES_TO_STAGE, addPagesToStage);

//    DesignImages.addEventListener(EVENT_ID.ADD_DESIGN_IMAGE_TO_PAGE, onAddDesignImageToPage);
    Designs.addEventListener(EVENT_ID.ADD_DESIGN_TO_PAGE, onAddPageDesignToPage);
    Pages.addEventListener(EVENT_ID.BUILD_PAGE, onBuildPage);
    Pages.addEventListener(EVENT_ID.BUILD_DESIGN_PAGE, onBuildDesignPage);
    Pages.addEventListener(EVENT_ID.PAGE_SELECTED, onPageSelected);
    Greetings.addEventListener(EVENT_ID.ADD_GREETING_TO_PAGE, onAddGreetingToPage);
    Logos.addEventListener(EVENT_ID.ADD_LOGO_TO_PAGE, onAddLogoToPage);
  }
  
  private function onAddGreetingToPage(e:IKEvent):Void{
    pageInFocus.setParam(e.getParam());
  }
  
  private function onAddLogoToPage(e:IKEvent):Void{
    pageInFocus.setParam(e.getParam());
  }
  
  override public function init():Void{}
    
  private function onResetWysiwyg(e:IKEvent):Void{
    if(pages != null) removePages();
    pages = new Vector<PageView>();
  }

  private function addPagesToStage(e:IKEvent):Void{
    addPages();
  }
  
  private function removePages():Void{
    for( i in 0...pages.length){
      if(this.contains(pages[i])){
        pages[i].setPlaceholderInFocus(null);
        removeChild(pages[i]);
        pages[i] = null;
      }
    }
    pages = null;
  }
  
  private function onAddPageDesignToPage(e:IKEvent):Void{
    pageInFocus.setParam(e.getParam());
  }

  private function onPageSelected(e:IKEvent):Void{
    //trace('update sitebar here');
    putPageOnTop( e.getInt());
  }
  
  private function onBuildDesignPage(e:IKEvent):Void{
    trace('3...onBuildDesignPage');
    var pageView:PageView = new PageView(controller);
    pageView.setModel(e.getParam().getModel());
    pages.push(pageView); 
     
  }
  
  private function onBuildPage(e:IKEvent):Void{
    var pageView:PageView = new PageView(controller);
    pageView.setModel(e.getParam().getModel());
    pages.push(pageView); 
  }
  
  private function onLoadDefaultPage(e:IKEvent):Void{
    putPageOnTop(0);
  }
  
  private function putPageOnTop(id:Int):Void{
    pageInFocus = pages[id];
    var side_of_top_paper:Bool = pages[id].getModel().getBool('front_of_paper');
    var i:Int = pages.length;
    while( i > 0){
      i--;
      var pageView                = pages[i];
      var side_of_paper:Bool      = pageView.getModel().getBool('front_of_paper');
      
      if( i >= id  &&  side_of_paper == side_of_top_paper ){
        this.setChildIndex(pageView, this.numChildren - 1);
        
        if(i>id && !pageView.hasHideMask() ){
          
          pageView.visible = false;
        }
        else{
//          trace('page has hidemask: ', i);
          pageView.useHideMask( i>id );
          pageView.visible = true;
        }
      }
      else{
        pageView.visible = false;
      }
    }
    trace('putPageOnTop');
  }
  
  private function addPages():Void{

    for( i in 0...pages.length){
      addChild(pages[i]);
      pages[i].visible = false;
      trace(i);
    }
   
  }

  override public function getView(i:Int):AView{
    return pages[i];
	}
}