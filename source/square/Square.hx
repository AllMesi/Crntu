package square;

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

using StringTools;

/**
	Square
**/
class Square extends FlxState
{
	// static var CURSOR1:Bool = FlxG.save.data.CURSOR1;
	// static var CURSOR2:Bool = FlxG.save.data.CURSOR2;
	// static var CURSOR3:Bool = FlxG.save.data.CURSOR3;
	static var VERSION = "0.0.1";
	public static var VER = '$VERSION';
	static var CURSOR = new FlxSprite();

	public static function unloadmouse()
	{
		FlxG.mouse.visible = false;
		FlxG.mouse.unload();
	}

	// public function new()
	// {
	// 	super();
	// 		CURSOR1 = true;
	// 		CURSOR2 = false;
	// 		CURSOR3 = false;
	// }

	public static function loadmouse()
	{
		FlxG.mouse.visible = true;
		CURSOR.makeGraphic(15, 15, FlxColor.TRANSPARENT);
		// if (CURSOR1)
		CURSOR.loadGraphic(Paths.image('ui/cursors/cursor1'));
//		if (cursor2)
//		CURSOR.loadGraphic(Paths.image('ui/cursors/cursor2'));
		// CURSOR1 = true;
		FlxG.mouse.load(CURSOR.pixels);
	}

	public static function shake(Intensity:Float = 0.05, Duration:Float = 0.5, ?OnComplete:Void->Void, Force:Bool = true):Void
	{
		FlxG.camera.shake(Intensity, Duration, OnComplete, Force);
	}

	public static function flash(Color:FlxColor = FlxColor.WHITE, Duration:Float = 1, ?OnComplete:Void->Void, Force:Bool = false)
	{
		FlxG.camera.flash(Color, Duration, OnComplete, Force);
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
    // public static function openURL(LINK:String)
    // {
    //     #if linux
    //     Sys.command('/usr/bin/xdg-open', [LINK, "&"]);
    //     #else
    //     FlxG.openURL(LINK);
    //     #end
    //     }
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
