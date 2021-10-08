package square;

import flixel.FlxSubState;
import flixel.FlxG;

class Global extends FlxSubState
{
    override public function update(elapsed)
    {
        super.update(elapsed);
        if (FlxG.keys.pressed.P && FlxG.keys.pressed.O && FlxG.keys.pressed.I)
        {
            final pc = new PlayerControls();
            openSubState(pc);
        }
    }
}