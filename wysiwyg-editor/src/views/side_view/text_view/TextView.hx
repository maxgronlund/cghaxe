import flash.events.Event;
import flash.geom.Point;

class TextView extends PropertyView, implements IView{
	
	private var back:Rectangle;
  private var scrollPaneBack:Rectangle;
	private var fontScrollPane:AView;
	private var fontPane:AView;
	private var fontScrollbar:VerticalScrollbar;

  private var lineSpacePopup:LineSpacePopup;
  private var fontSizePopup:FontSizePopup;
  
  private var textAlign:TextAlign;
  
  private var fixedSizeIButton:OneStateTextAndImageButton;
  private var fixedSizeButton:TwoStateTextAndImageButton;

  private var addTextfieldButton:OneStateTextAndImageButton;
  private var addTextfieldIButton:OneStateTextAndImageButton;
  
  private var lineSpaceLabel:FormatedText;
  private var fontSizeLabel:FormatedText;
  
  private var alignLabel:FormatedText;
  private var fontLabel:FormatedText;
  private var marginLeft:Int;
  
  private var fixedSizeInfo:InfoMessageView;
  private var addTextfieldInfo:InfoMessageView;
  
  var print_types:Xml;
  private var pos:Int;
  
  public function new(textController:IController){	
    super(textController);
    back                  = new Rectangle(190, 486, 0x000000, 0xDEDEDE, Rectangle.DONT_DRAW_LINES, Rectangle.USE_FILL);  
    scrollPaneBack        = new Rectangle(174, 160, 0xC3C3C3, 0xF4F4F4, Rectangle.DRAW_LINES, Rectangle.USE_FILL);                     
    fontScrollPane        = new ScrollPane(textController);
    fontPane    	        = new FontPane(textController);
    fontScrollbar         = new VerticalScrollbar(textController, EVENT_ID.FONT_SCROLL);
    lineSpacePopup        = new LineSpacePopup(textController);
    textAlign             = new TextAlign(textController);
    fontSizePopup         = new FontSizePopup(textController);
    fixedSizeIButton       = new OneStateTextAndImageButton();
    fixedSizeIButton.setFormat(0, 3, 0x333333, 'center');
    fixedSizeButton        = new TwoStateTextAndImageButton();
    fixedSizeButton.setFormat(0, 3, 0x333333, 'center');
    addTextfieldIButton   = new OneStateTextAndImageButton();
    addTextfieldIButton.setFormat(0, 3, 0x333333, 'center');
    addTextfieldButton    = new OneStateTextAndImageButton();
    addTextfieldButton.setFormat(0, 3, 0x333333, 'center');
    
    
    marginLeft            = 8;
    lineSpaceLabel        = new FormatedText('helvetica', '0.0', 11, false, 0x868686);
    fontSizeLabel         = new FormatedText('helvetica', '0.0', 11, false, 0x868686);
    alignLabel            = new FormatedText('helvetica', '0.0', 11, false, 0x868686);
    fontLabel             = new FormatedText('helvetica', '0.0', 11, false, 0x868686);
    

    fixedSizeInfo         = new InfoMessageView(GLOBAL.tool_tips_controller, 
                                                TOOL_TIPS.TEXT_FIXED_SIZE,
                                                'right', 
                                                'top');
                                                
   addTextfieldInfo       = new InfoMessageView(GLOBAL.tool_tips_controller, 
                                               TOOL_TIPS.TEXT_ADD,
                                               'right', 
                                               'top');
   
                                                

  }
  
  override public function init():Void {
    selectButton.init( controller,
        new Point(190,30), 
        new ToolSelectionButton(), 
        new Parameter( EVENT_ID.SHOW_TEXT)); //!!! rename
        
    textAlign.init();
                            
    fixedSizeIButton.init( GLOBAL.tool_tips_controller,
                        new Point(22,22), 
                        new OneStateButtonBackS(), 
                        new Parameter( TOOL_TIPS.TEXT_FIXED_SIZE));
            
    fixedSizeButton.init( controller,
                        new Point(150,22), 
                        new OneStateButtonBackL2State(), 
                        new Parameter( EVENT_ID.USE_GARAMOND));
            
    addTextfieldIButton.init(GLOBAL.tool_tips_controller,
                        new Point(22,22), 
                        new OneStateButtonBackS(), 
                        new Parameter( TOOL_TIPS.TEXT_ADD));
                        
    addTextfieldButton.init(controller,
                        new Point(150,22), 
                        new OneStateButtonBackL(), 
                        new Parameter( EVENT_ID.ADD_PLACEHOLDER));
                        

    //addTextfieldButton.fireOnMouseUp(false);
    Application.addEventListener(EVENT_ID.ADD_SCROLL_BARS, onAddScrollBars);
    Application.addEventListener(EVENT_ID.UPDATE_SIDE_VIEWS, onUpdateSideView);
    Application.addEventListener(EVENT_ID.SET_DEFAULT_TOOL, onLoadDefaultTool);
    Pages.addEventListener(EVENT_ID.PAGE_SELECTED, onPageSelected);
  }
   
  private function onUpdateSideView(e:IKEvent):Void{

    var b:Bool = e.getString() == 'garamond_place_holder';
    fixedSize(b);
    fixedSizeButton.setOn(b);

	}
  
  private function onPageSelected(e:IKEvent):Void{
    //disableTools();
    if(Pages.getString(CONST.PRINT_TYPES) != 'na'){
      print_types = Xml.parse(Pages.getString(CONST.PRINT_TYPES));
      setPrintTypes();
    }
    PositionTools();
  }
  
  private function disableTools():Void{
    //return;
    back.visible                  = false;
    selectButton.visible          = false;
    
    lineSpaceLabel.visible        = false;
    fontSizeLabel.visible         = false;
    lineSpacePopup.visible        = false;
    fontSizePopup.visible         = false;
    
    alignLabel.visible            = false;
    textAlign.visible             = false;
    
    fontLabel.visible             = false;
    
    fixedSizeIButton.visible      = false;
    fixedSizeInfo.visible         = false;
    fixedSizeButton.visible       = false;
    
    scrollPaneBack.visible        = false;
    fontScrollPane.visible        = false;
    fontScrollbar.visible         = false;
    
    addTextfieldInfo.visible      = false;
    addTextfieldIButton.visible   = false;
    addTextfieldButton.visible    = false;

  }
  
  private function onEnableTool(cmd:String):Void{
    
    switch ( cmd ){
      case 'Foil, Garamond':{
        back.visible                  = true;
        selectButton.visible          = true;
        fontLabel.visible             = true;
        fixedSizeButton.visible       = true;
        fixedSizeIButton.visible      = true;
        addTextfieldIButton.visible   = true;                                
        addTextfieldButton.visible    = true;
      }
      case 'PMS':{
        back.visible                  = true;
        selectButton.visible          = true;                                        
        lineSpaceLabel.visible        = true;
        fontSizeLabel.visible         = true;
        lineSpacePopup.visible        = true;
        fontSizePopup.visible         = true;                                        
        alignLabel.visible            = true;
        textAlign.visible             = true;                                        
        fontLabel.visible             = true;                                                                                
        scrollPaneBack.visible        = true;
        fontScrollPane.visible        = true;
        fontScrollbar.visible         = true;                            
        addTextfieldIButton.visible   = true;                                
        addTextfieldButton.visible    = true; 
      }
    }
    PositionTools();
  }
  
  private function PositionTools(): Void{
    pos = 0;
    if(back.visible){
      pos = 34;

      if(lineSpaceLabel.visible){
        lineSpaceLabel.y = pos;
        fontSizeLabel.y = pos;
        pos += 16;
        lineSpacePopup.y = pos;
        fontSizePopup.y = pos;
        pos += 32;
      }
      if(textAlign.visible){
        alignLabel.y = pos;
        pos += 16;
        textAlign.y = pos;
        pos  += 40;
      }
      if(scrollPaneBack.visible || fixedSizeButton.visible){
        fontLabel.y = pos;
        pos += 16;
      }
      if(fixedSizeButton.visible){
        fixedSizeButton.y = pos;
        fixedSizeIButton.y = pos;
        fixedSizeInfo.y = pos;
        pos += 32;
      }
      if(scrollPaneBack.visible){
        scrollPaneBack.y = pos-1;
        fontScrollPane.y = pos;
        fontScrollbar.y = pos;
        pos += 170;
      }
      addTextfieldButton.y = pos;
      addTextfieldIButton.y = pos;
      addTextfieldInfo.y = pos;
      
      back.height = pos;
      pos += 30;
    }
  }
  
  private function setPrintTypes():Void{

    disableTools();
    for(print_types in print_types.elementsNamed('print-types')){
      for(print_type in print_types.elementsNamed('print-type')){
        for(title in print_type.elementsNamed('title')){
          onEnableTool( title.firstChild().nodeValue.toString());
        }
      }
    }
    //PositionTools();
  }
  
  override public function onAddedToStage(e:Event):Void{
    
    super.onAddedToStage(e);
    
    pos = 30;
    addChild(back);
    back.y = pos;
    
    pos += 4;
    
    addChild(lineSpaceLabel);
    lineSpaceLabel.x   = marginLeft;
    lineSpaceLabel.y   = pos;
    
    addChild(fontSizeLabel);
    fontSizeLabel.x   = 110;
    fontSizeLabel.y   = pos;
    
    pos  += 14;
    
    addChild(lineSpacePopup);
    lineSpacePopup.x = 8;
    lineSpacePopup.y = pos;
    
    addChild(fontSizePopup);
    fontSizePopup.x = 110;
    fontSizePopup.y = pos;
    
    pos += 32;
    
    addChild(alignLabel);
    alignLabel.x   = marginLeft;
    alignLabel.y   = pos;
    
    pos  += 14;
    
    addChild(textAlign);
    textAlign.x = marginLeft;
    textAlign.y = pos;
    
    pos += 40;
    
    addChild(fontLabel);
    fontLabel.x = marginLeft;
    fontLabel.y = pos;
    
    pos += 14;
    
    addChild(fixedSizeButton);
    fixedSizeButton.x = marginLeft;
    fixedSizeButton.y = pos;
    
    addChild(fixedSizeIButton);
    fixedSizeIButton.x = marginLeft+154;
    fixedSizeIButton.y = pos;

    pos  += 30;
    
    addChild(scrollPaneBack);
    scrollPaneBack.x    = 8;
    scrollPaneBack.y    = pos;
    
    pos +=1;
    
    addChild(fontScrollPane);
    fontScrollPane.setSize(174,159);
    fontScrollPane.x = 9;
    fontScrollPane.y = pos;
    fontScrollPane.addView(fontPane, 0,0);	
    
    pos += 169;
    
    addChild(addTextfieldButton);
    addTextfieldButton.x = marginLeft;
    addTextfieldButton.y = pos;
    addTextfieldButton.fireOnMouseUp(false);
    
    addChild(addTextfieldIButton);
    addTextfieldIButton.x = marginLeft+154;
    //addTextfieldIButton.y = pos;
    addTextfieldIButton.fireOnMouseUp(false);
    
  
    back.height = pos;
    
    setChildIndex(lineSpacePopup, this.numChildren - 1);
    setChildIndex(fontSizePopup, this.numChildren - 1);
    
    fixedSizeInfo.x = fixedSizeIButton.x;
  	//fixedSizeInfo.y = fixedSizeIButton.y;
    addChild(fixedSizeInfo);
    
    addTextfieldInfo.x = addTextfieldIButton.x;
    addChild(addTextfieldInfo);
    
    PositionTools();

  }
  
  private function onLoadDefaultTool(e:IKEvent):Void{
    selectButton.setText(TRANSLATION.print_button);
    lineSpaceLabel.setLabel(TRANSLATION.line_space);
    fontSizeLabel.setLabel(TRANSLATION.font_size);
    alignLabel.setLabel(TRANSLATION.font_align);
    fixedSizeIButton.setText('?');    
    fixedSizeIButton.updateLabel();
    
    fixedSizeButton.setText(TRANSLATION.garamond);    
    fixedSizeButton.updateLabel();
    
    fontLabel.setLabel(TRANSLATION.select_font);
    addTextfieldIButton.setText('?');    
    addTextfieldIButton.updateLabel();
    addTextfieldButton.setText(TRANSLATION.add_text_field);    
    addTextfieldButton.updateLabel();

    
    fixedSizeInfo.setContent( TOOL_TIPS.text_fixed_size_title,
                              TOOL_TIPS.text_fixed_size_body,
                              TOOL_TIPS.text_fixed_size_link);
                              
    addTextfieldInfo.setContent( TOOL_TIPS.text_add_title,
                                 TOOL_TIPS.text_add_body,
                                 TOOL_TIPS.text_add_link);
  }
  
  private function onAddScrollBars(e:IKEvent):Void{

    if(fontPane.getFloat('height') > fontScrollPane.getFloat('mask_height')){
      addChild(fontScrollbar);
      fontScrollbar.setSize(fontPane.getFloat('height'), fontScrollPane.getFloat('mask_height'));
      fontScrollbar.x = fontScrollPane.getSize().x-2;
      fontScrollbar.y = fontScrollPane.y;
    } 
  }
  
  override public function setFloat(id:String, f:Float):Void{ 
    switch ( id ) {
      case EVENT_ID.FONT_SCROLL:{
        fontPane.y = -(fontPane.getFloat('height')-fontScrollPane.getFloat('mask_height')) * f;
      }
    }
  }
  
  override public function setParam(param:IParameter):Void{
    
    switch ( param.getLabel() ){
      case EVENT_ID.FONT_SELECTED:{
        fontPane.setParam(param);   
      }
      case EVENT_ID.LINE_SPACE_SELECTED:{
        lineSpacePopup.deselectItem(param.getInt());
        lineSpacePopup.show(true); 
        lineSpacePopup.setInt('display', param.getInt());
        
      }
      case EVENT_ID.FONT_SIZE_SELECTED:{
        fontSizePopup.deselectItem(param.getInt());
        fontSizePopup.show(true); 
        fontSizePopup.setInt('display', param.getInt());
      }
      case EVENT_ID.ALIGN_LEFT:{ textAlign.setParam(param); }
      case EVENT_ID.ALIGN_CENTER:{ textAlign.setParam(param); }
      case EVENT_ID.ALIGN_RIGHT:{ textAlign.setParam(param); }
      case EVENT_ID.USE_GARAMOND:{  fixedSize(param.getBool()); }
    }
  }
  
  private function fixedSize(b:Bool):Void{
    
    fontSizePopup.visible     = !b;
    lineSpacePopup.visible    = !b;
    fontSizeLabel.visible     = !b;
    lineSpaceLabel.visible    = !b;
    fontPane.visible          = !b;
    fontScrollbar.visible     = !b;
    lineSpacePopup.setString('use fixedSize', b ?'on':'off');
    if(b){
      fontSizePopup.setString('use fixedSize', 'foo');
      fontPane.setString('use fixedSize', 'foo');
    }
  }

  override public function getHeight():Int{
		return pos;
	}
}