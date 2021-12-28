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

class PauseSub extends FlxSubState
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

		if (FlxG.sound.music.playing)
			FlxG.sound.music.pause();
		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.fromRGB(88, 88, 88, 255));
		bg.y = 1700;
		bg.scrollFactor.set();
		add(bg);

		Crntu.fps = 120;

		// Crntu.unloadmouse();

		one = new FlxText(0, 0, 0, "Paused", 42);
		one.alpha = 0;
		one.setFormat("Comic Neue Angular Bold", 42, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, true);
		one.screenCenter();
		add(one);

		FlxTween.tween(one, {alpha: 1}, 0.4, {ease: FlxEase.quartInOut});
		FlxTween.tween(bg, {y: bg.y - 1700}, 0.4, {ease: FlxEase.quartInOut});

		new FlxTimer().start(.4, function(tmr:FlxTimer)
		{
			Crntu.fps = 30;
		});
	}

	override public function update(elapsed)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.Q)
		{
			var bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.RED);
			bg.alpha = 0;
			bg.scrollFactor.set();
			// add(bg);
			// FlxTween.tween(bg, {alpha: 1}, 3.7, {ease: FlxEase.quartInOut});
			FlxTween.tween(camera, {zoom: 3}, 2, {ease: FlxEase.quartInOut});
			final pause = new GameOver();
			openSubState(pause);
		}

		if (!FlxG.keys.pressed.ALT && FlxG.keys.justPressed.ENTER)
		{
			Crntu.fps = 120;
			FlxTween.tween(one, {alpha: 0}, .4, {ease: FlxEase.quartInOut});
			FlxTween.tween(bg, {alpha: 0, y: bg.y + 1700}, .4, {ease: FlxEase.quartInOut});

			new FlxTimer().start(.4, function(tmr:FlxTimer)
			{
				FlxG.sound.music.play();
				Crntu.fps = 0;
				close();
			});
		}
	}
}
