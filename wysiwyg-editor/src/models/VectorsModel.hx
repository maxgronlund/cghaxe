

import flash.events.Event;
import flash.Vector;

class VectorsModel extends Model, implements IModel {
  
  private var vectorsXml:Xml;

  public function new(){	
    super();
  }
    
 override public function init():Void{	
   super.init();
 }
 
  override public function setParam(param:IParameter):Void{
    
    switch ( param.getLabel() ){
      case EVENT_ID.VECTOR_SELECTED:{
        //trace('DESIGN_SELECTED');
        vectorsXml = param.getXml();
      }
      case EVENT_ID.ADD_VECTOR_TO_PAGE:{
        trace('ADD_Vector_TO_PAGE');
        if(vectorsXml != null){
          dispatchXML(EVENT_ID.ADD_VECTOR_TO_PAGE, vectorsXml);
        }
      }
    }
  }
  
  override public function setString(id:String, s:String):Void{
    
     //switch ( id ){
     //  case 'countrxy':             { countrxy = s;}
     //}
  }
  
  override public function getString(id:String):String{
     //switch ( id ){
     //  case 'countrxy':            {return countrxy;}
     //  
     //}
     return '';
  }
  
  // to do 
  private function onPassVector(e:IKEvent):Void{
    
    //trace('onPassDesign');
    var xml:Xml = Xml.parse(StringTools.htmlUnescape(e.getXml().toString()));

    
  }
  
  override public function getBool(id:String):Bool{
    //switch ( id ){
    //  case 'front_of_paper': true;
    //}
    return false;
  }
}