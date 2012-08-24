

import flash.events.Event;
import flash.Vector;

class PagesModel extends Model, implements IModel {
  
  private var pageModels:Vector<PageModel>;
  private var productId:Int;
  private var pageInFocus:PageModel;
  private var backDropsLoaded:UInt;
  private var pageOrder:Int;
  private var pageId:Int;
  private var shop_item_prices:ShopItemPrices;
  //private var print_mask_url:String;
  //private var hide_mask_url:String;
  //private var front_shoot:String;
  //private var page_name:String;
  private var front_of_paper:Bool;
  

  public function new(){	
  	super();
    pageModels  = new Vector<PageModel>();
    shop_item_prices = new ShopItemPrices();
  }
  
  override public function init():Void{	
    super.init();
    Application.addEventListener(EVENT_ID.PASS_PRICE_FILE, onParsePrice);
    //pageInFocus = null;
    //print_mask_url = '';
    //hide_mask_url = '';
    Preset.addEventListener(EVENT_ID.BUILD_PAGE, onBuildPage);                
    Designs.addEventListener(EVENT_ID.BUILD_DESIGN_PAGE, onBuildDesignPage);
    Preset.addEventListener(EVENT_ID.LOAD_FRONT_SHOT, onLoadFrontShot);
    Preset.addEventListener(EVENT_ID.PAGE_XML_LOADED, onPageXmlLoaded);
    Designs.addEventListener(EVENT_ID.PAGE_XML_LOADED, onPageXmlLoaded);
    Application.addEventListener(EVENT_ID.TRASH_PLACEHOLDERS, onDestroyPlaceholders);
    Designs.addEventListener(EVENT_ID.ADD_PAGE_DESIGN, onAddPagedesign);
    Application.addEventListener(EVENT_ID.PRESET_PAGEDESIGN_XML, onPresetPagedesignXml);
    //Application.addEventListener(EVENT_ID.LOAD_DEFAULT_PAGE, onLoadDefaultPage);
  }
  
  private function onAddPagedesign(e:IKEvent):Void{
    pageInFocus.dispatchParameter(new Parameter(EVENT_ID.TRASH_PLACEHOLDERS));
    pageInFocus.dispatchParameter(e.getParam());
  }
  
  private function onLoadDefaultPage(e:IKEvent): Void {
    setPageFocus(0);
  }
  
  private function setPageFocus(id:Int):Void{
    
    if(pageInFocus != null){
      pageInFocus.releaseFocus();
    }
    pageInFocus = pageModels[id];
	}
	
  private function onDestroyPlaceholders(e:IKEvent):Void{
    pageInFocus.dispatchParameter(new Parameter(e.getLabel()));
  }
  
  private function onPresetPagedesignXml(e:IKEvent):Void{
    // relaated to the sidebar
    //trace('onPresetPagedesignXml');
    pageInFocus.dispatchParameter(e.getParam());
  }
  
  private function onPageXmlLoaded(e:IKEvent):Void{

    var param:IParameter        = new Parameter(EVENT_ID.PAGE_XML_LOADED);
    param.setXml(e.getXml());
    pageModels[e.getInt()].dispatchParameter(param);
  }
  
  private function onBuildDesignPage( e:IKEvent):Void{
    trace('2...onBuildDesignPage');

    var pageModel = buildPage(e);
    
    for(design in e.getXml().elementsNamed("design") ) {
      for(title in design.elementsNamed("title") ) {
        pageModel.setString('page_name', title.firstChild().nodeValue.toString());
      }   
    }
    // picked up by PagesView
    var param:Parameter = new Parameter(EVENT_ID.BUILD_DESIGN_PAGE);
    param.setModel(pageModel);
    param.setXml(e.getXml());
    dispatchParameter(param);
  }

  private function onBuildPage( e:IKEvent ):Void{

    var pageModel = buildPage(e);
    for(title in e.getXml().elementsNamed("title") ) {
         pageModel.setString('page_name', title.firstChild().nodeValue.toString());
    } 
    
    // picked up by PagesView
    var param:Parameter = new Parameter(EVENT_ID.BUILD_PAGE);
    param.setModel(pageModel);
    param.setXml(e.getXml());
    dispatchParameter(param);
  }
  
  private function buildPage( e:IKEvent  ): PageModel
  {
    var pageModel:PageModel     = new PageModel();
     pageModel.init();
     pageModel.setInt('pageOrder', pageOrder);
     pageModel.setInt('pageId'   , pageId);
     pageModel.setXml('', e.getXml());
     
     pageOrder++;
     pageId++;
     pageInFocus    = pageModel;
     pageModels.push(pageModel);
     return pageModel;
  }
  
  private function onLoadFrontShot( e:IKEvent ):Void{
    
    var param:IParameter = new Parameter(EVENT_ID.LOAD_FRONT_SHOT);
    param.setString(e.getString());
    pageModels[e.getInt()].dispatchParameter(param);
    
  }

  private function parseImages( xml:Xml ): Void {
    var url:String;
    var id:Int;
    for(image in xml.elementsNamed('image')){
      for(img_path in image.elementsNamed('image-path')){
      	url = img_path.firstChild().nodeValue;
      }
      for(identifier in image.elementsNamed('identifier')){
      	id = Std.parseInt(identifier.firstChild().nodeValue);
      }
      //matchImageToPage(id,url);
      var param:IParameter = new Parameter(EVENT_ID.LOAD_FRONT_SHOT);
      param.setString(url);
      pageModels[id].dispatchParameter(param);
    }
  }

  override public function setParam(param:IParameter):Void{
    switch ( param.getLabel() ){
      case EVENT_ID.SET_TEXT_FORMAT:{
      	pageInFocus.onFontSelected(param);
      }
      case EVENT_ID.PAGE_SELECTED:{
        setPageFocus(param.getInt());
        dispatchParameter(param);
      }
      case EVENT_ID.SHOW_MASK:dispatchParameter(param);
      case EVENT_ID.SAVE_XML:{
      	//getXml('foo');
      	calculatePrice();
      	dispatchParameter(param);
      }
      case EVENT_ID.ADD_PLACEHOLDER:{
        var param:IParameter = new Parameter(EVENT_ID.ADD_PLACEHOLDER);
        pageInFocus.setParam(param);
        
        //calculatePrice();
        //Application.dispatchParameter( new Parameter(EVENT_ID.SELECT_MOVE_TOOL) );
      }

      case EVENT_ID.UPDATE_PLACEHOLDER:{
        if(pageInFocus != null){
      	  pageInFocus.dispatchParameter(param);
      	  //calculatePrice();
        }
      }
      case EVENT_ID.TRASH_PLACEHOLDER:{
        pageInFocus.setParam(param);
        calculatePrice();
      }
      
      case EVENT_ID.MOVE_TOOL:{
        dispatchParameter(param);
        pageInFocus.dispatchParameter(param);
      }
      
      case EVENT_ID.TEXT_TOOL:{
        dispatchParameter(param);
        pageInFocus.dispatchParameter(param);
      }
      
      case EVENT_ID.STD_PMS_COLOR_SELECTED:{ calculatePrice(); }
      case EVENT_ID.FOIL_COLOR_SELECTED:{ calculatePrice(); }
      case EVENT_ID.COLOR_SELECTED:{ calculatePrice(); }
    }
  }
  
  override public function calculatePrice():Void{
    //trace("clearColumns");
    GLOBAL.price_view.update('clearColumns', 0, '');
    //trace("CALCULATE_PRICE");
    dispatchEvent(new Event(EVENT_ID.CALCULATE_PRICE));
  }
  
  override function getString(id:String):String{
    switch ( id )
    {
      case 'price_xml':{
        var fileStr:String ='';
        fileStr += '<prices>\n';
        fileStr += GLOBAL.price_view.getString("price_xml");
        fileStr += '</prices>\n';
      }
      case'file_xml':{
        var fileStr:String ='';
        fileStr += '<stage>\n';
        fileStr += '\t<zoom>'   + Std.string(Zoom.saveZoom()*1000) + '</zoom>\n';
        fileStr += '\t<pos_x>'  + Std.string(GLOBAL.pos_x) + '</pos_x>\n';
        fileStr += '\t<pos_y>'  + Std.string(GLOBAL.pos_y) + '</pos_y>\n';
        fileStr += '</stage>\n';
        for( i in 0...pageModels.length){
        	fileStr += (pageModels[i].getXmlString(CONST.XML_FILE)).toString();
        }
        return fileStr;
      }
      case CONST.PRINT_TYPES:{
        return pageInFocus.getXmlString(CONST.PRINT_TYPES);
      }
    }
    return 'bar';
  }
  
  override function getFloat(id:String):Float{
    switch ( id )
    {
      case 'shop_item_unit_price':{
        return shop_item_prices.getPrice(Std.parseInt(GLOBAL.preset_quantity));
      }
      default: {
        return 0.0;
      }
    }
  }

  override function setString(id:String, s:String):Void{
    trace("#€%& HEY YO, don't call me again dude");

  }
  
  override function getBool(id:String):Bool{
    trace("#€%& HEY YO, don't call me again dude");
    return false;
  }
  
  private function onParsePrice(e:IKEvent):Void{
    shop_item_prices.onParsePrice(e);
  }
  
  
  
  
}