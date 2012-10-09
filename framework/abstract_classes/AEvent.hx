import flash.text.TextFormat;
import flash.geom.Point;
import flash.events.Event;


class AEvent extends Event
{
  public function getParam():IParameter{
  	trace("getParam: must be overriden in a subclass");
  	return null;
  }
  public function getLabel():String{
  	trace("getLabel: must be overriden in a subclass");
  	return '';
  }
  public function getFloat():Float{
  	trace("getFloat: must be overriden in a subclass");
  	return Math.NaN;
  }
  public function getInt():Int{
  	trace("getInt: must be overriden in a subclass");
  	return -1;
  }
  
  public function getUInt():Int{
  	trace("getUInt: must be overriden in a subclass");
  	return 0;
  }
  
  public function getBool():Bool{
  	trace("getBool: must be overriden in a subclass");
  	return false;
  }
  public function getXml():Xml{
  	trace("getXml: must be overriden in a subclass");
  	return null;
  }
  public function getString():String{
  	trace("getString: must be overriden in a subclass");
  	return '';
  }
  public function getType():String{
  	trace("getType: must be overriden in a subclass");
  	return '';
  }
  public function getDynamic():Dynamic{
  	trace("getDynamic: must be overriden in a subclass");
  	return null;
  }
  public function getParamType():String{
  	trace("getParamType: must be overriden in a subclass");
  	return '';
  }
  
  public function getFontPackage():FontPackage{
  	trace("getFontPackage: must be overriden in a subclass");
  	return null;
  }
  
  public function getPoint():Point{
  	trace("getPoint: must be overriden in a subclass");
  	return new Point(0,0);
  }
  
}