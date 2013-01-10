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
    
    switch ( param.getLabel() ){
      case EVENT_ID.SHOW_PRICES:{
        GLOBAL.side_view.showView(EVENT_ID.SHOW_PRICES, param.getBool());
      }
      case EVENT_ID.ADD_PRICE_COLUMN:{
        //price_view.setParam(param);
      }
      case EVENT_ID.BUY_NOW: Pages.setParam(param);
    }	
  }
}