package children;

import lime.app.Application;
import haxe.Timer;
import openfl.events.Event;
import openfl.text.TextField;
import openfl.text.TextFormat;
// #if gl_stats
import openfl.display._internal.stats.Context3DStats;
import openfl.display._internal.stats.DrawCallContext;
// #end
// #if flash
import openfl.Lib;
// #end
import flixel.FlxG;
import flixel.system.scaleModes.StageSizeScaleMode;
import openfl.system.System;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import haxe.Timer;

/**
	The FPS class provides an easy-to-use monitor to display
	the current frame rate of an OpenFL project
**/
class Info extends TextField
{
	/**
		The current frame rate, expressed using frames-per-second
	**/
	public static var currentFPS(default, null):Int = 0;

	public static var currentFPSPeak:Int = 0;

	var asdkjasdkjsakjskdjaskdjaskdj:Bool = true;

	public static var memPeak:Float = 0;

	public var displayFps = true;
	public var displayMemory = true;
	public var displayExtra = true;

	public static var mem:Float;
	public static var memTotal:Float;

	private var cacheCount:Int;
	private var currentTime:Float;
	private var times:Array<Float>;
	var counter = 0;
	var prevcount = 0;

	// @:noCompletion private var cacheCount:Int;
	// @:noCompletion private var currentTime:Float;
	// @:noCompletion private var times:Array<Float>;

	public function new(x:Float = 10, y:Float = 10, color:Int = 0x000000)
	{
		super();

		this.x = x;
		this.y = y;

		selectable = false;
		mouseEnabled = false;
		defaultTextFormat = new TextFormat("Highway Gothic", 12, color);
		text = "";
		width += 10734;

		cacheCount = 0;
		currentTime = 0;
		times = [];

    var timer  = new Timer(1000);

    timer.run = function()
    {
      text = "";
      #if debug
      text += "Draw: " + currentFPS + "/" + currentFPSPeak + "FPS\n";
      text += "EstimateMemory: " + mem + "/" + memPeak + "MB";
      #end
    }

		// #if flash
		// addEventListener(Event.ENTER_FRAME, function(e)
		// {
		// 	var time = Lib.getTimer();
		// 	__enterFrame(time - currentTime);
		// });
		// #end
	}

	// Event Handlers
	// @:noCompletion
	private #if !flash override #end function __enterFrame(deltaTime:Float):Void
	{
		currentTime += deltaTime;
		times.push(currentTime);

		while (times[0] < currentTime - 1000)
		{
			times.shift();
		}

		var currentCount = times.length;
		// currentFPS = Math.round((currentCount + cacheCount) / 2);

		// if (Math.isNaN(FlxG.updateFramerate))
		// currentFPS = Math.round((currentCount + cacheCount) / 2);

		// if (currentCount != cacheCount /*&& visible*/)
		// {
		// text = "";
		++counter;
		// Application.current.window.title = currentFPS;
		// text += "FPS: " + currentFPS + "\n";

		var currentCount = times.length;
		currentFPS = Math.round((currentCount + cacheCount) / 2);

		if (FlxG.keys.pressed.CONTROL && FlxG.mouse.wheel != 0)
		{
			FlxG.camera.zoom += (FlxG.mouse.wheel / 10);
			// FlxTween.tween(FlxG.camera, {zoom: FlxG.camera.zoom += (FlxG.mouse.wheel / 10)}, 1, {ease: FlxEase.linear});
		}

		if (FlxG.keys.pressed.CONTROL && FlxG.mouse.wheel == 0)
		{
			FlxG.camera.zoom -= (FlxG.mouse.wheel / 10);
			// FlxTween.tween(FlxG.camera, {zoom: FlxG.camera.zoom -= (FlxG.mouse.wheel / 10)}, 1, {ease: FlxEase.linear});
		}

		if (FlxG.keys.justReleased.F3)
		{
			FlxG.debugger.visible = false;
		}

		memTotal = System.totalMemory;
		mem = Math.round(memTotal / 1024 / 1024 * 100) / 100 / 2;

		if (mem > memPeak)
			memPeak = mem;

		if (currentFPS > currentFPSPeak)
			currentFPSPeak = currentFPS;

		if (FlxG.keys.justReleased.F3 && FlxG.keys.pressed.R)
		{
			FlxG.resetState();
			FlxG.debugger.visible = false;
		}

		cacheCount = currentCount;
	}
}
