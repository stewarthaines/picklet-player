
package net.picklet
{
  import flash.display.Sprite;
  import flash.display.Loader;
  import flash.events.*;
  import flash.net.URLRequest;

  public class Layer extends Sprite
  {
    private var data:Object;
    private var loader:Loader;

    // ------- Constructor -------
    public function Layer()
    {

    }
  
    // ------- Properties -------
    public var visible_name:String;
  
    // ------- Methods -------
    public function init(data:Object = null):void
    {
      if (data == null) return;

      this.data = data;
/*      trace ('loading: ' + data['image']);*/
      // load the layer image and position
      var url:String = data['image'];
      var urlRequest:URLRequest = new URLRequest(url);
      this.loader = new Loader();
      loader.contentLoaderInfo.addEventListener(Event.INIT, initListener);
      loader.load(urlRequest);
      loader.x = - data['origin_x'];
      loader.y = - data['origin_y'];
      this.rotation = data['rotation_offset'] * 180 / Math.PI;
      this.x = data['start_x'];
      this.y = data['start_y'];
      addChild(loader);
/*      setChildIndex(loader, i);*/
    }
    
    public function initListener(evt:Event):void
    {
      evt.target.content.smoothing = true;
    }

    public function updatePosition(pos:Number = 0):void
    {
      this.loader.x = - pos * this.data['origin_x'] - (1 - pos) * this.data['origin_x'];
      this.loader.y = - pos * this.data['origin_y'] - (1 - pos) * this.data['origin_y'];

      this.rotation = (pos * this.data['rotation'] + this.data['rotation_offset']) * 180 / Math.PI;
      this.x = pos * this.data['end_x'] + (1 - pos) * this.data['start_x'];
      this.y = pos * this.data['end_y'] + (1 - pos) * this.data['start_y'];
    }
  }
}
