## PickletPlayer

flash/ contains PickletPlayer.fla and *.as files to make a picklet player for the Flash plugin. The .fla contains code to initialize a SimplePlayer instance;

    import net.picklet.player.SimplePlayer;

    var player = new SimplePlayer();
    addChild(player);

    stop();

