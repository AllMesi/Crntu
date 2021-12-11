package settings;

import flixel.util.FlxColor;
import lime.app.Application;
import openfl.Lib;
import flixel.FlxG;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.text.FlxText;
import flixel.util.FlxTimer;
import flixel.math.FlxMath;

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
        var backdrop = new misc.FlxBackdrop(misc.Paths.image('sb'));
        backdrop.cameras = [FlxG.camera];
		backdrop.velocity.set(0, 150);
		add(backdrop);
  // im bad at tab
        title = new FlxText(50, 0, 0, "Options", 18);
        title.setFormat("_sans", 16, FlxColor.WHITE, CENTER);
        title.screenCenter(X);
        add(title);

        button1 = new FlxButton(0, 0, "Borderless Fullscreen", blfs);
		button1.loadGraphic(misc.Paths.image('ui/spritesheets/buttons/button'), true, 80, 29);
        button1.x = (FlxG.width / 2) - (button1.width / 2);
		button1.y = (FlxG.height / 2);
		add(button1);

       	button2 = new FlxButton(0, 50, "Fullscreen", fs);
		button2.loadGraphic(misc.Paths.image('ui/spritesheets/buttons/button'), true, 80, 20);
        button2.x = ((FlxG.width / 2) - button2.width / 2);
		button2.y = (FlxG.height / 2) + button1.height + 3;
		add(button2);

		button3 = new FlxButton(0, 100, "Windowed", w);
		button3.loadGraphic(misc.Paths.image('ui/spritesheets/buttons/button'), true, 80, 20);
		button3.x = ((FlxG.width / 2) - button3.width / 2);
		button3.y = (FlxG.height / 2) + button1.height + 26;
		add(button3);

		button4 = new FlxButton(0, 150, "Back", b);
		button4.loadGraphic(misc.Paths.image('ui/spritesheets/buttons/button'), true, 80, 20);
        button4.x = ((FlxG.width / 2) - button3.width / 2);
		button4.y = (FlxG.height / 2) + button2.height + 59;
		add(button4);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		if(FlxG.keys.justPressed.ESCAPE)
		{
			FlxG.switchState(new menus.Menu());
		}

		// square.shake(0.0005, 100);
		super.update(elapsed);
	}

    public static function blfs()
	{
		Square.setupWindow(true, false, false, true, true);
	}    

	public static function fs()
	{
		Square.setupWindow(false, true, false, true, true);
	}  

	public static function w()
	{
		Square.setupWindow(false, false, true, true, true);
	}  
  
  public static function wm()
  {
    Square.setupWindow(false, false, false, true, false, true);
  }

    function b()
    {
        FlxG.switchState(new menus.Menu());
    }
}
