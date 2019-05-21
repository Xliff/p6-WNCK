use v6.c;

use GTK::Compat::Types;
use GTK::Roles::Pointers;

unit package WNCK::Raw::Types;

constant wnck is export = 'wnck-3',v0;

class WnckActionMenu        is repr('CPointer') does GTK::Roles::Pointers is export { }
class WnckApplication       is repr('CPointer') does GTK::Roles::Pointers is export { }
class WnckClassGroup        is repr('CPointer') does GTK::Roles::Pointers is export { }
class WnckPager             is repr('CPointer') does GTK::Roles::Pointers is export { }
class WnckScreen            is repr('CPointer') does GTK::Roles::Pointers is export { }
class WnckSelector          is repr('CPointer') does GTK::Roles::Pointers is export { }
class WnckTasklist          is repr('CPointer') does GTK::Roles::Pointers is export { }
class WnckWindow            is repr('CPointer') does GTK::Roles::Pointers is export { }
class WnckWorkspace         is repr('CPointer') does GTK::Roles::Pointers is export { }

class WnckResourceUsage is repr('CStruct') does GTK::Roles::Pointers is export {
  has gulong  $.total_bytes_estimate is rw;
  has gulong  $.pixmap_bytes         is rw;
  has guint   $.n_pixmaps            is rw;
  has guint   $.n_windows            is rw;
  has guint   $.n_gcs                is rw;
  has guint   $.n_pictures           is rw;
  has guint   $.n_glyphsets          is rw;
  has guint   $.n_fonts              is rw;
  has guint   $.n_colormap_entries   is rw;
  has guint   $.n_passive_grabs      is rw;
  has guint   $.n_cursors            is rw;
  has guint   $.n_other              is rw;
};

our enum WnckWindowState is export (
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

our enum WnckPagerDisplayMode is export <
  WNCK_PAGER_DISPLAY_NAME
  WNCK_PAGER_DISPLAY_CONTENT
>;

our enum WnckTasklistGroupingType is export <
  WNCK_TASKLIST_NEVER_GROUP
  WNCK_TASKLIST_AUTO_GROUP
  WNCK_TASKLIST_ALWAYS_GROUP
>;

our enum WnckClientType is export (
  WNCK_CLIENT_TYPE_APPLICATION =>  1,
  WNCK_CLIENT_TYPE_PAGER       =>  2,
);

our enum WnckWindowGravity is export (
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

our enum WnckLayoutOrientation is export <
  WNCK_LAYOUT_ORIENTATION_HORIZONTAL
  WNCK_LAYOUT_ORIENTATION_VERTICAL
>;

our enum WnckLayoutCorner is export <
  WNCK_LAYOUT_CORNER_TOPLEFT
  WNCK_LAYOUT_CORNER_TOPRIGHT
  WNCK_LAYOUT_CORNER_BOTTOMRIGHT
  WNCK_LAYOUT_CORNER_BOTTOMLEFT
>;

our enum WnckWindowMoveResizeMask is export (
  WNCK_WINDOW_CHANGE_X      =>  1,
  WNCK_WINDOW_CHANGE_Y      =>  1 +< 1,
  WNCK_WINDOW_CHANGE_WIDTH  =>  1 +< 2,
  WNCK_WINDOW_CHANGE_HEIGHT =>  1 +< 3,
);

our enum WnckIconSize is export (
  WNCK_DEFAULT_ICON_SIZE      => 32,
  WNCK_DEFAULT_MINI_ICON_SIZE => 16
);
