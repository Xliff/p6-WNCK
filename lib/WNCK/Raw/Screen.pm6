use v6.c;

use NativeCall;

use GTK::Compat::Types;
use WNCK::Raw::Types;

unit package WNCK::Raw::Screen;

sub wnck_screen_calc_workspace_layout (
  WnckScreen $screen,
  gint $num_workspaces,
  gint $space_index,
  guint $layout # WnckWorkspaceLayout $layout
)
  is native(wnck)
  is export
{ * }

sub wnck_screen_change_workspace_count (WnckScreen $screen, gint $count)
  is native(wnck)
  is export
{ * }

sub wnck_screen_force_update (WnckScreen $screen)
  is native(wnck)
  is export
{ * }

sub wnck_screen_free_workspace_layout (
  guint $layout # WnckWorkspaceLayout $layout
)
  is native(wnck)
  is export
{ * }

sub wnck_screen_get (gint $index)
  returns WnckScreen
  is native(wnck)
  is export
{ * }

sub wnck_screen_get_active_window (WnckScreen $screen)
  returns WnckWindow
  is native(wnck)
  is export
{ * }

sub wnck_screen_get_active_workspace (WnckScreen $screen)
  returns WnckWorkspace
  is native(wnck)
  is export
{ * }

sub wnck_screen_get_background_pixmap (WnckScreen $screen)
  returns gulong
  is native(wnck)
  is export
{ * }

sub wnck_screen_get_default ()
  returns WnckScreen
  is native(wnck)
  is export
{ * }

sub wnck_screen_get_height (WnckScreen $screen)
  returns gint
  is native(wnck)
  is export
{ * }

sub wnck_screen_get_number (WnckScreen $screen)
  returns gint
  is native(wnck)
  is export
{ * }

sub wnck_screen_get_type ()
  returns GType
  is native(wnck)
  is export
{ * }

sub wnck_screen_get_window_manager_name (WnckScreen $screen)
  returns Str
  is native(wnck)
  is export
{ * }

sub wnck_screen_get_windows (WnckScreen $screen)
  returns GList
  is native(wnck)
  is export
{ * }

sub wnck_screen_get_windows_stacked (WnckScreen $screen)
  returns GList
  is native(wnck)
  is export
{ * }

sub wnck_screen_move_viewport (WnckScreen $screen, gint $x, gint $y)
  is native(wnck)
  is export
{ * }

sub wnck_screen_release_workspace_layout (
  WnckScreen $screen,
  gint $current_token
)
  is native(wnck)
  is export
{ * }

sub wnck_screen_toggle_showing_desktop (WnckScreen $screen, gboolean $show)
  is native(wnck)
  is export
{ * }

sub wnck_screen_try_set_workspace_layout (
  WnckScreen $screen,
  gint $current_token,
  gint $rows,
  gint $columns
)
  returns gint
  is native(wnck)
  is export
{ * }

sub wnck_screen_get_previously_active_window (WnckScreen $screen)
  returns WnckWindow
  is native(wnck)
  is export
{ * }


sub wnck_screen_get_showing_desktop (WnckScreen $screen)
  returns gboolean
  is native(wnck)
  is export
{ * }

sub wnck_screen_get_workspace_count (WnckScreen $screen)
  returns gint
  is native(wnck)
  is export
{ * }

sub wnck_screen_net_wm_supports (WnckScreen $screen, Str $atom)
  returns gboolean
  is native(wnck)
  is export
{ * }

sub wnck_screen_get_width (WnckScreen $screen)
  returns gint
  is native(wnck)
  is export
{ * }

sub wnck_screen_get_for_root (gulong $root)
  returns WnckScreen
  is native(wnck)
  is export
{ * }

sub wnck_screen_get_workspace (WnckScreen $screen, gint $workspace)
  returns WnckWorkspace
  is native(wnck)
  is export
{ * }

sub wnck_screen_get_workspaces (WnckScreen $screen)
  returns GList
  is native(wnck)
  is export
{ * }
