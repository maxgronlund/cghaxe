package;

class PresetData
{
	private var xml_file:String;
	private var catalog_id:String;
	private var sibling_id:String;
	
	
	
	public function new()
	{
		catalog_id = 'na';
		sibling_id = 'na';
	
	}
	
	public function setParam(label:String, param:String):Void{
		trace(label);
	//	switch(label){
	//		case
	//	}
		
	//	trace(param.getXml().toString());
		
	}
	
	public function setCatalogId(id:String):Void{ 
		catalog_id = id; 
	}
	public function setSiblingId( id:String):Void{ 
		sibling_id = id; 
	}
	
	
	public function getPreset():String{ 
		xml_file = '<?xml version="1.0" encoding="UTF-8"?>\n';
		xml_file += '\t<preset version="0" file_format="0">\n';
		xml_file += '\t\t<catalog-id>'+catalog_id+'</catalog-id>\n';
		xml_file += '\t\t<sibling-id>'+sibling_id+'</sibling-id>\n';
		
		xml_file += '\t</preset>\n';
		
		
		return xml_file;
	  
	  
	}
}