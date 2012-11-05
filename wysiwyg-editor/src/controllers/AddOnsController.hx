
import flash.text.TextFormat;

class AddOnsController extends Controller, implements IController
{

  private var color:UInt;
  private var fontSize:UInt;
  private var fontStyle:UInt;
  private var fontVariation:UInt;
  	
  public function new(){	
    super();
  }
  
  override public function setParam(param:IParameter):Void{
    switch ( param.getLabel() )
    {
      case EVENT_ID.SHOW_ADD_ONS:
        GLOBAL.side_view.showView(EVENT_ID.SHOW_ADD_ONS, param.getBool());
    }	
  }
  
}