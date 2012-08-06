import haxe.macro.Expr;
class CompileDate {
    @:macro public static function getDate() {
        var date = Date.now().toString();
        var pos = haxe.macro.Context.currentPos();
        return { expr : EConst(CString(date)), pos : pos };
    }
}