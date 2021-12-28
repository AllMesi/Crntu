package misc;

import openfl.Lib;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.FlxState;
import lime.app.Application;
import openfl.display.BitmapData;
import openfl.utils.Assets as OpenFlAssets;
import flixel.graphics.FlxGraphic;

using StringTools;

class LoadState extends FlxState
{
	var l:FlxText;
	var toBeDone = 0;
	var done = 0;
	var http = new haxe.Http("https://raw.githubusercontent.com/AllMesi/Crntu/main/version");
	var returnedData:Array<String> = [];

	static var images = [];
	public static var bitmapData:Map<String, FlxGraphic>;

	override public function create()
	{
		super.create();
		bitmapData = new Map<String, FlxGraphic>();
		FlxG.mouse.visible = false;
		l = new FlxText(200, 0, 0, "Loading..", 10);
		l.setFormat('VCR OSD Mono', 30, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, true);
		// add(l);
		FlxG.mouse.useSystemCursor = true;
		new FlxTimer().start(.3, function(tmr:FlxTimer)
		{
			DiscordClient.initialize();
			Crntu.onInitProgram();

			Application.current.onExit.add(function(exitCode)
			{
				DiscordClient.shutdown();
			});
			Crntu.onGameStart();

			Crntu.log("test log", false);
			// Application.current.window.resize(2000, 720);
			// Application.current.window.x = -5;
			// Application.current.window.y = -5;

			// var backdrop = new FlxBackdrop(Paths.image('sb'));
			// backdrop.cameras = [FlxG.camera];
			// backdrop.velocity.set(0, 150);
			// add(backdrop);

			Crntu.fps = 1000;

			FlxG.mouse.visible = true;
			FlxG.mouse.useSystemCursor = true;

			// new FlxTimer().start(.9, function(tmr:FlxTimer)
			// {
			// http.onData = function(data:String)
			// {
			// 	returnedData[0] = data.substring(0, data.indexOf(';'));
			// 	returnedData[1] = data.substring(data.indexOf('-'), data.length);
			// 	if (!Crntu.VER.contains(returnedData[0].trim()) && !OutdatedAlert.leftState)
			// 	{
			// 		Crntu.log('outdated ' + returnedData[0] + ' != ' + Crntu.VER);
			// 		OutdatedAlert.needVer = returnedData[0];
			// 		OutdatedAlert.currChanges = returnedData[1];
			// 		FlxG.switchState(new OutdatedAlert());
			// 	}
			// 	else
			// 	{
			// 		FlxG.switchState(new SplashScreens());
			// 	}
			// }

			// http.onError = function(error)
			// {
			// 	Crntu.log('error: $error');
			// 	FlxG.switchState(new SplashScreens());
			// }

			// http.request();
			// });
			// sys.thread.Thread.create(() ->
			// {
			//   for (i in images)
			//   {
			//     var replaced = i.replace(".png", "");

			//     var data:BitmapData = BitmapData.fromFile("assets/images" + i);
			//     var imagePath = misc.Paths.image('$i');
			//     // Debug.logTrace('Caching character graphic $i ($imagePath)...');
			//     var data = OpenFlAssets.getBitmapData(imagePath);
			//     var graph = FlxGraphic.fromBitmapData(data);
			//     graph.persist = true;
			//     graph.destroyOnNoUse = false;
			//     bitmapData.set(replaced, graph);
			//   }
			// });

			// 	sys.thread.Thread.create(() ->
			// 	{
			// 		while (!loaded)
			// 		{
			// 			if (toBeDone != 0 && done != toBeDone)
			// 			{
			// 				l.text = 'Loading... ($done/$toBeDone)';
			// 			}
			// 		}
			// 	});
			// 		add(l);
			setup();
			FlxG.switchState(new menus.Menu());
		});
		// }
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	public function setup()
	{
		// for (i in FileSystem.readDirectory(FileSystem.absolutePath("public/images")))
		// {
		// 	if (!i.endsWith(".png"))
		// 		continue;
		// 	images.push(i);
		// }

		// for (i in FileSystem.readDirectory(FileSystem.absolutePath("public/images/ui")))
		// {
		// 	if (!i.endsWith(".png"))
		// 		continue;
		// 	images.push(i);
		// }

		// for (i in FileSystem.readDirectory(FileSystem.absolutePath("public/images/ui/spritesheets/buttons")))
		// {
		// 	if (!i.endsWith(".png"))
		// 		continue;
		// 	images.push(i);
		// }

		// for (i in FileSystem.readDirectory(FileSystem.absolutePath("public/images/ui/game")))
		// {
		// 	if (!i.endsWith(".png"))
		// 		continue;
		// 	images.push(i);
		// }

		// for (i in FileSystem.readDirectory(FileSystem.absolutePath("public/images/ui/game/spritesheets")))
		// {
		// 	if (!i.endsWith(".png"))
		// 		continue;
		// 	images.push(i);
		// }

		// for (i in FileSystem.readDirectory(FileSystem.absolutePath("public/images/ui/cursors")))
		// {
		// 	if (!i.endsWith(".png"))
		// 		continue;
		// 	images.push(i);
		// }

		// for (i in FileSystem.readDirectory(FileSystem.absolutePath("public/images/spritesheets")))
		// {
		// 	if (!i.endsWith(".png"))
		// 		continue;
		// 	images.push(i);
		// }
		// cache();

		// l2.text = 'Setup func';

		if (FlxG.save.data.fs)
		{
			Crntu.setupWindow(false, true, false, false, false, true);
		}
		else if (FlxG.save.data.blfs)
		{
			Crntu.setupWindow(true, false, false, false, false, true);
		}
		else if (FlxG.save.data.w)
		{
			Crntu.setupWindow(false, false, true, false, false, true);
		}
		else if (FlxG.save.data.wm)
		{
			Crntu.setupWindow(false, false, false, true, false, true);
		}
	}
}
