/*  capture the mouse
*
*/

class MouseTrap
{
	public static var empty:Bool  = true;
	public static function capture():Bool{
		if(empty) {
			empty = false;
			return true;
		}
		return false;
	}
	
	public static function release():Void{
		empty = true;
	}
	
}