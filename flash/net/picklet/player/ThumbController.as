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
// author: Stewart Haines
// date: 2011-02-10
// https://github.com/stewarthaines/picklet-player

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

    private var thumb_start_x:int = 224;
    private var thumb_start_y:int = 407;

    private var target_x:int = thumb_start_x;
    private var target_y:int = thumb_start_y;

    private var thumb_width:int = 70;
    private var thumb_height:int = 50;

    private var thumb_travel_x:int = -200;

    private var thumb_border_radius:int = 10;
    private var anim_timer:Timer;
    private var dragging:Boolean = false;

    private var timer_frequency:int = 20; // ms

    private var player:SimplePlayer;

    private var draw_thumb:Boolean = true;

    public function ThumbController()
    {
      // draw background so this MovieClip gets the specified dimensions
      graphics.beginFill(0x000000, 0.1);
      graphics.drawRect(0, 386, stage_width, 94);
      graphics.drawRect(0, 0, stage_width, 20);
      graphics.endFill();

      buttonMode = true;
      useHandCursor = true;

      // do this to reset the thumb if mouse moves outside the stage
      addEventListener(MouseEvent.MOUSE_OUT, mouseOut);

      thumb = getThumb();
      addChild(thumb);

      anim_timer = new Timer(timer_frequency, 0);
      anim_timer.addEventListener('timer', timerHandler);

      dragging = false;
    }

    private function getThumb():MovieClip
    {
      var thumb:MovieClip = new MovieClip();
      if (draw_thumb) {
        thumb.graphics.lineStyle(2, 0xff0000);
      } else {
/*        thumb.graphics.lineStyle(0, 0);*/
      }
      thumb.graphics.beginFill(0xffffff, 0); // fill is transparent
      thumb.graphics.drawRoundRect(0, 0, thumb_width, thumb_height, thumb_border_radius);
      thumb.graphics.endFill();
      thumb.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
      thumb.x = thumb_start_x;
      thumb.y = thumb_start_y;
      return thumb;
    }

    public function drawThumb(val:Boolean):void
    {
      draw_thumb = val;
      removeChild(thumb);
      thumb = getThumb();
      addChild(thumb);

      graphics.clear();
      if (val) {
        graphics.beginFill(0x000000, 0.1);
      } else {
        graphics.beginFill(0x000000, 0);
      }
      graphics.drawRect(0, 386, stage_width, 94);
      graphics.drawRect(0, 0, stage_width, 20);
      graphics.endFill();
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
      /* notify listeners of move event */
      if (this.player) {
        var pos:Number = (thumb.x - thumb_start_x) / thumb_travel_x;
/*        trace(pos);*/
        player.updatePositions(pos);
      }
    }

    public function mouseOut(evt:MouseEvent):void
    {
      if (dragging && (evt.target == this) && (evt.relatedObject != thumb)) {
        mouseUp(evt);
      } else if (dragging && (evt.target == thumb) && (evt.relatedObject != this)) {
        mouseUp(evt);
      }
    }

    public function mouseDown(evt:MouseEvent):void
    {
      thumb.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
      start_x = evt.stageX - thumb.x;
      start_y = evt.stageY - thumb.y;
      addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
      addEventListener(MouseEvent.MOUSE_UP, mouseUp);

      anim_timer.start();
      dragging = true;
    }

    public function mouseMove(evt:MouseEvent):void
    {
/*      thumb.x = evt.stageX - start_x;*/
      target_x = evt.stageX - start_x;
      if (thumb_travel_x < 0) {
        if (target_x > thumb_start_x) {
          target_x = thumb_start_x;
        } else if (target_x < (thumb_start_x + thumb_travel_x)) {
          target_x = thumb_start_x + thumb_travel_x;
        }
      } else {
        // fill in (thumb_travel_x > 0) case here as required
      }
/*      thumb.y = thumb_start_y;*/
    }

    public function mouseUp(evt:MouseEvent):void
    {
      removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
      removeEventListener(MouseEvent.MOUSE_UP, mouseUp);

      if (target_x == thumb_start_x + thumb_travel_x) {
        player.nextPanel(null);
      }
      // return thumb to its initial position
      target_x = thumb_start_x;
      target_y = thumb_start_y;
      dragging = false;
    }

    public function addPlayer(p:SimplePlayer):void
    {
      this.player = p;
    }
  }
}
