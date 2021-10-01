package;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxMath;
import flixel.util.FlxColor;

using StringTools;

class Note extends FlxSprite
{
	public var strumTime:Float = 0;

	public var mustPress:Bool = false;
	public var noteData:Int = 0;
	public var canBeHit:Bool = false;
	public var tooLate:Bool = false;
	public var wasGoodHit:Bool = false;
	public var prevNote:Note;

	public var sustainLength:Float = 0;
	public var isSustainNote:Bool = false;

	public var noteScore:Float = 1;

	public static var swagWidth:Float = 160 * 0.7;
	public static var LEFT_NOTE:Int = 0;
	public static var UP_NOTE:Int = 2;
	public static var DOWN_NOTE:Int = 1;
	public static var RIGHT_NOTE:Int = 3;

	public function new(strumTime:Float, noteData:Int, ?prevNote:Note, ?sustainNote:Bool = false)
	{
		super();

		if (prevNote == null)
			prevNote = this;

		this.prevNote = prevNote;
		isSustainNote = sustainNote;

		x += 50;
		// MAKE SURE ITS DEFINITELY OFF SCREEN?
		y -= 2000;
		this.strumTime = strumTime;

		this.noteData = noteData;

		var daStage:String = PlayState.curStage;

		switch (daStage)
		{
				animation.add('upScroll', [6]);
				animation.add('rightScroll', [7]);
				animation.add('downScroll', [5]);
				animation.add('leftScroll', [4]);

				if (isSustainNote)
				{
					animation.add('leftholdend', [4]);
					animation.add('upholdend', [6]);
					animation.add('rightholdend', [7]);
					animation.add('downholdend', [5]);

					animation.add('lefthold', [0]);
					animation.add('uphold', [2]);
					animation.add('righthold', [3]);
					animation.add('downhold', [1]);
				}

				setGraphicSize(Std.int(width * PlayState.daPixelZoom));
				updateHitbox();

			default:
				frames = Paths.getSparrowAtlas('notes');

				animation.addByPrefix('upScroll', 'up0');
				animation.addByPrefix('rightScroll', 'right0');
				animation.addByPrefix('downScroll', 'down0');
				animation.addByPrefix('leftScroll', 'left0');

				animation.addByPrefix('leftholdend', 'left hold end');
				animation.addByPrefix('upholdend', 'up hold end');
				animation.addByPrefix('rightholdend', 'right hold end');
				animation.addByPrefix('downholdend', 'down hold end');

				animation.addByPrefix('lefthold', 'left hold piece');
				animation.addByPrefix('uphold', 'up hold piece');
				animation.addByPrefix('righthold', 'right hold piece');
				animation.addByPrefix('downhold', 'down hold piece');

				setGraphicSize(Std.int(width * 0.7));
				updateHitbox();
				antialiasing = true;
		}

		switch (noteData)
		{
			case 0:
				x += swagWidth * 0;
				animation.play('leftScroll');
			case 1:
				x += swagWidth * 1;
				animation.play('downScroll');
			case 2:
				x += swagWidth * 2;
				animation.play('upScroll');
			case 3:
				x += swagWidth * 3;
				animation.play('rightScroll');
		}

		// trace(prevNote);

		if (isSustainNote && prevNote != null)
		{
			noteScore * 0.2;
			alpha = 0.6;

			x += width / 2;

			switch (noteData)
			{
				case 2:
					animation.play('upholdend');
				case 3:
					animation.play('rightholdend');
				case 1:
					animation.play('downholdend');
				case 0:
					animation.play('leftholdend');
			}

			updateHitbox();

			x -= width / 2;

			// if (PlayState.curStage.startsWith('school'))
			// 	x += 30;

			if (prevNote.isSustainNote)
			{
				switch (prevNote.noteData)
				{
					case 0:
						prevNote.animation.play('lefthold');
					case 1:
						prevNote.animation.play('downhold');
					case 2:
						prevNote.animation.play('uphold');
					case 3:
						prevNote.animation.play('righthold');
				}

				prevNote.scale.y *= Conductor.stepCrochet / 100 * 1.5 * PlayState.SONG.speed;
				prevNote.updateHitbox();
				// prevNote.setGraphicSize();
			}
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (mustPress)
		{
			// The * 0.5 is so that it's easier to hit them too late, instead of too early
			if (strumTime > Conductor.songPosition - Conductor.safeZoneOffset
				&& strumTime < Conductor.songPosition + (Conductor.safeZoneOffset * 0.5))
				canBeHit = true;
			else
				canBeHit = false;

			if (strumTime < Conductor.songPosition - Conductor.safeZoneOffset && !wasGoodHit)
				tooLate = true;
		}
		else
		{
			canBeHit = false;

			if (strumTime <= Conductor.songPosition)
				wasGoodHit = true;
		}

		if (tooLate)
		{
			if (alpha > 0.3)
				alpha = 0.3;
		}
	}
}
