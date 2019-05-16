use v6.c;

use Method::Also;

use GTK::Compat::Types;
use WNCK::Raw::Types;

use GTK::Raw::Utils;

use WNCK::Raw::Application;

use GTK::Compat::GList;
use GTK::Compat::Pixbuf;

use WNCK::Window;

use GTK::Compat::Roles::ListData;
use GTK::Compat::Roles::Object;

use GTK::Roles::Signals::Generic;

class WNCK::Application {
  also does GTK::Compat::Roles::Object;
  also does GTK::Roles::Signals::Generic;

  has WnckApplication $!wa;

  submethod BUILD (:$application) {
    self!setObject( cast(GObject, $!wa = $application) );
  }

  method get (Int() $xid) {
    self.bless( application => wnck_application_get($xid) )
  }

  method WNCK::Raw::Types::WnckApplication
    is also<WnckApplication>
  { $!wa; }

  method icon-changed is also<icon_changed> {
    self.connect($!wa, 'icon-changed');
  }

  method name-changed is also<name_changed> {
    self.connect($!wa, 'name-changed');
  }

  method get_icon is also<get-icon> {
    GTK::Compat::Pixbuf.new( wnck_application_get_icon($!wa) );
  }

  method get_icon_is_fallback is also<get-icon-is-fallback> {
    so wnck_application_get_icon_is_fallback($!wa);
  }

  method get_icon_name is also<get-icon-name> {
    wnck_application_get_icon_name($!wa);
  }

  method get_n_windows is also<get-n-windows> {
    wnck_application_get_n_windows($!wa);
  }

  method get_name is also<get-name> {
    wnck_application_get_name($!wa);
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &wnck_application_get_type, $n, $t );
  }

  method get_windows (:$raw = False) is also<get-windows> {
    my $l = GTK::Compat::GList.new( wnck_application_get_windows($!wa) )
      but GTK::Compat::Roles::ListData[WnckWindow];
    $raw ??
      $l.Array !! $l.Array.map({ WNCK::Window.new($_) });
  }

  method get_xid is also<get-xid> {
    wnck_application_get_xid($!wa);
  }

  method get_mini_icon is also<get-mini-icon> {
    GTK::Compat::Pixbuf.new( wnck_application_get_mini_icon($!wa) );
  }

  method get_pid is also<get-pid> {
    wnck_application_get_pid($!wa);
  }

  method get_startup_id is also<get-startup-id> {
    wnck_application_get_startup_id($!wa);
  }

}
