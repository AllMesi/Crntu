package menus;

import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.app.Application;
import openfl.Lib;
import flixel.FlxG;
import flixel.FlxState;
import flixel.ui.FlxButton;

class SelectSong extends FlxState
{
	public static var curStage:String = '';

	var title:FlxText;
	var button1:FlxButton;
	var button2:FlxButton;
	var button3:FlxButton;
	var button4:FlxButton;

	override public function create()
	{
		var backdrop = new misc.FlxBackdrop(misc.Paths.image('sb'));
		backdrop.cameras = [FlxG.camera];
		backdrop.velocity.set(0, 150);
		add(backdrop);

		title = new FlxText(50, 100, 0, "Select Song", 18);
		title.setFormat("Comic Neue Angular Bold", 16, FlxColor.WHITE, CENTER);
		title.screenCenter(X);
		add(title);

		button2 = new FlxButton(0, 0, "Play", p);
		button2.x = (FlxG.width / 2) - (button2.width / 2);
		button2.y = (FlxG.height / 2);
		button2.loadGraphic(misc.Paths.image('ui/spritesheets/buttons/button'), true, 80, 20);
		add(button2);

		button1 = new FlxButton(0, 30, "Back", b);
		button1.x = ((FlxG.width / 2) - button1.width / 2);
		button1.y = (FlxG.height / 2) + button2.height + 3;
		button1.loadGraphic(misc.Paths.image('ui/spritesheets/buttons/button'), true, 80, 20);
		add(button1);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	function b()
	{
		// FlxG.sound.music.fadeOut(4, .2);
		FlxG.switchState(new Menu());
	}

	function p()
	{
		// FlxG.camera.fade(FlxColor.WHITE, .77, false);

		// new FlxTimer().start(.77, function(tmr:FlxTimer)
		// {
		// FlxG.switchState(new Play());
		// Crntu.songStart('bopeebo');
		final sel = new subStates.SongSelectSub();
		openSubState(sel);
		// });
	}
}
