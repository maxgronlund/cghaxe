class PMSColorToRGBConversionRow{
  public var pms_value:String;
  public var red_value:UInt;
  public var green_value:UInt;
  public var blue_value:UInt;
  public var hex_value:UInt;
  public function new(pms_value:String, red_value:String, green_value:String, blue_value:String, hex_value:String){
    this.pms_value = pms_value;
    this.red_value = red_value;
    this.green_value = green_value;
    this.blue_value = blue_value;
    this.hex_value = hex_value;
  }
}