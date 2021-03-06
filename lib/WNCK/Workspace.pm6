use v6.c;

use Method::Also;

use WNCK::Raw::Types;
use WNCK::Raw::Workspace;

use GLib::Roles::Object;
use GLib::Roles::Signals::Generic;

class WNCK::Workspace {
  also does GLib::Roles::Object;
  also does GLib::Roles::Signals::Generic;

  has WnckWorkspace $!wws;

  submethod BUILD (:$workspace) {
    self!setObject($!wws = $workspace);
  }

  method WNCK::Raw::Types::WnckWorkspace
    is also<WnckWorkspace>
  { $!wws }

  method new (WnckWorkspace $workspace) {
    self.bless(:$workspace);
  }

  method name-changed is also<name_changed> {
    self.connect($!wws, 'name-changed');
  }

  method get_neighbor (Int() $direction, :$raw = False)
    is also<
      get-neighbor
      neighbor
    >
  {
    my guint $d = $direction;
    my $w = wnck_workspace_get_neighbor($!wws, $d);

    $w ??
      ( $raw ?? $w !! WNCK::Workspace.new($w) )
      !!
      WnckWorkspace;
  }

  method get_layout_column
    is also<
      get-layout-column
      layout_column
      layout-column
    >
  {
    wnck_workspace_get_layout_column($!wws);
  }

  method get_layout_row
    is also<
      get-layout-row
      layout_row
      layout-row
    >
  {
    wnck_workspace_get_layout_row($!wws);
  }

  method get_name
    is also<
      get-name
      name
    >
  {
    wnck_workspace_get_name($!wws);
  }

  method get_number
    is also<
      get-number
      number
    >
  {
    wnck_workspace_get_number($!wws);
  }

  method get_screen (:$raw = False)
    is also<
      get-screen
      screen
    >
  {
    my $ws = wnck_workspace_get_screen($!wws);

    $ws ??
      ( $raw ?? $ws !! ::('WNCK::Screen').new($ws) )
      !!
      WnckWorkspace;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &wnck_workspace_get_type, $n, $t );
  }

  method get_viewport_x
    is also<
      get-viewport-x
      viewport_x
      viewport-x
    >
  {
    wnck_workspace_get_viewport_x($!wws);
  }

  method get_width
    is also<
      get-width
      width
    >
  {
    wnck_workspace_get_width($!wws);
  }

  method is_virtual is also<is-virtual> {
    so wnck_workspace_is_virtual($!wws);
  }

  method change_name (Str() $name) is also<change-name> {
    wnck_workspace_change_name($!wws, $name)
  }

  method activate (Int() $timestamp) {
    my guint $ts = $timestamp;

    wnck_workspace_activate($!wws, $ts)
  }

  method get_height
    is also<
      get-height
      height
    >
  {
    wnck_workspace_get_height($!wws);
  }

  method get_viewport_y
    is also<
      get-viewport-y
      viewport_y
      viewport-y
    >
  {
    wnck_workspace_get_viewport_y($!wws)
  }

}
