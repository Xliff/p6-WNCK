use v6.vc;

use GTK::Compat::Types;
use WNCK::Raw::Types;

use GTK::Raw::Utils;

use WNCK::Raw::Window;

use GTK::Compat::Pixbuf;

use GTK::Compat::Roles::Object;
use GTK::Roles::Signals::Generic;

class WNCK::Window {
  also does GTK::Compat::Roles::Object;
  also does GTK::Roles::Signals::Generic;

  has WnckWindow $!ww;

  submethod BUILD (:$window) {
    self!setObject($!ww = $window);
  }

  method WNCK::Raw::WnckWindow
  { $!ww }

  # Is originally:
  # WnckWindow, WnckWindowActions(uint), WnckWindowActions(uint), gpointer --> void
  method actions-changed {
    self.connect-uintuint($!ww, 'actions-changed');
  }

  # Is originally:
  # WnckWindow, gpointer --> void
  method class-changed {
    self.connect($!ww, 'class-changed');
  }

  # Is originally:
  # WnckWindow, gpointer --> void
  method geometry-changed {
    self.connect($!ww, 'geometry-changed');
  }

  # Is originally:
  # WnckWindow, gpointer --> void
  method icon-changed {
    self.connect($!ww, 'icon-changed');
  }

  # Is originally:
  # WnckWindow, gpointer --> void
  method name-changed {
    self.connect($!ww, 'name-changed');
  }

  # Is originally:
  # WnckWindow, gpointer --> void
  method role-changed {
    self.connect($!ww, 'role-changed');
  }

  # Is originally:
  # WnckWindow, WnckWindowState(uint), WnckWindowState(uint), gpointer --> void
  method state-changed {
    self.connect-uintuint($!ww, 'state-changed');
  }

  # Is originally:
  # WnckWindow, gpointer --> void
  method type-changed {
    self.connect($!ww, 'type-changed');
  }

  # Is originally:
  # WnckWindow, gpointer --> void
  method workspace-changed {
    self.connect($!ww, 'workspace-changed');
  }

  method get (Int() $xid) {
    my gulong $x = resolve-ulong($xid);
    self.bless( window => wnck_window_get($x) );
  }

  method get_transient (WnckWindow() $w) {
    self.bless( window => wnck_window_get_transient($w) );
  }

  method activate (Int() $timestamp) {
    my guint $ts = resolve-uint($timestamp);
    wnck_window_activate($!ww, $ts);
  }

  method activate_transient (Int() $timestamp) {
    my guint $ts = resolve-uint($timestamp);
    wnck_window_activate_transient($!ww, $ts);
  }

  method close (Int() $timestamp) {
    my guint $ts = resolve-uint($timestamp);
    wnck_window_close($!ww, $timestamp);
  }

  method get_actions {
    WnckWindowActions( wnck_window_get_actions($!ww) );
  }

  method get_application {
    ::('WNCK::Application').new( wnck_window_get_application($!ww) );
  }

  method get_class_group {
    ::('WNCK::ClassGroup').new( wnck_window_get_class_group($!ww) );
  }

  method get_class_group_name {
    wnck_window_get_class_group_name($!ww);
  }

  proto method get_client_window_geometry (|)
  { * }

  multi method get_client_window_geometry {
    ($xp, $yp, $widthp, $heightp) = 0 xx 4;
    samewith($xp, $yp, $widthp, $heightp);
  }
  multi method get_client_window_geometry (
    Int() $xp      is rw,
    Int() $yp      is rw,
    Int() $widthp  is rw,
    Int() $heightp is rw
  ) {
    my gint ($xx, $yy, $w, $h) = resolve-int($xp, $yp, $widthp, $heightp)
    wnck_window_get_client_window_geometry($!ww, $xx, $yy, $w, $h);
    ($xp, $yp, $widthp, $heightp) = ($xx, $yy, $w, $h);
  }

  proto method get_geometry (|)
  { * }

  multi method get_geometry {
    ($xp, $yp, $widthp, $heightp) = 0 xx 4;
    samewith($xp, $yp, $widthp, $heightp);
  }
  multi method get_geometry (
    Int() $xp      is rw,
    Int() $yp      is rw,
    Int() $widthp  is rw,
    Int() $heightp is rw
  ) {
    my gint ($xx, $yy, $w, $h) = resolve-int($xp, $yp, $widthp, $heightp)
    wnck_window_get_geometry($!ww, $xx, $yy, $w, $h);
    ($xp, $yp, $widthp, $heightp) = ($xx, $yy, $w, $h);
  }

  method get_icon {
    GTK::Compat::Pixbuf.new( wnck_window_get_icon($!ww) );
  }

  method get_icon_is_fallback {
    so wnck_window_get_icon_is_fallback($!ww);
  }

  method get_pid {
    wnck_window_get_pid($!ww);
  }

  method get_screen {
    ::('WNCK::Screen').wnck_window_get_screen($!ww);
  }

  method get_session_id {
    wnck_window_get_session_id($!ww);
  }

  method get_session_id_utf8 {
    wnck_window_get_session_id_utf8($!ww);
  }

  method get_state {
    WnckWindowState( wnck_window_get_state($!ww) );
  }

  method get_type {
    state ($n, $t);
    unstable_get_type( self.^name, &wnck_window_get_type, $n, $t );
  }

  method get_window_type {
    WnckWindowType( wnck_window_get_window_type($!ww) );
  }

  method get_workspace {
    ::('WNCK.Workspace').wnck_window_get_workspace($!ww);
  }

  method get_xid {
    wnck_window_get_xid($!ww);
  }

  method has_icon_name {
    wnck_window_has_icon_name($!ww);
  }

  method has_name {
    wnck_window_has_name($!ww);
  }

  method is_above {
    wnck_window_is_above($!ww);
  }

  method is_active {
    wnck_window_is_active($!ww);
  }

  method is_fullscreen {
    wnck_window_is_fullscreen($!ww);
  }

  method is_in_viewport (WnckWorkspace() $workspace) {
    wnck_window_is_in_viewport($!ww, $workspace);
  }

  method is_maximized {
    wnck_window_is_maximized($!ww);
  }

  method is_maximized_horizontally {
    wnck_window_is_maximized_horizontally($!ww);
  }

  method is_minimized {
    wnck_window_is_minimized($!ww);
  }

  method is_on_workspace (WnckWorkspace() $workspace) {
    wnck_window_is_on_workspace($!ww, $workspace);
  }

  method is_pinned {
    wnck_window_is_pinned($!ww);
  }

  method is_skip_pager {
    wnck_window_is_skip_pager($!ww);
  }

  method is_visible_on_workspace (WnckWorkspace() $workspace) {
    wnck_window_is_visible_on_workspace($!ww, $workspace);
  }

  method keyboard_move {
    wnck_window_keyboard_move($!ww);
  }

  method make_above {
    wnck_window_make_above($!ww);
  }

  method make_below {
    wnck_window_make_below($!ww);
  }

  method maximize {
    wnck_window_maximize($!ww);
  }

  method maximize_horizontally {
    wnck_window_maximize_horizontally($!ww);
  }

  method maximize_vertically {
    wnck_window_maximize_vertically($!ww);
  }

  method minimize {
    wnck_window_minimize($!ww);
  }

  method move_to_workspace (WnckWorkspace() $space) {
    wnck_window_move_to_workspace($!ww, $space);
  }

  method needs_attention {
    wnck_window_needs_attention($!ww);
  }

  method pin {
    wnck_window_pin($!ww);
  }

  method set_fullscreen (Int() $fullscreen) {
    my gboolean $fs = resolve-bool($fullscreen);
    wnck_window_set_fullscreen($!ww, $fs);
  }

  method set_geometry (
    Int() $gravity,
    Int() $geometry_mask,
    Int() $x,
    Int() $y,
    Int() $width,
    Int() $height
  ) {
    my guint ($g, $gm) = resolve-uint($gravity, $geometry_mask);
    my gint ($xx, $yy, $w, $h) = resolve-int($x, $y, $width, $height);
    wnck_window_set_geometry($!ww, $g, $gm, $xx, $yy, $w, $h);
  }

  method set_icon_geometry (Int() $x, Int() $y, Int() $width, Int() $height) {
    my gint ($xx, $yy, $w, $h) = resolve-int($x, $y, $width, $height);
    wnck_window_set_icon_geometry($!ww, $xx, $yy, $w, $h);
  }

  method set_skip_pager (Int() $skip) {
    my gboolean $s = resolve-bool($skip);
    wnck_window_set_skip_pager($!ww, $s);
  }

  method set_skip_tasklist (Int() $skip) {
    my gboolean $s = resolve-bool($skip);
    wnck_window_set_skip_tasklist($!ww, $s);
  }

  method set_sort_order (Int() $order) {
    my gint $o = resolve-int($order);
    wnck_window_set_sort_order($!ww, $o);
  }

  method set_window_type (Int() $wintype) {
    my guint $wt = resolve-uint($wintype);
    wnck_window_set_window_type($!ww, $wt);
  }

  method shade {
    wnck_window_shade($!ww);
  }

  method stick {
    wnck_window_stick($!ww);
  }

  method transient_is_most_recently_activated {
    wnck_window_transient_is_most_recently_activated($!ww);
  }

  method get_class_instance_name {
    wnck_get_class_instance_name($!ww);
  }

  method get_group_leader {
    wnck_window_get_group_leader($!ww);
  }

  method get_icon_name {
    wnck_window_get_icon_name($!ww);
  }

  method get_mini_icon {
    GTK::Compat::Pixbuf.new( wnck_window_get_mini_icon($!ww) );
  }

  method get_name {
    wnck_window_get_name($!ww);
  }

  method get_sort_order {
    wnck_window_get_sort_order($!ww);
  }

  method is_below {
    so wnck_window_is_below($!ww);
  }

  method is_maximized_vertically {
    so wnck_window_is_maximized_vertically($!ww);
  }

  method is_most_recently_activated {
    so wnck_window_is_most_recently_activated($!ww);
  }

  method is_pinned {
    so wnck_window_is_pinned($!ww);
  }

  method is_shaded {
    so wnck_window_is_shaded($!ww);
  }

  method keyboard_size {
    wnck_window_keyboard_size($!ww);
  }

  method or_transient_needs_attention {
    so wnck_window_or_transient_needs_attention($!ww);
  }

  method unmake_above {
    wnck_window_unmake_above($!ww);
  }

  method unmake_below {
    wnck_window_unmake_below($!ww);
  }

  method unmaximize {
    wnck_window_unmaximize($!ww);
  }

  method unmaximize_horizontally {
    wnck_window_unmaximize_horizontally($!ww);
  }

  method unmaximize_vertically {
    wnck_window_unmaximize_vertically($!ww);
  }

  method unminimize {
    wnck_window_unminimize($!ww);
  }

  method unpin {
    wnck_window_unpin($!ww);
  }

  method unshade {
    wnck_window_unshade($!ww);
  }

  method unstick {
    wnck_window_unstick($!ww);
  }

}
