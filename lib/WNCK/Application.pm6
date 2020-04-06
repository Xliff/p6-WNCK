use v6.c;

use Method::Also;

use WNCK::Raw::Types;
use WNCK::Raw::Application;

use GLib::GList;
use GDK::Pixbuf;
use WNCK::Window;

use GLib::Roles::ListData;
use GLib::Roles::Object;
use GLib::Roles::Signals::Generic;

class WNCK::Application {
  also does GLib::Roles::Object;
  also does GLib::Roles::Signals::Generic;

  has WnckApplication $!wa;

  submethod BUILD (:$application) {
    self!setObject( cast(GObject, $!wa = $application) );
  }

  method WNCK::Raw::Types::WnckApplication
    is also<WnckApplication>
  { $!wa; }

  method new (WnckApplication $application) {
    $application ?? self.bless( :$application ) !! WnckApplication;
  }

  method get (WNCK::Application:U: Int() $xid) {
    my $application = wnck_application_get($xid);

    $application ?? self.bless( :$application ) !! WnckApplication;
  }

  method icon-changed is also<icon_changed> {
    self.connect($!wa, 'icon-changed');
  }

  method name-changed is also<name_changed> {
    self.connect($!wa, 'name-changed');
  }

  method get_icon (:$raw = False)
    is also<
      get-icon
      icon
    >
  {
    my $p = wnck_application_get_icon($!wa);

    $p ??
      ( $raw ?? $p !! GDK::Pixbuf.new($p) )
      !!
      GdkPixbuf;
  }

  method get_icon_is_fallback
    is also<
      get-icon-is-fallback
      icon_is_fallback
      icon-is-fallback
    > {
    so wnck_application_get_icon_is_fallback($!wa);
  }

  method get_icon_name
    is also<
      get-icon-name
      icon_name
      icon-name
    >
  {
    wnck_application_get_icon_name($!wa);
  }

  method get_n_windows
    is also<
      get-n-windows
      n_windows
      n-windows
      elems
    >
  {
    wnck_application_get_n_windows($!wa);
  }

  method get_name
    is also<
      get-name
      name
    >
  {
    wnck_application_get_name($!wa);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &wnck_application_get_type, $n, $t );
  }

  method get_windows (:$glist = False, :$raw = False)
    is also<
      get-windows
      windows
    >
  {
    my $l = wnck_application_get_windows($!wa);

    return Nil unless $l;
    return $l  if $glist;

    $l = GLib::GList.new($l) but GLib::Roles::ListData[WnckWindow];
    $raw ?? $l.Array !! $l.Array.map({ WNCK::Window.new($_) });
  }

  method get_xid
    is also<
      get-xid
      xid
    >
  {
    wnck_application_get_xid($!wa);
  }

  method get_mini_icon (:$raw = False)
    is also<
      get-mini-icon
      mini_icon
      mini-icon
    >
  {
    my $p = wnck_application_get_mini_icon($!wa);

    $p ??
      ( $raw ?? $p !! GTK::Compat::Pixbuf.new($p) )
      !!
      GdkPixbuf
  }

  method get_pid
    is also<
      get-pid
      pid
    >
  {
    wnck_application_get_pid($!wa);
  }

  method get_startup_id
    is also<
      get-startup-id
      startup_id
      startup-id
    >
  {
    wnck_application_get_startup_id($!wa);
  }

}
