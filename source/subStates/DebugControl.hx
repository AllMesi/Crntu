package subStates;

import menus.Tests;
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

class DebugControl extends FlxSubState
{
	var one:FlxText;
	var two:FlxText;
	var three:FlxText;
	var four:FlxText;
	var five:FlxButton;
	var six:FlxButton;
	var CURSOR = new FlxSprite(0, 0).makeGraphic(15, 15, FlxColor.TRANSPARENT);
	var boxes:Bool = false;

	override public function create()
	{
		super.create();

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0.6;
		bg.scrollFactor.set();
		add(bg);

		misc.DiscordClient.changePresence("In DebugControls", null);

		CURSOR.loadGraphic(misc.Paths.image('ui/cursors/cursor10'), true, 14, 14);
		add(CURSOR);

		one = new FlxText(0, 0, 0, "DebugControl", 42);
		one.setFormat("Comic Neue Angular Bold", 42, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, true);

		two = new FlxText(0, 40, 0, "D = Open Debugger", 42);
		two.setFormat("Comic Neue Angular Bold", 42, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, true);

		three = new FlxText(0, 80, 0,
			"F3 = Open DebugControls\nF3 + R = Reset current state\nF3 + C = Close DebugControls\nF3 + D = Close Debugger\nF3 + F = Draw debug boxes", 42);
		three.setFormat("Comic Neue Angular Bold", 42, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, true);

		four = new FlxText(0, 80, 0, "\nF3 + S = Stop drawing debug boxes", 42);
		four.setFormat("Comic Neue Angular Bold", 42, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, true);

		add(one);
		add(two);
		add(three);
		add(four);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		FlxG.mouse.visible = true;
		FlxG.mouse.useSystemCursor = true;
		CURSOR.x = FlxG.mouse.x;
		CURSOR.y = FlxG.mouse.y;

		if (FlxG.keys.justReleased.F3 && FlxG.keys.pressed.C)
		{
			misc.DiscordClient.changePresence("Crntu", null);
			FlxG.resetState();
			close();
		}

		if (FlxG.keys.justPressed.D)
		{
			FlxG.debugger.visible = true;
		}

		if (FlxG.keys.justReleased.F3 && FlxG.keys.pressed.D)
		{
			FlxG.debugger.visible = false;
		}

		if (FlxG.keys.justReleased.F3 && FlxG.keys.pressed.V)
		{
			FlxG.switchState(new Tests());
		}

		if (FlxG.keys.justReleased.F3 && FlxG.keys.pressed.F)
		{
			FlxG.debugger.visible = false;
			FlxG.debugger.drawDebug = true;
		}

		if (FlxG.keys.justReleased.F3 && FlxG.keys.pressed.S)
		{
			FlxG.debugger.visible = false;
			FlxG.debugger.drawDebug = false;
		}

		if (FlxG.keys.justReleased.F3)
		{
			FlxG.debugger.visible = false;
		}
	}
}
