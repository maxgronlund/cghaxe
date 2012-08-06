class PrintablePageData
{
	public var order(default, set_order): Int;
	function set_order(i) return order = i
	
	public var id(default, set_id): UInt;
	function set_id(i) return id = i
	
	public var page(default, set_page): String;
	function set_page(s) return page = s
	
	public var maskUrl(default, set_mask): String;
	function set_mask(s) return maskUrl = s
	
	
	public function new(){
		id				= -1;
		order 		= 0;
		page			= '';
		maskUrl		= '';
	}

	public function clone(src:PrintablePageData):Void{
		this.id			= src.id;
		this.order		= src.order;
		this.page			= src.page;
		this.maskUrl	= src.maskUrl;
	}
	
	public function dump():Void{
		trace('id:',id);
		trace('order:',order);
		trace('page:',page);
		trace('maskUrl:',maskUrl); 	
	}
}