package;

import flixel.FlxSubState;
import flixel.util.FlxColor;
import lime.app.Application;
import openfl.Lib;
import flixel.FlxG;
import flixel.FlxState;
import flixel.ui.FlxButton;
import square.Square;
import flixel.FlxSprite;

class VT extends FlxState
{
	public static var curStage:String = '';
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
        three.animation.addByPrefix('Idle', 'Idle', 60);
        three.animation.play('Idle');	
        three.alpha = 0;

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
        if (!FlxG.keys.pressed.ALT && FlxG.keys.justPressed.ENTER)
        {
            final pause = new PauseSub();
            openSubState(pause);
        }

        Square.shake(0.0005, 100);

		super.update(elapsed);
	}

	function b()
	{
		FlxG.switchState(new Play());
	}
}
