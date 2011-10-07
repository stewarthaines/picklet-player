## PickletPlayer

flash/ contains PickletPlayer.fla and *.as files to make a picklet player for the Flash plugin. The .fla contains code to initialize a SimplePlayer instance;

    import net.picklet.player.SimplePlayer;

    var player = new SimplePlayer();
    addChild(player);

    stop();

In addition there is an Ant build task which will use Flex 4 to compile the player, which is my preferred method. See flash/build.xml flash/PickletPlayer.mxml and flash/main.as for details.

requires;

com.adobe.serialization.json

### picklet.json format

need to document this somewhere...

    var layer_prototype = {
      'name': 'head',
      'image': 'images/head.png',
      'start_x': 0,
      'start_y': 0,
      'end_x': 0,
      'end_y': 0,
      'width': 0,
      'height': 0,
      'origin_x': null,
      'origin_x_rel': 50,
      'origin_y': null,
      'origin_y_rel': 50,
      'rotation': 0,
      'rotation_offset': 0,
      'transform': '',
      'index': 0,
      'start_opacity': 1,
      'end_opacity': 1,
      'visible': true
    };

    var picklet_prototype = {
      'title': '(no title)',
      'about': '(short description of this picklet)',
      'sticky': false,
      'public': true,
      'author_name': 'Firstname Lastname',
      'author_about': 'short biography of author',
      'copyable': false,
      'layers': []
    };
