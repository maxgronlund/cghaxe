/*  capture the mouse
*
*/

class MouseTrap
{
	public static var empty:Bool  = true;
	public static function capture():Bool{
	  
		if(empty) {
			empty = false;
			trace('captured');
			return true;
		}
		return false;
	}
	
	public static function release():Void{
	  trace('release');
		empty = true;
	}
	
	public static function state():Bool{

		return empty;
	}
	
}