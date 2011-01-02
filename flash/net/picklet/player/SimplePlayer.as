
package net.picklet.player
{
  import flash.display.MovieClip;
  import net.picklet.player.ThumbController;

   public class SimplePlayer extends MovieClip
   {
      // ------- Constructor -------
      public function SimplePlayer()
      {
         this.thumb_controller = new ThumbController();
         addChild(thumb_controller);
         
      }
      
      // ------- Properties -------
/*      public var name:String;*/
      private var thumb_controller:ThumbController;
      
      // ------- Methods -------
      public function loadPickletFromString(value:String = null)
      {
        if (value == null) return;
        
        
      }

      public function sayHello():String
      {
         // create the greeting text and pass it as the return value
         return null;
      }
   }
}