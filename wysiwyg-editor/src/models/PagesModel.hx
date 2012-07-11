

import flash.events.Event;
import flash.Vector;

class PagesModel extends Model, implements IModel {
  
  private var pageModels:Vector<PageModel>;
  private var productId:Int;
  private var pageInFocus:PageModel;
  private var backDropsLoaded:UInt;
  private var pageOrder:Int;
  private var pageId:Int;
  private var mask_url:String;
  private var hide_mask_url:String;
  private var page_name:String;
  private var front_of_paper:Bool;
  

  public function new(){	
  	super();
    pageModels  = new Vector<PageModel>();

  }
  
  override public function init():Void{	
    super.init();
    pageInFocus = null;
    hide_mask_url = '';
    Preset.addEventListener(EVENT_ID.BUILD_PAGE, onBuildPage);
    Designs.addEventListener(EVENT_ID.BUILD_DESIGN_PAGE, onBuildDesignPage);
    Preset.addEventListener(EVENT_ID.LOAD_FRONT_SHOT, onLoadFrontShot);
    Preset.addEventListener(EVENT_ID.PAGE_XML_LOADED, onPlaceholdersXml);
    Designs.addEventListener(EVENT_ID.PAGE_XML_LOADED, onPlaceholdersXml);
    Application.addEventListener(EVENT_ID.TRASH_PLACEHOLDERS, onDestroyPlaceholders);
    Designs.addEventListener(EVENT_ID.ADD_PAGE_DESIGN, onAddPagedesign);
    Application.addEventListener(EVENT_ID.PRESET_PAGEDESIGN_XML, onPresetPagedesignXml);
    Application.addEventListener(EVENT_ID.LOAD_DEFAULT_PAGE, onLoadDefaultPage);
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
  
  private function onPlaceholdersXml(e:IKEvent):Void{
    
    //Preset.removeEventListener(EVENT_ID.PAGE_XML_LOADED, onPlaceholdersXml);
    Designs.removeEventListener(EVENT_ID.PAGE_XML_LOADED, onPlaceholdersXml);
    
    var param:IParameter        = new Parameter(EVENT_ID.PAGE_XML_LOADED);
    param.setXml(e.getXml());
    pageModels[e.getInt()].dispatchParameter(param);
  }

  private function onBuildPage( e:IKEvent ):Void{


    for(front in e.getXml().elementsNamed('front')){
       front_of_paper = front.firstChild().nodeValue == 'true';
    }
    
    for(hide_mask in e.getXml().elementsNamed('hide-mask-path')){
      hide_mask_url = hide_mask.firstChild().nodeValue;
    }
    
    for(title in e.getXml().elementsNamed('title')){
      page_name = title.firstChild().nodeValue;
    }

    for(print_mask in e.getXml().elementsNamed('print-mask-path')){
      mask_url = print_mask.firstChild().nodeValue;
    }
    buildPage();
    pageOrder++;
    pageId++;

  }
  
  private function onBuildDesignPage( e:IKEvent ):Void{
    //trace(e.getXml().toString());
    
    front_of_paper = true;
    hide_mask_url = '/assets/fallback/hide_mask.png';
    page_name = 'Design';
    mask_url = '/assets/fallback/hide_mask.png';
    
    buildPage();
    pageOrder++;
    pageId++;
  }
  
  private function buildPage():Void{

     var pageModel:PageModel     = new PageModel();
     pageModel.init();
     pageModel.setInt('pageOrder', pageOrder);
     pageModel.setInt('pageId'   , pageId);
     pageModel.setString('page_name', page_name);
     pageModel.setString('mask_url', mask_url);
     pageModel.setString('hide_mask_url', hide_mask_url);
     pageModel.setBool('front_of_paper', front_of_paper);

     pageInFocus                 = pageModel;
     pageModels.push(pageModel);

     // picked up by PagesView
     var param:Parameter = new Parameter(EVENT_ID.BUILD_PAGE);
     param.setModel(pageModel);
     dispatchParameter(param);

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
      	dispatchParameter(param);
      }
      case EVENT_ID.ADD_PLACEHOLDER:{
        var param:IParameter = new Parameter(EVENT_ID.ADD_PLACEHOLDER);
      	pageInFocus.setParam(param);
      }

      case EVENT_ID.UPDATE_PLACEHOLDER:{
        if(pageInFocus != null){
      	  pageInFocus.dispatchParameter(param);
        }
      }
      case EVENT_ID.TRASH_PLACEHOLDER:{
        pageInFocus.setParam(param);
      }
      
      case EVENT_ID.MOVE_TOOL:{
        dispatchParameter(param);
        pageInFocus.dispatchParameter(param);
      }
      
      case EVENT_ID.TEXT_TOOL:{
        trace(GLOBAL.TEXT_TOOL);
        dispatchParameter(param);
        pageInFocus.dispatchParameter(param);
      }
    }
  }
  
  //override public function getXml(cmd:String):String{
  //  //trace('------------ get xml ----------------');
  //  //var fileStr:String =  '<?xml version="1.0" encoding="UTF-8"?>\n';
  //  var fileStr:String ='';
  //    //for( i in 0...pageModels.length){
  //    //	fileStr += pageModels[i].getXml('foo');
  //    //}
  //    //trace(fileStr);
  //  return fileStr;
  //}
  
  override function getString(id:String):String{
    switch ( id )
    {
      case'file_xml':{
        trace('-----------getString-----------------');
        //var fileStr:String =  '<?xml version="1.0" encoding="UTF-8"?>\n';
        var fileStr:String ='';
        fileStr += '<stage>\n';
        fileStr += '\t<zoom>' + Std.string(Zoom.saveZoom()*1000) + '</zoom>\n';
        fileStr += '\t<pos_x>' + Std.string(GLOBAL.pos_x) + '</pos_x>\n';
        fileStr += '\t<pos_y>' + Std.string(GLOBAL.pos_y) + '</pos_y>\n';
        fileStr += '</stage>\n';
        for( i in 0...pageModels.length){
        	fileStr += (pageModels[i].getXml('foo')).toString();
        }
        trace( fileStr);
        return fileStr;
      }

    }
    return 'bar';
  }

  override function setString(id:String, s:String):Void{
    trace("#€%& HEY YO, don't call me again dude");

  }
  
  override function getBool(id:String):Bool{
    trace("#€%& HEY YO, don't call me again dude");
    return false;
  }
  
  
}