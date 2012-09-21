class ApplicationController extends Controller, implements IController{
  
  public function new(){	
    super();	
  }
  override public function setParam(param:IParameter):Void{
    Application.setParam(param);
  }
}