package ;

import flash.display.Sprite;
import flash.geom.Point;
import flash.events.Event;
import flash.events.MouseEvent;

/**
 * ...
 * @author VF
 */

class OverMessage extends Sprite
{
	
	private var _rect:Rectangle;
  private var _titleTexField:FormatedText;


	public function new() 
	{
		super();
		
		 _rect            = new Rectangle(10, 10, 0x000000, 0xE9E8DB, Rectangle.DRAW_LINES, Rectangle.USE_FILL);
		_titleTexField   = new FormatedText('helvetica', 'title', 14, false, 0x000000, 250);
		
		addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
	}
	
	public function setContent(title :String) :Void
	{
		_titleTexField.x = 8;
		_titleTexField.y = 6;
		
		_titleTexField.setLabel(title);
		
		 var width = _titleTexField.getTextWidth();
		 var height = _titleTexField.getHeight();
		 
		 _rect.setSize(width+16, height + 12);

	}
	
	public function getWidth() :Float
	{
		return _titleTexField.getTextWidth();
	}
	
	 public function onAddedToStage(e:Event):Void
	 {
		addChild(_rect);
		addChild(_titleTexField);
		 
		removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
	}
  
     public function onRemovedFromStage(e:Event):Void
	 {
      removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
	}
	
}