use v6.c;

use NativeCall;

use WNCK::Raw::Types;

unit package WNCK::Raw::Tasklist;

sub wnck_tasklist_get_size_hint_list (WnckTasklist $tasklist, gint $n_elements)
  returns gint
  is native(wnck)
  is export
{ * }

sub wnck_tasklist_get_type ()
  returns GType
  is native(wnck)
  is export
{ * }

sub wnck_tasklist_new ()
  returns WnckTasklist
  is native(wnck)
  is export
{ * }

sub wnck_tasklist_set_button_relief (
  WnckTasklist $tasklist,
  guint $relief # GtkReliefStyle $relief
)
  is native(wnck)
  is export
{ * }

sub wnck_tasklist_set_grouping (
  WnckTasklist $tasklist,
  guint $grouping # WnckTasklistGroupingType $grouping
)
  is native(wnck)
  is export
{ * }

sub wnck_tasklist_set_grouping_limit (WnckTasklist $tasklist, gint $limit)
  is native(wnck)
  is export
{ * }

sub wnck_tasklist_set_icon_loader (
  WnckTasklist $tasklist,
  &load_icon_func (Str, gint, guint, Pointer --> GdkPixbuf),
  Pointer $data,
  GDestroyNotify $free_data_func
)
  is native(wnck)
  is export
{ * }

sub wnck_tasklist_set_include_all_workspaces (
  WnckTasklist $tasklist,
  gboolean $include_all_workspaces
)
  is native(wnck)
  is export
{ * }

sub wnck_tasklist_set_middle_click_close (
  WnckTasklist $tasklist,
  gboolean $middle_click_close
)
  is native(wnck)
  is export
{ * }

sub wnck_tasklist_set_orientation (
  WnckTasklist $tasklist,
  guint $orient # GtkOrientation $orient
)
  is native(wnck)
  is export
{ * }

sub wnck_tasklist_set_switch_workspace_on_unminimize (
  WnckTasklist $tasklist,
  gboolean $switch_workspace_on_unminimize
)
  is native(wnck)
  is export
{ * }

sub wnck_tasklist_get_scroll_enabled (WnckTasklist $tasklist)
  returns uint32
  is native(wnck)
  is export
{ * }

sub wnck_tasklist_set_scroll_enabled (
  WnckTasklist $tasklist,
  gboolean $scroll_enabled
)
  is native(wnck)
  is export
{ * }
