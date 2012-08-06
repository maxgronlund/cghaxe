import flash.events.Event;
import flash.geom.Point;

class TextSuggestionView extends PropertyView, implements IView{
  
  private var placeholderScrollPane:AView;
  private var textSuggestionPane:AView;
  private var verticalScrollbar:VerticalScrollbar;
  private var addPlaceholderButton:OneStateButton;
  
  
  public function new(textController:IController){	
    super(textController);
    backdrop                = new PlaceholdersBackBitmap();
    placeholderScrollPane   = new ScrollPane(textController);
    textSuggestionPane      = new TextSuggestionPane(textController);
    verticalScrollbar       = new VerticalScrollbar(textController, EVENT_ID.SUGGESTION_SCROLL);
    addPlaceholderButton    = new OneStateButton();

    Application.addEventListener(EVENT_ID.PASS_DESIGN_FILE, onPageLayoutLoaded);
    Application.addEventListener(EVENT_ID.SET_DEFAULT_TOOL, onLoadDefaultToold);
    
  }

  override public function init():Void {

		selectButton.init( controller,
            new Point(190,30), 
            new PlaceholdersButton(), 
            new Parameter( EVENT_ID.SHOW_TEXT_SUGGESTIONS));
            
		addPlaceholderButton.init(controller,
            new Point(150,22), 
            new AddPlaceholderButton(), 
            new Parameter( EVENT_ID.ADD_TEXT_SUGGESTION));
            
		addPlaceholderButton.fireOnMouseUp(false);
		
	}
	
	override public function onAddedToStage(e:Event):Void{

		super.onAddedToStage(e);

    // font selection pane
    addChild(placeholderScrollPane);
    placeholderScrollPane.setSize(174,417);
    placeholderScrollPane.x = 9;
    placeholderScrollPane.y = 56;
    placeholderScrollPane.addView(textSuggestionPane, 0,0);	
    
    addChild(verticalScrollbar);
    verticalScrollbar.setSize(textSuggestionPane.getFloat('height'), placeholderScrollPane.getFloat('mask_height'));
    verticalScrollbar.x = placeholderScrollPane.getSize().x-2;
    verticalScrollbar.y = placeholderScrollPane.y;
    
    addChild(addPlaceholderButton);
    addPlaceholderButton.x = 20;
    addPlaceholderButton.y = 488;
  }

  override public function setParam(param:IParameter):Void{

    switch( param.getLabel() ){
      case EVENT_ID.TEXT_SUGGESTION_SELECTED: {
        textSuggestionPane.setParam(param);
      }
    }
	}

  override public function setFloat(id:String, f:Float):Void{
    
    switch ( id ) {
      case EVENT_ID.SUGGESTION_SCROLL:{
        textSuggestionPane.y = -(textSuggestionPane.getFloat('height')-placeholderScrollPane.getFloat('mask_height')) * f;
      }
    }
  }
  
  private function onPageLayoutLoaded(e:IKEvent):Void{
  
    for( design in e.getXml().elementsNamed("design") ) {
      for( text_suggestion in design.elementsNamed("text-suggestion") ) {
        for( wysiwyg_placeholders in text_suggestion.elementsNamed("wysiwyg-placeholders") ) {
          addPlaceholders(wysiwyg_placeholders);
        }
      }
    }
  }
  
  private function onLoadDefaultToold(e:IKEvent):Void{
    verticalScrollbar.setSize(textSuggestionPane.getFloat('height'), placeholderScrollPane.getFloat('mask_height'));
  }
  
  private function addPlaceholders(xml:Xml):Void{
    
    for( wysiwyg_placeholder in xml.elementsNamed("wysiwyg-placeholder") ) {
      var param:IParameter = new Parameter(EVENT_ID.ADD_SUGGESTION_BUTTON);
      param.setXml(wysiwyg_placeholder);
      textSuggestionPane.setParam(param);
    }
  }



  
}