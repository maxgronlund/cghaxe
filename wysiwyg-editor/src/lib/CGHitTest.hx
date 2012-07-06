import flash.text.TextField;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.geom.Matrix;

class CGHitTest
{

	public function new()
	{
		
	}
	
	public function textFieldHitBitmap(textField:TextField, bitmapMask:Bitmap)
	{
		return textFieldHitBitmapPixelCount(textField, bitmapMask) >= 1;
	}
	
	public function textFieldHitBitmapPixelCount(textField:TextField, bitmapMask:Bitmap)
	{
		var textFieldSnapshot:BitmapData = new BitmapData(Std.int(textField.width), Std.int(textField.height), true, 0x00000000);
		textFieldSnapshot.draw(textField, new Matrix());
		
		var bitmapDataMask:BitmapData = bitmapMask.bitmapData;
				
		var count = bitmapDataHitBitmapDataMaskPixelCount(textFieldSnapshot, Std.int(textField.x), Std.int(textField.y), bitmapDataMask, Std.int(bitmapMask.x), Std.int(bitmapMask.y));
		
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
				
				if(bitmapData.getPixel32(x, y) != 0)
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