class Valuta
{
  private var valuta:String;
  
  public function new(valuta:String = ''){
    this.valuta = valuta;
  }
  
  public function toString(f:Float):String{
    var decimal_string      = '00';
	  var i:Int               = Std.int(f);
	  var decimal:Float       = (f - i)*10;
	  decimal                 = Std.int(decimal);
	  if(decimal < 10)
	    decimal_string        = '.' + Std.string(decimal) + '0';
	  else 
	    decimal_string        = '.' + Std.string(decimal);
	    
	  return Std.string(i) + decimal_string;
  }
}