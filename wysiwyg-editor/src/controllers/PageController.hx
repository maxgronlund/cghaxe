class PageController extends Controller, implements IController
{

  private var pagesView:IView;
  public function new(){	
    super();
  }
  
  override public function setParam(param:IParameter):Void{
    Pages.setParam(param);
    
    //switch ( param.id )
    //{
    //  case expression:
    //    statement
    //}
  }
}