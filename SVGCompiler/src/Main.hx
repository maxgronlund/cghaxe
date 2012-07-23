package;
import flash.Lib;
import flash.display.MovieClip;

class MySVG extends MovieClip {
  public function new () {
    super();
  }
}

class Main extends MovieClip {
  private var movieclip:MovieClip;
  
  public function new () {
    super();
    movieclip = new MySVG();
  }
  
  public function getMovieClip() : MovieClip {
    return movieclip;
  }
  
  public static function main() {
    new Main();
  }
}
