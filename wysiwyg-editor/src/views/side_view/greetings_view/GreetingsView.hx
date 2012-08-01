import flash.geom.Point;
import flash.events.Event;

class GreetingsView extends PropertyView, implements IView{
  
  private var openGreetingsColorPickerButton:TwoStateButton;
  private var greetingsColorPicker:GreetingsColorPicker;
  private var greetingsScrollPane:AView;
  private var greetingsPane:AView;
  private var verticalScrollbar:VerticalScrollbar;
  private var addGreetingButton:OneStateButton;
  
  public function new(greetingsController:IController){	
    super(greetingsController);
    
    openGreetingsColorPickerButton  = new TwoStateButton();
		greetingsColorPicker						= new GreetingsColorPicker(greetingsController);
		
		
    backdrop              = new PlaceholdersBackBitmap();
    greetingsScrollPane   = new ScrollPane(greetingsController);
    greetingsPane         = new GreetingsPane(greetingsController);
    verticalScrollbar     = new VerticalScrollbar(greetingsController, EVENT_ID.GREETING_SCROLL);
    addGreetingButton     = new OneStateButton();
    
    Preset.addEventListener(EVENT_ID.GREETINGS_LOADED, onGeetingsLoaded);
    Application.addEventListener(EVENT_ID.SET_DEFAULT_TOOL, onLoadDefaultToold);
    greetingsColorPicker.visible 	= false;
  }
  
  
  override public function init():Void{

    openGreetingsColorPickerButton.init(controller,
                    new Point(32,32), 
                    new ColorPickerButton(), 
                    new Parameter( EVENT_ID.OPEN_GREETING_COLOR_PICKER));
                    
                    
    selectButton.init( controller,
              new Point(190,30), 
              new GreetingsViewButton(), 
              new Parameter( EVENT_ID.SHOW_GREETINGS));
    
    addGreetingButton.init(controller,
            new Point(150,22), 
            new AddPageDesignButton(), 
            new Parameter( EVENT_ID.ADD_GREETING_TO_PAGE));
    
    addGreetingButton.fireOnMouseUp(false);
  }
  
  override public function onAddedToStage(e:Event):Void{
    super.onAddedToStage(e);
    
    addChild(openGreetingsColorPickerButton);
    openGreetingsColorPickerButton.x = 10;
    openGreetingsColorPickerButton.y = 55;
    
    addChild(greetingsColorPicker);
    greetingsColorPicker.x = 5;
    greetingsColorPicker.y = 84;
    
    // font selection pane
    addChild(greetingsScrollPane);
    greetingsScrollPane.setSize(174,410-52);
    greetingsScrollPane.x = 9;
    greetingsScrollPane.y = 108;
    greetingsScrollPane.addView(greetingsPane, 0,0);	
    
    addChild(verticalScrollbar);
    verticalScrollbar.setSize(greetingsPane.getFloat('height'), greetingsScrollPane.getFloat('mask_height'));
    verticalScrollbar.x = greetingsScrollPane.getSize().x-2;
    verticalScrollbar.y = greetingsScrollPane.y;
    
    addChild(addGreetingButton);
    addGreetingButton.x = 20;
    addGreetingButton.y = 488;
  }
  
  private function onGeetingsLoaded(e:KEvent):Void{
    //var greetingsXml:Xml = Xml.parse(StringTools.htmlUnescape(e.getXml().toString()));
    
    for(greeting in e.getXml().elementsNamed('greeting')){
      //trace(greeting.toString());
      var param:IParameter = new Parameter(EVENT_ID.ADD_GREETING_BUTTON);
      param.setXml(greeting);
      greetingsPane.setParam(param);
    }

  }
  
  private function onLoadDefaultToold(e:IKEvent):Void{
    //trace('onLoadDefaultToold');
    //trace(greetingsPane.getFloat('height'));
    //trace(greetingsScrollPane.getFloat('mask_height'));
    
    verticalScrollbar.setSize(greetingsPane.getFloat('height'), greetingsScrollPane.getFloat('mask_height'));
  }
  
  override public function setParam(param:IParameter):Void{

    switch( param.getLabel() ){
      case EVENT_ID.GREETING_SELECTED: {
        greetingsPane.setParam(param);
      }
      
      case EVENT_ID.GREETING_COLOR_SELECTED:{
        trace('is there a free meel');
        greetingsColorPicker.showView('Look an UFO', false);
        openGreetingsColorPickerButton.setOn(false);
  
      }
      
      case EVENT_ID.OPEN_GREETING_COLOR_PICKER:{
      
        if(param.getBool())
          this.setChildIndex(greetingsColorPicker, this.numChildren - 1);
          greetingsColorPicker.showView('Love Rocks', param.getBool());
      }
      
      case EVENT_ID.NO_GREETING_COLOR_SELECTED:{
        trace('no color');
        greetingsColorPicker.showView('Love Rocks', false);
        openGreetingsColorPickerButton.setOn(false);
      }
      
      
    }
	}
	
	override public function setFloat(id:String, f:Float):Void{
    //switch ( id ) {
    //  case EVENT_ID.DESIGN_SCROLL:{
    //    greetingsPane.y = -(greetingsPane.getFloat('height')-greetingsScrollPane.getFloat('mask_height')) * f;
    //  }
    //}
	}
}