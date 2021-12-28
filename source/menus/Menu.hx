package menus;

import flixel.util.FlxTimer;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.ui.FlxButton;
import flixel.FlxState;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxSprite;
import haxe.Timer;
import flash.filters.BitmapFilter;
import flixel.graphics.frames.FlxFilterFrames;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flash.filters.GlowFilter;
import flixel.FlxSprite;
import flixel.addons.effects.FlxTrail;
import flixel.FlxCamera;
import flixel.addons.ui.FlxUIButton;

using StringTools;

class Menu extends FlxTransitionableState
{
	inline static var minuteInMs = 1000 * 60;
	inline static var hourInMs = minuteInMs * 60;
	inline static var dayInMs = hourInMs * 24;

	public static var title:FlxText;
	public static var play:FlxButton;
	public static var back:FlxButton;
	public static var options:FlxButton;

	var sprite:FlxSprite = new FlxSprite(0, 0);

	var reset:FlxButton;
	var vt:FlxButton;
	var test:FlxButton;

	// var CURSORNEW = new FlxSprite(0, 0).drawCircle(CURSORNEW, 0, 0, 8, FlxColor.WHITE);
	var CURSOR = new FlxSprite().makeGraphic(15, 15, FlxColor.TRANSPARENT);
	var CURSORTRAIL = new FlxSprite().makeGraphic(15, 15, FlxColor.TRANSPARENT);
	var crntuLogo = new FlxSprite(FlxG.width - 100, 0).loadGraphic(misc.Paths.image('logo/CrntuNewer'), false, 5, 5);
	#if debug
	var textMenuItems:Array<String> = ['play', 'options', 'debugmenu', 'close'];
	#else
	var textMenuItems:Array<String> = ['play', 'options', 'close'];
	#end
	var optionText:FlxText;
	var curSelected:Int = 0;
	var grpOptionsTexts:FlxTypedGroup<FlxText>;
	var text:FlxText;
	var canGo:Bool;
	var ok:FlxCamera;
	var ok2:FlxCamera;
	var http = new haxe.Http("https://raw.githubusercontent.com/AllMesi/Square/main/version");
	var returnedData:Array<String> = [];

	// var thecursorthingidklol = new misc.CursorSprite(0, 0);
	// public static var backdrop = new misc.FlxBackdrop(misc.Paths.image('sb'));

	override function create()
	{
		FlxTransitionableState.defaultTransIn = new TransitionData();
		FlxTransitionableState.defaultTransOut = new TransitionData();
		transOut = FlxTransitionableState.defaultTransOut;

		FlxG.switchState(new settings.Options());

		grpOptionsTexts = new FlxTypedGroup<FlxText>();

		ok = new FlxCamera();
		ok2 = new FlxCamera();

		ok2.bgColor.alpha = 0;
		ok.bgColor.alpha = 0;
		ok2.angle = 1;

		FlxG.debugger.visible = false;

		text = new FlxText(0, 0, 0, "Made By AllMesi", 23, true);
		text.setFormat("Comic Neue Angular Bold", 23, FlxColor.WHITE, CENTER);
		text.alpha = 0;
		text.screenCenter();

		canGo = false;

		var fade = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);

		fade.scrollFactor.set();

		persistentUpdate = persistentDraw = true;

		FlxG.cameras.reset(ok);
		FlxG.cameras.add(ok2);

		FlxCamera.defaultCameras = [ok];

		// var video:MP4Handler = new MP4Handler();
		// video.playMP4(misc.Paths.video('ok'), null, sprite);
		// video.finishCallback = function()
		// {
		// 	Sys.exit(0);
		// }
		// add(sprite);

		var trail:FlxTrail = new FlxTrail(CURSOR, misc.Paths.image('ui/cursors/cursor9'), 1, 1, 1, .5);
		misc.DiscordClient.changePresence("In The Menus", null);
		CURSOR.loadGraphic(misc.Paths.image('ui/cursors/cursor9'), true, 14, 14);
		CURSOR.alpha = 0;
		CURSORTRAIL.loadGraphic(misc.Paths.image('ui/cursors/cursor9trail'), true, 14, 14);
		CURSORTRAIL.alpha = 0;
		// CURSOR.loadGraphic(misc.Paths.image('ui/cursors/cursor9'), true, 14, 14);
		// CURSOR.alpha = 0;
		// CURSORTRAIL.loadGraphic(misc.Paths.image('ui/cursors/cursor9an'), true, 14, 14);
		// CURSORTRAIL.alpha = 0;
		// FlxG.camera.zoom += 1.2;
		// FlxTween.tween(camera, {zoom: 1}, .5, {ease: FlxEase.quartInOut});
		// FlxG.mouse.visible = true;
		// FlxG.mouse.set
		FlxG.mouse.enabled = true;

		// backdrop.cameras = [FlxG.camera];
		// backdrop.alpha = 0;
		// backdrop.velocity.set(0, 150);
		// add(backdrop);

		final lol = new subStates.All();
		openSubState(lol);

		title = new FlxText(50, 0, 0, "Crntu Menu", 18);
		title.setFormat("Comic Neue Angular Bold", 16, FlxColor.WHITE, CENTER);
		title.screenCenter(X);
		title.alpha = 0;
		// add(title);

		play = new FlxButton(0, 0, "Play", p);
		// play.x = (FlxG.width / 2) - (play.width / 2);
		play.x = 50;
		play.y = (FlxG.height / 2) + 50;
		play.loadGraphic(misc.Paths.image('ui/spritesheets/buttons/button'), true, 80, 20);
		play.onUp.sound = FlxG.sound.load(misc.Paths.sound('select'));
		play.alpha = 0;
		// add(play);

		// new FlxTimer().start(60, function(tmr:FlxTimer)
		// {
		// 	FlxG.resetState();
		// });

		for (i in 0...textMenuItems.length)
		{
			optionText = new FlxText(20, (FlxG.height / 2) + 100 + (i * 40), 0, textMenuItems[i], 32);
			optionText.setFormat("Comic Neue Angular Bold", 32, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLUE, true);
			optionText.ID = i;
			grpOptionsTexts.add(optionText);
		}

		options = new FlxButton(0, 30, "Options", o);
		// options.x = ((FlxG.width / 2) - options.width / 2);
		options.x = 50;
		options.y = (FlxG.height / 2) + play.height + 3 + 50;
		options.loadGraphic(misc.Paths.image('ui/spritesheets/buttons/button'), true, 80, 20);
		options.onUp.sound = FlxG.sound.load(misc.Paths.sound('select'));
		options.alpha = 0;
		// add(options);

		reset = new FlxButton(100, 0, "reset", r);
		reset.loadGraphic(misc.Paths.image('ui/spritesheets/buttons/button'), true, 80, 20);
		// add(reset);

		vt = new FlxButton(0, 0, "VT", vtlol);
		vt.loadGraphic(misc.Paths.image('ui/spritesheets/buttons/button'), true, 80, 20);
		add(vt);

		back = new FlxButton(0, 30, "Back", b);
		// back.x = ((FlxG.width / 2) - back.width / 2);
		back.x = 50;
		back.y = (FlxG.height / 2) + options.height + 26 + 50;
		back.loadGraphic(misc.Paths.image('ui/spritesheets/buttons/button'), true, 80, 20);
		back.onUp.sound = FlxG.sound.load(misc.Paths.sound('select'));
		back.alpha = 0;
		// add(back);

		add(text);
		add(crntuLogo);
		add(fade);
		// add(thecursorthingidklol);
		// add(CURSORTRAIL);

		// FlxTween.tween(options, {alpha: 1}, .2, {ease: FlxEase.linear});
		// FlxTween.tween(back, {alpha: 1}, .2, {ease: FlxEase.linear});
		// FlxTween.tween(play, {alpha: 1}, .2, {ease: FlxEase.linear});
		// FlxTween.tween(title, {alpha: 1}, .2, {ease: FlxEase.linear});
		// FlxTween.tween(backdrop, {alpha: 1}, .2, {ease: FlxEase.linear});
		crntuLogo.x = (FlxG.width / 2);
		crntuLogo.y = (FlxG.height / 2);
		FlxTween.tween(crntuLogo, {y: crntuLogo.y -= 20}, 2, {ease: FlxEase.quartInOut});

		new FlxTimer().start(0.01, function(tmr:FlxTimer)
		{
			if (crntuLogo.y == (FlxG.height / 2) - 20)
				FlxTween.tween(crntuLogo, {y: crntuLogo.y += 40}, 2, {ease: FlxEase.quartInOut});
			if (crntuLogo.y == (FlxG.height / 2) + 20)
				FlxTween.tween(crntuLogo, {y: crntuLogo.y -= 20}, 2, {ease: FlxEase.quartInOut});
		}, 0);

		// FlxTween.angle(crntuLogo, crntuLogo.angle, -4, 4, {ease: FlxEase.quartInOut});

		// new FlxTimer().start(.01, function(tmr:FlxTimer)
		// {
		// 	if (crntuLogo.angle == -4)
		// 		FlxTween.angle(crntuLogo, crntuLogo.angle, 4, 4, {ease: FlxEase.quartInOut});
		// 	if (crntuLogo.angle == 4)
		// 		FlxTween.angle(crntuLogo, crntuLogo.angle, -4, 4, {ease: FlxEase.quartInOut});
		// }, 0);

		new FlxTimer().start(1, function(tmr:FlxTimer)
		{
			// optionText.alpha = 0;
			crntuLogo.alpha = 0;
			text.alpha = 1;
			FlxTween.tween(fade, {alpha: 0}, .2, {ease: FlxEase.linear});
			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				FlxTween.tween(fade, {alpha: 1}, .2, {ease: FlxEase.linear});
				new FlxTimer().start(.2, function(tmr:FlxTimer)
				{
					// optionText.alpha = 1;
					crntuLogo.alpha = 1;
					text.alpha = 0;
					canGo = true;
					add(grpOptionsTexts);
					// add(trail);
					// add(CURSOR);
					crntuLogo.cameras = [ok2];
					fade.cameras = [ok2];
					// thecursorthingidklol.cameras = [ok2];
					FlxTween.tween(fade, {alpha: 0}, .2, {ease: FlxEase.linear});
					new FlxTimer().start(.3, function(tmr:FlxTimer)
					{
						remove(fade);
					});
					// Cursor.load();
					Crntu.Cursor.load();
					// FlxTween.tween(thecursorthingidklol, {alphaa: 1}, 2, {ease: FlxEase.linear});
					// FlxTween.tween(CURSORTRAIL, {alpha: 1}, 2, {ease: FlxEase.linear});
				});
			});
		});

		super.create();
	}

	private function p()
	{
		// FlxG.switchState(new menus.SelectSong());
		final sel = new subStates.SongSelectSub();
		openSubState(sel);
	}

	private function b()
	{
		FlxG.switchState(new menus.Start());
	}

	private function o()
	{
		FlxTween.tween(options, {alpha: 0}, .2, {ease: FlxEase.linear});
		FlxTween.tween(back, {alpha: 0}, .2, {ease: FlxEase.linear});
		FlxTween.tween(play, {alpha: 0}, .2, {ease: FlxEase.linear});
		// FlxTween.tween(crntuLogo, {y: crntuLogo.y = FlxG.height - 100}, 1, {ease: FlxEase.quartOut});
		title.text = "Crntu Settings";
		final pause = new settings.OptionsExper(); // .hx
		openSubState(pause);
	}

	private function r()
	{
		FlxG.resetGame();
		//* why *//
	}

	public function vtlol()
	{
		// Crntu.logInfo('Checking for an update...');
		// // http.onData = function(data:String)
		// // {
		// 	returnedData[0] = data.substring(0, data.indexOf(';'));
		// 	returnedData[1] = data.substring(data.indexOf('-'), data.length);
		// 	if (!Crntu.VER.contains(returnedData[0].trim()) && !misc.OutdatedAlert.leftState)
		// 	{
		// 		Crntu.logInfo('Found an update!');
		// 		Crntu.log('outdated ' + returnedData[0] + ' != ' + Crntu.VER);
		// 		misc.OutdatedAlert.needVer = returnedData[0];
		// 		misc.OutdatedAlert.currChanges = returnedData[1];
		// 		FlxG.switchState(new misc.OutdatedAlert());
		// 	}
		// // }
		// http.onError = function(error)
		// {
		// 	Crntu.logInfo('Didnt find an update + error');
		// 	Crntu.logError('error: $error');
		// }
	}

	override public function update(elapsed:Float)
	{
		// Crntu.shake(0.0005, 100);

		super.update(elapsed);

		// if (FlxG.keys.pressed.G)
		//   Cursor.stop();
		// else
		//   Cursor.start();

		// remove(ssssssssskjhjbhadbhjaFJHGGVHFJGJBtuyit4);

		if (FlxG.keys.justPressed.UP || FlxG.mouse.wheel == 1)
			curSelected -= 1;

		if (FlxG.keys.justPressed.DOWN || FlxG.mouse.wheel == -1)
			curSelected += 1;

		if (FlxG.mouse.justPressedRight)
		{
			FlxG.camera.fade(FlxColor.BLACK, .77, false, function()
			{
				Sys.exit(0);
			});
		}

		if (curSelected < 0)
			curSelected = textMenuItems.length - 1;

		if (curSelected >= textMenuItems.length)
			curSelected = 0;

		grpOptionsTexts.forEach(function(txt:FlxText)
		{
			txt.color = FlxColor.WHITE;

			if (txt.ID == curSelected)
			{
				txt.color = FlxColor.YELLOW;
			}

			// txt.screenCenter(X);
			// txt.y = (FlxG.height / 2) + 100;
		});

		if (FlxG.keys.justPressed.SPACE && canGo /* || FlxG.mouse.justPressed && canGo*/)
		{
			#if debug
			switch (textMenuItems[curSelected])
			{
				case "play":
					final sel = new subStates.SongSelectSub();
					openSubState(sel);
				case "options":
					FlxG.switchState(new settings.Options());
				case "debugmenu":
					final pause = new subStates.DebugControl();
					openSubState(pause);
				case "close":
					FlxG.camera.fade(FlxColor.BLACK, .77, false, function()
					{
						Sys.exit(0);
					});
			}
			#else
			switch (textMenuItems[curSelected])
			{
				case "play":
					final sel = new subStates.SongSelectSub();
					openSubState(sel);
				case "options":
					title.text = "Crntu Settings";
					final pause = new settings.OptionsExper(); // .hx
					openSubState(pause);
				case "close":
					FlxG.camera.fade(FlxColor.BLACK, .77, false, function()
					{
						Sys.exit(0);
					});
			}
			#end
		}

		title.screenCenter(X);

		if (FlxG.keys.pressed.CONTROL && FlxG.keys.justPressed.O)
		{
			FlxTween.tween(options, {alpha: 0}, .2, {ease: FlxEase.linear});
			FlxTween.tween(back, {alpha: 0}, .2, {ease: FlxEase.linear});
			FlxTween.tween(play, {alpha: 0}, .2, {ease: FlxEase.linear});
			// FlxTween.tween(crntuLogo, {y: crntuLogo.y = FlxG.height - 100}, 1, {ease: FlxEase.quartOut});
			title.text = "Crntu Settings";
			final pause = new settings.OptionsExper(); // .hx
			openSubState(pause);
		}

		if (FlxG.keys.justReleased.F3)
		{
			final pause = new subStates.DebugControl();
			openSubState(pause);
		}
		// CursorLoad();
		// crntuLogo.screenCenter();
	}

	// function CursorLoad()
	// {
	// 	FlxG.mouse.visible = false;
	// 	FlxG.mouse.useSystemCursor = false;
	// 	CURSOR.x = FlxG.mouse.x;
	// 	CURSOR.y = FlxG.mouse.y;
	// FlxTween.tween(CURSORTRAIL, {x: FlxG.mouse.x, y: FlxG.mouse.y}, .1, {ease: FlxEase.linear});
	// }
}
