package;
import flash.Lib;
import flash.display.MovieClip;

class MySVG extends MovieClip {
  public function new () {
    super();
  }
}

class Main extends MovieClip {
  
  public var svg:MovieClip;
  
  public function new () {
    super();
    Lib.current.Content = this;
    svg = new MySVG();
    Lib.current.MySVG = MySVG;
    Lib.current.addChild(svg);
  }
  
  //public function getMovieClip() : MovieClip {
  //  return svg_movieclip;
  //}
  //
  public static function main() {
    new Main();
  }
}
