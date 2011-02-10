
package net.picklet.player
{
  import flash.display.MovieClip;
  import flash.display.Loader;
  import flash.events.*;
  import flash.net.FileReference;
  import flash.net.URLRequest;

  import net.picklet.player.ThumbController;
  import net.picklet.Layer;

  public class SimplePlayer extends MovieClip
  {
    // ------- Properties -------
    /*      public var name:String;*/
    private var thumb_controller:ThumbController;
    private var layers:Array;
    private var current_panel_index:Number;
    private var data:Object;
    private var previous_btn:MovieClip;
    private var next_btn:MovieClip;
    private var current_panel:MovieClip;
    private var previous_panel:MovieClip;

    // ------- Constructor -------
    public function SimplePlayer()
    {

      current_panel = new MovieClip();
      addChild(current_panel);

      previous_panel = new MovieClip();
      addChild(previous_panel);

      previous_btn = new MovieClip();
      previous_btn.graphics.beginFill(0x000000, 0.1);
      previous_btn.graphics.drawRect(0, 0, 80, 380);
      previous_btn.graphics.endFill();
      addChild(previous_btn);
      previous_btn.addEventListener(MouseEvent.MOUSE_UP, previousPanel);
      previous_btn.buttonMode = true;
      previous_btn.useHandCursor = true;
      
      next_btn = new MovieClip();
      next_btn.graphics.beginFill(0x000000, 0.1);
      next_btn.graphics.drawRect(240, 0, 80, 380);
      next_btn.graphics.endFill();
      addChild(next_btn);
      next_btn.addEventListener(MouseEvent.MOUSE_UP, nextPanel);
      next_btn.buttonMode = true;
      next_btn.useHandCursor = true;

      /* keep the thumb_controller above loaded clips */
      thumb_controller = new ThumbController();
      thumb_controller.addPlayer(this);
      addChild(thumb_controller);
      /*       setChildIndex(thumb_controller, 100);*/
      /*      setChildIndex(thumb_controller, 3);*/
    }
  
    // ------- Methods -------
    public function loadPicklet(data:Object = null):void
    {
      if (data == null) return;

      this.data = data;
      this.current_panel_index = 0;
      loadPanel(current_panel_index);
    }
    
    public function previousPanel(evt:Event):void
    {
      current_panel_index--;
      loadPanel(current_panel_index);
    }

    public function nextPanel(evt:Event):void
    {
      current_panel_index++;
      loadPanel(current_panel_index);
    }

    public function showControls(val:Boolean):void
    {
      thumb_controller.drawThumb(val);
      var fill_opacity:Number;
      if (val) {
        fill_opacity = 0.1;
      } else {
        fill_opacity = 0;
      }

      previous_btn.graphics.clear();
      previous_btn.graphics.beginFill(0x000000, fill_opacity);
      previous_btn.graphics.drawRect(0, 0, 80, 380);
      previous_btn.graphics.endFill();

      next_btn.graphics.clear();
      next_btn.graphics.beginFill(0x000000, fill_opacity);
      next_btn.graphics.drawRect(240, 0, 80, 380);
      next_btn.graphics.endFill();
    }

    public function loadPanel(panel_index:Number):void
    {
      if (panel_index >= data.panels.length) {
        current_panel_index = data.panels.length - 1;
        return;
      } else if (panel_index < 0) {
        current_panel_index = 0;
        return;
      }
      
      previous_panel = current_panel;
      removeChild(previous_panel);
      current_panel = new MovieClip();
      addChild(current_panel);
      setChildIndex(current_panel, 1);
      
      this.layers = new Array();

      for (var i:String in data.panels[panel_index].layers) {
        var layer:Object = data.panels[panel_index].layers[i];
        var layer_mc:Layer = new Layer();
        layer_mc.init(layer);
        current_panel.addChild(layer_mc);
        layers.push(layer_mc);
      }
    }

    public function updatePositions(pos:Number = 0):void
    {
      for (var i:String in layers) {
        layers[i].updatePosition(pos);
      }
    }

    public function sayHello():String
    {
       // create the greeting text and pass it as the return value
       return null;
    }
  }
}