import flash.geom.Point;

class GaramondView extends PropertyView, implements IView{
	
	public function new(foilController:IController){	
		super(foilController);
		backdrop				= new GaramondViewBack();
	}

	override public function init():Void{
		selectButton.init( controller,
						new Point(190,30), 
						new GarmondViewButton(), 
						new Parameter( EVENT_ID.SHOW_GARAMOND));
	}
}