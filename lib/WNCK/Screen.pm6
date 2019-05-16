use v6.c;

use GTK::Compat::Types;
use WNCK::Raw::Types;

use GTK::Raw::Utils;

use WNCK::Raw::Screen;

use GTK::Compat::GList;

use WNCK::Window;
use WNCK::Workspace;

use GTK::Compat::Roles::ListData;
use GTK::Compat::Roles::Object;

use WNCK::Roles::Signals::Screen;

class WNCK::Screen {
  also does GTK::Compat::Roles::Object;
  also does WNCK::Roles::Signals::Screen;

  has WnckScreen $!ws;

  submethod BUILD (:$screen) {
    self!setObject( cast(GObject, $!ws = $screen) );
  }

  method get_default {
    self.bless( screen => wnck_screen_get_default() );
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
  method active-window-changed {
   self.connect-window($!ws, 'active-window-changed');
  }

  # Is originally:
  # WnckScreen, WnckWorkspace, gpointer --> void
  method active-workspace-changed {
   self.connect-workspace($!ws, 'active-workspace-changed');
  }

  # Is originally:
  # WnckScreen, WnckApplication, gpointer --> void
  method application-closed {
   self.connect-application($!ws, 'application-closed');
  }

  # Is originally:
  # WnckScreen, WnckApplication, gpointer --> void
  method application-opened {
   self.connect-application($!ws, 'application-opened');
  }

  # Is originally:
  # WnckScreen, gpointer --> void
  method background-changed {
   self.connect($!ws, 'background-changed');
  }

  # Is originally:
  # WnckScreen, WnckClassGroup, gpointer --> void
  method class-group-closed {
   self.connect-class-group($!ws, 'class-group-closed');
  }

  # Is originally:
  # WnckScreen, WnckClassGroup, gpointer --> void
  method class-group-opened {
   self.connect-class-group($!ws, 'class-group-opened');
  }

  # Is originally:
  # WnckScreen, gpointer --> void
  method showing-desktop-changed {
   self.connect($!ws, 'showing-desktop-changed');
  }

  # Is originally:
  # WnckScreen, gpointer --> void
  method viewports-changed {
   self.connect($!ws, 'viewports-changed');
  }

  # Is originally:
  # WnckScreen, WnckWindow, gpointer --> void
  method window-closed {
   self.connect-window($!ws, 'window-closed');
  }

  # Is originally:
  # WnckScreen, gpointer --> void
  method window-manager-changed {
   self.connect($!ws, 'window-manager-changed');
  }

  # Is originally:
  # WnckScreen, WnckWindow, gpointer --> void
  method window-opened {
   self.connect-window($!ws, 'window-opened');
  }

  # Is originally:
  # WnckScreen, gpointer --> void
  method window-stacking-changed {
   self.connect($!ws, 'window-stacking-changed');
  }

  # Is originally:
  # WnckScreen, WnckWorkspace, gpointer --> void
  method workspace-created {
   self.connect-workspace($!ws, 'workspace-created');
  }

  # Is originally:
  # WnckScreen, WnckWorkspace, gpointer --> void
  method workspace-destroyed {
   self.connect-workspace($!ws, 'workspace-destroyed');
  }

  method change_workspace_count (Int() $count) {
    my gint $c = resolve-int($count);
    wnck_screen_change_workspace_count($!ws, $c);
  }

  method force_update {
    wnck_screen_force_update($!ws);
  }

  # method free_workspace_layout {
  #   wnck_screen_free_workspace_layout($!ws);
  # }

  method get (Int $index) {
    my gint $i = resolve-int($index);
    wnck_screen_get($i);
  }

  method get_active_window {
    WNCK::Window.new( wnck_screen_get_active_window($!ws) );
  }

  method get_active_workspace {
    WNCK::Workspace.new( wnck_screen_get_active_workspace($!ws) );
  }

  method get_background_pixmap {
    wnck_screen_get_background_pixmap($!ws);
  }

  method get_height {
    wnck_screen_get_height($!ws);
  }

  method wnck_screen_get_previously_active_window {
    WNCK::Window.new( wnck_screen_get_previously_active_window($!ws) );
  }

  method get_number {
    wnck_screen_get_number($!ws);
  }

  method get_type {
    state ($n, $t);
    unstable_get_type( self.^name, &wnck_screen_get_type, $n, $t );
  }

  method get_showing_desktop {
    so wnck_screen_get_showing_desktop($!ws);
  }

  method get_window_manager_name {
    wnck_screen_get_window_manager_name($!ws);
  }

  method net_wm_supports(Str() $atom) {
    so wnck_screen_net_wm_supports($!ws, $atom);
  }

  method get_width {
    wnck_screen_get_width($!ws);
  }

  method get_windows (:$raw = False) {
    my $l = wnck_screen_get_windows($!ws)
      but GTK::Compat::Roles::ListData[WnckWnidow];
    $raw ??
      $l.Array !! $l.Array.map({ WNCK::Window.new($_) });
  }

  method get_windows_stacked (:$raw = False) {
    wnck_screen_get_windows_stacked($!ws);
    my $l = wnck_screen_get_windows($!ws)
      but GTK::Compat::Roles::ListData[WnckWnidow];
    $raw ??
      $l.Array !! $l.Array.map({ WNCK::Window.new($_) });
  }

  method get_workspace (Int() $index) {
    my gint $i = resolve-int($index);
    WNCK::Workspace.new( wnck_screen_get_workspace($i) );
  }

  method get_workspaces (:$raw = False) {
    my $l = GTK::Compat::GList.new( wnck_screen_get_workspaces($!ws) )
      but GTK::Compat::ListData[WnckWorkspace];
    $raw ??
      $l.Array !! $l.Array.map({ WNCK::Workspace.new($_) });
  }

  method get_workspace_count {
    wnck_screen_get_workspace_count($!ws);
  }

  method move_viewport (Int() $x, Int() $y) {
    my gint ($xx, $yy) = resolve-int($x, $y);
    wnck_screen_move_viewport($!ws, $xx, $yy);
  }

  method release_workspace_layout (Int() $current_token) {
    my gint $ct = resolve-int($current_token);
    wnck_screen_release_workspace_layout($!ws, $ct);
  }

  method toggle_showing_desktop (Int() $show) {
    my gboolean $s = resolve-bool($show);
    wnck_screen_toggle_showing_desktop($!ws, $s);
  }

  method try_set_workspace_layout (
    Int() $current_token,
    Int() $rows,
    Int() $columns
  ) {
    my gint ($ct, $r, $c) = resolve-int($current_token, $rows, $columns);
    wnck_screen_try_set_workspace_layout($!ws, $ct, $r, $c);
  }

}
