package;

import flixel.FlxSubState;
import flixel.util.FlxColor;
import lime.app.Application;
import openfl.Lib;
import flixel.FlxG;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxSprite;

class VT extends FlxState
{
    var button1:FlxButton;
    var button2:FlxButton;
	var button3:FlxButton;
	var button4:FlxButton;
    var one:FlxSprite;
    var two:FlxSprite;
    var three:FlxSprite;
	override public function create()
	{
        one = new FlxSprite(0, 0, Paths.image('white'));
        two = new FlxSprite(0, 0, Paths.image('thing'));
        three = new FlxSprite(0, 0);
        three.frames = Paths.getSparrowAtlas('spritesheets/1');
        // three.loadGraphic("assets/images/spritesheets/1.png", true, 501, 211);
        // three.animation.add('Idle', [1, 4, 3, 5, 3, 4, 2, 3, 5, 3, 4, 1, 2, 5, 4], 24, true);
        // three.animation.play('Idle');	
        three.animation.addByPrefix('Idle', 'IdllOLe', 24, true);
        three.animation.play('Idle');
        three.alpha = 2;
        button1 = new FlxButton(0, 0, "Back", b);
		button1.loadGraphic(Paths.image('ui/spritesheets/buttons/button'), true, 80, 20);
        button1.screenCenter();
        add(one);
        add(two);
        add(three);
		add(button1);
		super.create();
	}
	override public function update(elapsed:Float)
	{
        if (FlxG.keys.pressed.CONTROL && FlxG.mouse.wheel != 0)
        {
           FlxG.camera.zoom += (FlxG.mouse.wheel / 10);
        }
        if (FlxG.keys.pressed.CONTROL && FlxG.mouse.wheel == 0)
        {
           FlxG.camera.zoom -= (FlxG.mouse.wheel / 10);
        }
        if (!FlxG.keys.pressed.ALT && FlxG.keys.justPressed.ENTER)
        {
            final pause = new PauseSub();
            openSubState(pause);
        }
        FlxG.camera.shake(0.0005, 100);

		super.update(elapsed);
	}
	function b()
	{
		FlxG.switchState(new Menu());
	}
}
