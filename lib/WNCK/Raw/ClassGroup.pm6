use v6.c;

use NativeCall;

use WNCK::Raw::Types;

unit package WNCK::Raw::ClassGroup;

sub wnck_class_group_get (Str $id)
  returns WnckClassGroup
  is native(wnck)
  is export
{ * }

sub wnck_class_group_get_icon (WnckClassGroup $class_group)
  returns GdkPixbuf
  is native(wnck)
  is export
{ * }

sub wnck_class_group_get_id (WnckClassGroup $class_group)
  returns Str
  is native(wnck)
  is export
{ * }

sub wnck_class_group_get_name (WnckClassGroup $class_group)
  returns Str
  is native(wnck)
  is export
{ * }

sub wnck_class_group_get_res_class (WnckClassGroup $class_group)
  returns Str
  is native(wnck)
  is export
{ * }

sub wnck_class_group_get_type ()
  returns GType
  is native(wnck)
  is export
{ * }

sub wnck_class_group_get_windows (WnckClassGroup $class_group)
  returns GList
  is native(wnck)
  is export
{ * }

sub wnck_class_group_get_mini_icon (WnckClassGroup $class_group)
  returns GdkPixbuf
  is native(wnck)
  is export
{ * }
