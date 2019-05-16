use v6.c;

use NativeCall;

use GTK::Compat::Types;
use WNCK::Raw::Types;

use GTK::Roles::Signals::Generic;

role WNCK::Roles::Signals::Screen {
  also does GTK::Roles::Signals::Generic;
  
  has %!signals-ws;

  # WnckScreen, WnckWindow, gpointer
  method connect-window (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-ws{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-window($obj, $signal,
        -> $, $www, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $www, $ud ] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-ws{$signal}[0].tap(&handler) with &handler;
    %!signals-ws{$signal}[0];
  }

  # WnckScreen, WnckWorkspace, gpointer
  method connect-workspace (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-ws{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-workspace($obj, $signal,
        -> $, $wwe, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $wwe, $ud ] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-ws{$signal}[0].tap(&handler) with &handler;
    %!signals-ws{$signal}[0];
  }

  # WnckScreen, WnckApplication, gpointer
  method connect-application (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-ws{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-application($obj, $signal,
        -> $, $wan, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $wan, $ud ] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-ws{$signal}[0].tap(&handler) with &handler;
    %!signals-ws{$signal}[0];
  }

  # WnckScreen, WnckClassGroup, gpointer
  method connect-class-group (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-ws{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-class-group($obj, $signal,
        -> $, $wcgp, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $wcgp, $ud ] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-ws{$signal}[0].tap(&handler) with &handler;
    %!signals-ws{$signal}[0];
  }

}

# WnckScreen, WnckApplication, gpointer
sub g-connect-application (
  Pointer $app,
  Str $name,
  &handler (Pointer, WnckApplication, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
{ * }

# WnckScreen, WnckClassGroup, gpointer
sub g-connect-class-group (
  Pointer $app,
  Str $name,
  &handler (Pointer, WnckClassGroup, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
{ * }

# WnckScreen, WnckWindow, gpointer
sub g-connect-window (
  Pointer $app,
  Str $name,
  &handler (Pointer, WnckWindow, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
{ * }

# WnckScreen, WnckWorkspace, gpointer
sub g-connect-workspace (
  Pointer $app,
  Str $name,
  &handler (Pointer, WnckWorkspace, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
{ * }
