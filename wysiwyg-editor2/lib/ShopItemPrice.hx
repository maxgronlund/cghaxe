class ShopItemPrice
{
	private var min_units:UInt;
	private var max_units:UInt;
	private var price:Float;
	
	public function new(min_units:UInt, max_units:UInt, price:Float)
	{
	  this.min_units = min_units;
	  this.max_units = max_units;
	  this.price = price;
	}
	
	public function getMinUnits():UInt{
	  return min_units;
	}
	public function getMaxUnits():UInt{
	  return max_units;
	}
	public function getPrice():Float{
	  return price;
	}
}