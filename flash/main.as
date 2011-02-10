// PickletPlayer.fla
// author: Stewart Haines
// date: 2011-01-01
// https://github.com/stewarthaines/picklet-player

import flash.net.URLRequest;
import flash.net.URLLoader;
import flash.events.*;
import com.adobe.serialization.json.JSON;

import net.picklet.player.SimplePlayer;

var player:SimplePlayer;

function initPickletPlayer():void
{
  player = new SimplePlayer();
  stage.addChild(player);
  /*  stop();*/
  // loaderInfo.parameters corresponds to FlashVars in html parameters to embedded object
  var content_string:String = root.loaderInfo.parameters.picklet_content;
  trace(root.loaderInfo.parameters.picklet_content);
  if (typeof(root.loaderInfo.parameters.picklet_content) == 'undefined') {
    var dummy_url:String = 'dummy.json';

    var loader:URLLoader = new URLLoader();
    var request:URLRequest = new URLRequest(dummy_url);
    loader.addEventListener(Event.COMPLETE, onComplete);
    loader.load(request);
  } else {
  //  debug_txt.text = content_string;
    var jsonData:Object = JSON.decode(content_string);
    player.showControls(false);
    player.loadPicklet(jsonData);
  }

};

function onComplete(e:Event):void
{
  var loader:URLLoader = URLLoader(e.target);
  var jsonData:Object = JSON.decode(loader.data);
  player.loadPicklet(jsonData);
  //trace(jsonData);
}
