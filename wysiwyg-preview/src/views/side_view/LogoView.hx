import flash.geom.Point;

class LogoView extends PropertyView, implements IView{
	
	public function new(textController:IController){	
		super(textController);
		backdrop				= new LogoViewBack();
	}
	
	override public function init():Void{
		selectButton.init( controller,
						new Point(190,30), 
						new LogoViewButton(), 
						new Parameter( EVENT_ID.SHOW_LOGO));
	}
	
}