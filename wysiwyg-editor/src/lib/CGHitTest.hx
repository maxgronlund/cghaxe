import flash.text.TextField;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.geom.Matrix;

class CGHitTest
{

  private var pixelHitAmount:Int;

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
		var textFieldSnapshot:BitmapData = new BitmapData(Std.int(textField.width), Std.int(textField.height), true, 0x00000000);
		textFieldSnapshot.draw(textField, new Matrix());

		var bitmapDataMask:BitmapData = bitmapMask.bitmapData;
				
		var count = bitmapDataHitBitmapDataMaskPixelCount(textFieldSnapshot, textFieldX, textFieldY, bitmapDataMask, bitmapMaskX, bitmapMaskY);
		
		return count;
	}
	
	public function bitmapDataHitBitmapDataMaskPixelCount(bitmapData:BitmapData, bitmapX:Int, bitmapY:Int, bitmapDataMask:BitmapData, maskX:Int, maskY:Int)
	{
		var count = 0;
		
		var hitColor:UInt = 0xFF000000;
		
		for(x in 0...bitmapData.width)
		{
		    for(y in 0...bitmapData.height)
			{
				var pixelX:Int = x-bitmapX+maskX;
				var pixelY:Int = y-bitmapY+maskY;
				
				if(bitmapData.getPixel32(Std.int(x*0.48), Std.int(y*0.48)) != 0)
				{
					if(bitmapDataMask.getPixel32(pixelX, pixelY) == hitColor)
					{
						count = count + 1;
					}
					
				}
			}
		}
		
		return count;
	}
}