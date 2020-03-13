use v6.c;

use GLib::Raw::Definitions;
use WNCK::Raw::Definitions;

constant WnckWindowState is export := guint;
our enum WnckWindowStateEnum is export (
  WNCK_WINDOW_STATE_MINIMIZED               =>  1,
  WNCK_WINDOW_STATE_MAXIMIZED_HORIZONTALLY  =>  1 +< 1,
  WNCK_WINDOW_STATE_MAXIMIZED_VERTICALLY    =>  1 +< 2,
  WNCK_WINDOW_STATE_SHADED                  =>  1 +< 3,
  WNCK_WINDOW_STATE_SKIP_PAGER              =>  1 +< 4,
  WNCK_WINDOW_STATE_SKIP_TASKLIST           =>  1 +< 5,
  WNCK_WINDOW_STATE_STICKY                  =>  1 +< 6,
  WNCK_WINDOW_STATE_HIDDEN                  =>  1 +< 7,
  WNCK_WINDOW_STATE_FULLSCREEN              =>  1 +< 8,
  WNCK_WINDOW_STATE_DEMANDS_ATTENTION       =>  1 +< 9,
  WNCK_WINDOW_STATE_URGENT                  =>  1 +< 10,
  WNCK_WINDOW_STATE_ABOVE                   =>  1 +< 11,
  WNCK_WINDOW_STATE_BELOW                   =>  1 +< 12,
);

constant WnckPagerDisplayMode is export := guint;
our enum WnckPagerDisplayModeEnum is export <
  WNCK_PAGER_DISPLAY_NAME
  WNCK_PAGER_DISPLAY_CONTENT
>;

constant WnckTasklistGroupingType is export := guint;
our enum WnckTasklistGroupingTypeEnum is export <
  WNCK_TASKLIST_NEVER_GROUP
  WNCK_TASKLIST_AUTO_GROUP
  WNCK_TASKLIST_ALWAYS_GROUP
>;

constant WnckClientType is export := guint;
our enum WnckClientTypeEnum is export (
  WNCK_CLIENT_TYPE_APPLICATION =>  1,
  WNCK_CLIENT_TYPE_PAGER       =>  2,
);

constant WnckWindowGravity is export := guint;
our enum WnckWindowGravityEnum is export (
  WNCK_WINDOW_GRAVITY_CURRENT     =>  0,
  WNCK_WINDOW_GRAVITY_NORTHWEST   =>  1,
  WNCK_WINDOW_GRAVITY_NORTH       =>  2,
  WNCK_WINDOW_GRAVITY_NORTHEAST   =>  3,
  WNCK_WINDOW_GRAVITY_WEST        =>  4,
  WNCK_WINDOW_GRAVITY_CENTER      =>  5,
  WNCK_WINDOW_GRAVITY_EAST        =>  6,
  WNCK_WINDOW_GRAVITY_SOUTHWEST   =>  7,
  WNCK_WINDOW_GRAVITY_SOUTH       =>  8,
  WNCK_WINDOW_GRAVITY_SOUTHEAST   =>  9,
  WNCK_WINDOW_GRAVITY_STATIC      =>  10,
);

constant WnckLayoutOrientation is export := guint;
our enum WnckLayoutOrientationEnum is export <
  WNCK_LAYOUT_ORIENTATION_HORIZONTAL
  WNCK_LAYOUT_ORIENTATION_VERTICAL
>;

constant WnckLayoutCorner is export := guint;
our enum WnckLayoutCornerEnum is export <
  WNCK_LAYOUT_CORNER_TOPLEFT
  WNCK_LAYOUT_CORNER_TOPRIGHT
  WNCK_LAYOUT_CORNER_BOTTOMRIGHT
  WNCK_LAYOUT_CORNER_BOTTOMLEFT
>;

constant WnckWindowMoveResizeMask is export := guint;
our enum WnckWindowMoveResizeMaskEnum is export (
  WNCK_WINDOW_CHANGE_X      =>  1,
  WNCK_WINDOW_CHANGE_Y      =>  1 +< 1,
  WNCK_WINDOW_CHANGE_WIDTH  =>  1 +< 2,
  WNCK_WINDOW_CHANGE_HEIGHT =>  1 +< 3,
);

constant WnckIconSize is export := guint;
our enum WnckIconSizeEnum is export (
  WNCK_DEFAULT_ICON_SIZE      => 32,
  WNCK_DEFAULT_MINI_ICON_SIZE => 16
);
