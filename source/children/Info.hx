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
#if flash
import openfl.Lib;
#end
import flixel.FlxG;
import flixel.system.scaleModes.StageSizeScaleMode;
import openfl.system.System;

/**
	The FPS class provides an easy-to-use monitor to display
	the current frame rate of an OpenFL project
**/
#if !openfl_debug
@:fileXml('tags="haxe,release,custom"')
@:noDebug
#end
class Info extends TextField
{
	/**
		The current frame rate, expressed using frames-per-second
	**/
	public var currentFPS(default, null):Float = 0.0;

	var asdkjasdkjsakjskdjaskdjaskdj:Bool = true;

	public var memPeak:Float = 0;
	public var displayFps = true;
	public var displayMemory = true;
	public var displayExtra = true;
	public var mem:Float;
	public var memTotal:Float;

	private var cacheCount:Int;
	private var currentTime:Float;
	private var times:Array<Float>;

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
		text = "FPS: ";

		cacheCount = 0;
		currentTime = 0;
		times = [];

		#if flash
		addEventListener(Event.ENTER_FRAME, function(e)
		{
			var time = Lib.getTimer();
			__enterFrame(time - currentTime);
		});
		#end
	}

	// Event Handlers
	// @:noCompletion
	private #if !flash override #end function __enterFrame(deltaTime:Float):Void
	{
		currentTime += deltaTime;
		times.push(currentTime);

		while (times[0] < currentTime - 1000 - 1)
		{
			times.shift();
			// FlxG.scaleMode = new StageSizeScaleMode();
		}

		var currentCount = times.length;
		// currentFPS = Math.round((currentCount + cacheCount) / 2);

		// if (Math.isNaN(FlxG.updateFramerate))
		currentFPS = Math.round((currentCount + cacheCount));

		// if (currentCount != cacheCount /*&& visible*/)
		// {
		text = "";
		// Application.current.window.title = currentFPS;
		// text += "FPS: " + currentFPS + "\n";

		var currentCount = times.length;
		currentFPS = Math.round((currentCount + cacheCount) / 2);

		memTotal = System.totalMemory;
		mem = Math.round(memTotal / 1024 / 1024 * 100) / 100;
		if (mem > memPeak)
			memPeak = mem;

		text += "Update\n" + currentFPS + "FPS";
		text += "\nMem\n" + mem + "MB\n";
		text += memPeak + "MB";

		// #if (gl_stats && !disable_cffi && (!html5 || !canvas))
		// text += "\ntotalDC: " + Context3DStats.totalDrawCalls();
		// text += "\nstageDC: " + Context3DStats.contextDrawCalls(DrawCallContext.STAGE);
		// text += "\nstage3DDC: " + Context3DStats.contextDrawCalls(DrawCallContext.STAGE3D);
		// #end
		// }

		if (FlxG.keys.justPressed.F11)
		{
			Application.current.window.borderless = false;
			if (asdkjasdkjsakjskdjaskdjaskdj)
			{
				FlxG.fullscreen = true;
				asdkjasdkjsakjskdjaskdjaskdj = false;
			}
			else
			{
				FlxG.fullscreen = false;
			}
		}

		cacheCount = currentCount;
	}
}
