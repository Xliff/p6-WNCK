use v6.c;

use NativeCall;

use WNCK::Raw::Types;

unit package WNCK::Utils;

sub wnck_pid_read_resource_usage (
  GdkDisplay $gdk_display,
  gulong $pid,
  WnckResourceUsage $usage
)
  is native(wnck)
  is export
{ * }

sub wnck_set_client_type (
  uint32 $client_type # WnckClientType $ewmh_sourceindication_client_type
)
  is native(wnck)
  is export
{ * }

sub wnck_set_default_icon_size (gsize $size)
  is native(wnck)
  is export
{ * }

sub wnck_set_default_mini_icon_size (gsize $size)
  is native(wnck)
  is export
{ * }

sub wnck_shutdown ()
  is native(wnck)
  is export
{ * }

sub wnck_xid_read_resource_usage (
  GdkDisplay $gdk_display,
  gulong $xid,
  WnckResourceUsage $usage
)
  is native(wnck)
  is export
{ * }
