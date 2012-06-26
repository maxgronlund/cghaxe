// abstract class of models
package;

import flash.events.EventDispatcher;
import flash.events.Event;

class StringDispatcher extends EventDispatcher
{
	var strParam:IParameter;
	
	public function new()
	{
		
		strParam = new StringParameter('na');
		super();
		
	}
	
	public function dispatch(label:String, str:String):Void
	{	
		
		//var param:IParameter = new URLParameter(label);
		strParam.setLabel(label);
		strParam.setString(str);
		
		var strEvent:StringEvent = new StringEvent( strParam.getLabel(), strParam);
		dispatchEvent(strEvent);
	
	}
}