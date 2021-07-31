use v6.c;

use Method::Also;

use WNCK::Raw::Types;
use WNCK::Raw::Window;

use GDK::Pixbuf;
use GTK::Get;

use GLib::Roles::Object;
use GLib::Roles::Signals::Generic;

class WNCK::Window {
  also does GLib::Roles::Object;
  also does GLib::Roles::Signals::Generic;

  has WnckWindow $!ww;

  submethod BUILD (:$window) {
    self!setObject($!ww = $window);
  }

  method WNCK::Raw::WnckWindow
    is also<WnckWindow>
  { $!ww }

  method new (WnckWindow $window) {
    $window ?? self.bless(:$window) !! WnckWindow;
  }

  method get (Int() $xid) {
    my gulong $x = $xid;

    my $window = wnck_window_get($x);

    $window ?? self.bless( :$window ) !! WnckWindow;
  }

  method get_transient (WnckWindow() $w) is also<get-transient> {
    my $window = wnck_window_get_transient($w);

    $window ?? self.bless(:$window) !! WnckWindow;
  }

  # Is originally:
  # WnckWindow, WnckWindowActions(uint), WnckWindowActions(uint), gpointer --> void
  method actions-changed is also<actions_changed> {
    self.connect-uintuint($!ww, 'actions-changed');
  }

  # Is originally:
  # WnckWindow, gpointer --> void
  method class-changed is also<class_changed> {
    self.connect($!ww, 'class-changed');
  }

  # Is originally:
  # WnckWindow, gpointer --> void
  method geometry-changed is also<geometry_changed> {
    self.connect($!ww, 'geometry-changed');
  }

  # Is originally:
  # WnckWindow, gpointer --> void
  method icon-changed is also<icon_changed> {
    self.connect($!ww, 'icon-changed');
  }

  # Is originally:
  # WnckWindow, gpointer --> void
  method name-changed is also<name_changed> {
    self.connect($!ww, 'name-changed');
  }

  # Is originally:
  # WnckWindow, gpointer --> void
  method role-changed is also<role_changed> {
    self.connect($!ww, 'role-changed');
  }

  # Is originally:
  # WnckWindow, WnckWindowState(uint), WnckWindowState(uint), gpointer --> void
  method state-changed is also<state_changed> {
    self.connect-uintuint($!ww, 'state-changed');
  }

  # Is originally:
  # WnckWindow, gpointer --> void
  method type-changed is also<type_changed> {
    self.connect($!ww, 'type-changed');
  }

  # Is originally:
  # WnckWindow, gpointer --> void
  method workspace-changed is also<workspace_changed> {
    self.connect($!ww, 'workspace-changed');
  }

  method activate (Int() $timestamp = GTK::Get.current_event_time) {
    my guint $ts = $timestamp;

    wnck_window_activate($!ww, $ts);
  }

  method activate_transient (Int() $timestamp = GTK::Get.current_event_time)
    is also<activate-transient>
  {
    my guint $ts = $timestamp;

    wnck_window_activate_transient($!ww, $ts);
  }

  method close (Int() $timestamp = GTK::Get.current_event_time) {
    my guint $ts = $timestamp;

    wnck_window_close($!ww, $timestamp);
  }

  method get_actions
    is also<
      get-actions
      actions
    >
  {
    WnckWindowActionsEnum( wnck_window_get_actions($!ww) )
  }

  method get_application (:$raw = False)
    is also<
      get-application
      application
    >
  {
    my $a = wnck_window_get_application($!ww);

    $a ??
      ( $raw ?? $a !! ::('WNCK::Application').new($a) )
      !!
      WnckApplication;
  }

  method get_class_group (:$raw = False)
    is also<
      get-class-group
      class_group
      class-group
    >
  {
    my $cg = wnck_window_get_class_group($!ww);

    $cg ??
      ( $raw ?? $cg !! ::('WNCK::ClassGroup').new($cg) )
      !!
      WnckClassGroup;
  }

  method get_class_group_name
    is also<
      get-class-group-name
      class_group_name
      class-group-name
    >
  {
    wnck_window_get_class_group_name($!ww);
  }

  proto method get_client_window_geometry (|)
    is also<get-client-window-geometry>
  { * }

  multi method get_client_window_geometry
    is also<
      client_window_geometry
      client-window-geometry
    >
  {
    my ($xp, $yp, $widthp, $heightp) = 0 xx 4;

    samewith($xp, $yp, $widthp, $heightp);
  }
  multi method get_client_window_geometry (
    Int() $xp      is rw,
    Int() $yp      is rw,
    Int() $widthp  is rw,
    Int() $heightp is rw
  ) {
    my gint ($xx, $yy, $w, $h) = ($xp, $yp, $widthp, $heightp);

    wnck_window_get_client_window_geometry($!ww, $xx, $yy, $w, $h);
    ($xp, $yp, $widthp, $heightp) = ($xx, $yy, $w, $h);
  }

  proto method get_geometry (|)
    is also<
      get-geometry
      geometry
    >
  { * }

  multi method get_geometry {
    my ($xp, $yp, $widthp, $heightp) = 0 xx 4;

    samewith($xp, $yp, $widthp, $heightp);
  }
  multi method get_geometry (
    Int() $xp      is rw,
    Int() $yp      is rw,
    Int() $widthp  is rw,
    Int() $heightp is rw
  ) {
    my gint ($xx, $yy, $w, $h) = ($xp, $yp, $widthp, $heightp);

    wnck_window_get_geometry($!ww, $xx, $yy, $w, $h);
    ($xp, $yp, $widthp, $heightp) = ($xx, $yy, $w, $h);
  }

  method get_icon (:$raw = False)
    is also<
      get-icon
      icon
    >
  {
    my $p = wnck_window_get_icon($!ww);

    $p ??
      ( $raw ?? $p !! GDK::Pixbuf.new($p) )
      !!
      GdkPixbuf;
  }

  method get_icon_is_fallback
    is also<
      get-icon-is-fallback
      icon_is_fallback
      icon-is-fallback
    >
  {
    so wnck_window_get_icon_is_fallback($!ww);
  }

  method get_pid
    is also<
      get-pid
      pid
    >
  {
    wnck_window_get_pid($!ww);
  }

  method get_role
    is also<
      get-role
      role
    >
  {
    wnck_window_get_role($!ww);
  }

  method get_screen (:$raw = False)
    is also<
      get-screen
      screen
    >
  {
    returnObject(
      wnck_window_get_screen($!ww),
      $raw,
      WnckScreen,
      WNCK::Screen
    );
  }

  method get_session_id
    is also<
      get-session-id
      session_id
      session-id
    >
  {
    wnck_window_get_session_id($!ww);
  }

  method get_session_id_utf8
    is also<
      get-session-id-utf8
      session_id_utf8
      session-id-utf8
    >
  {
    wnck_window_get_session_id_utf8($!ww);
  }

  method get_state
    is also<
      get-state
      state
    >
  {
    WnckWindowStateEnum( wnck_window_get_state($!ww) );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &wnck_window_get_type, $n, $t );
  }

  method get_window_type
    is also<
      get-window-type
      window_type
      window-type
    >
  {
    WnckWindowTypeEnum( wnck_window_get_window_type($!ww) );
  }

  method get_workspace (:$raw = False)
    is also<
      get-workspace
      workspace
    >
  {
    my $w = wnck_window_get_workspace($!ww);

    $w ??
      ( $raw ?? $w !! ::('WNCK::Workspace').new($w) )
      !!
      Nil;
  }

  method get_xid
    is also<
      get-xid
      xid
    >
  {
    wnck_window_get_xid($!ww);
  }

  method has_icon_name is also<has-icon-name> {
    so wnck_window_has_icon_name($!ww);
  }

  method has_name is also<has-name> {
    so wnck_window_has_name($!ww);
  }

  method is_above is also<is-above> {
    so wnck_window_is_above($!ww);
  }

  method is_active is also<is-active> {
    so wnck_window_is_active($!ww);
  }

  method is_fullscreen is also<is-fullscreen> {
    so wnck_window_is_fullscreen($!ww);
  }

  method is_in_viewport (WnckWorkspace() $workspace) is also<is-in-viewport> {
    so wnck_window_is_in_viewport($!ww, $workspace);
  }

  method is_maximized is also<is-maximized> {
    so wnck_window_is_maximized($!ww);
  }

  method is_maximized_horizontally is also<is-maximized-horizontally> {
    so wnck_window_is_maximized_horizontally($!ww);
  }

  method is_minimized is also<is-minimized> {
    so wnck_window_is_minimized($!ww);
  }

  method is_on_workspace (WnckWorkspace() $workspace)
    is also<is-on-workspace>
  {
    so wnck_window_is_on_workspace($!ww, $workspace);
  }

  method is_pinned is also<is-pinned> {
    so wnck_window_is_pinned($!ww);
  }

  method is_skip_pager is also<is-skip-pager> {
    so wnck_window_is_skip_pager($!ww);
  }

  method is_visible_on_workspace (WnckWorkspace() $workspace)
    is also<is-visible-on-workspace>
  {
    so wnck_window_is_visible_on_workspace($!ww, $workspace);
  }

  method keyboard_move is also<keyboard-move> {
    wnck_window_keyboard_move($!ww);
  }

  method make_above is also<make-above> {
    wnck_window_make_above($!ww);
  }

  method make_below is also<make-below> {
    wnck_window_make_below($!ww);
  }

  method maximize {
    wnck_window_maximize($!ww);
  }

  method maximize_horizontally is also<maximize-horizontally> {
    wnck_window_maximize_horizontally($!ww);
  }

  method maximize_vertically is also<maximize-vertically> {
    wnck_window_maximize_vertically($!ww);
  }

  method minimize {
    wnck_window_minimize($!ww);
  }

  method move_to_workspace (WnckWorkspace() $space)
    is also<move-to-workspace>
  {
    wnck_window_move_to_workspace($!ww, $space);
  }

  method needs_attention is also<needs-attention> {
    wnck_window_needs_attention($!ww);
  }

  method pin {
    wnck_window_pin($!ww);
  }

  method set_fullscreen (Int() $fullscreen) is also<set-fullscreen> {
    my gboolean $fs = $fullscreen.so.Int;

    wnck_window_set_fullscreen($!ww, $fs);
  }

  proto method set_geometry (|)
    is also<set-geometry>
  { * }

  multi method set_geometry (
    Int() $x,
    Int() $y,
    Int() $width,
    Int() $height
  ) {
    my gint  ($xx, $yy, $w, $h) = ($x, $y, $width, $height);

    my $mask = 0;
    $mask +|= WNCK_WINDOW_CHANGE_X      if $xx >= 0;
    $mask +|= WNCK_WINDOW_CHANGE_Y      if $yy >= 0;
    $mask +|= WNCK_WINDOW_CHANGE_WIDTH  if  $w >= 0;
    $mask +|= WNCK_WINDOW_CHANGE_HEIGHT if  $h >= 0;

    say "Setting to ($xx, $yy, $w, $h)";

    samewith(WNCK_WINDOW_GRAVITY_CURRENT, $mask, $xx, $yy, $w, $h);
  }
  multi method set_geometry (
    Int() $gravity,
    Int() $geometry_mask,
    Int() $x,
    Int() $y,
    Int() $width,
    Int() $height
  ) {
    my guint ($g, $gm)          = ($gravity, $geometry_mask);
    my gint  ($xx, $yy, $w, $h) = ($x, $y, $width, $height);

    wnck_window_set_geometry($!ww, $g, $gm, $xx, $yy, $w, $h);
  }

  method set_icon_geometry (Int() $x, Int() $y, Int() $width, Int() $height)
    is also<set-icon-geometry>
  {
    my gint ($xx, $yy, $w, $h) = ($x, $y, $width, $height);

    wnck_window_set_icon_geometry($!ww, $xx, $yy, $w, $h);
  }

  method set_skip_pager (Int() $skip) is also<set-skip-pager> {
    my gboolean $s = $skip.so.Int;

    wnck_window_set_skip_pager($!ww, $s);
  }

  method set_skip_tasklist (Int() $skip) is also<set-skip-tasklist> {
    my gboolean $s = $skip.so.Int;

    wnck_window_set_skip_tasklist($!ww, $s);
  }

  method set_sort_order (Int() $order) is also<set-sort-order> {
    my gint $o = $order;

    wnck_window_set_sort_order($!ww, $o);
  }

  method set_window_type (Int() $wintype) is also<set-window-type> {
    my guint $wt = $wintype;

    wnck_window_set_window_type($!ww, $wt);
  }

  method shade {
    wnck_window_shade($!ww);
  }

  method stick {
    wnck_window_stick($!ww);
  }

  method transient_is_most_recently_activated
    is also<transient-is-most-recently-activated>
  {
    wnck_window_transient_is_most_recently_activated($!ww);
  }

  method get_class_instance_name is also<get-class-instance-name> {
    wnck_window_get_class_instance_name($!ww);
  }

  method get_group_leader
    is also<
      get-group-leader
      group_leader
      group-leader
    >
  {
    wnck_window_get_group_leader($!ww);
  }

  method get_icon_name
    is also<
      get-icon-name
      icon_name
      icon-name
    >
  {
    wnck_window_get_icon_name($!ww);
  }

  method get_mini_icon (:$raw = False)
    is also<
      get-mini-icon
      mini_icon
      mini-icon
    >
  {
    my $p = wnck_window_get_mini_icon($!ww);

    $p ??
      ( $raw ?? $p !! GDK::Pixbuf.new($p) )
      !!
      GdkPixbuf
  }

  method get_name
    is also<
      get-name
      name
    >
  {
    wnck_window_get_name($!ww);
  }

  method get_sort_order
    is also<
      get-sort-order
      sort_order
      sort-order
    >
  {
    wnck_window_get_sort_order($!ww);
  }

  method is_below is also<is-below> {
    so wnck_window_is_below($!ww);
  }

  method is_maximized_vertically is also<is-maximized-vertically> {
    so wnck_window_is_maximized_vertically($!ww);
  }

  method is_most_recently_activated is also<is-most-recently-activated> {
    so wnck_window_is_most_recently_activated($!ww);
  }

  method is_shaded is also<is-shaded> {
    so wnck_window_is_shaded($!ww);
  }

  method keyboard_size is also<keyboard-size> {
    wnck_window_keyboard_size($!ww);
  }

  method or_transient_needs_attention is also<or-transient-needs-attention> {
    so wnck_window_or_transient_needs_attention($!ww);
  }

  method unmake_above is also<unmake-above> {
    wnck_window_unmake_above($!ww);
  }

  method unmake_below is also<unmake-below> {
    wnck_window_unmake_below($!ww);
  }

  method unmaximize {
    wnck_window_unmaximize($!ww);
  }

  method unmaximize_horizontally is also<unmaximize-horizontally> {
    wnck_window_unmaximize_horizontally($!ww);
  }

  method unmaximize_vertically is also<unmaximize-vertically> {
    wnck_window_unmaximize_vertically($!ww);
  }

  method unminimize (Int() $timestamp = GTK::Get.current_event_time) {
    my guint $ts = $timestamp;

    wnck_window_unminimize($!ww, $ts);
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
