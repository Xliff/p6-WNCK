use v6.c;

use NativeCall;

use GTK::Compat::Types;
use WNCK::Raw::Types;

unit package WNCK::Raw::Pager;

sub wnck_pager_get_type ()
  returns GType
  is native(wnck)
  is export
{ * }

sub wnck_pager_get_wrap_on_scroll (WnckPager $pager)
  returns uint32
  is native(wnck)
  is export
{ * }

sub wnck_pager_new ()
  returns GtkWidget
  is native(wnck)
  is export
{ * }

sub wnck_pager_set_display_mode (
  WnckPager $pager,
  uint32 $mode # WnckPagerDisplayMode $mode
)
  is native(wnck)
  is export
{ * }

sub wnck_pager_set_n_rows (WnckPager $pager, gint $n_rows)
  returns uint32
  is native(wnck)
  is export
{ * }

sub wnck_pager_set_orientation (
  WnckPager $pager,
  uint32 $orientation # GtkOrientation $orientation
)
  returns uint32
  is native(wnck)
  is export
{ * }

sub wnck_pager_set_shadow_type (
  WnckPager $pager,
  uint32 $shadow_type # GtkShadowType $shadow_type
)
  is native(wnck)
  is export
{ * }

sub wnck_pager_set_show_all (WnckPager $pager, gboolean $show_all_workspaces)
  is native(wnck)
  is export
{ * }

sub wnck_pager_set_wrap_on_scroll (WnckPager $pager, gboolean $wrap_on_scroll)
  is native(wnck)
  is export
{ * }
