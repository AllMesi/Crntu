package subStates;

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

class PlayDebugSettings extends FlxSubState
{
	var one:FlxText;
	var bg:FlxSprite;
	public function new()
	{
		super();
	}

	override public function create()
	{
		super.create();

		FlxG.sound.music.pause();
		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.fromRGB(88, 88, 88, 255));
    bg.y = 1700;
		bg.scrollFactor.set();
		add(bg);

    Square.fps = 60;

		one = new FlxText(0, 0, 0, "DEBUG SETTINGS", 42);
		one.alpha = 0;
		one.setFormat('_sans', 42, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, true);
		add(one);

		FlxTween.tween(one, {alpha: 1}, 0.4, {ease: FlxEase.quartInOut});
		FlxTween.tween(bg, {y: bg.y - 1700}, 0.4, {ease: FlxEase.quartInOut});
	}

	override public function update(elapsed)
	{
		super.update(elapsed);
	}
}