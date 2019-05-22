use v6.c;

use NativeCall;

use GTK::Compat::Types;
use WNCK::Raw::Types;

unit package WNCK::Raw::Window;

sub wnck_window_activate (WnckWindow $window, guint32 $timestamp)
  is native(wnck)
  is export
{ * }

sub wnck_window_activate_transient (WnckWindow $window, guint32 $timestamp)
  is native(wnck)
  is export
{ * }

sub wnck_window_close (WnckWindow $window, guint32 $timestamp)
  is native(wnck)
  is export
{ * }

sub wnck_window_get (gulong $xwindow)
  returns WnckWindow
  is native(wnck)
  is export
{ * }

sub wnck_window_get_actions (WnckWindow $window)
  returns uint32 # WnckWindowActions
  is native(wnck)
  is export
{ * }

sub wnck_window_get_application (WnckWindow $window)
  returns WnckApplication
  is native(wnck)
  is export
{ * }

sub wnck_window_get_class_group (WnckWindow $window)
  returns WnckClassGroup
  is native(wnck)
  is export
{ * }

sub wnck_window_get_class_group_name (WnckWindow $window)
  returns Str
  is native(wnck)
  is export
{ * }

sub wnck_window_get_client_window_geometry (
  WnckWindow $window,
  gint $xp          is rw,
  gint $yp          is rw,
  gint $widthp      is rw,
  gint $heightp     is rw
)
  is native(wnck)
  is export
{ * }

sub wnck_window_get_geometry (
  WnckWindow $window,
  gint $xp          is rw,
  gint $yp          is rw,
  gint $widthp      is rw,
  gint $heightp     is rw
)
  is native(wnck)
  is export
{ * }

sub wnck_window_get_icon (WnckWindow $window)
  returns GdkPixbuf
  is native(wnck)
  is export
{ * }

sub wnck_window_get_icon_is_fallback (WnckWindow $window)
  returns uint32
  is native(wnck)
  is export
{ * }

sub wnck_window_get_pid (WnckWindow $window)
  returns gint
  is native(wnck)
  is export
{ * }

sub wnck_window_get_screen (WnckWindow $window)
  returns WnckScreen
  is native(wnck)
  is export
{ * }

sub wnck_window_get_session_id (WnckWindow $window)
  returns Str
  is native(wnck)
  is export
{ * }

sub wnck_window_get_session_id_utf8 (WnckWindow $window)
  returns Str
  is native(wnck)
  is export
{ * }

sub wnck_window_get_state (WnckWindow $window)
  returns guint # WnckWindowState
  is native(wnck)
  is export
{ * }

sub wnck_window_get_transient (WnckWindow $window)
  returns WnckWindow
  is native(wnck)
  is export
{ * }

sub wnck_window_get_type ()
  returns GType
  is native(wnck)
  is export
{ * }

sub wnck_window_get_window_type (WnckWindow $window)
  returns guint # WnckWindowType
  is native(wnck)
  is export
{ * }

sub wnck_window_get_workspace (WnckWindow $window)
  returns WnckWorkspace
  is native(wnck)
  is export
{ * }

sub wnck_window_get_xid (WnckWindow $window)
  returns gulong
  is native(wnck)
  is export
{ * }

sub wnck_window_has_icon_name (WnckWindow $window)
  returns uint32
  is native(wnck)
  is export
{ * }

sub wnck_window_has_name (WnckWindow $window)
  returns uint32
  is native(wnck)
  is export
{ * }

sub wnck_window_is_above (WnckWindow $window)
  returns uint32
  is native(wnck)
  is export
{ * }

sub wnck_window_is_active (WnckWindow $window)
  returns uint32
  is native(wnck)
  is export
{ * }

sub wnck_window_is_fullscreen (WnckWindow $window)
  returns uint32
  is native(wnck)
  is export
{ * }

sub wnck_window_is_in_viewport (WnckWindow $window, WnckWorkspace $workspace)
  returns uint32
  is native(wnck)
  is export
{ * }

sub wnck_window_is_maximized (WnckWindow $window)
  returns uint32
  is native(wnck)
  is export
{ * }

sub wnck_window_is_maximized_horizontally (WnckWindow $window)
  returns uint32
  is native(wnck)
  is export
{ * }

sub wnck_window_is_minimized (WnckWindow $window)
  returns uint32
  is native(wnck)
  is export
{ * }

sub wnck_window_is_on_workspace (WnckWindow $window, WnckWorkspace $workspace)
  returns uint32
  is native(wnck)
  is export
{ * }

sub wnck_window_is_pinned (WnckWindow $window)
  returns uint32
  is native(wnck)
  is export
{ * }

sub wnck_window_is_skip_pager (WnckWindow $window)
  returns uint32
  is native(wnck)
  is export
{ * }

sub wnck_window_is_visible_on_workspace (
  WnckWindow $window,
  WnckWorkspace $workspace
)
  returns uint32
  is native(wnck)
  is export
{ * }

sub wnck_window_keyboard_move (WnckWindow $window)
  is native(wnck)
  is export
{ * }

sub wnck_window_make_above (WnckWindow $window)
  is native(wnck)
  is export
{ * }

sub wnck_window_make_below (WnckWindow $window)
  is native(wnck)
  is export
{ * }

sub wnck_window_maximize (WnckWindow $window)
  is native(wnck)
  is export
{ * }

sub wnck_window_maximize_horizontally (WnckWindow $window)
  is native(wnck)
  is export
{ * }

sub wnck_window_maximize_vertically (WnckWindow $window)
  is native(wnck)
  is export
{ * }

sub wnck_window_minimize (WnckWindow $window)
  is native(wnck)
  is export
{ * }

sub wnck_window_move_to_workspace (WnckWindow $window, WnckWorkspace $space)
  is native(wnck)
  is export
{ * }

sub wnck_window_needs_attention (WnckWindow $window)
  returns uint32
  is native(wnck)
  is export
{ * }

sub wnck_window_pin (WnckWindow $window)
  is native(wnck)
  is export
{ * }

sub wnck_window_set_fullscreen (WnckWindow $window, gboolean $fullscreen)
  is native(wnck)
  is export
{ * }

sub wnck_window_set_geometry (
  WnckWindow $window,
  guint $gravity,       # WnckWindowGravity $gravity,
  guint $geometry_mask, # WnckWindowMoveResizeMask $geometry_mask,
  gint $x,
  gint $y,
  gint $width,
  gint $height
)
  is native(wnck)
  is export
{ * }

sub wnck_window_set_icon_geometry (
  WnckWindow $window,
  gint $x,
  gint $y,
  gint $width,
  gint $height
)
  is native(wnck)
  is export
{ * }

sub wnck_window_set_skip_pager (WnckWindow $window, gboolean $skip)
  is native(wnck)
  is export
{ * }

sub wnck_window_set_skip_tasklist (WnckWindow $window, gboolean $skip)
  is native(wnck)
  is export
{ * }

sub wnck_window_set_sort_order (WnckWindow $window, gint $order)
  is native(wnck)
  is export
{ * }

sub wnck_window_set_window_type (
  WnckWindow $window,
  guint $wintype # WnckWindowType $wintype
)
  is native(wnck)
  is export
{ * }

sub wnck_window_shade (WnckWindow $window)
  is native(wnck)
  is export
{ * }

sub wnck_window_stick (WnckWindow $window)
  is native(wnck)
  is export
{ * }

sub wnck_window_transient_is_most_recently_activated (WnckWindow $window)
  returns uint32
  is native(wnck)
  is export
{ * }


sub wnck_window_get_class_instance_name (WnckWindow $window)
  returns Str
  is native(wnck)
  is export
{ * }

sub wnck_window_get_group_leader (WnckWindow $window)
  returns gulong
  is native(wnck)
  is export
{ * }

sub wnck_window_get_icon_name (WnckWindow $window)
  returns Str
  is native(wnck)
  is export
{ * }

sub wnck_window_get_mini_icon (WnckWindow $window)
  returns GdkPixbuf
  is native(wnck)
  is export
{ * }

sub wnck_window_get_name (WnckWindow $window)
  returns Str
  is native(wnck)
  is export
{ * }

sub wnck_window_get_sort_order (WnckWindow $window)
  returns gint
  is native(wnck)
  is export
{ * }

sub wnck_window_is_below (WnckWindow $window)
  returns gboolean
  is native(wnck)
  is export
{ * }

sub wnck_window_is_maximized_vertically (WnckWindow $window)
  returns gboolean
  is native(wnck)
  is export
{ * }

sub wnck_window_is_most_recently_activated (WnckWindow $window)
  returns gboolean
  is native(wnck)
  is export
{ * }

sub wnck_window_is_shaded (WnckWindow $window)
  returns gboolean
  is native(wnck)
  is export
{ * }

sub wnck_window_keyboard_size (WnckWindow $window)
  returns gboolean
  is native(wnck)
  is export
{ * }

sub wnck_window_or_transient_needs_attention (WnckWindow $window)
  returns gboolean
  is native(wnck)
  is export
{ * }

sub wnck_window_unmake_above (WnckWindow $window)
  is native(wnck)
  is export
{ * }

sub wnck_window_unmake_below (WnckWindow $window)
  is native(wnck)
  is export
{ * }

sub wnck_window_unmaximize (WnckWindow $window)
  is native(wnck)
  is export
{ * }

sub wnck_window_unmaximize_horizontally (WnckWindow $window)
  is native(wnck)
  is export
{ * }

sub wnck_window_unmaximize_vertically (WnckWindow $window)
  is native(wnck)
  is export
{ * }

sub wnck_window_unminimize (WnckWindow $window, guint $timestamp)
  is native(wnck)
  is export
{ * }

sub wnck_window_unpin (WnckWindow $window)
  is native(wnck)
  is export
{ * }

sub wnck_window_unshade (WnckWindow $window)
  is native(wnck)
  is export
{ * }

sub wnck_window_unstick (WnckWindow $window)
  is native(wnck)
  is export
{ * }

sub wnck_window_get_role (WnckWindow $window)
  returns Str
  is native(wnck)
  is export
{ * }
