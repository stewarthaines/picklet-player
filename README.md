## PickletPlayer

flash/ contains PickletPlayer.fla and *.as files to make a picklet player for the Flash plugin. The .fla contains code to initialize a SimplePlayer instance;

    import net.picklet.player.SimplePlayer;

    var player = new SimplePlayer();
    addChild(player);

    stop();

In addition there is an Ant build task which will use Flex 4 to compile the player, which is my preferred method. See flash/build.xml flash/PickletPlayer.mxml and flash/main.as for details.

requires;

com.adobe.serialization.json
