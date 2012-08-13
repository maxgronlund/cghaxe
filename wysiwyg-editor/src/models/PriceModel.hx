package;
import flash.external.ExternalInterface;

class PriceModel {
  private var units:UInt;
  private var foil_price:Float;
  private var one_pms_color_price:Float;
  private var std_color_price:Float;
  
  public function new(units:UInt, foil_price:Float, one_pms_color_price:Float, std_color_price:Float){	
		this.units = units;
		this.foil_price = foil_price;
		this.one_pms_color_price = one_pms_color_price;
		this.std_color_price = std_color_price;
		
		//var string:String = Std.string(units);
		//string = "alert(\"num:" + string + "\")";
		//trace(string);
		//ExternalInterface.call(string);
	}
	
	public function getUnits():UInt{
	  return units;
	}
	public function getFoilPrice():Float{
	  return foil_price;
	}
	public function getOnePmsColorPrice():Float{
	  return one_pms_color_price;
	}
	public function getStdColorPrice():Float{
	  return std_color_price;
	}
}