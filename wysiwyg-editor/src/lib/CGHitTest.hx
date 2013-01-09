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
	  
		return textFieldHitBitmapPixel(textField, textFieldX, textFieldY, bitmapMask, bitmapMaskX, bitmapMaskY);
	}
	
	public function bitmapHitBitmapMask(bitmap:Bitmap, bitmapX:Int, bitmapY:Int, bitmapMask:Bitmap, bitmapMaskX:Int, bitmapMaskY:Int, bitmapScale:Float=0.25)
	{
	  var hit:Bool = false;
	  
  	if((bitmapX-(bitmap.width*bitmapScale*4)) > bitmapMaskX)
  	  hit = true;
  	else if((bitmapY-(bitmap.height*bitmapScale*4)) > bitmapMaskY)
    	hit = true;
    else if(bitmapX < (bitmapMaskX-(bitmapMask.width/2.08)))
      hit = true;
    else if(bitmapY < (bitmapMaskY-(bitmapMask.height/2.08)))
    	hit = true;
  	
  	if(hit == false)
  	  hit = bitmapDataHitBitmapDataMaskPixelCount(bitmap.bitmapData, bitmapX, bitmapY, bitmapMask.bitmapData, bitmapMaskX, bitmapMaskY, bitmapScale) >= pixelHitAmount;
  	  
		return hit;
	}
	
  public function textFieldHitBitmapPixel(textField:TextField, textFieldX:Int, textFieldY:Int, bitmapMask:Bitmap, bitmapMaskX:Int, bitmapMaskY:Int)
  {
    
    /// The bounds and The Matrix parametres are IMPORTANT
    var bounds = textField.getBounds(textField);
  	var textFieldSnapshot:BitmapData = new BitmapData(Std.int(bounds.width+0.5), Std.int(bounds.height+0.5), true, 0x00000000);   
  	textFieldSnapshot.draw(textField, new Matrix(1,0,0,1,-bounds.x,-bounds.y));
  			
  	return bitmapHitBitmapMask(new Bitmap(textFieldSnapshot), textFieldX, textFieldY, bitmapMask, bitmapMaskX, bitmapMaskY);
  }
  
  public function bitmapDataHitBitmapDataMaskPixelCount(bitmapData:BitmapData, bitmapX:Int, bitmapY:Int, bitmapDataMask:BitmapData, maskX:Int, maskY:Int, bitmapScale:Float=0.25)
  {
    maskX = 0;
    maskY = 0;
    var count = 0;
    var tolerance:UInt = 0xFF444444;
    //var non_transparent_pixels = 0;
    
    //var hitColor:UInt = 0xFF000000;
    
    for(x in 0...bitmapData.width)
    {
        for(y in 0...bitmapData.height)
    	{	
    		if(bitmapData.getPixel32(Std.int(x), Std.int(y)) != 0x00000000)
    		{
    		  //non_transparent_pixels += 1;
    		  
    		  var pixelX:Int = Std.int((((x*bitmapScale*4)-bitmapX)+maskX)*GLOBAL.from_72_to_150_dpi);
    			var pixelY:Int = Std.int((((y*bitmapScale*4)-bitmapY)+maskY)*GLOBAL.from_72_to_150_dpi);
    		  
    			if(bitmapDataMask.getPixel32(pixelX, pixelY) < tolerance)
    			{
    				count = count + 1;
    			}
    			
    		}
    	}
    }
    
    //trace("Nontransparent_pixels:");
    //trace(non_transparent_pixels);
    
    return count;
  }
}