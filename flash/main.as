/*
Copyright (C) 2011 Stewart Haines

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
*/
// file: main.as
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
