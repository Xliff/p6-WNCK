use v6.c;

use Method::Also;

use WNCK::Raw::Types;
use WNCK::Raw::ClassGroup;

use GLib::Roles::Object;

use WNCK::Window;

use GLib::Roles::Signals::Generic;

class WNCK::ClassGroup {
  also does GLib::Roles::Object;
  also does GLib::Roles::Signals::Generic;

  has WnckClassGroup $!wcg;

  submethod BUILD (:$group) {
    self!setObject( cast(GObject, $!wcg = $group) );
  }

  method new (Str() $id) {
    self.get($id);
  }

  method get (Str() $id) {
    my $group = wnck_class_group_get($id);

    $group ?? self.bless(:$group) !! WnckClassGroup;
  }

  method icon-changed {
    self.connect($!wcg, 'icon-changed');
  }

  method name-changed {
    self.connect($!wcg, 'name-changed');
  }

  method get_icon (:$raw = False)
    is also<
      get-icon
      icon
    >
  {
    my $p = wnck_class_group_get_icon($!wcg);

    $p ??
      ( $raw ?? $p !! GDK::Pixbuf.new($p) )
      !!
      GdkPixbuf;
  }

  method get_id
    is also<
      get-id
      id
    >
  {
    wnck_class_group_get_id($!wcg);
  }

  method get_name
    is also<
      get-name
      name
    >
  {
    wnck_class_group_get_name($!wcg);
  }

  method get_res_class
    is also<
      get-res-class
      res_clas
      res-class
    >
  {
    wnck_class_group_get_res_class($!wcg);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &wnck_class_group_get_type, $n, $t );
  }

  method get_windows (:$glist = False, :$raw = False)
    is also<
      get-windows
      windows
    >
  {
    my $wl = wnck_class_group_get_windows($!wcg);

    return Nil unless $wl;
    return $wl if $glist;

    $wl = GLib::GList.new($wl) but GLib::Roles::ListData[WnckWindow];
    $raw ?? $wl.Array !! $wl.Array.map({ WNCK::Window.new($_) });
  }

  method get_mini_icon (:$raw = False)
    is also<
      get-mini-icon
      mini_icon
      mini-icon
    >
  {
    my $p = wnck_class_group_get_icon($!wcg);

    $p ??
      ( $raw ?? $p !! GTK::Compat::Pixbuf.new($p) )
      !!
      GdkPixbuf;
  }

}
