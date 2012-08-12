class PriceController extends Controller, implements IController
{
  private var price:Float;
  
  public function new(){	
    super();
    
  }
  
  private function getPrintPrice(units:UInt, printType:String):Float {
    return GLOBAL.Prices.getPrintPrice(units, printType);
  }
  //override public function setParam(param:IParameter):Void{
  //  Price.setParam(param);
  //}
  
  override public function setParam(param:IParameter):Void{
    trace(param.getLabel());
    switch ( param.getLabel() ){
      case EVENT_ID.SHOW_PRICES:{
        
        GLOBAL.side_view.showView(EVENT_ID.SHOW_PRICES, true);
      }
    }	
  }
  
  private function calculatePrice():Void {
    
  }
}