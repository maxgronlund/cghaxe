class PMSColorToRGBConverter{
  private var conversion_table:PMSColorToRGBConversionTable;

  public function new(){
    conversion_table = new PMSColorToRGBConversionTable();
  }

  public function convertPMSToRGB(pms:String):UInt{
    return conversion_table.rgb_from_pms(pms);
  }
}