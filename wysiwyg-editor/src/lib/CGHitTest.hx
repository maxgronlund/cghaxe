import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.geom.Matrix;

class CGHitTest
{

  private var pixelHitAmount:Int;
  private var test_tmp:Bitmap;

	public function new()
	{
		pixelHitAmount = 1;
	}
	
	public function textFieldHitBitmap(textField:TextField, textFieldX:Int, textFieldY:Int, bitmapMask:Bitmap, bitmapMaskX:Int, bitmapMaskY:Int)
	{
		return textFieldHitBitmapPixelCount(textField, textFieldX, textFieldY, bitmapMask, bitmapMaskX, bitmapMaskY) >= pixelHitAmount;
	}
	
  public function textFieldHitBitmapPixelCount(textField:TextField, textFieldX:Int, textFieldY:Int, bitmapMask:Bitmap, bitmapMaskX:Int, bitmapMaskY:Int)
  {
    
    /// The bounds and The Matrix parametres are IMPORTANT
    var bounds = textField.getBounds(textField);
  	var textFieldSnapshot:BitmapData = new BitmapData(Std.int(bounds.width+0.5), Std.int(bounds.height+0.5), true, 0x00000000);   
  	textFieldSnapshot.draw(textField, new Matrix(1,0,0,1,-bounds.x,-bounds.y));
  	
  	//// Show the generated bitmap from textfield  used in hittest
  	//if( test_tmp != null)
  	//  flash.Lib.current.removeChild(test_tmp);
  	//test_tmp = new Bitmap(textFieldSnapshot);
  	//test_tmp.x = 100;
  	//test_tmp.y = 100;
  	//flash.Lib.current.addChild(test_tmp);
  	
  	var bitmapDataMask:BitmapData = bitmapMask.bitmapData;
  			
  	var count = bitmapDataHitBitmapDataMaskPixelCount(textFieldSnapshot, textFieldX, textFieldY, bitmapDataMask, bitmapMaskX, bitmapMaskY);
  	
  	return count;
  }
  
  public function bitmapDataHitBitmapDataMaskPixelCount(bitmapData:BitmapData, bitmapX:Int, bitmapY:Int, bitmapDataMask:BitmapData, maskX:Int, maskY:Int)
  {
    maskX = 0;
    maskY = 0;
    var count = 0;
    var non_transparent_pixels = 0;
    
    var hitColor:UInt = 0xFF000000;
    
    for(x in 0...bitmapData.width)
    {
        for(y in 0...bitmapData.height)
    	{	
    		if(bitmapData.getPixel32(Std.int(x), Std.int(y)) != 0x00000000)
    		{
    		  non_transparent_pixels += 1;
    		  
    		  var pixelX:Int = Std.int((x-bitmapX+maskX)*(150/71));
    			var pixelY:Int = Std.int((y-bitmapY+maskY)*(150/72));
    		  
    			if(bitmapDataMask.getPixel32(pixelX, pixelY) == hitColor)
    			{
    				count = count + 1;
    			}
    			
    		}
    	}
    }
    
    trace("Nontransparent_pixels:");
    trace(non_transparent_pixels);
    
    return count;
  }
}