// abstract class of models
package;

class VersionCheck
{
	public function new(){}
	
	public function check():Bool{	
		if (flash.Lib.current.loaderInfo.parameters.noversioncheck != null)
            return true;

        var vs : String = flash.system.Capabilities.version;
        var vns : String = vs.split(" ")[1];
        var vn : Array<String> = vns.split(",");

        if (vn.length < 1 || Std.parseInt(vn[0]) < 10)
            return false;

        if (vn.length < 2 || Std.parseInt(vn[1]) > 0)
            return true;

        if (vn.length < 3 || Std.parseInt(vn[2]) > 0)
            return true;

        if (vn.length < 4 || Std.parseInt(vn[3]) >= 525)
            return true;

        return false;
	}
}