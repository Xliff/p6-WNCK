use v6.c;

use Method::Also;

use WNCK::Raw::Types;
use WNCK::Raw::Utils;

use GLib::Roles::StaticClass;

class WNCK::Utils {
  also does GLib::Roles::StaticClass;

  method pid_read_resource_usage (
    GdkDisplay() $gdk_display,
    Int() $pid,
    WnckResourceUsage $usage
  )
    is also<pid-read-resource-usage>
  {
    my gulong $p = $pid;

    wnck_pid_read_resource_usage($gdk_display, $p, $usage);
  }

  method set_client_type (Int() $ewmh_sourceindication_client_type)
    is also<set-client-type>
  {
    my guint $ct = $ewmh_sourceindication_client_type;

    wnck_set_client_type($ct);
  }

  method set_default_icon_size (Int() $size) is also<set-default-icon-size> {
    my gsize $s = $size;

    wnck_set_default_icon_size($s);
  }

  method set_default_mini_icon_size (Int() $size)
    is also<set-default-mini-icon-size>
  {
    my gsize $s = $size;

    wnck_set_default_mini_icon_size($size);
  }

  method shutdown {
    wnck_shutdown();
  }

  method xid_read_resource_usage (
    GdkDisplay() $gdk_display,
    gulong $xid,
    WnckResourceUsage $usage
  )
    is also<xid-read-resource-usage>
  {
    wnck_xid_read_resource_usage($gdk_display, $xid, $usage);
  }

}
