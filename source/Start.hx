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
    var backdrop = new FlxBackdrop(Paths.image('sb'));
	var backdrop2 = new FlxBackdrop(Paths.image('sb'));
	var game:FlxText;
	var tip:FlxText;
	var wed:FlxText;

	override public function create()
	{
		if (Date.now().getDay() == 3)
		{
			wed = new FlxText(0, 0, 0, "ITS WEDSNAYDA MY DUDES", 10, true);
			wed.setFormat("_sans", 16, FlxColor.WHITE);
			add(wed);
		}

		// FlxG.sound.playMusic(Paths.music('MenuMusic'), 0);

		Square.loadmouse();

		FlxG.mouse.useSystemCursor = false;

		Square.loadmouse();

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

		FlxG.camera.fade(FlxColor.BLACK, 0.77, true);

		begin = new FlxText(0, 0, 0, "PRESS SPACE TO BEGIN", 10, true);
		begin.setFormat("_sans", 16, FlxColor.WHITE);
		begin.screenCenter();
		add(begin);

		
		begin.angle = -4;

		new FlxTimer().start(0.01, function(tmr:FlxTimer)
			{
				if (begin.angle == -4)
					FlxTween.angle(begin, begin.angle, 4, 4, {ease: FlxEase.quartInOut});
				if (begin.angle == 4)
					FlxTween.angle(begin, begin.angle, -4, 4, {ease: FlxEase.quartInOut});
			}, 0);

		new FlxTimer().start(10, function (tmr:FlxTimer)
		{
			warnings = new FlxText(0, 0, 0, "Switching to the Menu State in 30 seconds", 10, true);
			warnings.setFormat("_sans", 16, FlxColor.WHITE);
			warnings.screenCenter(X);
			add(warnings);
			ver.y = 15;

			new FlxTimer().start(5, function (tmr:FlxTimer)
			{
				warnings.text = "Switching to the Menu State in 25 seconds";
			});

			new FlxTimer().start(10, function (tmr:FlxTimer)
			{
				new FlxTimer().start(10, function (tmr:FlxTimer)
				{
					warnings.text = "Switching to the Menu State in 10 seconds";

					new FlxTimer().start(5, function (tmr:FlxTimer)
					{
						warnings.text = "Switching to the Menu State in 5 seconds";
					});
				});

					warnings.text = "Switching to the Menu State in 20 seconds";

					new FlxTimer().start(5, function (tmr:FlxTimer)
					{
						warnings.text = "Switching to the Menu State in 15 seconds";
					});
				});

			new FlxTimer().start(29, function (tmr:FlxTimer)
			{
				warnings.text = "Switching to the Menu State in 1 second";
				new FlxTimer().start(1, function (tmr:FlxTimer)
					{
						FlxG.switchState(new Menu());
					});
			});
		});
		
		super.create();
	}

	override public function update(elapsed:Float)
	{
		if (FlxG.keys.pressed.P && FlxG.keys.pressed.O && FlxG.keys.pressed.I)
            FlxG.switchState(new BreathOrElse());

		// new FlxTimer().start(10, function (tmr:FlxTimer)
		// {
		// 	if (tip.alpha > 0)
		// 	{
		// 		tip.alpha -= 0.01;
		// 	}
		// });
		// square.shake(0.0005, 100);

		if (FlxG.keys.justReleased.ESCAPE)
		{
			exitfunc();
		}

		if (FlxG.keys.justPressed.SPACE)
		{
			FlxG.drawFramerate = 1000;
			FlxG.updateFramerate = 1000;
			FlxG.camera.shake(0.05, 0.1, function(){
				FlxG.drawFramerate = 120;
				FlxG.updateFramerate = 120;
			}, true);
			FlxG.camera.flash(FlxColor.WHITE, 1);
			FlxTween.color(begin, 2, FlxColor.WHITE, FlxColor.GREEN, {ease: FlxEase.quartInOut});
			// begin.size = 30;
			Square.log("Fading");
			FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
			{
				Square.log("Switching...");
				FlxG.switchState(new Menu());
			});
		}
		super.update(elapsed);
	}

	function exitfunc()
	{
		ver.screenCenter();
		begin.alpha = 0;
		backdrop.alpha = 0;
		ver.text = "Exiting...";
		Square.exitfunc(true);
	}
}
