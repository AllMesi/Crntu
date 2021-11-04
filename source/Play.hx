package;

import flixel.input.mouse.FlxMouse;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.atlas.FlxAtlas;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import flixel.util.FlxSort;
import flixel.util.FlxStringUtil;
import flixel.util.FlxTimer;
import haxe.Json;
import lime.utils.Assets;

using StringTools;

class Play extends FlxState
{

	private var strumLine:FlxSprite;

	override public function create()
	{
		persistentUpdate = true;
		persistentDraw = true;

		strumLine = new FlxSprite(0, 70).makeGraphic(FlxG.width, 10);
		strumLine.scrollFactor.set();
		add(strumLine);

		Square.unloadmouse(false);

		super.create();
	}

	override public function update(elapsed)
	{

		if (FlxG.mouse.justMoved)
		{
			FlxG.mouse.x
			FlxG.mouse.y
			FlxG.mouse.getWorldPosition();
		}

		if (FlxG.keys.justPressed.ESCAPE)
		{
			Square.loadmouse();
			FlxG.switchState(new Menu());
		}
		super.update(elapsed);
	}
}
