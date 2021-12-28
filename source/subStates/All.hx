package subStates;

import children.Info;
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
import flixel.addons.effects.FlxTrail;

class All extends FlxSubState
{
	var text:FlxText;
	var texgffgt:FlxText;

	var cursor = new FlxSprite().loadGraphic(misc.Paths.image('ui/cursors/cursor9'), true, 14, 14);

	public static var stopped:Bool = true;
	public static var opacity:Float = .0;

	override public function create()
	{
		// canChange = true;
		text = new FlxText(0, 0, 0, "", 16, true);
		text.setFormat("Comic Neue Angular Bold", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLUE, true);
		text.alpha = 0;
		add(text);

		cursor.loadGraphic(misc.Paths.image('ui/cursors/cursor9'), true, 14, 14);
		var trail:FlxTrail = new FlxTrail(cursor, misc.Paths.image('ui/cursors/cursor9'), 1, 1, 1, .5);
		add(trail);
		add(cursor);

		texgffgt = new FlxText(0, 0, 0, "", 16, true);
		texgffgt.setFormat("Comic Neue Angular Bold", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLUE, true);
		add(texgffgt);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		texgffgt.text = Info.currentFPS + "\n" + Info.currentFPSPeak + "\n" + Info.mem + "\n" + Info.memPeak + " ";
		texgffgt.screenCenter(X);
		if (FlxG.keys.justPressed.MINUS)
		{
			FlxG.sound.volume -= .01;
			FlxG.sound.play(misc.Paths.soundwav('drum'), 1, false);
			text.alpha = 1;
			text.text += "\nVolume: " + FlxG.sound.volume * 100 + "%";
			new FlxTimer().start(5, function(tmr:FlxTimer)
			{
				text.alpha = 0;
				text.text = "";
			});
		}
		else if (FlxG.keys.justPressed.PLUS)
		{
			FlxG.sound.volume += .01;
			FlxG.sound.play(misc.Paths.soundwav('drum'), 1, false);
			text.alpha = 1;
			text.text += "\nVolume: " + FlxG.sound.volume * 100 + "%";
			new FlxTimer().start(5, function(tmr:FlxTimer)
			{
				text.alpha = 0;
				text.text = "";
			});
		}

		super.update(elapsed);
	}
}
