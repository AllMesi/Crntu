package menus;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class Tests extends FlxState
{
	var sprite:FlxSprite = new FlxSprite(0, 0);
	var textMenuItems:Array<String> = ['a', 'aaaaafdgfg', 'aaadfgfdg'];
	var selector:FlxSprite;
	var curSelected:Int = 0;
	var grpOptionsTexts:FlxTypedGroup<FlxText>;

	override public function create()
	{
		// var video:MP4Handler = new MP4Handler();
		// video.playMP4(misc.Paths.video('ok'), null, sprite);
		// video.finishCallback = function()
		// {
		// 	Sys.exit(0);
		// }
		// add(sprite);

		grpOptionsTexts = new FlxTypedGroup<FlxText>();
		add(grpOptionsTexts);

		selector = new FlxSprite().makeGraphic(5, 5, FlxColor.RED);
		add(selector);

		for (i in 0...textMenuItems.length)
		{
			var optionText:FlxText = new FlxText(20, (FlxG.height / 2) + (i * 40), 0, textMenuItems[i], 32);
			optionText.setFormat("Comic Neue Angular Bold", 32, FlxColor.WHITE, LEFT);
			optionText.ID = i;
			grpOptionsTexts.add(optionText);
		}

		super.create();
	}

	override public function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.UP)
			curSelected -= 1;

		if (FlxG.keys.justPressed.DOWN)
			curSelected += 1;

		if (curSelected < 0)
			curSelected = textMenuItems.length - 1;

		if (curSelected >= textMenuItems.length)
			curSelected = 0;

		grpOptionsTexts.forEach(function(txt:FlxText)
		{
			txt.color = FlxColor.WHITE;
			// FlxTween.tween(txt, { x:20 }, 2, {ease: FlxEase.quartOut});

			if (txt.ID == curSelected)
			{
				txt.color = FlxColor.YELLOW;
				// FlxTween.tween(txt, { x:40 }, 2, {ease: FlxEase.quartOut});
			}

			txt.screenCenter(X);

			// FlxTween.tween(txt, {color: FlxColor.YELLOW}, .2, {ease: FlxEase.linear});
		});

		if (FlxG.keys.justPressed.SPACE)
		{
			switch (textMenuItems[curSelected])
			{
				case "a":
					FlxG.switchState(new Menu());
			}
		}

		super.update(elapsed);
	}
}
