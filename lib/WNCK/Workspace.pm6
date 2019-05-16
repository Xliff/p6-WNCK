use v6.c;

use GTK::Compat::Types;
use WNCK::Raw::Types;

use WNCK::Raw::Workspace;

use GTK::Compat::Roles::Object;
use GTK::Roles::Signals::Generic;

class WNCK::Workspace {
  also does GTK::Compat::Roles::Object;
  also does GTK::Roles::Signals::Generic;

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

  method get_neighbor (Int() $direction)
    is also<
      get-neighbor
      neighbor
    >
  {
    my guint $d = resolve-uint($direction);
    WNCK::Workspace.new( wnck_workspace_get_neighbor($!wws, $d) );
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

  method get_screen
    is also<
      get-screen
      screen
    >
  {
    ::('WNCK::Screen').new( wnck_workspace_get_screen($!wws) );
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

  method activate (guint $timestamp) {
    my guint $ts = resolve-uint($timestamp);
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
