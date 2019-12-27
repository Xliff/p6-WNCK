use v6.c;

use Method::Also;

use GTK::Compat::Types;
use WNCK::Raw::Types;

use GTK::Raw::Utils;

use WNCK::Raw::Screen;

use GLib::GList;

use WNCK::Window;
use WNCK::Workspace;

use GLib::Roles::ListData;
use GTK::Compat::Roles::Object;

use WNCK::Roles::Signals::Screen;

class WNCK::Screen {
  also does GTK::Compat::Roles::Object;
  also does WNCK::Roles::Signals::Screen;

  has WnckScreen $!ws;

  submethod BUILD (:$screen) {
    self!setObject( cast(GObject, $!ws = $screen) );
  }

  multi method new {
    self.get_default;
  }
  multi method new (Int() $index) {
    self.get($index);
  }

  method get_default
    is also<
      get-default
      default
    >
  {
    self.bless( screen => wnck_screen_get_default() );
  }

  method get (Int $index) {
    my gint $i = resolve-int($index);
    self.bless( screen => wnck_screen_get($i) );
  }

  method get_for_root (Int() $root_id)
    is also<
      get-for-root
      new_for_root
      new-for-root
    >
  {
    my gulong $r = resolve-ulong($root_id);
    self.bless( screen => wnck_screen_get_for_root($r) );
  }

  # method calc_workspace_layout (
  #   Int() $num_workspaces,
  #   Int() $space_index,
  #   WnckWorkspaceLayout $layout
  # ) {
  #   my gint ($nw, $si) = resolve-int($num_workspaces, $space_index);
  #   wnck_screen_calc_workspace_layout($!ws, $nw, $si, $layout);
  # }

  # Is originally:
  # WnckScreen, WnckWindow, gpointer --> void
  method active-window-changed is also<active_window_changed> {
   self.connect-window($!ws, 'active-window-changed');
  }

  # Is originally:
  # WnckScreen, WnckWorkspace, gpointer --> void
  method active-workspace-changed is also<active_workspace_changed> {
   self.connect-workspace($!ws, 'active-workspace-changed');
  }

  # Is originally:
  # WnckScreen, WnckApplication, gpointer --> void
  method application-closed is also<application_closed> {
   self.connect-application($!ws, 'application-closed');
  }

  # Is originally:
  # WnckScreen, WnckApplication, gpointer --> void
  method application-opened is also<application_opened> {
   self.connect-application($!ws, 'application-opened');
  }

  # Is originally:
  # WnckScreen, gpointer --> void
  method background-changed is also<background_changed> {
   self.connect($!ws, 'background-changed');
  }

  # Is originally:
  # WnckScreen, WnckClassGroup, gpointer --> void
  method class-group-closed is also<class_group_closed> {
   self.connect-class-group($!ws, 'class-group-closed');
  }

  # Is originally:
  # WnckScreen, WnckClassGroup, gpointer --> void
  method class-group-opened is also<class_group_opened> {
   self.connect-class-group($!ws, 'class-group-opened');
  }

  # Is originally:
  # WnckScreen, gpointer --> void
  method showing-desktop-changed is also<showing_desktop_changed> {
   self.connect($!ws, 'showing-desktop-changed');
  }

  # Is originally:
  # WnckScreen, gpointer --> void
  method viewports-changed is also<viewports_changed> {
   self.connect($!ws, 'viewports-changed');
  }

  # Is originally:
  # WnckScreen, WnckWindow, gpointer --> void
  method window-closed is also<window_closed> {
   self.connect-window($!ws, 'window-closed');
  }

  # Is originally:
  # WnckScreen, gpointer --> void
  method window-manager-changed is also<window_manager_changed> {
   self.connect($!ws, 'window-manager-changed');
  }

  # Is originally:
  # WnckScreen, WnckWindow, gpointer --> void
  method window-opened is also<window_opened> {
   self.connect-window($!ws, 'window-opened');
  }

  # Is originally:
  # WnckScreen, gpointer --> void
  method window-stacking-changed is also<window_stacking_changed> {
   self.connect($!ws, 'window-stacking-changed');
  }

  # Is originally:
  # WnckScreen, WnckWorkspace, gpointer --> void
  method workspace-created is also<workspace_created> {
   self.connect-workspace($!ws, 'workspace-created');
  }

  # Is originally:
  # WnckScreen, WnckWorkspace, gpointer --> void
  method workspace-destroyed is also<workspace_destroyed> {
   self.connect-workspace($!ws, 'workspace-destroyed');
  }

  method change_workspace_count (Int() $count)
    is also<change-workspace-count>
  {
    my gint $c = resolve-int($count);
    wnck_screen_change_workspace_count($!ws, $c);
  }

  method force_update is also<force-update> {
    wnck_screen_force_update($!ws);
  }

  # method free_workspace_layout {
  #   wnck_screen_free_workspace_layout($!ws);
  # }

  method get_active_window
    is also<
      get-active-window
      active_window
      active-window
    >
  {
    WNCK::Window.new( wnck_screen_get_active_window($!ws) );
  }

  method get_active_workspace
    is also<
      get-active-workspace
      active_workspace
      active-workspace
    >
  {
    WNCK::Workspace.new( wnck_screen_get_active_workspace($!ws) );
  }

  method get_background_pixmap
    is also<
      get-background-pixmap
      background_pixmap
      background-pixmap
    >
  {
    wnck_screen_get_background_pixmap($!ws);
  }

  method get_height
    is also<
      get-height
      height
    >
  {
    wnck_screen_get_height($!ws);
  }

  method get_previously_active_window
    is also<
      get-previously-active-window
      previously_active_window
      previously-active-window
    >
  {
    WNCK::Window.new( wnck_screen_get_previously_active_window($!ws) );
  }

  method get_number
    is also<
      get-number
      number
    >
  {
    wnck_screen_get_number($!ws);
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &wnck_screen_get_type, $n, $t );
  }

  method get_showing_desktop
    is also<
      get-showing-desktop
      showing_desktop
      showing-desktop
    >
  {
    wnck_screen_get_showing_desktop($!ws);
  }

  method get_window_manager_name
    is also<
      get-window-manager-name
      window_manager_name
      window-manager-name
    >
  {
    wnck_screen_get_window_manager_name($!ws);
  }

  method net_wm_supports(Str() $atom) is also<net-wm-supports> {
    so wnck_screen_net_wm_supports($!ws, $atom);
  }

  method get_width
    is also<
      get-width
      width
    >
  {
    wnck_screen_get_width($!ws);
  }

  method get_windows (:$raw = False)
    is also<
      get-windows
      windows
    >
  {
    my $l = GLib::GList.new( wnck_screen_get_windows($!ws) )
       but GLib::Roles::ListData[WnckWindow];
     $raw ??
       $l.Array !! $l.Array.map({ WNCK::Window.new( cast(WnckWindow, $_) ) });
  }

  method get_windows_stacked (:$raw = False)
    is also<
      get-windows-stacked
      windows_stacked
      windows-stacked
    >
  {
    wnck_screen_get_windows_stacked($!ws);
    my $l = GLib::GList.new( wnck_screen_get_windows($!ws) )
      but GLib::Roles::ListData[WnckWindow];
    $raw ??
      $l.Array !! $l.Array.map({ WNCK::Window.new($_) });
  }

  method get_workspace (Int() $index) is also<get-workspace> {
    my gint $i = resolve-int($index);
    WNCK::Workspace.new( wnck_screen_get_workspace($!ws, $i) );
  }

  method get_workspaces (:$raw = False)
    is also<
      get-workspaces
      workspaces
    >
  {
    my $l = GLib::GList.new( wnck_screen_get_workspaces($!ws) )
      but GTK::Compat::ListData[WnckWorkspace];
    $raw ??
      $l.Array !! $l.Array.map({ WNCK::Workspace.new($_) });
  }

  method get_workspace_count
    is also<
      get-workspace-count
      workspace_count
      workspace-count
    >
  {
    wnck_screen_get_workspace_count($!ws);
  }

  method move_viewport (Int() $x, Int() $y) is also<move-viewport> {
    my gint ($xx, $yy) = resolve-int($x, $y);
    wnck_screen_move_viewport($!ws, $xx, $yy);
  }

  method release_workspace_layout (Int() $current_token)
    is also<release-workspace-layout>
  {
    my gint $ct = resolve-int($current_token);
    wnck_screen_release_workspace_layout($!ws, $ct);
  }

  method toggle_showing_desktop (Int() $show)
    is also<toggle-showing-desktop>
  {
    my gboolean $s = resolve-bool($show);
    wnck_screen_toggle_showing_desktop($!ws, $s);
  }

  method try_set_workspace_layout (
    Int() $current_token,
    Int() $rows,
    Int() $columns
  )
    is also<try-set-workspace-layout>
  {
    my gint ($ct, $r, $c) = resolve-int($current_token, $rows, $columns);
    wnck_screen_try_set_workspace_layout($!ws, $ct, $r, $c);
  }

}
