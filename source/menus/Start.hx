package menus;

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

class Start extends FlxState
{
	var begin:FlxText;
	var first:FlxText;
	var warnings:FlxText;
	var sound:FlxText;
	var ver:FlxText;
	var options:FlxButton;
	var close:FlxButton;
  var backdrop = new misc.FlxBackdrop(misc.Paths.image('sb'));
	var game:FlxText;
	var tip:FlxText;
	var wed:FlxText;
	var canGo:Bool = false;

	override public function create()
	{

    FlxG.camera.zoom += 1.2;

    FlxG.camera.flash(FlxColor.WHITE, 1, function()
    {
      FlxTween.tween(camera, {zoom: 1}, .5, {ease: FlxEase.quartInOut});
      new FlxTimer().start(.5, function(tmr:FlxTimer)
      {
        canGo = true;
      });
    });

		if (Date.now().getDay() == 3)
		{
			wed = new FlxText(0, 0, 0, "ITS WEDSNAYDA MY DUDES, AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", 10, true);
			wed.setFormat("_sans", 16, FlxColor.WHITE);
			add(wed);
		}

		// FlxG.sound.playMusic(Paths.music('MenuMusic'), 0);

		// Square.loadmouse();

		// FlxG.mouse.useSystemCursor = false;

		// Square.loadmouse();

		// FlxG.sound.music.fadeIn(4, 0, .7);
		
// 		#if desktop
		// close = new FlxButton(FlxG.width - 28, 8, "X", exitfunc);
		// close.onUp.sound = FlxG.sound.load(Paths.sound('select'));
		// close.loadGraphic(Paths.image('ui/spritesheets/buttons/buttonsmall'), true, 20, 20);
		// add(close);
// 		#end

		#if flash
		warnings = new FlxText(0, 0, 0, "this game wont work on flash lmao", 10, true);
		warnings.setFormat("_sans", 16, FlxColor.WHITE);
		warnings.screenCenter(X);
		add(warnings);
		#end

		ver = new FlxText(50, 0, 0, "Square " + Square.VER, 10, true);
		ver.setFormat("_sans", 16, FlxColor.WHITE);
		ver.screenCenter(X);
		add(ver);

		// tip = new FlxText(0, 0, 0, "Press escape in this state to close the game", 10, true);
		// tip.setFormat("_sans", 16, FlxColor.WHITE);
		// add(tip);

    backdrop.cameras = [FlxG.camera];
    backdrop.velocity.set(0, 150);
    add(backdrop);

		// FlxG.camera.fade(FlxColor.BLACK, 0.77, true);

		begin = new FlxText(0, 0, 0, "PRESS SPACE TO BEGIN", 10, true);
		begin.setFormat("_sans", 16, FlxColor.WHITE);
		begin.screenCenter();
		add(begin);

		
		begin.angle = 0;
    FlxTween.angle(begin, begin.angle, -4, 4, {ease: FlxEase.quartInOut});

		new FlxTimer().start(0.01, function(tmr:FlxTimer)
			{
				if (begin.angle == -4)
					FlxTween.angle(begin, begin.angle, 4, 4, {ease: FlxEase.quartInOut});
				if (begin.angle == 4)
					FlxTween.angle(begin, begin.angle, -4, 4, {ease: FlxEase.quartInOut});
			}, 0);
		
		super.create();
	}

	override public function update(elapsed:Float)
	{
		// if (FlxG.keys.pressed.P && FlxG.keys.pressed.O && FlxG.keys.pressed.I)
    //         FlxG.switchState(new BreathOrElse());

		if (FlxG.keys.justReleased.ESCAPE)
		{
			exitfunc();
		}

		if (FlxG.keys.justReleased.SPACE && canGo)
		{
        FlxG.camera.shake(0.05, 0.1);
        FlxG.camera.flash(FlxColor.WHITE, 1);
        FlxTween.color(begin, .77, FlxColor.WHITE, FlxColor.GREEN, {ease: FlxEase.quartInOut});
        Square.log("Fading");
        FlxG.camera.fade(FlxColor.BLACK, .77, false, function()
        {
          Square.log("Switching...");
          FlxG.switchState(new Menu());
        });
        FlxTween.tween(camera, {zoom: 30}, 2, {ease: FlxEase.quartInOut});
		}

    if (FlxG.keys.pressed.SPACE && canGo)
    {
      FlxTween.tween(camera, {zoom: 1.2}, .5, {ease: FlxEase.quartInOut});
    }

		super.update(elapsed);
	}

	function exitfunc()
	{
    FlxG.sound.music.fadeOut(.73, 0);
    FlxG.camera.fade(FlxColor.RED, .77, false, function()
    {
      #if !html5
        Sys.exit(0);
      #end
    });
    FlxTween.tween(camera, {zoom: 10}, .77, {ease: FlxEase.quartInOut});
		// ver.screenCenter(X);
		// begin.alpha = 0;
		// backdrop.alpha = 0;
    // FlxTween.tween(begin, {alpha: 0}, .5, {ease: FlxEase.quartInOut});
    // FlxTween.tween(backdrop, {alpha: 0}, .5, {ease: FlxEase.quartInOut});
		// ver.text = "Exiting...";
    // ver.y = 300;
		// Square.exitfunc(true);
	}
}
