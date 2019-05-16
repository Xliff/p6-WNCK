use v6.c;

use NativeCall;

use GTK::Compat::Types;
use WNCK::Raw::Types;

unit package WNCK::Raw::Application;

sub wnck_application_get (gulong $xwindow)
  returns WnckApplication
  is native(wnck)
  is export
  { * }

sub wnck_application_get_icon (WnckApplication $app)
  returns GdkPixbuf
  is native(wnck)
  is export
  { * }

sub wnck_application_get_icon_is_fallback (WnckApplication $app)
  returns uint32
  is native(wnck)
  is export
  { * }

sub wnck_application_get_icon_name (WnckApplication $app)
  returns Str
  is native(wnck)
  is export
  { * }

sub wnck_application_get_n_windows (WnckApplication $app)
  returns gint
  is native(wnck)
  is export
  { * }

sub wnck_application_get_name (WnckApplication $app)
  returns Str
  is native(wnck)
  is export
  { * }

sub wnck_application_get_type ()
  returns GType
  is native(wnck)
  is export
  { * }

sub wnck_application_get_windows (WnckApplication $app)
  returns GList
  is native(wnck)
  is export
  { * }

sub wnck_application_get_xid (WnckApplication $app)
  returns gulong
  is native(wnck)
  is export
  { * }

sub wnck_application_get_mini_icon (WnckApplication $app)
  returns GdkPixbuf
  is native(wnck)
  is export
{ * }

sub wnck_application_get_pid (WnckApplication $app)
  returns guint
  is native(wnck)
  is export
{ * }

sub wnck_application_get_startup_id (WnckApplication $app)
  returns Str
  is native(wnck)
  is export
{ * }
