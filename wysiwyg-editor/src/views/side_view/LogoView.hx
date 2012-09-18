import flash.geom.Point;
import flash.events.Event;

class LogoView extends PropertyView, implements IView{
  
  //private var openGreetingsColorPickerButton:TwoStateButton;
  //private var greetingsColorPicker:GreetingsColorPicker;
  private var logosScrollPane:AView;
  private var logosPane:AView;
  private var verticalScrollbar:VerticalScrollbar;
  private var addLogoButton:OneStateButton;
  
  public function new(logosController:IController){	
    super(logosController);
		backdrop				= new LogoViewBack();
    
    logosScrollPane   = new ScrollPane(logosController);
    logosPane         = new GreetingsPane(logosController);
    verticalScrollbar     = new VerticalScrollbar(logosController, EVENT_ID.LOGO_SCROLL);
    addLogoButton     = new OneStateButton();
    
    Preset.addEventListener(EVENT_ID.LOGOS_LOADED, onLogosLoaded);
    Application.addEventListener(EVENT_ID.SET_DEFAULT_TOOL, onLoadDefaultToold);
  }
  
  
  override public function init():Void{

    //openGreetingsColorPickerButton.init(controller,
    //                new Point(32,32), 
    //                new ColorPickerButton(), 
    //                new Parameter( EVENT_ID.OPEN_GREETING_COLOR_PICKER));
    //                
                    
    //selectButton.init( controller,
    //          new Point(190,30), 
    //          new GreetingsViewButton(), 
    //          new Parameter( EVENT_ID.SHOW_GREETINGS));
    
    addLogoButton.init(controller,
            new Point(150,22), 
            new AddPageDesignButton(), 
            new Parameter( EVENT_ID.ADD_GREETING_TO_PAGE));
    
    addLogoButton.fireOnMouseUp(false);
    
    selectButton.init( controller,
						new Point(190,30), 
						new LogoViewButton(), 
						new Parameter( EVENT_ID.SHOW_LOGO));
  }
  
  override public function onAddedToStage(e:Event):Void{
    super.onAddedToStage(e);
    
    //addChild(openGreetingsColorPickerButton);
    //openGreetingsColorPickerButton.x = 10;
    //openGreetingsColorPickerButton.y = 55;
    
    //addChild(greetingsColorPicker);
    //greetingsColorPicker.x = 5;
    //greetingsColorPicker.y = 84;
    
    // font selection pane
    addChild(logosScrollPane);
    logosScrollPane.setSize( 174, 430);
    logosScrollPane.x = 9;
    logosScrollPane.y = 44;
    logosScrollPane.addView(logosPane, 0,0);	
    
    addChild(verticalScrollbar);
    verticalScrollbar.setSize(logosPane.getFloat('height'), logosScrollPane.getFloat('mask_height'));
    verticalScrollbar.x = logosScrollPane.getSize().x-2;
    verticalScrollbar.y = logosScrollPane.y;
    
    addChild(addLogoButton);
    addLogoButton.x = 20;
    addLogoButton.y = 488;
  }
  
  private function onLogosLoaded(e:KEvent):Void{
    //var greetingsXml:Xml = Xml.parse(StringTools.htmlUnescape(e.getXml().toString()));
    
    for(greeting in e.getXml().elementsNamed('greeting')){
      //trace(greeting.toString());
      var param:IParameter = new Parameter(EVENT_ID.ADD_GREETING_BUTTON);
      param.setXml(greeting);
      logosPane.setParam(param);
    }

  }
  
  private function onLoadDefaultToold(e:IKEvent):Void{
    //trace('onLoadDefaultToold');
    //trace(logosPane.getFloat('height'));
    //trace(logosScrollPane.getFloat('mask_height'));
    
    verticalScrollbar.setSize(logosPane.getFloat('height'), logosScrollPane.getFloat('mask_height'));
  }
  
  override public function setParam(param:IParameter):Void{

    switch( param.getLabel() ){
      case EVENT_ID.GREETING_SELECTED: {
        logosPane.setParam(param);
      }
      
      //case EVENT_ID.GREETING_COLOR_SELECTED:{
      //  trace('is there a free meel');
      //  greetingsColorPicker.showView('Look an UFO', false);
      //  openGreetingsColorPickerButton.setOn(false);
      //
      //}
      
      //case EVENT_ID.OPEN_GREETING_COLOR_PICKER:{
      //
      //  if(param.getBool())
      //    this.setChildIndex(greetingsColorPicker, this.numChildren - 1);
      //    greetingsColorPicker.showView('Love Rocks', param.getBool());
      //}
      
      //case EVENT_ID.NO_GREETING_COLOR_SELECTED:{
      //  trace('no color');
      //  greetingsColorPicker.showView('Love Rocks', false);
      //  openGreetingsColorPickerButton.setOn(false);
      //}
      
      
    }
	}
	
	//override public function setFloat(id:String, f:Float):Void{
  //  
  //  switch ( id ) {
  //    
  //    case EVENT_ID.FONT_SCROLL:{
  //      fontPane.y = -(fontPane.getFloat('height')-fontScrollPane.getFloat('mask_height')) * f;
  //    }
  //  }
  //}
	
	override public function setFloat(id:String, f:Float):Void{
    switch ( id ) {
      case EVENT_ID.GREETING_SCROLL:{
        logosPane.y = -(logosPane.getFloat('height')-logosScrollPane.getFloat('mask_height')) * f;
      }
    }
	}
}