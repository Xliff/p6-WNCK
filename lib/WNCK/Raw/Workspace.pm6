use v6.c;

use GTK::Compat::Types;
use WNCK::Raw::Types;

unit package WNCK::Raw::Workspace;

sub wnck_workspace_get_layout_column (WnckWorkspace $space)
  returns gint
  is native(wnck)
  is export
{ * }

sub wnck_workspace_get_layout_row (WnckWorkspace $space)
  returns gint
  is native(wnck)
  is export
{ * }

sub wnck_workspace_get_name (WnckWorkspace $space)
  returns char
  is native(wnck)
  is export
{ * }

sub wnck_workspace_get_number (WnckWorkspace $space)
  returns gint
  is native(wnck)
  is export
{ * }

sub wnck_workspace_get_screen (WnckWorkspace $space)
  returns WnckScreen
  is native(wnck)
  is export
{ * }

sub wnck_workspace_get_type ()
  returns GType
  is native(wnck)
  is export
{ * }

sub wnck_workspace_get_viewport_x (WnckWorkspace $space)
  returns gint
  is native(wnck)
  is export
{ * }

sub wnck_workspace_get_width (WnckWorkspace $space)
  returns gint
  is native(wnck)
  is export
{ * }

sub wnck_workspace_is_virtual (WnckWorkspace $space)
  returns uint32
  is native(wnck)
  is export
{ * }

sub wnck_workspace_change_name (WnckWorkspace $space, Str $name)
  is native(wnck)
  is export
{ * }

sub wnck_workspace_activate (WnckWorkspace $space, guint $timestamp)
  is native(wnck)
  is export
{ * }

sub wnck_workspace_get_height (WnckWorkspace $space)
  is native(wnck)
  is export
{ * }

sub wnck_workspace_get_neighbor (WnckWorkspace $space, guint $direction)
  is native(wnck)
  is export
{ * }

sub wnck_workspace_get_viewport_y (WnckWorkspace $space)
  is native(wnck)
  is export
{ * }
