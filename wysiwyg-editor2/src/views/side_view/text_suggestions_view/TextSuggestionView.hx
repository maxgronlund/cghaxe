import flash.events.Event;
import flash.geom.Point;

class TextSuggestionView extends PropertyView, implements IView{
  
  private var back:Rectangle;
  private var placeholderScrollPane:AView;
  private var textSuggestionPane:AView;
  private var verticalScrollbar:VerticalScrollbar;
  private var addPlaceholderButton:OneStateTextAndImageButton;
  
  
  public function new(textSuggestionController:IController){	
    super(textSuggestionController);
    back                    = new Rectangle(190, 208, 0x000000, 0xDEDEDE, Rectangle.DONT_DRAW_LINES, Rectangle.USE_FILL);
    
    placeholderScrollPane   = new ScrollPane(textSuggestionController);
    textSuggestionPane      = new TextSuggestionPane(textSuggestionController);
    verticalScrollbar       = new VerticalScrollbar(textSuggestionController, EVENT_ID.SUGGESTION_SCROLL);
    addPlaceholderButton    = new OneStateTextAndImageButton();
    addPlaceholderButton.setFormat(0, 3, 0x333333, 'center');

    Preset.addEventListener(EVENT_ID.TEXT_SUGGESTION_LOADED, onTextSuggestionsLoaded);
    Application.addEventListener(EVENT_ID.SET_DEFAULT_TOOL, onLoadDefaultTool);
    
  }

  override public function init():Void {

		selectButton.init( controller,
            new Point(190,30), 
            new ToolSelectionButton(), 
            new Parameter( EVENT_ID.SHOW_TEXT_SUGGESTIONS));
            
		addPlaceholderButton.init(controller,
            new Point(150,22), 
            new OneStateButtonBackL(), 
            new Parameter( EVENT_ID.ADD_TEXT_SUGGESTION));
            
		addPlaceholderButton.fireOnMouseUp(false);
		
	}
	
	override public function onAddedToStage(e:Event):Void{

		super.onAddedToStage(e);
		addChild(back);
    back.y = 30;

    // font selection pane
    addChild(placeholderScrollPane);
    placeholderScrollPane.setSize(174,160);
    placeholderScrollPane.x = 9;
    placeholderScrollPane.y = 38;
    placeholderScrollPane.addView(textSuggestionPane, 0,0);	
    
    addChild(verticalScrollbar);
    verticalScrollbar.setSize(textSuggestionPane.getFloat('height'), placeholderScrollPane.getFloat('mask_height'));
    verticalScrollbar.x = placeholderScrollPane.getSize().x-2;
    verticalScrollbar.y = placeholderScrollPane.y;
    
    addChild(addPlaceholderButton);
    addPlaceholderButton.x = 20;
    addPlaceholderButton.y = 208;
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
  
  private function onTextSuggestionsLoaded(e:IKEvent):Void{
    
    for( wysiwyg_placeholders in e.getXml().elementsNamed("wysiwyg-placeholders") ) {
      addPlaceholders(wysiwyg_placeholders);
      //for( wysiwyg_placeholder in wysiwyg_placeholders.elementsNamed("wysiwyg-placeholder") ) {
      //  trace('++++++++++++++++++++++++++++++++');
      //  addPlaceholders(wysiwyg_placeholders);
      //  //for( wysiwyg_placeholders in text_suggestion.elementsNamed("wysiwyg-placeholders") ) {
      //  //  addPlaceholders(wysiwyg_placeholders);
      //  //}
      //}
    }
  }
  
  private function onLoadDefaultTool(e:IKEvent):Void{
    verticalScrollbar.setSize(textSuggestionPane.getFloat('height'), placeholderScrollPane.getFloat('mask_height'));
    selectButton.setText('TEXT SUGGESTIONS');  
    addPlaceholderButton.setText('ADD SUGGESTIONS'); 
    addPlaceholderButton.updateLabel(); 
  }
  
  private function addPlaceholders(xml:Xml):Void{
    
    for( wysiwyg_placeholder in xml.elementsNamed("wysiwyg-placeholder") ) {
      var param:IParameter = new Parameter(EVENT_ID.ADD_SUGGESTION_BUTTON);
      param.setXml(wysiwyg_placeholder);
      textSuggestionPane.setParam(param);
    }
  }
  
  override public function getHeight():Int{
    return 238;
  }


  
}