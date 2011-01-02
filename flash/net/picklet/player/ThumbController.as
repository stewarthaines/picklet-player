/*
  net.picklet.player.ThumbController
  author: Stewart Haines
  date: 2010-01-01
*/

package net.picklet.player
{
  import flash.display.MovieClip;
  import flash.events.MouseEvent;
  import flash.utils.Timer;
  import flash.events.TimerEvent;
  
  public class ThumbController extends MovieClip
  {
    private var stage_width:int = 320;
    private var stage_height:int = 480;

    private var thumb:MovieClip;
    private var start_x:int;
    private var start_y:int;
    
    private var thumb_start_x:int = 210;
    private var thumb_start_y:int = 390;
    
    private var target_x:int = thumb_start_x;
    private var target_y:int = thumb_start_y;

    private var thumb_width:int = 70;
    private var thumb_height:int = 50;

    private var thumb_travel_x:int = 200;
    
    private var thumb_border_radius:int = 10;
    private var anim_timer:Timer;
    private var dragging:Boolean = false;
    
    private var timer_frequency:int = 20; // ms
    private var direction_rtl:Boolean = true;

    public function ThumbController()
    {
      // draw background so this MovieClip gets the specified dimensions
      graphics.beginFill(0x00ff00, 0.0);
      graphics.drawRect(x, y, stage_width, stage_height);
      graphics.endFill();
      
      // do this to reset the thumb if mouse moves outside the stage
      addEventListener(MouseEvent.MOUSE_OUT, mouseOut);

      thumb = new MovieClip();
      thumb.graphics.lineStyle(2, 0xff0000);
      thumb.graphics.beginFill(0xffffff, 0); // fill is transparent
      thumb.graphics.drawRoundRect(0, 0, thumb_width, thumb_height, thumb_border_radius);
      thumb.graphics.endFill();
      thumb.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
      thumb.x = thumb_start_x;
      thumb.y = thumb_start_y;
      addChild(thumb);

      anim_timer = new Timer(timer_frequency, 0);
      anim_timer.addEventListener('timer', timerHandler);

      dragging = false;
    }

    public function timerHandler(evt:TimerEvent):void {
      // adjust position of thumb closer to the target position, or clamped
      if (!dragging && (thumb.x == target_x)) {
        anim_timer.reset();
        thumb.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
      } else {
        if (dragging) {
          if (Math.abs(thumb.x - target_x) < 3) {
            thumb.x = target_x;
          } else {
            thumb.x -= Math.floor((thumb.x - target_x) / 2);
          }
        } else {
          if (Math.abs(thumb.x - target_x) < 3) {
            thumb.x = target_x;
          } else {
            thumb.x -= Math.floor((thumb.x - target_x) / 3);
            thumb.y -= Math.floor((thumb.y - target_y) / 3);
          }
        }
      }
    }
    
    public function mouseOut(evt:MouseEvent) {
      if (dragging && (evt.target == this) && (evt.relatedObject != thumb)) {
        mouseUp(evt);
      } else if (dragging && (evt.target == thumb) && (evt.relatedObject != this)) {
        mouseUp(evt);
      }
    }

    public function mouseDown(evt:MouseEvent)
    {
      thumb.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
      start_x = evt.stageX - thumb.x;
      start_y = evt.stageY - thumb.y;
      addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
      addEventListener(MouseEvent.MOUSE_UP, mouseUp);

      anim_timer.start();
      dragging = true;
    }
    
    public function mouseMove(evt:MouseEvent)
    {
/*      thumb.x = evt.stageX - start_x;*/
      target_x = evt.stageX - start_x;
      if (direction_rtl) {
        if (target_x > thumb_start_x) {
          target_x = thumb_start_x;
        } else if (target_x < (thumb_start_x - thumb_travel_x)) {
          target_x = thumb_start_x - thumb_travel_x;
        }
      } else {
        // fill in (direction_rtl == false) case here as required
      }
/*      thumb.y = thumb_start_y;*/
    }
    
    public function mouseUp(evt:MouseEvent)
    {
      removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
      removeEventListener(MouseEvent.MOUSE_UP, mouseUp);

      // return thumb to its initial position
      target_x = thumb_start_x;
      target_y = thumb_start_y;
      
      dragging = false;
    }
  }
}