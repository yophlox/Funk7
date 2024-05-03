// Lit js a pause substate clone
package debug.states;

import Controls.Control;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.system.FlxSound;
import flixel.util.FlxColor;
import game.states.LoopState;
import game.states.PlayState;

class DebugPauseState extends MusicBeatSubstate
{
	var grpMenuShit:FlxTypedGroup<Alphabet>;

	var menuItems:Array<String> = ['Speed Up Song', 'Slow Down Song', 'Set Song To Normal', 'Loop Song', 'Close'];
	var curSelected:Int = 0;

	var pauseMusic:FlxSound;
	var loopCallback:Bool->Void;
	var loopState:LoopState;

	public function new(x:Float, y:Float,loopCallback:Bool->Void,loopState:LoopState)
	{
		super();

		pauseMusic = new FlxSound().loadEmbedded('assets/music/breakfast' + game.states.TitleState.soundExt, true, true);
		pauseMusic.volume = 0;
		pauseMusic.play(false, FlxG.random.int(0, Std.int(pauseMusic.length / 2)));

		FlxG.sound.list.add(pauseMusic);

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0.6;
		bg.scrollFactor.set();
		add(bg);

		this.loopCallback = loopCallback;
		this.loopState = loopState;
		updateLoopState();

		grpMenuShit = new FlxTypedGroup<Alphabet>();
		add(grpMenuShit);

		for (i in 0...menuItems.length)
		{
			var songText:Alphabet = new Alphabet(0, (70 * i) + 30, menuItems[i], true, false);
			songText.isMenuItem = true;
			songText.targetY = i;
			grpMenuShit.add(songText);
		}

		changeSelection();

		cameras = [FlxG.cameras.list[1]];
	}

	override function update(elapsed:Float)
	{
		if (pauseMusic.volume < 0.5)
			pauseMusic.volume += 0.01 * elapsed;

		super.update(elapsed);

		var upP = controls.UP_P;
		var downP = controls.DOWN_P;
		var accepted = controls.ACCEPT;

		if (upP)
		{
			changeSelection(-1);
		}
		if (downP)
		{
			changeSelection(1);
		}

		if (accepted)
		{
			var daSelected:String = menuItems[curSelected];

			switch (daSelected)
			{
				case "Speed Up Song":
					PlayState.timeScale *= 2;
				case "Slow Down Song":
					PlayState.timeScale /= 2;
                case "Set Song To Normal":
                    PlayState.timeScale = 1;    
                case "Loop Song":
                    loopCallback(false);
				case "Close":
					close();
			}
		}
	}

	function updateLoopState(){
		FlxG.log.add(loopState);
		switch(loopState){
			case NONE:
				menuItems[2] = 'Loop Song';
				menuItems[3] = 'AB Repeat';
			case REPEAT:
				menuItems[2] = 'Stop Repeating';
				menuItems[3] = 'AB Repeat';
			case ANODE:
				menuItems[2] = 'Cancel AB repeat';
				menuItems[3] = 'Confirm B Node';
			case ABREPEAT:
				menuItems[2] = 'Loop Song';
				menuItems[3] = 'Stop Repeating';
		}
	}

	override function destroy()
	{
		pauseMusic.destroy();

		super.destroy();
	}

	function changeSelection(change:Int = 0):Void
	{
		curSelected += change;

		if (curSelected < 0)
			curSelected = menuItems.length - 1;
		if (curSelected >= menuItems.length)
			curSelected = 0;

		var bullShit:Int = 0;

		for (item in grpMenuShit.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
	}
}
