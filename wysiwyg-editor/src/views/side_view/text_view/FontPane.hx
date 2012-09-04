import flash.events.Event;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.geom.Point;
import flash.Vector;

class FontPane extends View, implements IView{

	private var selectedButton:Int;
	private var fontButtons:Vector<OneStateButton>;
	private var buttonIndex:UInt;
	private var buttonPos:UInt;
//	private var defaultParam:IParameter;

	
	
  public function new(textController:IController){	
    super(textController);
    //backdrop				= new TestBack();
    bmpData 				= new BitmapData(172,20,false, COLOR.SCROLLPANE );
    backdrop				= new Bitmap(bmpData);
    
    fontButtons = new Vector<OneStateButton>();
    buttonIndex	= 0;
    selectedButton = 0;
    buttonPos	= 0;
    Application.addEventListener(EVENT_ID.LOAD_DEFAULT_FONT, onLoadDefaultFont);
    Application.addEventListener(EVENT_ID.UPDATE_SIDE_VIEWS, onUpdateSideView);
  }
  
  override public function init():Void{
  
  }
  
  override public function onAddedToStage(e:Event):Void{
    super.onAddedToStage(e);
    addChild(backdrop);
    addButtons();
    
  }
  
  private function addButtons():Void{
    // algerian
    addButton( new AvantGardeGothicButton(), SystemFonts.avant_garde_gothic);
    addButton( new BickhamScriptButton(), SystemFonts.bickham_script);
    addButton( new BurguesScriptButton(), SystemFonts.burgues_script);
    addButton( new CezanneButton(), SystemFonts.cezanne);
    addButton( new CalligraphicButton(), SystemFonts.calligraphic);
    addButton( new CorsivaButton(), SystemFonts.corsiva );
    addButton( new CopperplateButton(), SystemFonts.copperplate );
    addButton( new EccentricButton(), SystemFonts.eccentric );
    addButton( new FinehandButton(), SystemFonts.finehand );
    addButton( new GaramondButton(), SystemFonts.garamond );
    addButton( new MutluButton(), SystemFonts.mutlu__ornamental );
    addButton( new MediciScriptButton(), SystemFonts.medici_script );
    addButton( new PopplResidenzButton(), SystemFonts.poppl_residenz );
    addButton( new TimesRomanButton(), SystemFonts.times_roman);
    addButton( new TrajanProButton(), SystemFonts.trajan_pro );
    
    
    
    backdrop.height = this.height;	
  }
  
  private function addButton(	bmp:Bitmap, fontPackage:FontPackage):Void{
    
    var fontButton:OneStateButton = new OneStateButton();
    fontButton.fireOnMouseUp(false);
    
    var param:IParameter = new Parameter(EVENT_ID.FONT_SELECTED); 
    
    
    param.setString(fontPackage.screenName );
    param.setFontPackage(fontPackage);
    param.setInt(buttonIndex);
    
    fontButton.init(controller, new Point(171,27), bmp, param);
    fontButton.jumpBack(false);
    fontButtons[buttonIndex] = fontButton;
    addChild(fontButtons[buttonIndex]);
    fontButtons[buttonIndex].y = buttonPos;
    
    buttonPos += 27;
    buttonIndex++;

	}
	
	private function onLoadDefaultFont(e:IKEvent):Void{
	  
	  this.selectedButton = 1;
	  fontButtons[0].fire();
	}
	
	private function onUpdateSideView(e:IKEvent):Void{
	  setSelectedButton(GLOBAL.Font.fileName);
	}
	
	override public function setParam(param:IParameter):Void{
	  
	  switch ( param.getLabel() )
	  {
	    case EVENT_ID.FONT_SELECTED:{
 	      deselectFont(param.getInt());
	    }
	  }
	}

  private function setSelectedButton(fontName:String):Void{
    //trace(GLOBAL.Font.fileName);
    for( index in 0...fontButtons.length){
      //trace(fontButtons[index].getParam().getString());
      if (fontButtons[index].getParam().getFontPackage().fileName(0) == GLOBAL.Font.fileName)
      {
        fontButtons[index].setOn(true);
        this.selectedButton = index;
      } else {
        fontButtons[index].setOn(false);
      }
    }
  }
	
  private function deselectFont( id:Int ): Void{
    
    if(id != selectedButton){
      fontButtons[selectedButton].setOn(false);
      this.selectedButton = id;
    }
    
  }
  
  override public function getFloat(id:String):Float{
    switch ( id ){
      case 'height':
        return buttonPos;
    }
    return 0;
  }
  
  override public function setString(id:String, s:String):Void{

    switch ( id )	{
      case EVENT_ID.UPDATE_FONT_PANE: 
        onUpdateFontPane(s);
      case 'disable':{
        enable(false);
      }
      
      case 'enable':{
        enable(true);
      }
    }
  }
  private function enable(b:Bool):Void{
    trace(b);
    for( index in 0...fontButtons.length){
      fontButtons[index].enable(b);
    }
  }
  
  private function onUpdateFontPane(fontName:String):Void{
    trace('onUpdateFontPane');
    fontButtons[selectedButton].setOn(false);
    
    for(i in 0...fontButtons.length){
      var btn:OneStateButton = fontButtons[i];
      if(btn.getParam().getString() == fontName){
        btn.setOn(true);
        selectedButton = i;
        return;
      }
    }
	}
}
