package;
import flash.Lib;
import flash.display.MovieClip;

class MySVG extends MovieClip {
  public function new () {
    super();
  }
}

class Main extends MovieClip {
  public var svg_movieclip:MovieClip;
  
  public function new () {
    super();
    Lib.current.Content = this;
    Lib.current.addChild(new MySVG());
  }
  
  //public function getMovieClip() : MovieClip {
  //  return svg_movieclip;
  //}
  //
  public static function main() {
    new Main();
  }
}
