package game.substates;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import game.states.PlayState;
import game.states.TitleState;
import backend.Paths;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.util.FlxColor;

class ResultsState extends FlxSubState
{
	public var background:FlxSprite;
	public var text:FlxText;
	public var anotherBackground:FlxSprite;
	public var comboText:FlxText;
	public var contText:FlxText;
    var resultsBf:FlxSprite = null;
    var resultsGf:FlxSprite = null;
    // GayState
    var sicksS = PlayState.isStoryMode ? PlayState.storySicks : PlayState.sicks;
    var goods = PlayState.isStoryMode ? PlayState.storyGoods : PlayState.goods;
    var bads = PlayState.isStoryMode ? PlayState.storyBads : PlayState.bads;
    var shits = PlayState.isStoryMode ? PlayState.storyShits : PlayState.shits; 
	var missess = PlayState.isStoryMode ? PlayState.storyMisses : PlayState.misses; 
	// Dif text shits cuz I'm gay
	public var sickText:FlxText; 
	public var goodText:FlxText; 
	public var badText:FlxText; 
	public var shitText:FlxText; 
	public var missText:FlxText; 

	override function create()
	{
		var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('resultsboard'));
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0.18;
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);

		var screenWidth:Float = FlxG.width;
		var textWidth:Float = 240;
		var centerX:Float = (screenWidth - textWidth) / 2;
		
        var bfDanceX:Float = centerX + textWidth + 20;
        var bfDanceY:Float = 50;
        var bfDance = new FlxSprite(bfDanceX, bfDanceY);
        bfDance.frames = Paths.getSparrowAtlas('results/resultBoyfriendGOOD');
        bfDance.animation.addByPrefix('idle', 'Boyfriend Good Anim', 24, false);
        bfDance.antialiasing = true;
        bfDance.flipX = false;
        bfDance.animation.play('idle');
        add(bfDance);

		text = new FlxText(centerX, 150, 0, "Level Complete!");
		text.size = 34;
		text.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 4, 1);
		text.color = FlxColor.WHITE;
		text.scrollFactor.set();
		add(text);

		sickText = new FlxText(75, 250, 0, "Sicks Hit: " + sicksS);
		sickText.size = 34;
		sickText.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 4, 1);
		sickText.color = FlxColor.WHITE;
		sickText.scrollFactor.set();
		add(sickText);
		trace("Sicks Hit: " + sicksS);
		goodText = new FlxText(75, 300, 0, "Goods Hit: " + goods);
		goodText.size = 34;
		goodText.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 4, 1);
		goodText.color = FlxColor.WHITE;
		goodText.scrollFactor.set();
		add(goodText);
		trace("Goods Hit: " + goods);
		badText = new FlxText(75, 350, 0, 'Bads: ${bads}');
		badText.size = 34;
		badText.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 4, 1);
		badText.color = FlxColor.WHITE;
		badText.scrollFactor.set();
		add(badText);
		trace("Bads Hit: " + bads);
		shitText = new FlxText(75, 400, 0, "Shits Hit: " + shits);
		shitText.size = 34;
		shitText.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 4, 1);
		shitText.color = FlxColor.WHITE;
		shitText.scrollFactor.set();
		add(shitText);
		trace("Shits hit: " + shits);
		missText = new FlxText(75, 450, 0, "Misses: " + missess);
		trace("Misses: " + missess);
		missText.size = 34;
		missText.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 4, 1);
		missText.color = FlxColor.WHITE;
		missText.scrollFactor.set();
		add(missText);

		var score = PlayState.instance.songScore;
		if (PlayState.isStoryMode)
		{
			score = PlayState.storyScore;
		}      

		super.create();
	}

	override function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.ENTER)
		{
            if (PlayState.isStoryMode)
            {
                FlxG.switchState(new game.states.StoryMenuState());
            }
            else
            {
                FlxG.switchState(new game.states.FreeplayState());
            }
		}
		super.update(elapsed);
	}
}
