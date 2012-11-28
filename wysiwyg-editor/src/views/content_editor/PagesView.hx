import flash.events.Event;
import flash.geom.Point;
import flash.Vector;
import flash.events.KeyboardEvent;

class PagesView extends View, implements IView{
  
  private var pages:Vector<PageView>;
  private var pageInFocus:PageView;
  
  public function new(desktopController:IController){	
    
    super(desktopController);
    Application.addEventListener(EVENT_ID.RESET_WYSIWYG, onResetWysiwyg);
    Application.addEventListener(EVENT_ID.ADD_PAGES_TO_STAGE, addPagesToStage);
    Designs.addEventListener(EVENT_ID.ADD_DESIGN_TO_PAGE, onAddPageDesignToPage);
    Pages.addEventListener(EVENT_ID.BUILD_PAGE, onBuildPage);
    Pages.addEventListener(EVENT_ID.BUILD_DESIGN_PAGE, onBuildDesignPage);
    Pages.addEventListener(EVENT_ID.PAGE_SELECTED, onPageSelected);
    Greetings.addEventListener(EVENT_ID.ADD_GREETING_TO_PAGE, onAddGreetingToPage);
    Symbols.addEventListener(EVENT_ID.ADD_SYMBOL_TO_PAGE, onAddSymbolToPage);
    Logos.addEventListener(EVENT_ID.ADD_LOGO_TO_PAGE, onAddLogoToPage);
    Application.addEventListener(EVENT_ID.ALLIGN_SELECTED_LEFT, onAllignLeft);
  }
  
  private function onAddGreetingToPage(e:IKEvent):Void{
    pageInFocus.setParam(e.getParam());
  }
  
  private function onAddSymbolToPage(e:IKEvent):Void{
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
    for( i in 0...pages.length){
      addChild(pages[i]);
      pages[i].visible = false;
    }
   stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPressed);
   Application.setString(EVENT_ID.UPDATE_LOAD_PROGRESS,'All Pages Added to Stage');
  }
  
  private function onAllignLeft(e:Event):Void{
    this.x = 0;
    this.y = 0;
    for( i in 0...pages.length){
      pages[i].x = 0;
      pages[i].y = 0;
    }
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
    putPageOnTop( e.getInt());
  }
  
  private function onBuildDesignPage(e:IKEvent):Void{
    
    var pageView:PageView = new PageView(controller);
    pageView.setModel(e.getParam().getModel());
    pages.push(pageView); 
     
  }
  
  private function onBuildPage(e:IKEvent):Void{
    Application.setString(EVENT_ID.UPDATE_LOAD_PROGRESS,'Building Page');
    var pageView:PageView = new PageView(controller);
    pageView.setModel(e.getParam().getModel());
    pages.push(pageView); 
  }
  
  private function onLoadDefaultPage(e:IKEvent):Void{
    putPageOnTop(0);
  }
  
  private function putPageOnTop(id:Int):Void{
    pageInFocus = pages[id];
    pageInFocus.setString(EVENT_ID.ENABLE_DELETE_KEY, 'sir');
    
    var side_of_top_paper:Bool = pageInFocus.getModel().getBool('front_of_paper');
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
          pageView.useHideMask( i>id );
          pageView.visible = true;
        }
      }
      else{
        pageView.visible = false;
      }
    }
  }
  
  override public function setString(id:String, s:String):Void{
    switch ( id ){
      case 'set_pages_to_top_left':setPagesToTopLeft();
    }
  }
  
  private function setPagesToTopLeft():Void{
    // move pages relative to front page
    var posX = pages[0].x;
    var posY = pages[0].y;
    pages[0].x = 0;
    pages[0].y = 0;
    
    for( i in 1...pages.length){
      pages[i].x -= posX;
      pages[i].y -= posY;
    }
  
  }
  
  override public function getView(i:Int):AView{
    return pages[i];
	}

  private function onKeyUp(event:KeyboardEvent):Void{}
    
  private function onKeyPressed(event:KeyboardEvent):Void{
    
    return;
     switch(event.keyCode){
       case 8:{
         pageInFocus.setString(EVENT_ID.DELETE_KEY_PRESSED, 'foo');
       }; 
     }
   }
}