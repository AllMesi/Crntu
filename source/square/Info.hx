package square;

import flixel.util.FlxTimer;
import openfl.events.Event;
import lime.app.Application;
import flixel.FlxG;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.system.System;
import flixel.ui.FlxButton;
import square.FlxGKeys;
#if gl_stats
import openfl.display._internal.stats.Context3DStats;
import openfl.display._internal.stats.DrawCallContext;
#end
import openfl.Lib;

/**
	The FPS class provides an easy-to-use monitor to display
	the current frame rate of an OpenFL project
**/
#if !openfl_debug
@:fileXml('tags="haxe,release"')
@:noDebug
#end
class Info extends TextField
{
	public var currentFPS(default, null):Int;
	public var cacheCount:Int;
	public var currentTime:Float;
	public var times:Array<Float>;
	public var memPeak:Float = 0;
	public var displayFps = true;
	public var displayMemory = true;
	public var displayExtra = true;
	public var mem:Float;
	public var memTotal:Float;

	public function new(x:Float = 10, y:Float = 10, color:Int = 0x000000)
	{
		super();

		this.x = x;
		this.y = y;

		currentFPS = 0;
		selectable = false;
		mouseEnabled = false;
		defaultTextFormat = new TextFormat("_sans", 12, color);
		text = "FPS:\nMem:\nMemPeak:";

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
	@:noCompletion
	private #if !flash override #end function __enterFrame(deltaTime:Float):Void
	{
		currentTime += deltaTime;
		times.push(currentTime);

		while (times[0] < currentTime - 1000)
		{
			times.shift();
		}

		var currentCount = times.length;
		currentFPS = Math.round((currentCount + cacheCount) / 2);

		mem = Math.round(System.totalMemory / 1024 / 1024 * 100) / 100;
		memTotal = System.totalMemory;
//		mem = Math.round(System.totalMemory / (1e+6));
		if (mem > memPeak)
			memPeak = mem;

//		if (currentCount != cacheCount /*&& visible*/)
//		{

			text = "";

//			if (FlxG.save.data.infoCounters)
//			text += "FPS: " + currentFPS + "\nMem: " + mem + "\nMemPeak: " + memPeak;
				if (FlxG.fullscreen || Application.current.window.borderless == true || FlxG.keys.pressed.S)
					{
						Lib.application.window.title = "Square";
						text += "FPS: " + currentFPS + "\nMem: " + mem + "\nMemPeak: " + memPeak;
					}
					else
					{
						Lib.application.window.title = "Square | FPS: " + currentFPS + " | Mem: " + mem + " | MemPeak: " + memPeak;
						text += "";
					}
			// 	Lib.application.window.title = "Sqaure | FPS: " + currentFPS + " | Mem: " + mem + " | MemPeak: " + memPeak;
			// else
			// 	text += "FPS: " + currentFPS + "\nMem: " + mem + "\nMemPeak: " + memPeak;


			// #if (gl_stats && !disable_cffi && (!html5 || !canvas))
			// text += "\ntotalDC: " + Context3DStats.totalDrawCalls();
			// text += "\nstageDC: " + Context3DStats.contextDrawCalls(DrawCallContext.STAGE);
			// text += "\nstage3DDC: " + Context3DStats.contextDrawCalls(DrawCallContext.STAGE3D);
			// #end
//		}

		cacheCount = currentCount;
		}
	public function getFrames():Float
	{
		return currentFPS;
	}
	public function getMemoryUsage():Float
	{
		return mem;
	}
}