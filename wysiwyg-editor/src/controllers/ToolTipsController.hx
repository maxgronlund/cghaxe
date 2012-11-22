
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

    //if(param.getBool() ){
    //  //GLOBAL.Application.dispatchParameter(new Parameter(EVENT_ID.EVENT_ID.CLOSE_TOOL_TIPS));
    //}
    Application.dispatchParameter(param);
  }
}