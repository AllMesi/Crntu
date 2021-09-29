import lime.app.Application;
import openfl.Lib;
import flixel.ui.FlxButton;
import square.FlxBackdrop;
import square.Square;
import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import square.Square;

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

	override public function create()
	{
		// if (!FlxG.sound.music.playing)
		// {
		// 	FlxG.sound.playMusic(Paths.music('MenuMusic'));
		// }
		FlxG.sound.playMusic(Paths.music('MenuMusic'), 0);
		Square.loadmouse();
		FlxG.sound.music.fadeIn(4, 0, 0.7);
//		options = new FlxButton(0, 0, "Options", options);
//		add(options);
		close = new FlxButton(FlxG.width - 28, 8, "X", exitfunc);
		close.onUp.sound = FlxG.sound.load(Paths.sound('select'));
		close.loadGraphic(Paths.image('ui/spritesheets/buttons/buttonsmall'), true, 20, 20);
		// add(close);
		#if flash
		warnings = new FlxText(0, 0, 0, "this game wont work on flash lmao", 10, true);
		warnings.setFormat("_sans", 16, FlxColor.WHITE);
		warnings.screenCenter(X);
		add(warnings);
		#end
		ver = new FlxText(50, 100, 0, "Square " + Square.VER, 10, true);
		ver.setFormat("_sans", 16, FlxColor.WHITE);
		ver.screenCenter(X);
		add(ver);
		tip = new FlxText(0, 0, 0, "Press escape in this state to close the game", 10, true);
		tip.setFormat("_sans", 16, FlxColor.WHITE);
		add(tip);
		new FlxTimer().start(10, function (tmr:FlxTimer)
		{
			tip.text = "";
		});
		backdrop.cameras = [FlxG.camera];
		backdrop.velocity.set(0, 150);
		add(backdrop);
		FlxG.camera.fade(FlxColor.BLACK, 0.77, true);
				if (!FlxG.save.data.welcome)
				{
					first = new FlxText(0, 10, 0, "WELCOME!", 10, true);
					first.setFormat("_sans", 16, FlxColor.WHITE);
					add(first);
					begin = new FlxText(0, 0, 0, "PRESS SPACE TO BEGIN", 10, true);
					begin.setFormat("_sans", 12, FlxColor.WHITE);
					begin.screenCenter();
					add(begin);
					FlxG.save.data.welcome = true;
				}
				else {
					begin = new FlxText(0, 0, 0, "PRESS SPACE TO BEGIN", 10, true);
					begin.setFormat("_sans", 16, FlxColor.WHITE);
					begin.screenCenter();
					add(begin);
				}
		begin.angle = -4;
		new FlxTimer().start(10, function (tmr:FlxTimer)
		{
			warnings = new FlxText(0, 0, 0, "Switching to the Menu State in 30 seconds", 10, true);
			warnings.setFormat("_sans", 16, FlxColor.WHITE);
			warnings.screenCenter(X);
			add(warnings);
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
		trace("Start State");
		super.create();
	}

	override public function update(elapsed:Float)
	{
		if (!FlxG.keys.justPressed.SPACE)
			{
				new FlxTimer().start(0.01, function(tmr:FlxTimer)
				{
					if (begin.angle == -4)
						FlxTween.angle(begin, begin.angle, 4, 0.55, {ease: FlxEase.quartInOut});
					if (begin.angle == 4)
						FlxTween.angle(begin, begin.angle, -4, 0.55, {ease: FlxEase.quartInOut});
				}, 0);
			}
		if (FlxG.keys.justReleased.ESCAPE)
			{
				exitfunc();
			}
		if (FlxG.keys.justPressed.SPACE)
		{
#if !flash
if (!FlxG.save.data.web)
	{
	FlxG.save.data.web = true;
	}
	#end
	Square.shake(0.77, 0.1, function()
	{
		null;
	}, true);
	Square.flash(FlxColor.WHITE, 1);
//	FlxG.sound.play("assets/sounds/confirm.ogg");
	FlxTween.color(begin, 0.30, FlxColor.WHITE, FlxColor.GREEN, {ease: FlxEase.quartInOut});
	begin.size = 30;
	trace("Fading");
	FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
	{
		trace("Switching...");
		FlxG.switchState(new Menu());
	});
		}
		super.update(elapsed);
	}
//	function options()
//	{
//		FlxG.switchState(new Options());
//	}
	function exitfunc()
	{
		FlxG.sound.music.fadeOut(0.77, 0);
		Application.current.window.borderless = true;
		trace("Fading");
		FlxG.camera.fade(FlxColor.BLACK, .77, false, function() {
			Application.current.window.x = 0;
			Application.current.window.y = 30;
			Application.current.window.resize(1280, 720);
			FlxG.fullscreen = false;
			trace("Closing...");
			Sys.exit(0);
		});
	}
}
