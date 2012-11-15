
import flash.text.TextFormat;

class ToolTipsController extends Controller, implements IController
{
  private var color:UInt;
  private var fontSize:UInt;
  private var fontStyle:UInt;
  private var fontVariation:UInt;
  	
  public function new(){	
  	super();
  }
  
  override public function setParam(param:IParameter):Void{
  //  trace(param.getLabel());
    Application.dispatchParameter(param);
  }
}