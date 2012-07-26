import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.display.MovieClip;
import flash.display.GradientType;
import flash.display.SpreadMethod;
import flash.Lib;
import flash.filters.DropShadowFilter;
import flash.filters.BitmapFilter;
import flash.geom.ColorTransform; 
import flash.geom.Matrix;

class Foil extends MovieClip {
	private var foil_filters:Array<BitmapFilter>;
	private var foilMasks:Sprite;
	
	public function new(foiltexture)
	{
		super();
		initFilters();
		
		this.addChild(foiltexture);
		
		foilMasks = new Sprite();
		//this.mask = foilMasks;
		return this;
	}
	
	
	public function foilify(object:DisplayObject): Void
	{
		foilMasks.addChild(object);
	}
	
	public function unfoilify(object:DisplayObject): Void
	{
		foilMasks.removeChild(object);
	}
	
	
	private function initFilters(): Void
	{
		var dropShadowOuter:DropShadowFilter = new DropShadowFilter(); 
		dropShadowOuter.distance = -3.5;
		dropShadowOuter.angle = 40;
		dropShadowOuter.color = 0x000000;
		dropShadowOuter.alpha = 0.45;
		dropShadowOuter.blurX = 1.35;
		dropShadowOuter.blurY = 1.35;
		dropShadowOuter.strength = 0.6;
		dropShadowOuter.quality = 15;
		dropShadowOuter.inner = false;
		dropShadowOuter.knockout = false;
		dropShadowOuter.hideObject = false;
		
		var dropShadow:DropShadowFilter = new DropShadowFilter(); 
		dropShadow.distance = 0.1;
		dropShadow.angle = 40;
		dropShadow.color = 0x000000;
		dropShadow.alpha = 1;
		dropShadow.blurX = 1.25;
		dropShadow.blurY = 1.25;
		dropShadow.strength = 0.35;
		dropShadow.quality = 15;
		dropShadow.inner = true;
		dropShadow.knockout = false;
		dropShadow.hideObject = false;
		
		var innerGlow:DropShadowFilter = new DropShadowFilter(); 
		innerGlow.distance = -0.25;
		innerGlow.angle = 40;
		innerGlow.color = 0xFFFFFF;
		innerGlow.alpha = 1;
		innerGlow.blurX = 1.1;
		innerGlow.blurY = 1.1;
		innerGlow.strength = 5.8;
		innerGlow.quality = 15;
		innerGlow.inner = true;
		innerGlow.knockout = false;
		innerGlow.hideObject = false;
		
		foil_filters = new Array();
		
		foil_filters.push(dropShadow);
		foil_filters.push(dropShadowOuter);
		foil_filters.push(innerGlow);
		
		this.filters = foil_filters;
	}
}