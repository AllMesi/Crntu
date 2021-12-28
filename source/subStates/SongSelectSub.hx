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

class SongSelectSub extends FlxSubState
{
	var one:FlxText;
	var bg:FlxSprite;

	override public function create()
	{
		super.create();

		// FlxG.sound.music.pause();
		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.scrollFactor.set();
		bg.alpha = 0;
		add(bg);

		var button2 = new FlxButton(0, 0, "1", function()
		{
			Crntu.songStart('TheDrop', 100);
		});

		button2.x = (FlxG.width / 2) - (button2.width / 2);
		button2.y = (FlxG.height / 2);
		button2.loadGraphic(misc.Paths.image('ui/spritesheets/buttons/button'), true, 80, 20);
		add(button2);

		var button1 = new FlxButton(0, 0, "2", function()
		{
			Crntu.songStart('fresh', 100);
		});

		button1.x = (FlxG.width / 2) - (button2.width / 2);
		button1.y = (FlxG.height / 2) + 20;
		button1.loadGraphic(misc.Paths.image('ui/spritesheets/buttons/button'), true, 80, 20);
		add(button1);

		one = new FlxText(0, 0, 0, "Select Song (Q to cancel)", 42);
		one.alpha = 0;
		one.setFormat("Comic Neue Angular Bold", 42, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, true);
		add(one);

		FlxTween.tween(one, {alpha: 1}, .4, {ease: FlxEase.quartInOut});
		FlxTween.tween(bg, {alpha: .7}, .4, {ease: FlxEase.quartInOut});
	}

	override public function update(elapsed)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.Q)
		{
			close();
		}
	}
}
