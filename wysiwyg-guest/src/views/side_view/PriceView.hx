import flash.geom.Point;

class PriceView extends PropertyView, implements IView{
	
	public function new(priceController:IController){	
		super(priceController);
		backdrop				= new PriceViewBack();
	}
	
	override public function init():Void{
		selectButton.init( controller,
						new Point(190,30), 
						new PriceViewButton(), 
						new Parameter( EVENT_ID.SHOW_PRICES));
	}

}