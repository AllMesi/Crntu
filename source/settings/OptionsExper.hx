package settings;

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
import flixel.ui.FlxBar;
import flixel.util.FlxSave;
import flixel.util.FlxAxes;
import flixel.addons.ui.FlxUI;
import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUICheckBox;
import flixel.addons.ui.FlxUIRadioGroup;
import flixel.addons.ui.FlxUISprite;
import flixel.addons.ui.FlxUITabMenu;
import flixel.addons.ui.FlxUIText;

class OptionsExper extends FlxSubState
{
	var one:FlxText;
	var bg:FlxSprite;
	var button1 = new FlxButton(0, 0, "Borderless Fullscreen", blfs);
	var button2 = new FlxButton(0, 50, "Fullscreen", fs);
	var button3 = new FlxButton(0, 100, "Windowed", w);
	var button4 = new FlxButton(0, 100, "Windowed Maximize", wm);
	// var button5 = new FlxButton(0, 100, "AutoPause", ap);
	var volumeBar:FlxBar;
	var volumeText:FlxText;
	var volumeAmountText:FlxText;
	var volumeDownButton:FlxButton;
	var volumeUpButton:FlxButton;
	var clearDataButton:FlxButton;
	var titleText = new FlxText(0, 20, 0, "Options", 22);

	// var CURSOR = new FlxSprite(0, 0).makeGraphic(15, 15, FlxColor.TRANSPARENT);
	// var CURSORTRAIL = new FlxSprite(0, 0).makeGraphic(15, 15, FlxColor.TRANSPARENT);
	// var closebrhsefbhg = new FlxButton(FlxG.width - 28, 8, "X", closeSettings);

	public function new()
	{
		super();
	}

	override public function create()
	{
		super.create();
		if (FlxG.save.data.pauseUnfocused = null)
			FlxG.save.data.pauseUnfocused = false;

		persistentUpdate = true;
		persistentDraw = true;
		// #if debug
		// // FlxG.camera.zoom = .5;
		// FlxTween.tween(camera, {zoom: .5}, 1, {ease: FlxEase.quartOut});
		// #end

		// CURSOR.loadGraphic(misc.Paths.image('ui/cursors/cursor9'), true, 14, 14);
		// CURSORTRAIL.loadGraphic(misc.Paths.image('ui/cursors/cursor9trail'), true, 14, 14);

		// FlxG.sound.music.pause();
		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.fromRGB(88, 88, 88, 255));
		// bg = new FlxSprite(0, 0, misc.Paths.image('ds'));
		bg.y = 1700;
		// bg.x = FlxG.width - 500;
		bg.scrollFactor.set();
		// add(bg);
		misc.DiscordClient.changePresence("In Settings", null);
		// var b = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		// b.scrollFactor.set();
		// b.alpha = 0;
		// add(b);
		// var bg = new misc.FlxBackdrop(misc.Paths.image('ds'));
		// bg.cameras = [FlxG.camera];
		// bg.velocity.set(0, 300);
		// bg.alpha = 0;
		// add(bg);

		volumeText = new FlxText(0, titleText.y + 30, 0, "Volume", 8);
		volumeText.screenCenter(X);
		volumeText.setFormat("Comic Neue Angular Bold", 16, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(volumeText);

		// the volume buttons will be smaller than 'default' buttons
		volumeDownButton = new FlxButton(8, volumeText.y + volumeText.height + 2, "-", clickVolumeDown);
		// volumeDownButton.loadGraphic(Assets.button__png, true, 20, 20);
		// volumeDownButton.onUp.sound = FlxG.sound.load(Assets.select__wav);
		add(volumeDownButton);

		volumeUpButton = new FlxButton(FlxG.width - 28, volumeDownButton.y, "+", clickVolumeUp);
		// volumeUpButton.loadGraphic(Assets.button__png, true, 20, 20);
		// volumeUpButton.onUp.sound = FlxG.sound.load(Assets.select__wav);
		add(volumeUpButton);

		volumeBar = new FlxBar(volumeDownButton.x + volumeDownButton.width + 4, volumeDownButton.y, LEFT_TO_RIGHT, Std.int(FlxG.width - 150),
			Std.int(volumeUpButton.height));
		volumeBar.createFilledBar(0xff464646, FlxColor.WHITE, true, FlxColor.WHITE);
		add(volumeBar);

		volumeAmountText = new FlxText(0, 0, 200, (FlxG.sound.volume * 100) + "%", 8);
		volumeAmountText.alignment = CENTER;
		volumeAmountText.borderStyle = FlxTextBorderStyle.OUTLINE;
		volumeAmountText.borderColor = 0xff464646;
		volumeAmountText.y = volumeBar.y + (volumeBar.height / 2) - (volumeAmountText.height / 2);
		volumeAmountText.screenCenter(FlxAxes.X);
		add(volumeAmountText);

		button1.loadGraphic(misc.Paths.image('ui/spritesheets/buttons/buttonOptions'), true, 80, 29);
		// button1.x = (FlxG.width / 2) - (button1.width / 2);
		button1.x = 200;
		// button1.y = 1700;
		button1.y = (FlxG.height / 2);
		add(button1);

		button2.loadGraphic(misc.Paths.image('ui/spritesheets/buttons/buttonOptions'), true, 80, 20);
		// button2.x = ((FlxG.width / 2) - button2.width / 2);
		button2.x = 200;
		// button2.y = 1700;
		button2.y = (FlxG.height / 2) + button1.height + 3;
		add(button2);

		button3.loadGraphic(misc.Paths.image('ui/spritesheets/buttons/buttonOptions'), true, 80, 20);
		// button3.x = ((FlxG.width / 2) - button3.width / 2);
		button3.x = 200;
		// button3.y = 1700;
		button3.y = (FlxG.height / 2) + button1.height + 26;
		add(button3);

		button4.loadGraphic(misc.Paths.image('ui/spritesheets/buttons/buttonOptions'), true, 80, 20);
		// button3.x = ((FlxG.width / 2) - button3.width / 2);
		button4.x = 200;
		// button4.y = 1700;
		button3.y = (FlxG.height / 2) + button1.height + 26;
		add(button4);

		// button5.loadGraphic(misc.Paths.image('ui/spritesheets/buttons/buttonOptions'), true, 80, 20);
		// // button3.x = ((FlxG.width / 2) - button3.width / 2);
		// button5.x = 400;
		// button5.y = (FlxG.height / 2);
		// // button3.y = (FlxG.height / 2) + button1.height + 26;
		// add(button5);

		// var close = new FlxButton(FlxG.width - 28, 8, "X", sdjfhsdkfjh);
		// close.onUp.sound = FlxG.sound.load(Paths.sound('select'));
		// closebrhsefbhg.loadGraphic(misc.Paths.image('ui/spritesheets/buttons/buttonSmallOptions'), true, 20, 20);
		// add(closebrhsefbhg);

		// var button4 = new FlxButton(0, 150, "Back", b);
		// button4.loadGraphic(misc.Paths.image('ui/spritesheets/buttons/button'), true, 80, 20);
		//     button4.x = ((FlxG.width / 2) - button3.width / 2);
		// button4.y = (FlxG.height / 2) + button2.height + 59;
		// add(button4);

		// Crntu.fps = 30;

		// one = new FlxText(0, 0, 0, "Paused", 42);
		// one.alpha = 0;
		// one.y = 1300;
		// one.screenCenter(X);
		// one.setFormat("Comic Neue Angular Bold", 42, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, true);
		// add(one);

		// FlxTween.tween(one, {y: one.y - 1300}, .4, {ease: FlxEase.quartInOut});
		// FlxTween.tween(bg, {alpha: 1, y: bg.y - 1700}, 1, {ease: FlxEase.quartInOut});
		// FlxTween.tween(button1, {y: one.y = (FlxG.height / 2)}, .4, {ease: FlxEase.quartInOut});
		// FlxTween.tween(button2, {y: one.y = (FlxG.height / 2) + button1.height + 3}, .6, {ease: FlxEase.quartInOut});
		// FlxTween.tween(button3, {y: one.y = (FlxG.height / 2) + button1.height + 26}, .8, {ease: FlxEase.quartInOut});
		// FlxTween.tween(button4, {y: one.y = (FlxG.height / 2) + button1.height + 52}, 1, {ease: FlxEase.quartInOut});

		// add(CURSORTRAIL);
		// add(CURSOR);

		// updateVolume();
	}

	override public function update(elapsed)
	{
		super.update(elapsed);
		persistentUpdate = true;

		FlxG.mouse.visible = false;
		// CURSOR.x = FlxG.mouse.x;
		// CURSOR.y = FlxG.mouse.y;
		// FlxTween.tween(CURSORTRAIL, {x: FlxG.mouse.x, y: FlxG.mouse.y}, .1, {ease: FlxEase.linear});

		// if (FlxG.keys.justPressed.Q)
		// {
		// var bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.RED);
		// bg.alpha = 0;
		// bg.scrollFactor.set();
		// // add(bg);
		// // FlxTween.tween(bg, {alpha: 1}, 3.7, {ease: FlxEase.quartInOut});
		// FlxTween.tween(camera, {zoom: 3}, 2, {ease: FlxEase.quartInOut});
		// final pause = new GameOver();
		// openSubState(pause);
		// }

		if (FlxG.keys.justPressed.ESCAPE)
		{
			closeSettings();
		}
		updateVolume();
	}

	public static function blfs()
	{
		Crntu.setupWindow(true, false, false, false, true, true);
	}

	public static function fs()
	{
		Crntu.setupWindow(false, true, false, false, true, true);
	}

	public static function w()
	{
		Crntu.setupWindow(false, false, true, false, true, true);
	}

	public static function wm()
	{
		Crntu.setupWindow(false, false, false, true, false, true);
	}

	// public function ap()
	// {
	// }

	function closeSettings()
	{
		// FlxTween.tween(closebrhsefbhg, {x: one.x = 1700}, .4, {ease: FlxEase.quartInOut});
		// FlxTween.tween(one, {y: one.y + 1300}, .4, {ease: FlxEase.quartInOut});
		// FlxTween.tween(bg, {/*alpha: 0, */ y: bg.y + 1700}, 1, {ease: FlxEase.quartInOut});
		// FlxTween.tween(bg, {alpha: 0, y: bg.y - 1700}, 1, {ease: FlxEase.quartInOut});
		// FlxTween.tween(b, {alpha: 0}, 1, {ease: FlxEase.quartInOut});
		// FlxTween.tween(button1, {y: one.y = 1700}, .8, {ease: FlxEase.quartInOut});
		// FlxTween.tween(button2, {y: one.y = 1700}, .6, {ease: FlxEase.quartInOut});
		// FlxTween.tween(button3, {y: one.y = 1700}, .4, {ease: FlxEase.quartInOut});
		// FlxTween.tween(button4, {y: one.y = 1700}, 1, {ease: FlxEase.quartInOut});
		// FlxTween.tween(menus.Menu.backdrop, {alpha: 0}, .2, {ease: FlxEase.linear});
		// FlxTween.tween(menus.Menu.crntuLogo, {y: menus.Menu.crntuLogo.y = 0}, 1, {ease: FlxEase.quartOut});
		// Crntu.fps = 30;
		final lol = new subStates.All();
		openSubState(lol);

		new FlxTimer().start(.8, function(tmr:FlxTimer)
		{
			// FlxG.sound.music.play();
			// Crntu.fps = 120;
			FlxG.mouse.visible = true;
			FlxG.mouse.enabled = true;
			FlxG.mouse.useSystemCursor = true;
			// FlxTween.tween(menus.Menu.options, {alpha: 1}, .2, {ease: FlxEase.linear});
			// FlxTween.tween(menus.Menu.back, {alpha: 1}, .2, {ease: FlxEase.linear});
			// FlxTween.tween(menus.Menu.play, {alpha: 1}, .2, {ease: FlxEase.linear});
			misc.DiscordClient.changePresence("In The Menus", null);
			menus.Menu.title.text = "Crntu Menu";
			// FlxG.resetState();
			// #if debug
			// FlxTween.tween(camera, {zoom: 1}, 1, {ease: FlxEase.quartOut});
			// #end
			close();
		});
	}

	function clickVolumeDown()
	{
		FlxG.sound.volume -= 0.01;
		FlxG.save.data.volume = FlxG.sound.volume;
		FlxG.sound.music.fadeIn(1, 0, 2);
		updateVolume();
	}

	function clickVolumeUp()
	{
		FlxG.sound.volume += 0.01;
		FlxG.save.data.volume = FlxG.sound.volume;
		FlxG.sound.music.fadeIn(1, 0, 2);
		updateVolume();
	}

	function updateVolume()
	{
		var volume:Int = Math.round(FlxG.sound.volume * 100);
		volumeBar.value = volume;
		volumeAmountText.text = volume + "%";
	}
}
