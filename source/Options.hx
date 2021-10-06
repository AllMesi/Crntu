package;

import flixel.util.FlxColor;
import lime.app.Application;
import openfl.Lib;
import flixel.FlxG;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.text.FlxText;
import square.FlxBackdrop;
import flixel.util.FlxTimer;
import flixel.math.FlxMath;
import square.Square;

class Options extends FlxState
{
    var title:FlxText;
    var button1:FlxButton;
    var button2:FlxButton;
	var button3:FlxButton;
	var button4:FlxButton;
	var button5:FlxButton;
    var options:FlxButton;
	override public function create()
	{
        var backdrop = new FlxBackdrop(Paths.image('sb'));
        backdrop.cameras = [FlxG.camera];
		backdrop.velocity.set(0, 150);
		add(backdrop);
	
        title = new FlxText(50, 100, 0, "Options", 18);
        title.setFormat("_sans", 16, FlxColor.WHITE, CENTER);
        title.screenCenter(X);
        add(title);
        button1 = new FlxButton(0, 0, "Borderless Fullscreen", blfs);
		button1.loadGraphic(Paths.image('ui/spritesheets/buttons/button'), true, 80, 29);
        button1.x = (FlxG.width / 2) - (button1.width / 2);
		button1.y = (FlxG.height / 2);
		add(button1);
       	button2 = new FlxButton(0, 50, "Fullscreen", fs);
		button2.loadGraphic(Paths.image('ui/spritesheets/buttons/button'), true, 80, 20);
        button2.x = ((FlxG.width / 2) - button2.width / 2);
		button2.y = (FlxG.height / 2) + button1.height + 3;
		add(button2);
		button3 = new FlxButton(0, 100, "Windowed", w);
		button3.loadGraphic(Paths.image('ui/spritesheets/buttons/button'), true, 80, 20);
		button3.x = ((FlxG.width / 2) - button3.width / 2);
		button3.y = (FlxG.height / 2) + button1.height + 26;
		add(button3);
		button4 = new FlxButton(0, 150, "Back", b);
		button4.loadGraphic(Paths.image('ui/spritesheets/buttons/button'), true, 80, 20);
        button4.x = ((FlxG.width / 2) - button3.width / 2);
		button4.y = (FlxG.height / 2) + button2.height + 59;
		add(button4);
		if (!FlxG.sound.music.playing)
			{
				FlxG.sound.playMusic(Paths.music('MenuMusic'));
			}
		super.create();
	}

	override public function update(elapsed:Float)
	{
		if(FlxG.keys.justPressed.ESCAPE)
		{
			FlxG.switchState(new Start());
		}
		Square.shake(0.0005, 100);
		super.update(elapsed);
		super.update(elapsed);
	}

    public static function blfs()
	{
		FlxG.save.data.blfs = !FlxG.save.data.blfs;
		FlxG.save.data.fs = false;
		FlxG.save.data.blfs = true;
		FlxG.save.data.w = false;
		trace('Borderless fullscreen');
		Application.current.window.x = 0;
		Application.current.window.y = 0;
		Application.current.window.borderless = true;
		Application.current.window.resize(Application.current.window.display.currentMode.width, Application.current.window.display.currentMode.height);
		FlxG.fullscreen = false;
		// FlxG.save.data.blfs = blfs();
	}    

	public static function fs()
	{
		FlxG.save.data.fs = !FlxG.save.data.fs;
		FlxG.save.data.fs = true;
		FlxG.save.data.blfs = false;
		FlxG.save.data.w = false;
		trace('Fullscreen');
		Application.current.window.borderless = false;
		FlxG.fullscreen = true;
		// FlxG.save.data.fs = fs();
	}  

public static function w()
	{
		FlxG.save.data.w = !FlxG.save.data.w;
		FlxG.save.data.fs = false;
		FlxG.save.data.blfs = false;
		FlxG.save.data.w = true;
		trace('Windowed');
		Application.current.window.x = 0;
		Application.current.window.y = 30;
		Application.current.window.resize(1280, 720);
		Application.current.window.borderless = false;
		FlxG.fullscreen = false;
		new FlxTimer().start(0.01, function(tmr:FlxTimer)
			{
				// Lib.application.window.move((FlxG.height / 2),(FlxG.width / 2));
			}, 20);
		// FlxG.save.data.w = w();
	}  

	public static function fv() 
	{
			// FlxG.save.data.fps = !FlxG.save.data.fps;
			// (cast(Lib.current.getChildAt(0), Game)).toggleFPS(FlxG.save.data.fps);
			// return true;
	}

    function b()
    {
        FlxG.switchState(new Menu());
    }
}
