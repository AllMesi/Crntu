package;

import flixel.util.FlxColor;
import lime.app.Application;
import openfl.Lib;
import flixel.FlxG;
import flixel.FlxState;
import flixel.ui.FlxButton;
import square.Square;

class Play extends FlxState
{
	public static var curStage:String = '';
    var button1:FlxButton;
    var button2:FlxButton;
	var button3:FlxButton;
	var button4:FlxButton;
	override public function create()
	{
        button1 = new FlxButton(0, 0, "Back", b);
		button1.loadGraphic(Paths.image('ui/spritesheets/buttons/button'), true, 80, 20);
		add(button1);
		if (!FlxG.sound.music.playing)
			{
				FlxG.sound.playMusic(Paths.music('MenuMusic'));
			}
            trace("Play State");
		super.create();
	}

	override public function update(elapsed:Float)
	{
        Square.shake(0.0005, 100);
		super.update(elapsed);
	}

	function b()
	{
		FlxG.switchState(new Menu());
	}

}
