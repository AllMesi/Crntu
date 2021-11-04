import flixel.FlxG;

enum Achievements
{
    WED;
}

class Vars 
{
    public static var itswedmydudes:Int = FlxG.save.data.wed;
    private var _achievement:Achievements;
    public function new()
    {
        super();
        itswedmydudes = 0;
        switch (_achievement)
        {
            case WED:
                itswedmydudes++;
        }
    }
}