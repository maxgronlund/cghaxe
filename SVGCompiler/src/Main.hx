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
<<<<<<< HEAD
    Lib.current.addChild(new MySVG());
=======
    svg = new MySVG();
    Lib.current.MySVG = MySVG;
    Lib.current.addChild(svg);
>>>>>>> 71841eb93ea7093bfa4305dfb94b46f0ab8cced6
  }
  
  //public function getMovieClip() : MovieClip {
  //  return svg_movieclip;
  //}
  //
  public static function main() {
    new Main();
  }
}
