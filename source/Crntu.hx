import flixel.FlxSubState;
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
import lime.app.Application;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.debug.log.LogStyle;
import flixel.system.debug.watch.Tracker.TrackerProfile;
import flixel.util.FlxStringUtil;
import haxe.Log;
import haxe.PosInfos;
import haxe.Timer;
import flixel.system.scaleModes.StageSizeScaleMode;
#if !html
import sys.FileSystem;
import sys.io.File;
#end
import flixel.FlxSubState;
import flixel.addons.effects.FlxTrail;
import openfl.display.BitmapData;
import openfl.utils.Assets as OpenFlAssets;
import flixel.graphics.FlxGraphic;

using StringTools;
using flixel.util.FlxSpriteUtil;

/**
 *	if this file didnt exist the game wouldnt work lol
 */
class Crntu extends FlxState
{
	var one:FlxText;

	static final LOG_STYLE_ERROR:LogStyle = new LogStyle('[ ERROR ] ', 'FF8888', 12, true, false, false, 'flixel/sounds/beep', true);
	static final LOG_STYLE_WARN:LogStyle = new LogStyle('[ WARN ] ', 'D9F85C', 12, true, false, false, 'flixel/sounds/beep', true);
	static final LOG_STYLE_INFO:LogStyle = new LogStyle('[ INFO ] ', '5CF878', 12, false);
	static final LOG_STYLE_TRACE:LogStyle = new LogStyle('[ TRACE ] ', '5CF878', 12, false);

	static var logFileWriter:DebugLogWriter = null;

	public static var VER = '0.3.5.8';
	public static var BASEGAMENAME = 'Crntu';
	static var CURSOR = new FlxSprite();
	static var CURSOROUT = new FlxSprite();
	// var CURSORNEW = new FlxSprite(0, 0).drawCircle(CURSORNEW, 0, 0, 8, FlxColor.WHITE);
	static var images = [];
	public static var bitmapData:Map<String, FlxGraphic>;

	static var subStatethingidk:FlxSubState;

	// var _requestSubStateReset:Bool = false;
	public static var mode:String;

	/**
	 * Sets the games fps.
	 * @param FPS The fps itself, 0 = uncapped.
	 */
	public static var fps(default, set):Int;

	public static inline function logError(input:Dynamic, ?pos:haxe.PosInfos):Void
	{
		if (input == null)
			return;
		var output = formatOutput(input, pos);
		writeToFlxGLog(output, LOG_STYLE_ERROR);
		writeToLogFile(output, 'ERROR');
	}

	/**
	 * Log an warning message to the game's console.
	 * Plays a beep to the user and forces the console open if this is a debug build.
	 * @param input The message to display.
	 * @param pos This magic type is auto-populated, and includes the line number and class it was called from.
	 */
	public static inline function logWarn(input:Dynamic, ?pos:haxe.PosInfos):Void
	{
		if (input == null)
			return;
		var output = formatOutput(input, pos);
		writeToFlxGLog(output, LOG_STYLE_WARN);
		writeToLogFile(output, 'WARN');
	}

	/**
	 * Log an info message to the game's console. Only visible in debug builds.
	 * @param input The message to display.
	 * @param pos This magic type is auto-populated, and includes the line number and class it was called from.
	 */
	public static inline function logInfo(input:Dynamic, ?pos:haxe.PosInfos):Void
	{
		if (input == null)
			return;
		var output = formatOutput(input, pos);
		writeToFlxGLog(output, LOG_STYLE_INFO);
		writeToLogFile(output, 'INFO');
	}

	/**
	 * Log a debug message to the game's console. Only visible in debug builds.
	 * NOTE: We redirect all Haxe `trace()` calls to this function.
	 * @param input The message to display.
	 * @param pos This magic type is auto-populated, and includes the line number and class it was called from.
	 */
	public static function logTrace(input:Dynamic, ?pos:haxe.PosInfos):Void
	{
		if (input == null)
			return;
		var output = formatOutput(input, pos);
		writeToFlxGLog(output, LOG_STYLE_TRACE);
		writeToLogFile(output, 'TRACE');
	}

	/**
	 * Display the value of a particular field of a given object
	 * in the Debug watch window, labelled with the specified name.
	 		* Updates continuously.
	 * @param object The object to watch.
	 * @param field The string name of a field of the above object.
	 * @param name
	 */
	public static inline function watchVariable(object:Dynamic, field:String, name:String):Void
	{
		#if debug
		if (object == null)
		{
			logError("Tried to watch a variable on a null object!");
			return;
		}
		FlxG.watch.add(object, field, name == null ? field : name);
		#end
		// Else, do nothing outside of debug mode.
	}

	/**
	 * Adds the specified value to the Debug Watch window under the current name.
	 * A lightweight alternative to watchVariable, since it doesn't update until you call it again.
	 * 
	 * @param value 
	 * @param name 
	 */
	public inline static function quickWatch(value:Dynamic, name:String)
	{
		#if debug
		FlxG.watch.addQuick(name == null ? "QuickWatch" : name, value);
		#end
		// Else, do nothing outside of debug mode.
	}

	/**
	 * The Console window already supports most hScript, meaning you can do most things you could already do in Haxe.
	 		 * However, you can also add custom commands using this function.
	 */
	public inline static function addConsoleCommand(name:String, callbackFn:Dynamic)
	{
		FlxG.console.registerFunction(name, callbackFn);
	}

	/**
	 * Add an object with a custom alias so that it can be accessed via the console.
	 */
	public inline static function addObject(name:String, object:Dynamic)
	{
		FlxG.console.registerObject(name, object);
	}

	/**
	 * Create a tracker window for an object.
	 * This will display the properties of that object in
	 * a fancy little Debug window you can minimize and drag around.
	 * 
	 * @param obj The object to display.
	 */
	public inline static function trackObject(obj:Dynamic)
	{
		if (obj == null)
		{
			logError("Tried to track a null object!");
			return;
		}
		FlxG.debugger.track(obj);
	}

	/**
	 * The game runs this function when it starts, but after Flixel is initialized.
	 */
	public static function onGameStart()
	{
		// Add the mouse position to the debug Watch window.
		FlxG.watch.addMouse();

		defineTrackerProfiles();
		defineConsoleCommands();

		// Now we can remember the log level.
		if (FlxG.save.data.debugLogLevel == null)
			FlxG.save.data.debugLogLevel = "TRACE";

		logFileWriter.setLogLevel(FlxG.save.data.debugLogLevel);
	}

	static function writeToFlxGLog(data:Array<Dynamic>, logStyle:LogStyle)
	{
		if (FlxG != null && FlxG.game != null && FlxG.log != null)
		{
			FlxG.log.advanced(data, logStyle);
		}
	}

	static function writeToLogFile(data:Array<Dynamic>, logLevel:String = "TRACE")
	{
		if (logFileWriter != null && logFileWriter.isActive())
		{
			logFileWriter.write(data, logLevel);
		}
	}

	/**
	 * Defines what properties will be displayed in tracker windows for all these classes.
	 */
	static function defineTrackerProfiles()
	{
		// Example: This will display all the properties that FlxSprite does, along with curCharacter and barColor.
		// FlxG.debugger.addTrackerProfile(new TrackerProfile(Character, ["curCharacter", "isPlayer", "barColor"], [FlxSprite]));
		// FlxG.debugger.addTrackerProfile(new TrackerProfile(HealthIcon, ["char", "isPlayer", "isOldIcon"], [FlxSprite]));
		// FlxG.debugger.addTrackerProfile(new TrackerProfile(Note, ["x", "y", "strumTime", "mustPress", "rawNoteData", "sustainLength"], []));
		// FlxG.debugger.addTrackerProfile(new TrackerProfile(Song, [
		// 	"chartVersion",
		// 	"song",
		// 	"speed",
		// 	"player1",
		// 	"player2",
		// 	"gfVersion",
		// 	"noteStyle",
		// 	"stage"
		// ], []));
	}

	/**
	 * Defines some commands you can run in the console for easy use of important debugging functions.
	 * Feel free to add your own!
	 */
	inline static function defineConsoleCommands()
	{
		// Example: This will display Boyfriend's sprite properties in a debug window.
		// addConsoleCommand("trackBoyfriend", function()
		// {
		// 	Debug.logInfo("CONSOLE: Begin tracking Boyfriend...");
		// 	trackObject(PlayState.boyfriend);
		// });
		// addConsoleCommand("trackGirlfriend", function()
		// {
		// 	Debug.logInfo("CONSOLE: Begin tracking Girlfriend...");
		// 	trackObject(PlayState.gf);
		// });
		// addConsoleCommand("trackDad", function()
		// {
		// 	Debug.logInfo("CONSOLE: Begin tracking Dad...");
		// 	trackObject(PlayState.dad);
		// });

		addConsoleCommand("setLogLevel", function(logLevel:String)
		{
			if (!DebugLogWriter.LOG_LEVELS.contains(logLevel))
			{
				logWarn('CONSOLE: Invalid log level $logLevel!');
				logWarn('  Expected: ${DebugLogWriter.LOG_LEVELS.join(', ')}');
			}
			else
			{
				logInfo('CONSOLE: Setting log level to $logLevel...');
				logFileWriter.setLogLevel(logLevel);
			}
		});

		addConsoleCommand("playSong", function(thing:String)
		{
			Crntu.songStart(thing, 100);
		});

		// Console commands let you do WHATEVER you want.
		// addConsoleCommand("playSong", function(songName:String, ?difficulty:Int = 1)
		// {
		// 	Debug.logInfo('CONSOLE: Opening song $songName ($difficulty) in Free Play...');
		// 	FreeplayState.loadSongInFreePlay(songName, difficulty, false);
		// });
		// addConsoleCommand("chartSong", function(songName:String, ?difficulty:Int = 1)
		// {
		// 	Debug.logInfo('CONSOLE: Opening song $songName ($difficulty) in Chart Editor...');
		// 	FreeplayState.loadSongInFreePlay(songName, difficulty, true, true);
		// });
	}

	static function formatOutput(input:Dynamic, pos:haxe.PosInfos):Array<Dynamic>
	{
		// This code is junk but I kept getting Null Function References.
		var inArray:Array<Dynamic> = null;
		if (input == null)
		{
			inArray = ['<NULL>'];
		}
		else if (!Std.is(input, Array))
		{
			inArray = [input];
		}
		else
		{
			inArray = input;
		}

		if (pos == null)
			return inArray;

		// Format the position ourselves.
		var output:Array<Dynamic> = ['(${pos.className}/${pos.methodName}#${pos.lineNumber}): '];

		return output.concat(inArray);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	override public function create()
	{
		super.create();
		bitmapData = new Map<String, FlxGraphic>();
		one = new FlxText(200, 0, 0, "bruh what howwhhy?", 10);
		one.setFormat('VCR OSD Mono', 30, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, true);
		add(one);
		FlxG.mouse.visible = false;
		log("Fetched Manage");
		log("Fetched Manage", true);
		new FlxTimer().start(.5, function(tmr:FlxTimer)
		{
			Sys.exit(0);
		});
	}

	/**
	 * Fades then closes the game.
	 */
	public static function exitfunc(fade)
	{
		if (fade)
		{
			log("Fading");
			FlxG.camera.fade(FlxColor.BLACK, .77, false, function()
			{
				log("Closing...");
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

	public static function displayAlert(title:String, description:String):Void
	{
		Application.current.window.alert(description, title);
	}

	public static function onInitProgram()
	{
		// Initialize logging tools.
		trace('Initializing Debug tools...');

		// Override Haxe's vanilla trace() calls to use the Flixel console.
		Log.trace = function(data:Dynamic, ?info:PosInfos)
		{
			var paramArray:Array<Dynamic> = [data];

			if (info != null)
			{
				if (info.customParams != null)
				{
					for (i in info.customParams)
					{
						paramArray.push(i);
					}
				}
			}

			logTrace(paramArray, info);
		};

		// Start the log file writer.
		// We have to set it to TRACE for now.
		logFileWriter = new DebugLogWriter("TRACE");

		logInfo("Debug logging initialized. Hello, developer.");

		#if debug
		logInfo("This is a DEBUG build, can display FPS.");
		#else
		logInfo("This is a RELEASE build, can't display FPS.");
		#end

		#if RUNNING_ON_SOURCE
		logInfo('The game is running on the source code');
		#else
		logInfo('The game is not running on the source code');
		#end

		logInfo('HaxeFlixel version: ${Std.string(FlxG.VERSION)}');
		// logInfo('Friday Night Funkin\' version: ${MainMenuState.gameVer}');
		// logInfo('KadeEngine version: ${MainMenuState.kadeEngineVer}');
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
	public static function setupWindow(isTrueBorderless:Bool = true, isTrueFullscreen:Bool = false, isTrueWindow:Bool = false, isTrueWindowMax:Bool = false,
			fullscreenFirst:Bool = true, cacheSound:Bool = true)
	{
		FlxG.sound.cacheAll();

		#if debug
		mode == "debug";
		#else
		mode == "release";
		#end

		FlxG.fullscreen = false;

		if (fullscreenFirst)
		{
			FlxG.debugger.visible = false;
			FlxG.mouse.useSystemCursor = false;
			FlxG.fullscreen = true;
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
			// FlxG.scaleMode = new StageSizeScaleMode();
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
			// FlxG.scaleMode = new StageSizeScaleMode();
		}

		if (isTrueWindow)
		{
			FlxG.save.data.fs = false;
			FlxG.save.data.blfs = false;
			FlxG.save.data.w = true;
			FlxG.save.data.wm = false;
			log('Windowed');
			FlxG.fullscreen = false;
			Application.current.window.resize(1560, 720);
			Application.current.window.x = 0;
			Application.current.window.y = 30;
			Application.current.window.borderless = false;
			// FlxG.scaleMode = new StageSizeScaleMode();
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
			// FlxG.scaleMode = new StageSizeScaleMode();
		}

		fps = 120;
		FlxG.mouse.useSystemCursor = true;
		// FlxG.scaleMode = new StageSizeScaleMode();
	}

	// static function cache() {
	//   for (i in images)
	// 		{
	// 			var replaced = i.replace(".png", "");
	// 			var data:BitmapData = BitmapData.fromFile("assets/shared/images/characters/" + i);
	// 			var imagePath = misc.Paths.image('$i');
	//      Debug.logTrace('Caching character graphic $i ($imagePath)...');
	// 			var data = OpenFlAssets.getBitmapData(imagePath);
	// 			var graph = FlxGraphic.fromBitmapData(data);
	// 			graph.persist = true;
	// 			graph.destroyOnNoUse = false;
	// 			bitmapData.set(replaced, graph);
	// 		}
	// }

	/**
	 * Simply prints to the console or logs.
	 * @param log put a string to log here.
	 * @param debuglog log to the debugger.
	 * @param message>
	 * @param trace says file and line and stuff.
	 */
	public static function log(log:String, debuglog:Bool = false, message:String = 'Crntu', trace = false)
	{
		if (mode == "debug")
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
		new FlxTimer().start(.30, function(tmr:FlxTimer)
		{
			FlxG.switchState(new game.Play());
			// Play.loadText = new FlxText(0, 0, 0, "Loading...", 30, true);
			// Play.loadText.setFormat("Comic Neue Angular Bold", 20, FlxColor.BLACK, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLUE, true);
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
		new FlxTimer().start(.30, function(tmr:FlxTimer)
		{
			// loadmouse();
			FlxG.switchState(new menus.Menu());
			game.Play.curLevel = level;
      FlxG.sound.music.stop();
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

	public static function openSubStatesssssss(SubState:FlxSubState):Void
	{
		// _requestSubStateReset = true;
		subStatethingidk = SubState;
	}
}

/**
 * Debug thing
 */
class DebugLogWriter
{
	static final LOG_FOLDER = "logs";
	public static final LOG_LEVELS = ['ERROR', 'WARN', 'INFO', 'TRACE'];

	/**
	 * Set this to the current timestamp that the game started.
	 */
	var startTime:Float = 0;

	var logLevel:Int;

	var active = false;
	// #if FEATURE_FILESYSTEM
	var file:sys.io.FileOutput;

	// #end

	public function new(logLevelParam:String)
	{
		logLevel = LOG_LEVELS.indexOf(logLevelParam);

		// #if FEATURE_FILESYSTEM
		printDebug("Initializing log file...");

		var timer = new Timer(1000);
		timer.run = function()
		{
			Crntu.logInfo("Current FPS: " + children.Info.currentFPS);
		}

		#if debug
		var logFilePath = '$LOG_FOLDER/CrntuLog Debug ${Sys.time()}.log';
		#else
		var logFilePath = '$LOG_FOLDER/CrntuLog ${Sys.time()}.log';
		#end

		// Make sure that the path exists
		if (logFilePath.indexOf("/") != -1)
		{
			var lastIndex:Int = logFilePath.lastIndexOf("/");
			var logFolderPath:String = logFilePath.substr(0, lastIndex);
			printDebug('Creating log folder $logFolderPath');
			sys.FileSystem.createDirectory(logFolderPath);
		}
		// Open the file
		printDebug('Creating log file $logFilePath');
		file = sys.io.File.write(logFilePath, false);
		active = true;
		// #else
		// printDebug("Won't create log file; no file system access.");
		// active = false;
		// #end

		// Get the absolute time in seconds. This lets us show relative time in log, which is more readable.
		startTime = getTime(true);
	}

	public function isActive()
	{
		return active;
	}

	/**
	 * Get the time in seconds.
	 * @param abs Whether the timestamp is absolute or relative to the start time.
	 */
	public inline function getTime(abs:Bool = false):Float
	{
		#if sys
		// Use this one on CPP and Neko since it's more accurate.
		return abs ? Sys.time() : (Sys.time() - startTime);
		#else
		// This one is more accurate on non-CPP platforms.
		return abs ? Date.now().getTime() : (Date.now().getTime() - startTime);
		#end
	}

	function shouldLog(input:String):Bool
	{
		var levelIndex = LOG_LEVELS.indexOf(input);
		// Could not find this log level.
		if (levelIndex == -1)
			return false;
		return levelIndex <= logLevel;
	}

	public function setLogLevel(input:String):Void
	{
		var levelIndex = LOG_LEVELS.indexOf(input);
		// Could not find this log level.
		if (levelIndex == -1)
			return;

		logLevel = levelIndex;
		FlxG.save.data.debugLogLevel = logLevel;
	}

	/**
	 * Output text to the log file.
	 */
	public function write(input:Array<Dynamic>, logLevel = 'TRACE'):Void
	{
		var ts = FlxStringUtil.formatTime(getTime(), true);
		var msg = '$ts [${logLevel.rpad(' ', 5)}] ${input.join('')}';

		// #if FEATURE_FILESYSTEM
		if (active && file != null)
		{
			if (shouldLog(logLevel))
			{
				file.writeString('$msg\n');
				file.flush();
				file.flush();
			}
		}
		// #end

		// Output text to the debug console directly.
		if (shouldLog(logLevel))
		{
			printDebug(msg);
		}
	}

	function printDebug(msg:String)
	{
		#if sys
		Sys.println(msg);
		#else
		// Pass null to exclude the position.
		haxe.Log.trace(msg, null);
		#end
	}
}

/**
 * The cursor
 */
class CursorSub extends FlxSubState
{
	var cursor = new FlxSprite().makeGraphic(15, 15, FlxColor.TRANSPARENT);

	public static var stopped:Bool = true;
	public static var opacity:Float = .0;

	override public function create()
	{
		cursor.loadGraphic(misc.Paths.image('ui/cursors/cursor9'), true, 14, 14);
		var trail:FlxTrail = new FlxTrail(cursor, misc.Paths.image('ui/cursors/cursor9'), 1, 1, 1, .5);
		add(trail);
		add(cursor);
		super.create();
	}

	override function update(elapsed:Float)
	{
		if (!stopped)
		{
			cursor.y = FlxG.mouse.y;
			cursor.x = FlxG.mouse.x;
			cursor.alpha = opacity;
		}
		else
		{
			cursor.alpha = 0;
		}

		super.update(elapsed);
	}
}

/**
 * The thing that powers the cursor
 */
class Cursor extends FlxState
{
	override public function create()
	{
		openSubState(new CursorSub());
		Crntu.logInfo('Cursor Class');
		super.create();
	}

	/**
	 * Loads the cursor
	 */
	public static function load()
	{
		CursorSub.stopped = false;
		setOpacity(1);
	}

	/**
	 * Sets the cursor opacity
	 * @param newOpacity 
	 */
	public static function setOpacity(newOpacity:Float = .8)
	{
		CursorSub.opacity = newOpacity;
	}
}
