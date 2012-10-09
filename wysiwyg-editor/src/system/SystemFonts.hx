import flash.Vector;


class SystemFonts
{
  public static var allegro:FontPackage;
  public static var amaze:FontPackage;
  public static var avant_garde_gothic:FontPackage;
  public static var bickham_script:FontPackage;
  public static var burgues_script:FontPackage;
  
  
  public static var calligraphic:FontPackage;
  public static var copperplate:FontPackage;
  public static var corsiva:FontPackage;
  public static var cezanne:FontPackage;
//  public static var didotlt_headline:FontPackage;
  public static var eccentric:FontPackage;
  public static var faustus:FontPackage;
  public static var finehand:FontPackage;
  public static var garamond:FontPackage;
  public static var mutlu__ornamental:FontPackage;
  public static var medici_script:FontPackage;
  public static var phyllis:FontPackage;
  public static var poppl_residenz:FontPackage;
  public static var renaissance:FontPackage;
  public static var signet_roundhand:FontPackage;
  public static var staropolski:FontPackage;
  //public static var taggets:FontPackage;
  public static var times_roman:FontPackage;
  public static var trajan_pro:FontPackage;
  public static var volante:FontPackage;
  
  
  public function new(){	
    var defaultSize:Int = 24;
    
    
    // Dynamic loaded fonts
    allegro = new FontPackage('Allegro');
    allegro.addFont('Regular', defaultSize , "allegro");
    
    amaze = new FontPackage('Amaze');
    amaze.addFont('Regular', defaultSize , "amaze");
    
    avant_garde_gothic = new FontPackage('Avant Garde Gothic');
    avant_garde_gothic.addFont('Regular', defaultSize , "avant_garde_gothic");

    bickham_script = new FontPackage('Bickham Cript');
    bickham_script.addFont('Regular', defaultSize , "bickham_script");
    
    burgues_script = new FontPackage('Burgues Cript');
    burgues_script.addFont('Regular', defaultSize , "burgues_script");
    
    
    calligraphic = new FontPackage('Calligraphic');
    calligraphic.addFont('Regular', defaultSize, "calligraphic");
    
    cezanne = new FontPackage('Cezanne');
    cezanne.addFont('Regular', defaultSize , "cezanne");
    
    corsiva = new FontPackage('Corsiva');
    corsiva.addFont('Regular', defaultSize , "corsiva");
    
    copperplate = new FontPackage('Copperplate');
    copperplate.addFont('Regular', defaultSize , "copperplate");

//    didotlt_headline = new FontPackage('Didotlt Headline');
//    didotlt_headline.addFont('Regular', defaultSize, "didotlt_headline");
    
    eccentric = new FontPackage('Eccentric');
    eccentric.addFont('Regular', defaultSize, "eccentric");
    
    faustus = new FontPackage('Faustus');
    faustus.addFont('Regular', defaultSize, "faustus");
    
    finehand = new FontPackage('Finehand');
    finehand.addFont('Regular', defaultSize, "finehand");
    
    garamond = new FontPackage('Garamond');
    garamond.addFont('Regular', defaultSize, "garamond");
 
    mutlu__ornamental = new FontPackage('Mutlu Ornamental');
    mutlu__ornamental.addFont('Regular', defaultSize, "mutlu__ornamental");

    medici_script = new FontPackage('Medici Script');
    medici_script.addFont('Regular', defaultSize, "medici_script");
    
    
//    phyllis = new FontPackage('Phyllis');
//    phyllis.addFont('Regular', defaultSize, "phyllis");
    		
    poppl_residenz = new FontPackage('PopplrResidenz');
    poppl_residenz.addFont('Regular', defaultSize, "poppl_residenz");
  
    
    renaissance = new FontPackage('Renaissance');
    renaissance.addFont('Regular', defaultSize, "renaissance");
    
    signet_roundhand = new FontPackage('Signet Roundhand');
    signet_roundhand.addFont('Regular', defaultSize, "signet_roundhand");
    
    staropolski = new FontPackage('Staropolski');
    staropolski.addFont('Regular', defaultSize, "staropolski");
    
    //taggets = new FontPackage('Taggets');
    //taggets.addFont('Regular', defaultSize, "taggets");
    
    times_roman = new FontPackage('Times Roman');
    times_roman.addFont('Regular', defaultSize, "times_roman");
    
    trajan_pro = new FontPackage('TrajanPro');
    trajan_pro.addFont('Regular', defaultSize, "trajan_pro");
    
    volante = new FontPackage('Volante');
    volante.addFont('Regular', defaultSize, "volante");
    
    
	}
}