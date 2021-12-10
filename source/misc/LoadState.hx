package misc;

import openfl.Lib;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.FlxState;
import lime.app.Application;

using StringTools;

class LoadState extends FlxState
{
    var l = new FlxText(50, 100, 0, "Loading...", 10, true);
    var l2 = new FlxText(50, 130, 0, "...", 10, true);
    var http = new haxe.Http("https://raw.githubusercontent.com/AllMesi/Square/main/version");
    var returnedData:Array<String> = [];
    override public function create()
    {
        super.create();
        FlxG.mouse.visible = false;
        FlxG.mouse.useSystemCursor = true;
        var one = new FlxText(200, 0, 0, "Loading..", 10);
        one.setFormat('VCR OSD Mono', 30, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, true);
        add(one);
        new FlxTimer().start(.3, function(tmr:FlxTimer)
        {
            Square.log("test log", false);
            // Application.current.window.resize(2000, 720);
			      // Application.current.window.x = -5;
            // Application.current.window.y = -5;

            // var backdrop = new FlxBackdrop(Paths.image('sb'));
            // backdrop.cameras = [FlxG.camera];
            // backdrop.velocity.set(0, 150);
            // add(backdrop);

            Square.fps = 1000;

            FlxG.mouse.visible = true;
            FlxG.mouse.useSystemCursor = true;

            // new FlxTimer().start(.9, function(tmr:FlxTimer)
            // {
                http.onData = function (data:String)
                    {
                        returnedData[0] = data.substring(0, data.indexOf(';'));
                        returnedData[1] = data.substring(data.indexOf('-'), data.length);
                        if (!Square.VER.contains(returnedData[0].trim()) && !OutdatedAlert.leftState)
                        {
                            Square.log('outdated ' + returnedData[0] + ' != ' + Square.VER);
                            OutdatedAlert.needVer = returnedData[0];
                            OutdatedAlert.currChanges = returnedData[1];
                            FlxG.switchState(new OutdatedAlert());
                        }
                        else
                        {
                            FlxG.switchState(new SplashScreens());
                        }
                    }

                    http.onError = function (error) {
                        Square.log('error: $error');
                        FlxG.switchState(new SplashScreens());
                    }
                
                    http.request();
            // });

            l.setFormat('_sans', 10, FlxColor.WHITE, CENTER);
            l.screenCenter(X);
            add(l);

            l2.setFormat('_sans', 10, FlxColor.WHITE, CENTER);
            l2.screenCenter(X);
            add(l2);
            setup();
            FlxG.switchState(new SplashScreens());
        });
    }

    override public function update(elapsed:Float)
    {
      super.update(elapsed);
    }

    public function setup()
    {          
        l2.text = 'Setup func';

        if (FlxG.save.data.fs)
        {
            Square.setup(false, true, false, false, false, true);
            l2.text = 'Fullscreen func';
        }
        else if (FlxG.save.data.blfs)
        {
            Square.setup(true, false, false, false, false, true);
            l2.text = 'Borderless fullscreen func';
        }
        else if (FlxG.save.data.w)
        {
            Square.setup(false, false, true, false, false, true);
            l2.text = 'Windowed func';
        } 
        else if (FlxG.save.data.wm)
        {
            Square.setup(false, false, false, true, false, true);
            l2.text = 'WindowedMax func';
        }
    }
}