import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.FlxState;
import Options;

class ApplyOptions extends FlxState
{
    var l = new FlxText(50, 100, 0, "Loading...", 10, true);
    var l2 = new FlxText(0, 0, 0, "", 10, true);
    var done = false;
    override public function create()
    {
        l.setFormat('_sans', 10, FlxColor.WHITE, CENTER);
        l.screenCenter(X);
        add(l);
        l2.setFormat('_sans', 10, FlxColor.WHITE, CENTER);
        add(l2);

                    l2.text = "You have 1 second to skip applying the settings (SPACE)";
                    new FlxTimer().start(1, function (tmr:FlxTimer)
                        {
                            l2.text = "Applying settings";
                        });

        new FlxTimer().start(1.1, function (tmr:FlxTimer)
        {
            apply();
            done = true;
            new FlxTimer().start(0.5, function (tmr:FlxTimer)
                {
                    FlxG.switchState(new SplashScreens());
                });
        });
    }
    
    override public function update(elapsed:Float)
    {
        if (FlxG.keys.justPressed.SPACE)
            {
                FlxG.switchState(new SplashScreens());
            }
    }

    public function apply()
        {
            if (FlxG.save.data.fs)
            {
                Options.fs();
            }
            else if (FlxG.save.data.blfs)
            {
                Options.blfs();
            }
            else if (FlxG.save.data.w)
            {
                Options.w();
            }
        }
}