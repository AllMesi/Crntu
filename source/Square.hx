package;

import openfl.net.URLRequest;
import openfl.Lib;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxAssets.FlxSoundAsset;
import flixel.system.FlxSound;
import flixel.system.FlxSoundGroup;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.utils.Assets;
import flixel.text.FlxText;
import lime.app.Application;
import haxe.Timer;

using StringTools;
using flixel.util.FlxSpriteUtil;

/**
*	Thing that workgamwloll
*/
class Square extends FlxState
{
	var one:FlxText;
	static var VERSION = "0.1.2.0";
	public static var VER = '$VERSION';
	static var CURSOR = new FlxSprite();
	static var CURSOROUT = new FlxSprite();

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	override public function create()
	{
		super.create();
		one = new FlxText(0, 0, 0, "SQUARE MANAGE STATE", 42);
		one.setFormat('_sans', 30, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, true);
		one.screenCenter();
		add(one);
		log("Fetched Manage");
		log("Fetched Manage", true);
		new FlxTimer().start(1, function(tmr:FlxTimer)
		{
			FlxG.resetGame();
		});
	}

	/**
	* unloads the cursor
	* @param enabled true-false (required)
	*/
	public static function unloadmouse(enabled)
	{
		FlxG.mouse.visible = false;
		FlxG.mouse.unload();
		if (enabled)
			FlxG.mouse.enabled = true;
		else
			FlxG.mouse.enabled = false;
	}

	/**
	 * loads the cursor
	 */
	public static function loadmouse()
	{
		// var timer = new haxe.Timer(1000);
		// timer.run = function()
		// {
		// 	FlxG.mouse.load(CURSOR.pixels);
		// }

		FlxG.mouse.enabled = true;
		FlxG.mouse.visible = true;	
		CURSOR.makeGraphic(15, 15, FlxColor.TRANSPARENT);
		CURSOR.loadGraphic(Paths.image('ui/cursors/cursor9'), true, 14, 14);
		// CURSOR.animation.add('Idle', [1, 2], 1, true);
		// CURSOR.animation.play('Idle');
		CURSOR.alpha = 0.5;
		FlxG.mouse.load(CURSOR.pixels);
		// timer.run();
	}

	/**
	 * Fades then closes tje game.
	 */
	public static function exitfunc(fade)
	{
		if (fade)
		{
			Square.log("Fading");
			FlxG.camera.fade(FlxColor.BLACK, .77, false, function()
			{
				Square.log("Closing...");
				Sys.exit(0);
			});
			// if (FlxG.sound.music.playing)
				// FlxG.sound.music.fadeOut(0.77, 0);
		}
		else
		{
			Sys.exit(0);
		}
	}

	// HAHA STOLE THIS FROM MYSELF
	/**
	 * The function the sets the window settings.
	 * @param isTrueBorderless 
	 * @param isTrueFullscreen 
	 * @param isTrueWindow 
	 * @param fullscreenFirst (true)
	 */
	public static function setup(isTrueBorderless, isTrueFullscreen, isTrueWindow, fullscreenFirst, cacheSound)
	{
		if (cacheSound)
			FlxG.sound.cacheAll();

		unloadmouse(false);

		if (fullscreenFirst)
		{
			FlxG.debugger.visible = false;
			FlxG.mouse.useSystemCursor = false;
			loadmouse();
			log('Windowed');
			FlxG.fullscreen = false;
			Application.current.window.resize(1280, 720);
			Application.current.window.borderless = false;
			loadmouse();
		}

		if (isTrueBorderless)
		{
			FlxG.save.data.fs = false;
			FlxG.save.data.blfs = true;
			FlxG.save.data.w = false;
			log('Borderless fullscreen');
			FlxG.fullscreen = false;
			Application.current.window.x = 0;
			Application.current.window.y = 0;
			Application.current.window.borderless = true;
			Application.current.window.resize(Application.current.window.display.currentMode.width, Application.current.window.display.currentMode.height);
			loadmouse();
		}

		if (isTrueFullscreen)
		{
			FlxG.fullscreen = false;
			FlxG.save.data.fs = true;
            FlxG.save.data.blfs = false;
            FlxG.save.data.w = false;
            log('Fullscreen');
            Application.current.window.borderless = false;
            FlxG.fullscreen = true;
			loadmouse();
		}

		if (isTrueWindow)
		{
			FlxG.save.data.fs = false;
			FlxG.save.data.blfs = false;
			FlxG.save.data.w = true;
			log('Windowed');
			FlxG.fullscreen = false;
			Application.current.window.resize(1280, 720);
			Application.current.window.x = 0;
            Application.current.window.y = 30;
			Application.current.window.borderless = false;
			loadmouse();
		} 

        FlxG.updateFramerate = 120;
        FlxG.drawFramerate = 120;
		loadmouse();
		Square.log('Setup from manage');
	}

	/**
	 * Simply prints to the console or logs
	 * @param msg
	 * @param log
	 */
	public static function log(msg, log = false)
	{
		if (log)
		{
			FlxG.log.add(msg);
		}
		else
		{
			haxe.Log.trace(msg, null);
		}
	}

	// HAHA STOLE THIS FROM FNF
	public static function coolTextFile(path:String):Array<String>
	{
		var daList:Array<String> = Assets.getText(path).trim().split('\n');

		for (i in 0...daList.length)
		{
			daList[i] = daList[i].trim();
		}

		return daList;
	}

	public static function coolStringFile(path:String):Array<String>
	{
		var daList:Array<String> = path.trim().split('\n');

		for (i in 0...daList.length)
		{
			daList[i] = daList[i].trim();
		}

		return daList;
	}

	public static function numberArray(max:Int, ?min = 0):Array<Int>
	{
		var dumbArray:Array<Int> = [];
		for (i in min...max)
		{
			dumbArray.push(i);
		}
		return dumbArray;
	}

	// HAHA STOLE THIS FROM FLXG
	public static function openURL(URL:String, Target:String = "_blank"):Void
	{
		#if linux
        Sys.command('/usr/bin/xdg-open', [URL, "&"]);
        #else
		var prefix:String = "";
		// if the URL does not already start with "http://" or "https://", add it.
		if (!~/^https?:\/\//.match(URL))
			prefix = "http://";
		Lib.getURL(new URLRequest(prefix + URL), Target);
		#end
	}
}
