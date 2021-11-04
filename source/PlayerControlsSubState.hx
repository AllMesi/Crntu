import lime.app.Application;
import openfl.Lib;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.FlxSubState;
import flixel.FlxSprite;

class PlayerControlsSubState extends FlxSubState
{
	var one:FlxText;
	var two:FlxText;
	var three:FlxText;
	var four:FlxText;
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

		FlxG.mouse.visible = false;

		one = new FlxText(0, 0, 0, "Player Controls", 42);
		one.setFormat('_sans', 42, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, true);

		two = new FlxText(0, 40, 0, '', 42);
		two.setFormat('_sans', 42, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, true);
		two.text = 'R to reset game';

		three = new FlxText(0, 80, 0, '', 42);
		three.setFormat('_sans', 42, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, true);
		three.text = 'C to close game';

		four = new FlxText(0, 120, 0, '', 42);
		four.setFormat('_sans', 42, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, true);
		four.text = 'C and ESC to close this substate';

		add(one);
		add(two);
		add(three);
		add(four);
		FlxG.sound.music.pause();
	}

	override public function update(elapsed)
	{
			super.update(elapsed);
				if (FlxG.keys.justReleased.R)
				{
					FlxG.camera.fade(FlxColor.BLACK, 0.77, false, function()
					{
						new FlxTimer().start(1, function(tmr:FlxTimer)
						{
							FlxG.resetGame();
						}, 0);
					});
				}
				if (FlxG.keys.justReleased.C && FlxG.keys.pressed.ESCAPE)
				{
					FlxG.sound.music.play();
					close();
				}
				else if (FlxG.keys.justReleased.C)
				{
					#if !flash
					Sys.exit(0);
					#end
				}
		}
}