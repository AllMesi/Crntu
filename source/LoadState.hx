import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.FlxState;
import Options;
import lime.app.Application;

class LoadState extends FlxState
{
    var l = new FlxText(50, 100, 0, "Loading...", 10, true);
    var l2 = new FlxText(0, 0, 0, "", 10, true);
    override public function create()
    {
        super.create();
        Application.current.window.frameRate = 1000;
        l.setFormat('_sans', 10, FlxColor.WHITE, CENTER);
        l.screenCenter(X);
        add(l);
        l2.setFormat('_sans', 10, FlxColor.WHITE, CENTER);
        add(l2);

                    // l2.text = "You have 1 second to skip applying the settings (SPACE)";
                    new FlxTimer().start(1, function (tmr:FlxTimer)
                        {
                            l2.text = "Applying settings";
                        });

        new FlxTimer().start(1.1, function (tmr:FlxTimer)
        {
            apply();
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
            // if (FlxG.save.data.fs)
            // {
            //     FlxG.save.data.fs = true;
            //     FlxG.save.data.blfs = false;
            //     FlxG.save.data.w = false;
            //     trace('Fullscreen');
            //     Application.current.window.borderless = false;
            //     FlxG.fullscreen = true;
            // }
            // if (FlxG.save.data.blfs)
            // {
            //     FlxG.save.data.fs = false;
            //     FlxG.save.data.blfs = true;
            //     FlxG.save.data.w = false;
            //     trace('Borderless fullscreen');
            //     Application.current.window.x = 0;
            //     Application.current.window.y = 0;
            //     Application.current.window.borderless = true;
            //     Application.current.window.resize(Application.current.window.display.currentMode.width, Application.current.window.display.currentMode.height);
            //     FlxG.fullscreen = false;
            // }
            // if (FlxG.save.data.w)
            // {
            //     FlxG.save.data.fs = false;
            //     FlxG.save.data.blfs = false;
            //     FlxG.save.data.w = true;
            //     trace('Windowed');
            //     Application.current.window.resize(1280, 720);
            //     Application.current.window.borderless = false;
            //     FlxG.fullscreen = false;
            // }
            Application.current.window.resize(Application.current.window.display.currentMode.width, Application.current.window.display.currentMode.height);
            Application.current.window.x = 0;
            Application.current.window.y = 30;
        }
}