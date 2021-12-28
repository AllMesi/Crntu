package misc;

import flixel.FlxSubState;
import flixel.group.FlxGroup;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.addons.effects.FlxTrail;

class CursorSprite extends FlxSubState
{
  var cursor = new FlxSprite().loadGraphic(misc.Paths.image('ui/cursors/cursor9'), true, 14, 14);
	public static var stopped:Bool = true;
	public static var alphaa:Float = 0.0;
	// var trail:FlxTrail = new FlxTrail(cursor, misc.Paths.image('ui/cursors/cursor9'), 1, 1, 1, .5);

	// public function new(x:Float, y:Float)
	// {
	// 	super(x, y);

	// 	// E.loadGraphic(misc.Paths.image('ui/cursors/cursor9'), true, 14, 14);

	// 	// drag.x = drag.y = 1600;
	// }

	override function update(elapsed:Float)
	{
		// E.x = FlxG.mouse.x;
		// E.y = FlxG.mouse.y;

		// if (f)
		// {
    //   FlxGroup.add(trail);
    //   f = false;
    // }

		if (!stopped)
		{
      cursor.y = FlxG.mouse.y;
      cursor.x = FlxG.mouse.x;
			cursor.alpha = alphaa;
		}
    else
    {
      close();
    }

		super.update(elapsed);
	}
}
