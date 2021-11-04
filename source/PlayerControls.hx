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

class PlayerControls extends FlxSubState
{
	var one:FlxText;
	var two:FlxText;
	var three:FlxText;
	var five:FlxText;
	var six:FlxButton;
	var seven:FlxButton;
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

		Square.loadmouse();

		one = new FlxText(0, 0, 0, "Are you sure?", 42);
		one.setFormat('_sans', 42, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, true);

		two = new FlxText(0, 40, 0, "Y = Yes", 42);
		two.setFormat('_sans', 42, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, true);

		three = new FlxText(0, 80, 0, "N = No", 42);
		three.setFormat('_sans', 42, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, true);

		five = new FlxText(0, 120, 0, '', 42);
		five.setFormat('_sans', 42, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, true);
		five.text = 'Incase you like buttons \\/';

		six = new FlxButton(0, 160, "Y", Y);
		six.loadGraphic(Paths.image('ui/spritesheets/buttons/buttonsmall'), true, 20, 20);
		six.onUp.sound = FlxG.sound.load(Paths.sound('select'));

		seven = new FlxButton(30, 160, "N", N);
		seven.loadGraphic(Paths.image('ui/spritesheets/buttons/buttonsmall'), true, 20, 20);
		seven.onUp.sound = FlxG.sound.load(Paths.sound('select'));

		add(one);
		add(two);
		add(three);
		// add(five);
		// add(six);
		// add(seven);
	}

	override public function update(elapsed)
	{
		super.update(elapsed);

		if (FlxG.keys.pressed.Y)
		{
			final pc = new PlayerControlsSubState();
			openSubState(pc);
			one.text = "N to close this substate";
			two.text = "";
			three.text = "";
			one.y = 160;
		}

		if (FlxG.keys.pressed.N)
		{
			close();
		}
	}

	function Y()
	{
		final pc = new PlayerControlsSubState();
		openSubState(pc);
		one.text = "N to close this substate";
		two.text = "";
		three.text = "";
		one.y = 160;
	}

	function N()
	{
		FlxG.switchState(new SplashScreens());
	}
}