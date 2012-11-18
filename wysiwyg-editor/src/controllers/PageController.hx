class PageController extends Controller, implements IController
{

  private var pagesView:IView;
  public function new(){	
    super();
  }
  
  override public function setParam(param:IParameter):Void{
    Pages.setParam(param);
    
    Pages.dispatchEvent( new KEvent(EVENT_ID.UPDATE_TOOL_SIZES, param));
    //Pages.dispatchEvent( new KEvent(EVENT_ID.POSSITION_TOOLS, param));
    
    
  }
}