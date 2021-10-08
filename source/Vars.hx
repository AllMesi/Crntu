import flixel.FlxG;

enum Achievements
{
    WED;
}

class Vars 
{
    switch (type)
    {
        case WED:
            public static var itswedmydudes = 0;
            itswedmydudes = FlxG.save.data.wed;
            itswedmydudes++;
    }
}