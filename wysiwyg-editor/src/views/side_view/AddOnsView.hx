import flash.geom.Point;
import flash.events.Event;

class AddOnsView extends PropertyView, implements IView{
	
	public function new(addOnsController:IController){	
		super(addOnsController);
		backdrop				= new AddOnsViewBack();
	}
	
	override public function init():Void{
    selectButton.init( controller,
        new Point(190,30), 
        new AddOnsButton(), 
        new Parameter( EVENT_ID.SHOW_ADD_ONS));
	}
}