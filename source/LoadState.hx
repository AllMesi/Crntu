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
        new FlxTimer().start(.1, function(tmr:FlxTimer)
        {
            Square.log("test log", false);
            Application.current.window.resize(1280, 720);
			Application.current.window.x = 500;
            Application.current.window.y = 500;

            var backdrop = new FlxBackdrop(Paths.image('sb'));
            backdrop.cameras = [FlxG.camera];
            backdrop.velocity.set(0, 150);
            add(backdrop);

            FlxG.updateFramerate = 1000;
            FlxG.drawFramerate = 1000;

            FlxG.mouse.visible = true;
            FlxG.mouse.useSystemCursor = true;

            new FlxTimer().start(.9, function(tmr:FlxTimer)
            {
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
                            FlxG.switchState(new Start());
                        }
                    }

                    http.onError = function (error) {
                        Square.log('error: $error');
                        FlxG.switchState(new Start());
                    }
                
                    http.request();
            });

            l.setFormat('_sans', 10, FlxColor.WHITE, CENTER);
            l.screenCenter(X);
            add(l);

            l2.setFormat('_sans', 10, FlxColor.WHITE, CENTER);
            l2.screenCenter(X);
            add(l2);

            setup();
            FlxG.switchState(new Start());
        });
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);
        if (FlxG.keys.justPressed.SPACE)
        {
            FlxG.switchState(new LoadStateLeave());
        }
    }

    public function setup()
    {          
        l2.text = 'Setup func';

        if (FlxG.save.data.fs)
        {
            Square.setup(false, true, false, false, true);
            l2.text = 'Fullscreen func';
        }
        else if (FlxG.save.data.blfs)
        {
            Square.setup(true, false, false, false, true);
            l2.text = 'Borderless fullscreen func';
        }
        else if (FlxG.save.data.w)
        {
            Square.setup(false, false, true, false, true);
            l2.text = 'Windowed func';
        }
    }
}