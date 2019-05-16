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
  { $!wws }

  method new (WnckWorkspace $workspace) {
    self.bless(:$workspace);
  }

  method name-changed {
    self.connect($!wws, 'name-changed');
  }

  method get_neighbor (Int() $direction) {
    my guint $d = resolve-uint($direction);
    WNCK::Workspace.new( wnck_workspace_get_neighbor($!wws, $d) );
  }

  method get_layout_column {
    wnck_workspace_get_layout_column($!wws);
  }

  method get_layout_row {
    wnck_workspace_get_layout_row($!wws);
  }

  method get_name {
    wnck_workspace_get_name($!wws);
  }

  method get_number {
    wnck_workspace_get_number($!wws);
  }

  method get_screen {
    wnck_workspace_get_screen($!wws);
  }

  method get_type {
    state ($n, $t);
    unstable_get_type( self.^name, &wnck_workspace_get_type, $n, $t );
  }

  method get_viewport_x {
    wnck_workspace_get_viewport_x($!wws);
  }

  method get_width {
    wnck_workspace_get_width($!wws);
  }

  method is_virtual {
    so wnck_workspace_is_virtual($!wws);
  }

  method change_name (Str() $name) {
    wnck_workspace_change_name($!wws, $name)
  }

  method activate (guint $timestamp) {
    my guint $ts = resolve-uint($timestamp);
    wnck_workspace_activate($!wws, $ts)
  }

  method get_height {
    wnck_workspace_get_height($!wws);
  }

  method get_viewport_y {
    wnck_workspace_get_viewport_y($!wws)
  }

}
