import flash.geom.Point;

class FoilView extends PropertyView, implements IView{
	public function new(foilController:IController){	
		super(foilController);
		backdrop				= new FoilViewBack();
	}
	
	override public function init():Void{
    selectButton.init( controller,
                        new Point(190,30), 
                        new FoilViewButton(), 
                        new Parameter( EVENT_ID.SHOW_FOIL));
	}
}