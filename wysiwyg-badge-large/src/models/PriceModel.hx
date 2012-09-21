package;

class PriceModel extends Model, implements IModel
{


	public function new(){	
		super();	
	}
	
	override public function init():Void{	
		super.init();
		
	}
	//	private function passPrices(xml:Xml):Void{
	//	//	trace(xml);
	//		for( prices in xml.elementsNamed("prices") ) {
	//			for( price in prices.elementsNamed("price") ) {
	//				for( country_id in price.elementsNamed("country-id") ) {
	//					trace(country_id.firstChild().nodeValue);	
	//				}
	//				for( site_id in price.elementsNamed("site-id") ) {
	//					trace(site_id.firstChild().nodeValue);	
	//				}
	//				for( price in price.elementsNamed("price") ) {
	//					trace(price.firstChild().nodeValue);	
	//				}
	//				for( min_units in price.elementsNamed("min-units") ) {
	//					trace(min_units.firstChild().nodeValue);	
	//				}
	//				for( max_units in price.elementsNamed("max-units") ) {
	//					trace(max_units.firstChild().nodeValue);	
	//				}
	//			}
	//		}
	//	}
	//
	
}


