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
import flixel.system.scaleModes.StageSizeScaleMode;
import sys.FileSystem;
import sys.io.File;
import openfl.display.BitmapData;
import openfl.utils.Assets as OpenFlAssets;
import flixel.graphics.FlxGraphic;

using StringTools;
using flixel.util.FlxSpriteUtil;

/**
*	Thing that workgamwloll
*/
class Square extends FlxState
{
	var one:FlxText;
	static var VERSION = "0.3.5.8";
	public static var VER = '$VERSION';
	static var CURSOR = new FlxSprite();
	static var CURSOROUT = new FlxSprite();
  static var images = [];
  public static var bitmapData:Map<String, FlxGraphic>;

	/**
	 * Sets the games fps.
	 * @param FPS The fps itself, 0 = uncapped.
	 */
	public static var fps(default, set):Int;

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	override public function create()
	{
		super.create();
    Application.current.window.resize(1280, 720);
		one = new FlxText(200, 0, 0, "Loading..\nSquare", 10);
		one.setFormat('VCR OSD Mono', 30, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, true);
		add(one);
    FlxG.mouse.visible = false;
		log("Fetched Manage");
		log("Fetched Manage", true);
		new FlxTimer().start(.5, function(tmr:FlxTimer)
		{
			FlxG.switchState(new misc.LoadState());
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
		FlxG.mouse.enabled = true;
		FlxG.mouse.visible = true;	
		// CURSOR.makeGraphic(15, 15, FlxColor.TRANSPARENT);
		// CURSOR.loadGraphic(Paths.image('ui/cursors/cursor9'), true, 14, 14);
		// CURSOR.alpha = 0.5;
		// FlxG.mouse.load(CURSOR.pixels);
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
        #if !html5
        Sys.exit(0);
      #end
			});
		}
		else
		{
      #if !html5
      Sys.exit(0);
    #end
		}
	}

	// HAHA STOLE THIS FROM MYSELF
	/**
	 * The function the sets the window settings.
	 * @param isTrueBorderless 
	 * @param isTrueFullscreen 
	 * @param isTrueWindow
   * @param isTrueWindowMax
	 * @param fullscreenFirst (true)
   * @param cacheSound (true)
	 */
	public static function setup(isTrueBorderless:Bool, isTrueFullscreen:Bool, isTrueWindow:Bool, isTrueWindowMax:Bool, fullscreenFirst:Bool = true, cacheSound:Bool = true)
	{
		if (cacheSound)
			FlxG.sound.cacheAll();

    FlxG.debugger.toggleKeys = [F3];

    for (i in FileSystem.readDirectory(FileSystem.absolutePath("public/images")))
			{
				if (!i.endsWith(".png"))
					continue;
				images.push(i);
			}

			for (i in FileSystem.readDirectory(FileSystem.absolutePath("public/images/ui")))
			{
				if (!i.endsWith(".png"))
					continue;
				images.push(i);
			}

      for (i in FileSystem.readDirectory(FileSystem.absolutePath("public/images/ui/spritesheets/buttons")))
        {
          if (!i.endsWith(".png"))
            continue;
          images.push(i);
        }

        for (i in FileSystem.readDirectory(FileSystem.absolutePath("public/images/ui/game")))
          {
            if (!i.endsWith(".png"))
              continue;
            images.push(i);
          }

          for (i in FileSystem.readDirectory(FileSystem.absolutePath("public/images/ui/game/spritesheets")))
            {
              if (!i.endsWith(".png"))
                continue;
              images.push(i);
            }

            for (i in FileSystem.readDirectory(FileSystem.absolutePath("public/images/ui/cursors")))
              {
                if (!i.endsWith(".png"))
                  continue;
                images.push(i);
              }

              for (i in FileSystem.readDirectory(FileSystem.absolutePath("public/images/spritesheets")))
                {
                  if (!i.endsWith(".png"))
                    continue;
                  images.push(i);
                }
    cache();

		if (fullscreenFirst)
		{
			FlxG.debugger.visible = false;
			FlxG.mouse.useSystemCursor = false;
			loadmouse();
			log('Windowed');
			FlxG.fullscreen = false;
			Application.current.window.resize(1280, 720);
			Application.current.window.borderless = false;
      // FlxG.scaleMode = new StageSizeScaleMode();
		}

		if (isTrueBorderless)
		{
      FlxG.save.data.fs = false;
			FlxG.save.data.blfs = true;
			FlxG.save.data.w = false;
      FlxG.save.data.wm = false;
			log('Borderless fullscreen');
			FlxG.fullscreen = false;
			Application.current.window.x = 0;
			Application.current.window.y = 0;
			Application.current.window.borderless = true;
			Application.current.window.resize(Application.current.window.display.currentMode.width, Application.current.window.display.currentMode.height);
      FlxG.scaleMode = new StageSizeScaleMode();
		}

		if (isTrueFullscreen)
		{
			FlxG.fullscreen = false;
      FlxG.save.data.fs = true;
			FlxG.save.data.blfs = false;
			FlxG.save.data.w = false;
      FlxG.save.data.wm = false;
            log('Fullscreen');
            Application.current.window.borderless = false;
            FlxG.fullscreen = true;
            FlxG.scaleMode = new StageSizeScaleMode();
		}

		if (isTrueWindow)
    {
      FlxG.save.data.fs = false;
			FlxG.save.data.blfs = false;
			FlxG.save.data.w = true;
      FlxG.save.data.wm = false;
			log('Windowed');
			FlxG.fullscreen = false;
			Application.current.window.resize(1280, 720);
			Application.current.window.x = 0;
            Application.current.window.y = 30;
			Application.current.window.borderless = false;
      FlxG.scaleMode = new StageSizeScaleMode();
		} 

    if (isTrueWindowMax)
    {
      FlxG.save.data.fs = false;
			FlxG.save.data.blfs = false;
			FlxG.save.data.w = false;
      FlxG.save.data.wm = true;
			// log('Windowed');
			FlxG.fullscreen = false;
			Application.current.window.resize(1280, 720);
			Application.current.window.x = 0;
      Application.current.window.y = 30;
			Application.current.window.borderless = false;
      Application.current.window.maximized = false;
      Application.current.window.maximized = true;
      FlxG.scaleMode = new StageSizeScaleMode();
    } 

    Square.fps = 120;
		Square.log('Setup from manage');
    FlxG.mouse.useSystemCursor = true; 
    // FlxG.scaleMode = new StageSizeScaleMode();
	}

static function cache() {
  for (i in images)
		{
			var replaced = i.replace(".png", "");

			var data:BitmapData = BitmapData.fromFile("assets/shared/images/characters/" + i);
			var imagePath = misc.Paths.image('$i');
			// Debug.logTrace('Caching character graphic $i ($imagePath)...');
			var data = OpenFlAssets.getBitmapData(imagePath);
			var graph = FlxGraphic.fromBitmapData(data);
			graph.persist = true;
			graph.destroyOnNoUse = false;
			bitmapData.set(replaced, graph);
		}
}

	/**
	 * Simply prints to the console or logs.
	 * @param log put a string to log here.
	 * @param debuglog log to the debugger.
	 * @param message>
	 * @param trace says file and line and stuff.
	 */
	public static function log(log:String, debuglog:Bool = false, message:String = 'Square', trace = false)
	{
		if (debuglog)
		{
			FlxG.log.add(log);
		}
		else
		{
			if (trace)
			{
				haxe.Log.trace('$message> ' + log);
			}
			else
			{
				haxe.Log.trace('$message> ' + log, null);
			}
		}
	}

	/**
	 * Sets the games fps.
	 * @param FPS The fps itself, 0 = uncapped.
	 */
	static function set_fps(FPS:Int):Int
	{
		if (FPS == 0)
		{
			FlxG.updateFramerate = 1000;
        	FlxG.drawFramerate = 1000;
			new FlxTimer().start(.2, function(tmr:FlxTimer)
			{
				log('UnCapped', false, 'FPS');
			});
		}
		else
		{
			FlxG.updateFramerate = FPS;
			FlxG.drawFramerate = FPS;
			new FlxTimer().start(.2, function(tmr:FlxTimer)
			{
				log('$FPS', false, 'FPS');
			});
		}

		return FPS;
	}

	public static function songStart(level, bpm)
	{
		game.Conductor.changeBPM(50);
		FlxG.camera.fade(FlxColor.BLACK, .30, false);
		new FlxTimer().start(.30, function (tmr:FlxTimer)
		{
			FlxG.switchState(new game.Play());
      // Play.loadText = new FlxText(0, 0, 0, "Loading...", 30, true);
      // Play.loadText.setFormat("_sans", 20, FlxColor.BLACK, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLUE, true);
      // Play.bg.scrollFactor.set();
      // Play.bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE);
			game.Play.curLevel = level;
    });
		log('Level: $level');
		game.Conductor.changeBPM(bpm);
	}

	public static function songNext(level)
	{
		FlxG.camera.fade(FlxColor.BLACK, .30, false);
		new FlxTimer().start(.30, function (tmr:FlxTimer)
		{
			loadmouse();
			FlxG.switchState(new menus.SelectSong());
			game.Play.curLevel = level;
		});
		log('Next level: $level');
		game.Conductor.changeBPM(50);
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
