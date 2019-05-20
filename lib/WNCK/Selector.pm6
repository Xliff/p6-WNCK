use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;
use WNCK::Raw::Types;

use GTK::MenuBar;

our subset SelectorAncestry is export of Mu
  where WnckSelector | MenuBarAncestry;

class WNCK::Selector is GTK::MenuBar {
  has WnckSelector $!ws;

  submethod BUILD (:$selector) {
    given $selector {
      when SelectorAncestry {
        my $to-parent;
        $!ws = do {
          when WnckSelector {
            $to-parent = cast(GtkMenuBar, $_);
            $_;
          }
          default {
            $to-parent = $_;
            cast(WnckSelector, $_);
          }
        }
        self.setMenuBar($to-parent);
      }
      when WNCK::Selector {
      }
      default {
      }
    }
  }

  method WNCK::Raw::Types::WnckSelector
    is also<WnckSelector>
  { $!ws }

  multi method new (SelectorAncestry $selector) {
    self.bless( :$selector );
  }
  multi method new {
    self.bless( selector => wnck_selector_new() );
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &wnck_selector_get_type, $n, $t );
  }

}

sub wnck_selector_get_type ()
  returns GType
  is native(wnck)
  is export
{ * }

sub wnck_selector_new ()
  returns WnckSelector
  is native(wnck)
  is export
{ * }