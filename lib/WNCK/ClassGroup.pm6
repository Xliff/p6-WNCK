use v6.c;

use Method::Also;

use GTK::Compat::Types;
use WNCK::Raw::Types;

use WNCK::Raw::ClassGroup;

use GTK::Compat::Roles::Object;

use WNCK::Window;

use GTK::Roles::Signals::Generic;

class WNCK::ClassGroup {
  also does GTK::Compat::Roles::Object;
  also does GTK::Roles::Signals::Generic;

  has WnckClassGroup $!wcg;

  submethod BUILD (:$group) {
    self!setObject( cast(GObject, $!wcg = $group) );
  }

  method get (Str() $id) {
    self.bless( group => wnck_class_group_get($id) );
  }

  method icon-changed {
    self.connect($!wcg, 'icon-changed');
  }

  method name-changed {
    self.connect($!wcg, 'name-changed');
  }

  method get_icon
    is also<
      get-icon
      icon
    >
  {
    GTK::Compat::Pixbuf.new( wnck_class_group_get_icon($!wcg) );
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

  method get_windows (:$raw = False)
    is also<
      get-windows
      windows
    >
  {
    my $l = GLib::GList.new( wnck_class_group_get_windows($!wcg) )
      but GLib::Roles::ListData[WnckWindow];
    $raw ??
      $l.Array !! $l.Array.map({ WNCK::Window.new($_) });
  }

  method get_mini_icon
    is also<
      get-mini-icon
      mini_icon
      mini-icon
    >
  {
    GTK::Compat::Pixbuf.new( wnck_class_group_get_icon($!wcg) );
  }

}
