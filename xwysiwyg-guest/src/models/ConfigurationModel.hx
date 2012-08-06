/* responsible for buildeing xml with sim´bling selected */

import flash.events.Event;


class ConfigurationModel extends Model, implements IModel {
	
	public function new(){
		super();
	}
	
	override public function init():Void{
		super.init();
		//Application.addEventListener(CONST.CONFIGURATION_FILE, onConfigurationXmlLoaded);
	}

	// private functions
	private function onConfigurationXmlLoaded(e:IKEvent):Void{
		
		for( catalog in e.getXml().elementsNamed("catalog") ) {
			for(name in catalog.elementsNamed('name')){
			}
			for(printable_pages in catalog.elementsNamed('printable-pages')){
				trace(printable_pages.toString());
				trace('11111111111111111111111');
			}
			
			for(siblings in catalog.elementsNamed('sibling-products')){
				//parseSiblings(siblings);
				trace('22222222222222222222222');
			}
		}
	}
}