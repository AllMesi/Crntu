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

class GameOver extends FlxSubState
{
	var one:FlxText;
	var b:FlxSprite;
	public function new()
	{
		super();
	}

	override public function create()
	{
		super.create();

		FlxG.sound.music.pause();
		b = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		b.scrollFactor.set();
    b.alpha = 0;
		add(b);
      var bg = new misc.FlxBackdrop(misc.Paths.image('ds'));
      bg.cameras = [FlxG.camera];
      bg.velocity.set(0, 300);
      add(bg);

		Square.unloadmouse(false);

		Square.fps = 120;

		one = new FlxText(0, 0, 0, "You Died", 42);
		one.alpha = 0;
		one.setFormat('_sans', 42, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, true);
		one.screenCenter();
		add(one);

		FlxTween.tween(one, {alpha: 1}, .4, {ease: FlxEase.linear});
		FlxTween.tween(bg, {alpha: 1}, 1, {ease: FlxEase.linear});
    FlxTween.tween(b, {alpha: 1}, 1, {ease: FlxEase.linear});
	}

	override public function update(elapsed)
	{
		super.update(elapsed);
    FlxG.camera.shake(.001, 104950);

		if (!FlxG.keys.pressed.ALT && FlxG.keys.justPressed.ENTER)
		{
			// FlxTween.tween(one, {alpha: 0}, .4, {ease: FlxEase.quartInOut});
			// FlxTween.tween(bg, {alpha: 0}, .4, {ease: FlxEase.quartInOut});
      FlxG.camera.fade(FlxColor.WHITE, 1, false, function()
      {
        FlxG.switchState(new menus.Menu());
        FlxG.camera.fade(FlxColor.WHITE, .4, true, function()
        {
          close();
        });
      });

			// new FlxTimer().start(.4, function(tmr:FlxTimer)
			// {
      //   FlxG.switchState(new Menu());
			// 	close();
			// });
		}
	}
}