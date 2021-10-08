import lime.app.Application;
import openfl.Lib;
import flixel.ui.FlxButton;
import square.FlxBackdrop;
import square.Square;
import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.FlxSubState;
import flixel.FlxSprite;

class PauseSub extends FlxSubState
{
	var one:FlxText;
	public function new()
	{
		super();
		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0.6;
		bg.scrollFactor.set();
		add(bg);
	}

	override public function create()
	{
		super.create();

		Square.unloadmouse();

		one = new FlxText(0, 0, 0, "Paused", 42);
		one.setFormat('_sans', 42, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, true);
		one.screenCenter();
		add(one);

		FlxG.sound.music.pause();
	}

	override public function update(elapsed)
	{
			super.update(elapsed);
			if (!FlxG.keys.pressed.ALT && FlxG.keys.justPressed.ENTER)
				{
					Square.loadmouse();
					FlxG.sound.music.play();
					close();
				}
				// if (FlxG.keys.pressed.R)
				// {
				// 	FlxG.resetGame();
				// }
				// if (FlxG.keys.pressed.C)
				// {
				// 	Sys.exit(0);
				// }
		}
}